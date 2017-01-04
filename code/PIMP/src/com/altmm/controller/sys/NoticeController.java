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
import com.altmm.model.sys.Notice;
import com.altmm.model.sys.SysUser;
import com.altmm.service.sys.NoticeService;
import com.altmm.service.sys.SysUserService;

import core.support.ExtJSBaseParameter;
import core.support.JqGridPageView;
import core.support.QueryResult;

/**
 * @file NoticeController.java
 * @category 公示表的控制层
 * @author xumin
 * @date 2016年4月5日 下午4:11:19
 */
@Controller
@RequestMapping("/sys/notice")
public class NoticeController extends JavaEEFrameworkBaseController<Notice>
		implements Constant {

	@Resource
	private NoticeService noticeService;
	@Resource
	private SysUserService userService;

	// 查询公示表的表格，包括分页、搜索和排序
	@RequestMapping(value = "/getNotice", method = { RequestMethod.POST,
			RequestMethod.GET })
	public void getNotice(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		Integer firstResult = Integer.valueOf(request.getParameter("page"));
		Integer maxResults = Integer.valueOf(request.getParameter("rows"));
		String sortedObject = request.getParameter("sidx");
		String sortedValue = request.getParameter("sord");
		String filters = request.getParameter("filters");
		Notice obj = new Notice();
		if (StringUtils.isNotBlank(filters)) {
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			JSONObject jsonObject = JSONObject.fromObject(filters);
			JSONArray jsonArray = (JSONArray) jsonObject.get("rules");
			for (int i = 0; i < jsonArray.size(); i++) {
				JSONObject result = (JSONObject) jsonArray.get(i);
				if (result.getString("field").equals("subject")
						&& result.getString("op").equals("cn")) {// 蘑菇公示表主题
					obj.set$like_subject(result.getString("data"));
				} else if (result.getString("field").equals("townID")
						&& result.getString("op").equals("eq")) {// 匹配乡镇
					obj.set$eq_townID(result.getString("data"));
				} else if (result.getString("field").equals("villageID")
						&& result.getString("op").equals("eq")) {// 匹配自然村
					obj.set$eq_villageID(result.getString("data"));
				} else if (result.getString("field").equals("isShow")
						&& result.getString("op").equals("eq")) {// 匹配自然村
					obj.set$eq_isShow("是".equals(result.getString("data")
							.toString()) ? true : false);
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
		obj.setSortedConditions(sortedCondition);
		QueryResult<Notice> queryResult = noticeService.doPaginationQuery(obj);
		JqGridPageView<Notice> roleListView = new JqGridPageView<Notice>();
		roleListView.setMaxResults(maxResults);
		List<Notice> noticeCnList = noticeService.queryNoticeCnList(queryResult
				.getResultList());
		roleListView.setRows(noticeCnList);
		roleListView.setRecords(queryResult.getTotalCount());
		writeJSON(response, roleListView);
	}

	/**
	 * @Method getLookNotice
	 * @category 获得查看公示信息
	 * @author xumin
	 * @param @param request
	 * @param @param response
	 * @param @throws Exception
	 * @return void
	 * @date 2016年4月24日 下午2:24:11
	 */
	@RequestMapping(value = "/getLookNotice", method = { RequestMethod.POST,
			RequestMethod.GET })
	public void getLookNotice(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		Integer firstResult = Integer.valueOf(request.getParameter("page"));
		Integer maxResults = Integer.valueOf(request.getParameter("rows"));
		String sortedObject = request.getParameter("sidx");
		String sortedValue = request.getParameter("sord");
		String filters = request.getParameter("filters");
		Notice obj = new Notice();
		if (StringUtils.isNotBlank(filters)) {
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			JSONObject jsonObject = JSONObject.fromObject(filters);
			JSONArray jsonArray = (JSONArray) jsonObject.get("rules");
			for (int i = 0; i < jsonArray.size(); i++) {
				JSONObject result = (JSONObject) jsonArray.get(i);
				if (result.getString("field").equals("subject")
						&& result.getString("op").equals("cn")) {// 蘑菇公示表主题
					obj.set$like_subject(result.getString("data"));
				} else if (result.getString("field").equals("townID")
						&& result.getString("op").equals("eq")) {// 匹配乡镇
					obj.set$eq_townID(result.getString("data"));
				} else if (result.getString("field").equals("villageID")
						&& result.getString("op").equals("eq")) {// 匹配自然村
					obj.set$eq_villageID(result.getString("data"));
				} else if (result.getString("field").equals("isShow")
						&& result.getString("op").equals("eq")) {// 匹配自然村
					obj.set$eq_isShow("是".equals(result.getString("data")
							.toString()) ? true : false);
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
		Map<String, String> sortedCondition = new HashMap<String, String>();
		sortedCondition.put(sortedObject, sortedValue);
		obj.setSortedConditions(sortedCondition);
		QueryResult<Notice> queryResult = noticeService.doPaginationQuery(obj);
		JqGridPageView<Notice> roleListView = new JqGridPageView<Notice>();
		roleListView.setMaxResults(maxResults);
		List<Notice> noticeCnList = noticeService.queryNoticeCnList(queryResult
				.getResultList());
		roleListView.setRows(noticeCnList);
		roleListView.setRecords(queryResult.getTotalCount());
		writeJSON(response, roleListView);
	}

	// 保存公示表的实体Bean
	@RequestMapping(value = "/saveNotice", method = { RequestMethod.POST,
			RequestMethod.GET })
	public void doSave(Notice entity, HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		ExtJSBaseParameter parameter = ((ExtJSBaseParameter) entity);
		if (CMD_EDIT.equals(parameter.getCmd())) {
			noticeService.update(entity);
		} else if (CMD_NEW.equals(parameter.getCmd())) {
			noticeService.persist(entity);
		}
		parameter.setSuccess(true);
		writeJSON(response, parameter);
	}

	// 操作公示表的删除、导出Excel、字段判断和保存
	@RequestMapping(value = "/operateNotice", method = { RequestMethod.POST,
			RequestMethod.GET })
	public void operateNotice(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		String oper = request.getParameter("oper");
		String id = request.getParameter("id");
		if (oper.equals("del")) {
			String[] ids = id.split(",");
			deleteNotice(request, response, ids);
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
			// Notice role = null;
			// if (oper.equals("edit")) {
			// role = noticeService.get(Long.valueOf(id));
			// }
			// Notice roleKeyNotice =
			// noticeService.getByProerties("roleKey",
			// roleKey);
			// if (StringUtils.isBlank(roleKey) ||
			// StringUtils.isBlank(roleValue)) {
			// response.setStatus(HttpServletResponse.SC_LENGTH_REQUIRED);
			// result.put("notice", "请填写公示表编码和公示表名称");
			// writeJSON(response, result);
			// } else if (null != roleKeyNotice && oper.equals("add")) {
			// response.setStatus(HttpServletResponse.SC_CONFLICT);
			// result.put("notice", "此公示表编码已存在，请重新输入");
			// writeJSON(response, result);
			// } else if (null != roleKeyNotice
			// && !role.getNoticeKey().equalsIgnoreCase(roleKey)
			// && oper.equals("edit")) {
			// response.setStatus(HttpServletResponse.SC_CONFLICT);
			// result.put("notice", "此公示表编码已存在，请重新输入");
			// writeJSON(response, result);
			// } else {
			// Notice entity = new Notice();
			// entity.setNoticeKey(roleValue);
			// entity.setNoticeValue(roleValue);
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

	// 删除公示表
	@RequestMapping("/deleteNotice")
	public void deleteNotice(HttpServletRequest request,
			HttpServletResponse response, @RequestParam("ids") String[] ids)
			throws IOException {
		boolean flag = noticeService.deleteByPK(ids);
		if (flag) {
			writeJSON(response, "{success:true}");
		} else {
			writeJSON(response, "{success:false}");
		}
	}

	/**
	 * @Method getNoticeById
	 * @category 通过公示表ID获取公示表信息
	 * @author xumin
	 * @param @param request
	 * @param @param response
	 * @param @throws Exception
	 * @return void
	 * @date 2016年3月23日 下午3:40:41
	 */
	@RequestMapping(value = "/getNoticeById", method = { RequestMethod.POST,
			RequestMethod.GET })
	public void getNoticeById(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		String id = request.getParameter("id");
		Notice notice = noticeService.get(id);
		writeJSON(response, notice);
	}

	/**
	 * @Method verifySaveNotice
	 * @category 验证并保存公示表对象
	 * @author xumin
	 * @param @param request
	 * @param @param response
	 * @param @throws Exception
	 * @return void
	 * @date 2016年3月24日 下午2:34:02
	 */
	@RequestMapping(value = "/verifySaveNotice", method = { RequestMethod.POST,
			RequestMethod.GET })
	public void verifySaveNotice(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		SysUser loginUser = (SysUser) request.getSession().getAttribute(
				SESSION_SYS_USER);
		String noticeID = request.getParameter("noticeID");// 公示表编码
		String subject = request.getParameter("subject");// 主题
		String content = request.getParameter("content");// 内容
		String scope = request.getParameter("scope");// 公示范围
		String villageID = request.getParameter("villageID");// 自然村编码
		String townID = request.getParameter("townID");// 乡镇编码
		String zoneID = request.getParameter("zoneID");// 区域编码
		String isShow = request.getParameter("isShow");// 是否展示
		String mark = request.getParameter("mark");// 备注
		boolean information = true;
		information = userService.JudgeRole(townID, villageID, request,
				response);
		String returnString = "";
		if (information) {
			List<Notice> noticeList = noticeService.queryByProerties("subject",
					subject);
			Notice entity = new Notice();
			entity.setSubject(subject);
			entity.setContent(content);
			entity.setScope(Integer.parseInt("".equals(scope) ? "1" : scope));
			entity.setVillageID(villageID);
			entity.setTownID(townID);
			entity.setZoneID(zoneID);
			entity.setIsShow("是".equals(isShow) ? true : false);
			entity.setMark(mark);
			if ("" == noticeID) {// 公示ID不存在，新增验证
				if (null != noticeList && noticeList.size() > 0) {
					information = false;
				} else {
					entity.setCreateTime(new Date());
					entity.setUser(loginUser.getId());
					noticeService.persist(entity);
				}
			} else {// 公示ID存在，更新验证
				if (null != noticeList) {
					for (int i = 0; i < noticeList.size(); i++) {
						Notice notice = noticeList.get(i);
						if (!noticeID.equals(notice.getId())) {
							information = false;
						}
					}
				}
				if (information) {
					Notice temp = noticeService.get(noticeID);
					temp.setSubject(subject);
					temp.setContent(content);
					temp.setScope(Integer.parseInt("".equals(scope) ? "1"
							: scope));
					temp.setVillageID(villageID);
					temp.setTownID(townID);
					temp.setZoneID(zoneID);
					temp.setIsShow("是".equals(isShow) ? true : false);
					temp.setMark(mark);
					noticeService.update(temp);
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
}
