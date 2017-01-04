package com.altmm.controller.sys;

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

import com.altmm.core.Constant;
import com.altmm.core.JavaEEFrameworkBaseController;
import com.altmm.model.sys.SysUser;
import com.altmm.model.sys.UserPoints;
import com.altmm.service.sys.SysUserService;
import com.altmm.service.sys.UserPointsService;

import core.support.JqGridPageView;
import core.support.QueryResult;

/**
 * @file UserPointsController.java
 * @category 用户积分管理的控制层
 * @author xumin
 * @date 2016年4月16日 下午8:11:14
 */
@Controller
@RequestMapping("/sys/userpoints")
public class UserPointsController extends
		JavaEEFrameworkBaseController<SysUser> implements Constant {

	@Resource
	private SysUserService sysUserService;

	@Resource
	private UserPointsService userPointsService;

	/**
	 * @Method getParty
	 * @category 获得党员或者入党积极分子列表
	 * @author xumin
	 * @param @param request
	 * @param @param response
	 * @param @throws Exception
	 * @return void
	 * @date 2016年3月30日 下午2:49:24
	 */
	@RequestMapping(value = "/getParty", method = { RequestMethod.POST,
			RequestMethod.GET })
	public void getParty(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		SysUser loginUser = (SysUser) request.getSession().getAttribute(
				SESSION_SYS_USER);
		Integer firstResult = Integer.valueOf(request.getParameter("page"));
		Integer maxResults = Integer.valueOf(request.getParameter("rows"));
		String sortedObject = request.getParameter("sidx");
		String sortedValue = request.getParameter("sord");
		String filters = request.getParameter("filters");
		SysUser sysUser = new SysUser();
		if (StringUtils.isNotBlank(filters)) {
			JSONObject jsonObject = JSONObject.fromObject(filters);
			JSONArray jsonArray = (JSONArray) jsonObject.get("rules");
			for (int i = 0; i < jsonArray.size(); i++) {
				JSONObject result = (JSONObject) jsonArray.get(i);
				if (result.getString("field").equals("townID")
						&& result.getString("op").equals("eq")) {// 匹配乡镇
					sysUser.set$eq_townID(result.getString("data"));
				} else if (result.getString("field").equals("villageID")
						&& result.getString("op").equals("eq")) {// 匹配自然村
					sysUser.set$eq_villageID(result.getString("data"));
				} else if (result.getString("field").equals("userName")
						&& result.getString("op").equals("cn")) {// 蘑菇匹配用户名称
					sysUser.set$like_userName(result.getString("data"));
				} else if (result.getString("field").equals("IDCard")
						&& result.getString("op").equals("cn")) {// 蘑菇匹配身份证
					sysUser.set$like_idCard(result.getString("data"));
				}
			}
			if (((String) jsonObject.get("groupOp")).equalsIgnoreCase("OR")) {
				sysUser.setFlag("OR");
			} else {
				sysUser.setFlag("AND");
			}
		}
		sysUser.setFirstResult((firstResult - 1) * maxResults);
		sysUser.setMaxResults(maxResults);
		sysUser.set$ne_identity(3);// 不等于群众
		if (null != loginUser) {// 匹配当前用户角色信息
			if (Constant.ROLE_ADMIN.equals(loginUser.getRole())) {// 超级管理员

			} else {
				sysUser.set$ne_role(Constant.ROLE_ADMIN);// 不匹配超级管理员
			}
			if (Constant.ROLE_ADMIN.equals(loginUser.getRole())
					|| Constant.ROLE_ZONE.equals(loginUser.getRole())) {// 超级管理员
																		// &&
																		// 区域管理员
			} else if (Constant.ROLE_TOWN.equals(loginUser.getRole())) {// 乡镇管理员
				sysUser.set$eq_townID(loginUser.getTownID());
			} else if (Constant.ROLE_VILLAGE.equals(loginUser.getRole())) {// 村管理员
				sysUser.set$eq_townID(loginUser.getTownID());
				sysUser.set$eq_villageID(loginUser.getVillageID());
			} else {
				sysUser.set$eq_townID(loginUser.getTownID());
				sysUser.set$eq_villageID(loginUser.getVillageID());
			}
		}
		Map<String, String> sortedCondition = new HashMap<String, String>();
		sortedCondition.put(sortedObject, sortedValue);
		sortedCondition.put("points", "desc");// 积分总数
		sysUser.setSortedConditions(sortedCondition);
		QueryResult<SysUser> queryResult = sysUserService
				.doPaginationQuery(sysUser);
		JqGridPageView<SysUser> sysUserListView = new JqGridPageView<SysUser>();
		sysUserListView.setMaxResults(maxResults);
		List<SysUser> sysUserCnList = sysUserService
				.querySysUserCnList(queryResult.getResultList());
		sysUserListView.setRows(sysUserCnList);
		sysUserListView.setRecords(queryResult.getTotalCount());
		writeJSON(response, sysUserListView);
	}

	/**
	 * @Method getLookParty
	 * @category 获得查看党员或者入党积极分子列表
	 * @author xumin
	 * @param @param request
	 * @param @param response
	 * @param @throws Exception
	 * @return void
	 * @date 2016年4月24日 下午2:23:00
	 */
	@RequestMapping(value = "/getLookParty", method = { RequestMethod.POST,
			RequestMethod.GET })
	public void getLookParty(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		Integer firstResult = Integer.valueOf(request.getParameter("page"));
		Integer maxResults = Integer.valueOf(request.getParameter("rows"));
		String sortedObject = request.getParameter("sidx");
		String sortedValue = request.getParameter("sord");
		String filters = request.getParameter("filters");
		SysUser sysUser = new SysUser();
		if (StringUtils.isNotBlank(filters)) {
			JSONObject jsonObject = JSONObject.fromObject(filters);
			JSONArray jsonArray = (JSONArray) jsonObject.get("rules");
			for (int i = 0; i < jsonArray.size(); i++) {
				JSONObject result = (JSONObject) jsonArray.get(i);
				if (result.getString("field").equals("townID")
						&& result.getString("op").equals("eq")) {// 匹配乡镇
					sysUser.set$eq_townID(result.getString("data"));
				} else if (result.getString("field").equals("villageID")
						&& result.getString("op").equals("eq")) {// 匹配自然村
					sysUser.set$eq_villageID(result.getString("data"));
				} else if (result.getString("field").equals("userName")
						&& result.getString("op").equals("cn")) {// 蘑菇匹配用户名称
					sysUser.set$like_userName(result.getString("data"));
				} else if (result.getString("field").equals("IDCard")
						&& result.getString("op").equals("cn")) {// 蘑菇匹配身份证
					sysUser.set$like_idCard(result.getString("data"));
				}
			}
			if (((String) jsonObject.get("groupOp")).equalsIgnoreCase("OR")) {
				sysUser.setFlag("OR");
			} else {
				sysUser.setFlag("AND");
			}
		}
		sysUser.setFirstResult((firstResult - 1) * maxResults);
		sysUser.setMaxResults(maxResults);
		sysUser.set$ne_identity(3);// 不等于群众
		Map<String, String> sortedCondition = new HashMap<String, String>();
		sortedCondition.put(sortedObject, sortedValue);
		sortedCondition.put("points", "desc");// 积分总数
		sysUser.setSortedConditions(sortedCondition);
		QueryResult<SysUser> queryResult = sysUserService
				.doPaginationQuery(sysUser);
		JqGridPageView<SysUser> sysUserListView = new JqGridPageView<SysUser>();
		sysUserListView.setMaxResults(maxResults);
		List<SysUser> sysUserCnList = sysUserService
				.querySysUserCnList(queryResult.getResultList());
		sysUserListView.setRows(sysUserCnList);
		sysUserListView.setRecords(queryResult.getTotalCount());
		writeJSON(response, sysUserListView);
	}

	/**
	 * @Method verifySaveUserPoints
	 * @category 验证保存用户积分详情
	 * @author xumin
	 * @param @param request
	 * @param @param response
	 * @param @throws Exception
	 * @return void
	 * @date 2016年4月10日 下午9:41:48
	 */
	@RequestMapping(value = "/verifySaveUserPoints", method = {
			RequestMethod.POST, RequestMethod.GET })
	public void verifySaveUserPoints(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		String dataArray = request.getParameter("dataArray");
		String userID = request.getParameter("userID");
		if (StringUtils.isNotBlank(dataArray)) {
			JSONArray jsonArray = JSONArray.fromObject(dataArray);
			for (int i = 0; i < jsonArray.size(); i++) {
				JSONObject result = (JSONObject) jsonArray.get(i);
				String id = result.getString("Id");
				String source = result.getString("source");
				String sourceID = result.getString("sourceID");
				String points = result.getString("sourcePoints");
				UserPoints obj = new UserPoints();
				obj.setUserID(userID);
				obj.setSource(Integer.parseInt(source));
				obj.setSourceID(sourceID);
				obj.setPoints(Double.valueOf(null == points
						&& "".equals(points) ? "0" : points));
				obj.setIsEffect(true);
				if ("".equals(id)) {// 信息不存在
					obj.setTime(new Date());
					userPointsService.persist(obj);
				} else {
					UserPoints temp = userPointsService.get(id);
					temp.setUserID(userID);
					temp.setSource(Integer.parseInt(source));
					temp.setSourceID(sourceID);
					temp.setPoints(Double.valueOf(points));
					temp.setIsEffect(true);
					userPointsService.update(temp);
				}
			}
			userPointsService.updateUserPoints(userID);
		}
		// UserPoints userPoints = new UserPoints();
		writeJSON(response, true);
	}

	/**
	 * @Method getUserPointsList
	 * @category 得到用户积分详情
	 * @author xumin
	 * @param @param request
	 * @param @param response
	 * @param @throws Exception
	 * @return void
	 * @date 2016年4月17日 上午7:00:12
	 */
	@RequestMapping(value = "/getUserPointsList", method = {
			RequestMethod.POST, RequestMethod.GET })
	public void getUserPointsList(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		String userID = request.getParameter("userID");
		Map<String, Object> data = userPointsService.getUserPointsList(userID);
		writeJSON(response, data);
	}
}
