package com.altmm.controller.sys;

import java.io.IOException;
import java.io.OutputStream;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.altmm.core.Constant;
import com.altmm.core.JavaEEFrameworkBaseController;
import com.altmm.model.sys.Activity;
import com.altmm.model.sys.ActivityPerson;
import com.altmm.model.sys.SysUser;
import com.altmm.model.sys.UserPoints;
import com.altmm.service.sys.ActivityPersonService;
import com.altmm.service.sys.ActivityService;
import com.altmm.service.sys.SysUserService;
import com.altmm.service.sys.UserPointsService;

import core.support.ExtJSBaseParameter;
import core.support.JqGridPageView;
import core.support.QueryResult;

/**
 * @file ActivityController.java
 * @category 活动的控制层
 * @author xumin
 * @date 2016年4月5日 下午4:11:19
 */
@Controller
@RequestMapping("/sys/activity")
public class ActivityController extends JavaEEFrameworkBaseController<Activity>
		implements Constant {

	@Resource
	private ActivityService activityService;
	@Resource
	private ActivityPersonService activityPersonService;
	@Resource
	private SysUserService userService;
	@Resource
	private UserPointsService userPointsService;
	private static SimpleDateFormat dateFormat = new SimpleDateFormat(
			"yyyy-MM-dd");

	// 查询活动的表格，包括分页、搜索和排序
	@RequestMapping(value = "/getActivity", method = { RequestMethod.POST,
			RequestMethod.GET })
	public void getActivity(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		Integer firstResult = Integer.valueOf(request.getParameter("page"));
		Integer maxResults = Integer.valueOf(request.getParameter("rows"));
		String sortedObject = request.getParameter("sidx");
		String sortedValue = request.getParameter("sord");
		String filters = request.getParameter("filters");
		Activity obj = new Activity();
		if (StringUtils.isNotBlank(filters)) {
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			JSONObject jsonObject = JSONObject.fromObject(filters);
			JSONArray jsonArray = (JSONArray) jsonObject.get("rules");
			for (int i = 0; i < jsonArray.size(); i++) {
				JSONObject result = (JSONObject) jsonArray.get(i);
				if (result.getString("field").equals("subject")
						&& result.getString("op").equals("cn")) {// 蘑菇活动主题
					obj.set$like_subject(result.getString("data"));
				} else if (result.getString("field").equals("townID")
						&& result.getString("op").equals("eq")) {// 匹配乡镇
					obj.set$eq_townID(result.getString("data"));
				} else if (result.getString("field").equals("villageID")
						&& result.getString("op").equals("eq")) {// 匹配自然村
					obj.set$eq_villageID(result.getString("data"));
				} else if (result.getString("field").equals("startDate")
						&& result.getString("op").equals("ge")) {// 匹配自然村
					obj.set$ge_startDate(sdf.parse(result.getString("data")
							+ " 00:00:00"));
				} else if (result.getString("field").equals("startDate")
						&& result.getString("op").equals("le")) {// 匹配自然村
					obj.set$ge_startDate(sdf.parse(result.getString("data")
							+ " 23:59:59"));
				}
			}
			if (((String) jsonObject.get("groupOp")).equalsIgnoreCase("OR")) {
				obj.setFlag("OR");
			} else {
				obj.setFlag("AND");
			}
		}
		obj.setFirstResult((firstResult - 1) * maxResults);
		obj.setMaxResults(maxResults);
		SysUser loginUser = (SysUser) request.getSession().getAttribute(
				SESSION_SYS_USER);
		if (null != loginUser) {// 匹配当前用户角色信息
			if (ROLE_ADMIN.equals(loginUser.getRole())
					|| Constant.ROLE_ZONE.equals(loginUser.getRole())) {// 超级管理员
																		// &&
																		// 区域管理员
			} else if (Constant.ROLE_TOWN.equals(loginUser.getRole())) {// 乡镇管理员
				obj.set$eq_townID(loginUser.getTownID());
			} else if (Constant.ROLE_VILLAGE.equals(loginUser.getRole())) {// 村管理员
				obj.set$eq_townID(loginUser.getTownID());
				obj.set$eq_villageID(loginUser.getVillageID());
			} else {
				obj.set$eq_townID(loginUser.getTownID());
				obj.set$eq_villageID(loginUser.getVillageID());
			}

		}
		Map<String, String> sortedCondition = new HashMap<String, String>();
		sortedCondition.put(sortedObject, sortedValue);
		sortedCondition.put("createTime", "desc");
		obj.setSortedConditions(sortedCondition);
		QueryResult<Activity> queryResult = activityService
				.doPaginationQuery(obj);
		JqGridPageView<Activity> roleListView = new JqGridPageView<Activity>();
		roleListView.setMaxResults(maxResults);
		List<Activity> activityCnList = activityService
				.queryActivityCnList(queryResult.getResultList());
		roleListView.setRows(activityCnList);
		roleListView.setRecords(queryResult.getTotalCount());
		writeJSON(response, roleListView);
	}

	/**
	 * @Method getLookActivity
	 * @category 查看活动信息列表
	 * @author xumin
	 * @param @param request
	 * @param @param response
	 * @param @throws Exception
	 * @return void
	 * @date 2016年4月10日 上午9:28:39
	 */
	@RequestMapping(value = "/getLookActivity", method = { RequestMethod.POST,
			RequestMethod.GET })
	public void getLookActivity(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		Integer firstResult = Integer.valueOf(request.getParameter("page"));
		Integer maxResults = Integer.valueOf(request.getParameter("rows"));
		String sortedObject = request.getParameter("sidx");
		String sortedValue = request.getParameter("sord");
		String filters = request.getParameter("filters");
		Activity obj = new Activity();
		if (StringUtils.isNotBlank(filters)) {
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			JSONObject jsonObject = JSONObject.fromObject(filters);
			JSONArray jsonArray = (JSONArray) jsonObject.get("rules");
			for (int i = 0; i < jsonArray.size(); i++) {
				JSONObject result = (JSONObject) jsonArray.get(i);
				if (result.getString("field").equals("subject")
						&& result.getString("op").equals("cn")) {// 蘑菇活动主题
					obj.set$like_subject(result.getString("data"));
				} else if (result.getString("field").equals("townID")
						&& result.getString("op").equals("eq")) {// 匹配乡镇
					obj.set$eq_townID(result.getString("data"));
				} else if (result.getString("field").equals("villageID")
						&& result.getString("op").equals("eq")) {// 匹配自然村
					obj.set$eq_villageID(result.getString("data"));
				} else if (result.getString("field").equals("startDate")
						&& result.getString("op").equals("ge")) {// 匹配自然村
					obj.set$ge_startDate(sdf.parse(result.getString("data")
							+ " 00:00:00"));
				} else if (result.getString("field").equals("startDate")
						&& result.getString("op").equals("le")) {// 匹配自然村
					obj.set$ge_startDate(sdf.parse(result.getString("data")
							+ " 23:59:59"));
				}
			}
			if (((String) jsonObject.get("groupOp")).equalsIgnoreCase("OR")) {
				obj.setFlag("OR");
			} else {
				obj.setFlag("AND");
			}
		}
		obj.set$eq_isShow(true);
		obj.setFirstResult((firstResult - 1) * maxResults);
		obj.setMaxResults(maxResults);
		Map<String, String> sortedCondition = new HashMap<String, String>();
		sortedCondition.put(sortedObject, sortedValue);
		sortedCondition.put("createTime", "desc");
		obj.setSortedConditions(sortedCondition);
		QueryResult<Activity> queryResult = activityService
				.doPaginationQuery(obj);
		JqGridPageView<Activity> roleListView = new JqGridPageView<Activity>();
		roleListView.setMaxResults(maxResults);
		List<Activity> activityCnList = activityService
				.queryActivityCnList(queryResult.getResultList());
		roleListView.setRows(activityCnList);
		roleListView.setRecords(queryResult.getTotalCount());
		writeJSON(response, roleListView);
	}

	// 保存活动的实体Bean
	@RequestMapping(value = "/saveActivity", method = { RequestMethod.POST,
			RequestMethod.GET })
	public void doSave(Activity entity, HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		ExtJSBaseParameter parameter = ((ExtJSBaseParameter) entity);
		if (CMD_EDIT.equals(parameter.getCmd())) {
			activityService.update(entity);
		} else if (CMD_NEW.equals(parameter.getCmd())) {
			activityService.persist(entity);
		}
		parameter.setSuccess(true);
		writeJSON(response, parameter);
	}

	// 操作活动的删除、导出Excel、字段判断和保存
	@RequestMapping(value = "/operateActivity", method = { RequestMethod.POST,
			RequestMethod.GET })
	public void operateActivity(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		String oper = request.getParameter("oper");
		String id = request.getParameter("id");
		if (oper.equals("del")) {
			String[] ids = id.split(",");
			deleteActivity(request, response, ids);
		} else if (oper.equals("excel")) {
			response.setContentType("application/msexcel;charset=UTF-8");
			try {
				response.addHeader("Content-Disposition",
						"attachment;filename=file.xls");
				OutputStream out = response.getOutputStream();
				out.write(request.getParameter("csvBuffer").getBytes());
				out.flush();
				out.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else {
			// Map<String, Object> result = new HashMap<String, Object>();
			// String roleKey = request.getParameter("roleKey");
			// String roleValue = request.getParameter("roleValue");
			// String description = request.getParameter("description");
			// Activity role = null;
			// if (oper.equals("edit")) {
			// role = activityService.get(Long.valueOf(id));
			// }
			// Activity roleKeyActivity =
			// activityService.getByProerties("roleKey",
			// roleKey);
			// if (StringUtils.isBlank(roleKey) ||
			// StringUtils.isBlank(roleValue)) {
			// response.setStatus(HttpServletResponse.SC_LENGTH_REQUIRED);
			// result.put("message", "请填写活动编码和活动名称");
			// writeJSON(response, result);
			// } else if (null != roleKeyActivity && oper.equals("add")) {
			// response.setStatus(HttpServletResponse.SC_CONFLICT);
			// result.put("message", "此活动编码已存在，请重新输入");
			// writeJSON(response, result);
			// } else if (null != roleKeyActivity
			// && !role.getActivityKey().equalsIgnoreCase(roleKey)
			// && oper.equals("edit")) {
			// response.setStatus(HttpServletResponse.SC_CONFLICT);
			// result.put("message", "此活动编码已存在，请重新输入");
			// writeJSON(response, result);
			// } else {
			// Activity entity = new Activity();
			// entity.setActivityKey(roleValue);
			// entity.setActivityValue(roleValue);
			// entity.setDescription(description);
			// if (oper.equals("edit")) {
			// entity.setId(Long.valueOf(id));
			// entity.setCmd("edit");
			// doSave(entity, request, response);
			// } else if (oper.equals("add")) {
			// entity.setCmd("new");
			// doSave(entity, request, response);
			// }
			// }
		}
	}

	// 删除活动
	@RequestMapping("/deleteActivity")
	public void deleteActivity(HttpServletRequest request,
			HttpServletResponse response, @RequestParam("ids") String[] ids)
			throws IOException {
		boolean flag = activityService.deleteByPK(ids);
		if (flag) {
			writeJSON(response, "{success:true}");
		} else {
			writeJSON(response, "{success:false}");
		}
	}

	/**
	 * @Method getActivityById
	 * @category 通过活动ID获取活动信息
	 * @author xumin
	 * @param @param request
	 * @param @param response
	 * @param @throws Exception
	 * @return void
	 * @date 2016年3月23日 下午3:40:41
	 */
	@RequestMapping(value = "/getActivityById", method = { RequestMethod.POST,
			RequestMethod.GET })
	public void getActivityById(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		String id = request.getParameter("id");
		Activity activity = activityService.get(id);
		activity.setIsShowCn(activity.getIsShow() ? "是" : "否");
		writeJSON(response, activity);
	}

	/**
	 * @Method verifySaveActivity
	 * @category 验证并保存活动对象
	 * @author xumin
	 * @param @param request
	 * @param @param response
	 * @param @throws Exception
	 * @return void
	 * @date 2016年3月24日 下午2:34:02
	 */
	@RequestMapping(value = "/verifySaveActivity", method = {
			RequestMethod.POST, RequestMethod.GET })
	public void verifySaveActivity(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		String activityID = request.getParameter("activityID");// 活动编码
		String subject = request.getParameter("subject");// 主题
		String content = request.getParameter("content");// 内容
		String startDate = request.getParameter("startDate");// 开始时间
		String endDate = request.getParameter("endDate");// 截止时间
		String scope = request.getParameter("scope");// 活动范围
		String villageID = request.getParameter("villageID");// 自然村编码
		String townID = request.getParameter("townID");// 乡镇编码
		String zoneID = request.getParameter("zoneID");// 区域编码
		String place = request.getParameter("place");// 地点
		String dutyCode = request.getParameter("dutyCode");// 职责编码
		String points = request.getParameter("points");// 本次活动积分
		String isShow = request.getParameter("isShow");// 是否展示
		String mark = request.getParameter("mark");// 备注
		boolean information = true;
		information = userService.JudgeRole(townID, villageID, request,
				response);
		String returnString = "";
		if (information) {
			List<Activity> activityList = activityService.queryByProerties(
					"subject", subject);
			Activity entity = new Activity();
			entity.setSubject(subject);
			entity.setContent(content);
			if (StringUtils.isNotBlank(startDate)) {
				entity.setStartDate(dateFormat.parse(startDate));
			}
			if (StringUtils.isNotBlank(endDate)) {
				entity.setEndDate(dateFormat.parse(endDate));
			}
			entity.setScope(Integer.parseInt("".equals(scope) ? "1" : scope));
			entity.setVillageID(villageID);
			entity.setTownID(townID);
			entity.setZoneID(zoneID);
			entity.setPlace(place);
			entity.setDutyCode(dutyCode);
			entity.setPoints(Double.parseDouble("".equals(points) ? "0"
					: points));
			entity.setIsShow("是".equals(isShow) ? true : false);
			entity.setMark(mark);
			if ("" == activityID) {// 活动ID不存在，新增验证
				if (null != activityList && activityList.size() > 0) {
					information = false;
				} else {
					entity.setCreateTime(new Date());
					activityService.persist(entity);
				}
			} else {// 活动ID存在，更新验证
				if (null != activityList) {
					for (int i = 0; i < activityList.size(); i++) {
						Activity activity = activityList.get(i);
						if (!activityID.equals(activity.getId())) {
							information = false;
						}
					}
				}
				if (information) {
					Activity temp = activityService.get(activityID);
					temp.setSubject(subject);
					temp.setContent(content);
					if (StringUtils.isNotBlank(startDate)) {
						temp.setStartDate(dateFormat.parse(startDate));
					}
					if (StringUtils.isNotBlank(endDate)) {
						temp.setEndDate(dateFormat.parse(endDate));
					}
					temp.setScope(Integer.parseInt("".equals(scope) ? "1"
							: scope));
					temp.setVillageID(villageID);
					temp.setTownID(townID);
					temp.setZoneID(zoneID);
					temp.setPlace(place);
					temp.setDutyCode(dutyCode);
					temp.setPoints(Double.parseDouble("".equals(points) ? "0"
							: points));
					temp.setIsShow("是".equals(isShow) ? true : false);
					temp.setMark(mark);
					activityService.update(temp);
				}
			}
			if (information) {
				returnString = "{success:true,information:'保存成功'}";
			} else {
				returnString = "{success:false,information:'该主题已存在，保存失败'}";
			}
		} else {
			returnString = "{success:false,information:'当前用户权限不足'}";
		}
		writeJSON(response, returnString);
	}

	/**
	 * @Method verifySaveActivityPerson
	 * @category 验证并保存活动人员列表
	 * @author xumin
	 * @param @param request
	 * @param @param response
	 * @param @throws Exception
	 * @return void
	 * @date 2016年4月10日 下午9:46:38
	 */
	@RequestMapping(value = "/verifySaveActivityPerson", method = {
			RequestMethod.POST, RequestMethod.GET })
	public void verifySaveActivityPerson(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		String activityID = request.getParameter("activityID");
		String userID = request.getParameter("userID");
		String[] propName = new String[] { "activityID", "userID" };
		Object[] propValue = new Object[] { activityID, userID };
		List<ActivityPerson> personList = activityPersonService
				.queryByProerties(propName, propValue);
		boolean information = true;
		ActivityPerson entity = new ActivityPerson();
		entity.setActivityID(activityID);
		entity.setUserID(userID);
		if (null != personList && personList.size() > 0) {
			information = false;
		} else {
			activityPersonService.persist(entity);
		}
		writeJSON(response, information);
	}

	/**
	 * @Method getActivityPerson
	 * @category 获取活动人员列表
	 * @author xumin
	 * @param @param request
	 * @param @param response
	 * @param @throws Exception
	 * @return void
	 * @date 2016年4月10日 下午10:14:11
	 */
	@RequestMapping(value = "/getActivityPerson", method = {
			RequestMethod.POST, RequestMethod.GET })
	public void getActivityPerson(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		String activityID = request.getParameter("activityID");
		List<ActivityPerson> resultList = activityPersonService
				.queryByProerties("activityID", activityID);
		List<ActivityPerson> personList = activityPersonService
				.queryActivityPersonCnList(resultList);
		writeJSON(response, personList);
	}

	/**
	 * @Method verifySavePersonPoints
	 * @category 修改保存人员积分信息
	 * @author xumin
	 * @param @param request
	 * @param @param response
	 * @param @throws Exception
	 * @return void
	 * @date 2016年4月10日 下午10:26:57
	 */
	@RequestMapping(value = "/verifySavePersonPoints", method = {
			RequestMethod.POST, RequestMethod.GET })
	public void verifySavePersonPoints(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		String ActivityPersonID = request.getParameter("ActivityPersonID");
		ActivityPerson entity = activityPersonService.get(ActivityPersonID);
		boolean information = true;
		if (null != entity) {
			entity.setIsAddPoints(true);
			activityPersonService.update(entity);
			// 往用户积分表中添加积分信息
			String[] propName = new String[] { "source", "sourceID", "userID" };
			Object[] propValue = new Object[] { 1, entity.getActivityID(),
					entity.getUserID() };
			List<UserPoints> pointsList = userPointsService.queryByProerties(
					propName, propValue);
			if (null != pointsList && !pointsList.isEmpty()) {
				// 积分已存在
			} else {
				Activity activity = activityService.get(entity.getActivityID());
				if (null != activity) {
					UserPoints points = new UserPoints();
					points.setUserID(entity.getUserID());
					points.setSource(1);// 积分来源为活动,
					points.setSourceID(entity.getActivityID());
					points.setPoints(activity.getPoints());
					points.setTime(new Date());
					points.setIsEffect(true);
					userPointsService.persist(points);
				}
			}
		} else {
			information = false;
		}
		writeJSON(response, information);
	}
}
