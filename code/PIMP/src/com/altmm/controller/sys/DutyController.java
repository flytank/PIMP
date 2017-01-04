package com.altmm.controller.sys;

import java.io.IOException;
import java.io.OutputStream;
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
import com.altmm.model.sys.Duty;
import com.altmm.service.sys.DutyService;

import core.support.ExtJSBaseParameter;
import core.support.JqGridPageView;
import core.support.QueryResult;

/**
 * 职责的控制层
 * 
 * 
 */
@Controller
@RequestMapping("/sys/duty")
public class DutyController extends JavaEEFrameworkBaseController<Duty>
		implements Constant {

	@Resource
	private DutyService dutyService;

	// 查询职责的表格，包括分页、搜索和排序
	@RequestMapping(value = "/getDuty", method = { RequestMethod.POST,
			RequestMethod.GET })
	public void getDuty(HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		Integer firstResult = Integer.valueOf(request.getParameter("page"));
		Integer maxResults = Integer.valueOf(request.getParameter("rows"));
		String sortedObject = request.getParameter("sidx");
		String sortedValue = request.getParameter("sord");
		String filters = request.getParameter("filters");
		Duty duty = new Duty();
		if (StringUtils.isNotBlank(filters)) {
			JSONObject jsonObject = JSONObject.fromObject(filters);
			JSONArray jsonArray = (JSONArray) jsonObject.get("rules");
			for (int i = 0; i < jsonArray.size(); i++) {
				JSONObject result = (JSONObject) jsonArray.get(i);
				if (result.getString("field").equals("id")
						&& result.getString("op").equals("eq")) {
					duty.setId(result.getString("data"));
				}
				if (result.getString("field").equals("dutyName")
						&& result.getString("op").equals("cn")) {
					duty.setDutyName(result.getString("data"));
				}
			}

		}
		duty.setFirstResult((firstResult - 1) * maxResults);
		duty.setMaxResults(maxResults);
		Map<String, String> sortedCondition = new HashMap<String, String>();
		sortedCondition.put(sortedObject, sortedValue);
		duty.setSortedConditions(sortedCondition);
		QueryResult<Duty> queryResult = dutyService.doPaginationQuery(duty);
		JqGridPageView<Duty> authorityListView = new JqGridPageView<Duty>();
		authorityListView.setMaxResults(maxResults);
		authorityListView.setRows(queryResult.getResultList());
		authorityListView.setRecords(queryResult.getTotalCount());
		writeJSON(response, authorityListView);
	}

	// 保存菜单的实体Bean

	@RequestMapping(value = "/saveDuty", method = { RequestMethod.POST,
			RequestMethod.GET })
	public void doSave(Duty entity, HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		ExtJSBaseParameter parameter = ((ExtJSBaseParameter) entity);
		if (CMD_EDIT.equals(parameter.getCmd())) {
			dutyService.update(entity);
		} else if (CMD_NEW.equals(parameter.getCmd())) {
			dutyService.persist(entity);
		}
		parameter.setSuccess(true);
		writeJSON(response, parameter);
	}

	// 操作菜单的删除、导出Excel、字段判断和保存
	@RequestMapping(value = "/operateDuty", method = { RequestMethod.POST,
			RequestMethod.GET })
	public void operateAuthority(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		String oper = request.getParameter("oper");
		String id = request.getParameter("id");
		if (oper.equals("del")) {
			String[] ids = id.split(",");
			deleteDuty(request, response, ids);
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
			Map<String, Object> result = new HashMap<String, Object>();
			// String ids = request.getParameter("id");
			String dutyName = request.getParameter("dutyName");
			String mark = request.getParameter("mark");
			String points = request.getParameter("points");
			Duty duty = null;
			if (oper.equals("edit")) {
				duty = dutyService.get(id);
			}
			Duty menuCodeAuthority = dutyService.getByProerties("id", id);
			// Authority parentMenuCodeAuthority = authorityService
			// .getByProerties("menuCode", parentMenuCode);
			if (StringUtils.isBlank(id) || StringUtils.isBlank(dutyName)
					|| StringUtils.isBlank(mark) || StringUtils.isBlank(points)) {
				response.setStatus(HttpServletResponse.SC_LENGTH_REQUIRED);
				result.put("message", "请填写职责编码、职责名称、备注和积分值");
				writeJSON(response, result);
			} else if (null != menuCodeAuthority && oper.equals("add")) {
				response.setStatus(HttpServletResponse.SC_CONFLICT);
				result.put("message", "此菜单编码已存在，请重新输入");
				writeJSON(response, result);
			} else if (null != menuCodeAuthority
					&& !duty.getId().equalsIgnoreCase(id)
					&& oper.equals("edit")) {
				response.setStatus(HttpServletResponse.SC_CONFLICT);
				result.put("message", "此菜单编码已存在，请重新输入");
				writeJSON(response, result);
			} else {
				Duty entity = new Duty();
				entity.setId(id);
				entity.setDutyName(dutyName);
				entity.setMark(mark);
				entity.setPoints(Double.valueOf(points));
				if (oper.equals("edit")) {
					entity.setCmd("edit");
					doSave(entity, request, response);
				} else if (oper.equals("add")) {
					entity.setCmd("new");
					doSave(entity, request, response);
				}
			}
		}
	}

	// 删除菜单
	@RequestMapping("/deleteDuty")
	public void deleteDuty(HttpServletRequest request,
			HttpServletResponse response, @RequestParam("ids") String[] ids)
			throws IOException {
		boolean flag = dutyService.deleteByPK(ids);
		if (flag) {
			writeJSON(response, "{success:true}");
		} else {
			writeJSON(response, "{success:false}");
		}
	}

	// 获取菜单树
	// @RequestMapping("/getAuthorityTreeList")
	// public void getAuthorityTreeList(HttpServletRequest request,
	// HttpServletResponse response) throws Exception {
	// String id = request.getParameter("id");
	// String roleKey = request.getParameter("roleKey");
	// if (id.equals("0")) {
	// List<Authority> mainMenuList = authorityService.queryByProerties(
	// "parentMenuCode", "0");
	// JSONObject allJSONObject = new JSONObject();
	// JSONArray jsonArray = new JSONArray();
	// for (int i = 0; i < mainMenuList.size(); i++) {
	// JSONObject mainJsonObject = new JSONObject();
	// mainJsonObject.element("id", mainMenuList.get(i).getMenuCode());
	// mainJsonObject.element("name", mainMenuList.get(i)
	// .getMenuName());
	// mainJsonObject.element("type", "folder");
	// mainJsonObject.element("children", true);
	// mainJsonObject.element("additionalParameters", mainJsonObject);
	// jsonArray.add(mainJsonObject);
	// }
	// allJSONObject.element("status", "OK");
	// allJSONObject.element("data", jsonArray);
	// writeJSON(response, allJSONObject);
	// } else {
	// List<RoleAuthority> roleAuthorityList = roleAuthorityService
	// .queryByProerties("roleKey", roleKey);
	// List<String> menuCodeList = new ArrayList<String>();
	// for (int j = 0; j < roleAuthorityList.size(); j++) {
	// menuCodeList.add(roleAuthorityList.get(j).getMenuCode());
	// }
	// Authority authority = authorityService.getByProerties("menuCode",
	// id);
	// List<Authority> subMenuList = authorityService.queryByProerties(
	// "parentMenuCode", authority.getMenuCode());
	// JSONObject allJSONObject = new JSONObject();
	// JSONArray jsonArray = new JSONArray();
	// for (int i = 0; i < subMenuList.size(); i++) {
	// JSONObject subJsonObject = new JSONObject();
	// subJsonObject.element("id", subMenuList.get(i).getMenuCode());
	// subJsonObject.element("name", subMenuList.get(i).getMenuName());
	// subJsonObject.element("type", "item");
	// if (menuCodeList.contains(subMenuList.get(i).getMenuCode())) {
	// subJsonObject.element("item-selected", true);
	// } else {
	// subJsonObject.element("item-selected", false);
	// }
	// subJsonObject.element("additionalParameters", subJsonObject);
	// jsonArray.add(subJsonObject);
	// }
	// allJSONObject.element("status", "OK");
	// allJSONObject.element("data", jsonArray);
	// writeJSON(response, allJSONObject);
	// }
	// }
	/**
	 * @Method getDutyList
	 * @category 得到所有职责列表
	 * @author xumin
	 * @param @param request
	 * @param @param response
	 * @param @throws Exception
	 * @return void
	 * @date 2016年4月10日 上午9:10:33
	 */
	@RequestMapping(value = "/getDutyList", method = { RequestMethod.POST,
			RequestMethod.GET })
	public void getDutyList(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		List<Duty> dutyList = dutyService.doQueryAll();
		writeJSON(response, dutyList);
	}
}
