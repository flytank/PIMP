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
import com.altmm.model.sys.SysUser;
import com.altmm.model.sys.Team;
import com.altmm.service.sys.SysUserService;
import com.altmm.service.sys.TeamService;

import core.support.ExtJSBaseParameter;
import core.support.JqGridPageView;
import core.support.QueryResult;

/**
 * @file TeamController.java
 * @category 党小组的控制层
 * @author xumin
 * @date 2016年3月23日 下午3:06:46
 */
@Controller
@RequestMapping("/sys/team")
public class TeamController extends JavaEEFrameworkBaseController<Team>
		implements Constant {

	@Resource
	private TeamService teamService;
	@Resource
	private SysUserService userService;

	// 查询党小组的表格，包括分页、搜索和排序
	@RequestMapping(value = "/getTeam", method = { RequestMethod.POST,
			RequestMethod.GET })
	public void getTeam(HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		SysUser loginUser = (SysUser) request.getSession().getAttribute(
				SESSION_SYS_USER);
		Integer firstResult = Integer.valueOf(request.getParameter("page"));
		Integer maxResults = Integer.valueOf(request.getParameter("rows"));
		String sortedObject = request.getParameter("sidx");
		String sortedValue = request.getParameter("sord");
		String filters = request.getParameter("filters");
		Team obj = new Team();
		if (ROLE_ADMIN.equals(loginUser.getRole())
				|| ROLE_ZONE.equals(loginUser.getRole())) {// 超级管理员 && 区域管理员
		} else if (ROLE_TOWN.equals(loginUser.getRole())) {// 乡镇管理员
			obj.set$eq_townID(loginUser.getTownID());
		} else if (ROLE_VILLAGE.equals(loginUser.getRole())) {// 自然村管理员
			obj.set$eq_townID(loginUser.getTownID());
			obj.set$eq_villageID(loginUser.getVillageID());
		} else {
			obj.set$eq_townID(loginUser.getTownID());
			obj.set$eq_villageID(loginUser.getVillageID());
		}
		if (StringUtils.isNotBlank(filters)) {
			JSONObject jsonObject = JSONObject.fromObject(filters);
			JSONArray jsonArray = (JSONArray) jsonObject.get("rules");
			for (int i = 0; i < jsonArray.size(); i++) {
				JSONObject result = (JSONObject) jsonArray.get(i);
				if (result.getString("field").equals("teamName")
						&& result.getString("op").equals("cn")) {// 蘑菇匹配名称
					obj.set$like_teamName(result.getString("data"));
				}
				if (result.getString("field").equals("townID")
						&& result.getString("op").equals("eq")) {// 匹配乡镇
					obj.set$eq_townID(result.getString("data"));
				}
				if (result.getString("field").equals("villageID")
						&& result.getString("op").equals("eq")) {// 匹配自然村
					obj.set$eq_villageID(result.getString("data"));
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
		QueryResult<Team> queryResult = teamService.doPaginationQuery(obj);
		JqGridPageView<Team> roleListView = new JqGridPageView<Team>();
		roleListView.setMaxResults(maxResults);
		List<Team> teamCnList = teamService.queryTeamCnList(queryResult
				.getResultList());
		roleListView.setRows(teamCnList);
		roleListView.setRecords(queryResult.getTotalCount());
		writeJSON(response, roleListView);
	}

	// 保存党小组的实体Bean
	@RequestMapping(value = "/saveTeam", method = { RequestMethod.POST,
			RequestMethod.GET })
	public void doSave(Team entity, HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		ExtJSBaseParameter parameter = ((ExtJSBaseParameter) entity);
		if (CMD_EDIT.equals(parameter.getCmd())) {
			teamService.update(entity);
		} else if (CMD_NEW.equals(parameter.getCmd())) {
			teamService.persist(entity);
		}
		parameter.setSuccess(true);
		writeJSON(response, parameter);
	}

	// 操作党小组的删除、导出Excel、字段判断和保存
	@RequestMapping(value = "/operateTeam", method = { RequestMethod.POST,
			RequestMethod.GET })
	public void operateTeam(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		String oper = request.getParameter("oper");
		String id = request.getParameter("id");
		if (oper.equals("del")) {
			String[] ids = id.split(",");
			deleteTeam(request, response, ids);
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
			// Team role = null;
			// if (oper.equals("edit")) {
			// role = teamService.get(Long.valueOf(id));
			// }
			// Team roleKeyTeam = teamService.getByProerties("roleKey",
			// roleKey);
			// if (StringUtils.isBlank(roleKey) ||
			// StringUtils.isBlank(roleValue)) {
			// response.setStatus(HttpServletResponse.SC_LENGTH_REQUIRED);
			// result.put("message", "请填写党小组编码和党小组名称");
			// writeJSON(response, result);
			// } else if (null != roleKeyTeam && oper.equals("add")) {
			// response.setStatus(HttpServletResponse.SC_CONFLICT);
			// result.put("message", "此党小组编码已存在，请重新输入");
			// writeJSON(response, result);
			// } else if (null != roleKeyTeam
			// && !role.getTeamKey().equalsIgnoreCase(roleKey)
			// && oper.equals("edit")) {
			// response.setStatus(HttpServletResponse.SC_CONFLICT);
			// result.put("message", "此党小组编码已存在，请重新输入");
			// writeJSON(response, result);
			// } else {
			// Team entity = new Team();
			// entity.setTeamKey(roleValue);
			// entity.setTeamValue(roleValue);
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

	// 删除党小组
	@RequestMapping("/deleteTeam")
	public void deleteTeam(HttpServletRequest request,
			HttpServletResponse response, @RequestParam("ids") String[] ids)
			throws IOException {
		boolean flag = teamService.deleteByPK(ids);
		if (flag) {
			writeJSON(response, "{success:true}");
		} else {
			writeJSON(response, "{success:false}");
		}
	}

	/**
	 * @Method getTeamById
	 * @category 通过党小组ID获取党小组信息
	 * @author xumin
	 * @param @param request
	 * @param @param response
	 * @param @throws Exception
	 * @return void
	 * @date 2016年3月23日 下午3:40:41
	 */
	@RequestMapping(value = "/getTeamById", method = { RequestMethod.POST,
			RequestMethod.GET })
	public void getTeamById(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		String id = request.getParameter("id");
		Team team = teamService.get(id);
		writeJSON(response, team);
	}

	/**
	 * @Method verifySaveTeam
	 * @category 验证并保存党小组对象
	 * @author xumin
	 * @param @param request
	 * @param @param response
	 * @param @throws Exception
	 * @return void
	 * @date 2016年3月24日 下午2:34:02
	 */
	@RequestMapping(value = "/verifySaveTeam", method = { RequestMethod.POST,
			RequestMethod.GET })
	public void verifySaveTeam(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		String teamID = request.getParameter("teamID");// 党小组编码
		String teamName = request.getParameter("teamName");// 党小组名称
		String villageID = request.getParameter("villageID");// 自然村编码
		String townID = request.getParameter("townID");// 乡镇编码
		String zoneID = request.getParameter("zoneID");// 区域编码
		String mark = request.getParameter("mark");// 备注
		boolean information = true;
		information = userService.JudgeRole(townID, villageID, request,
				response);
		String returnString = "";
		if (information) {
			String[] propName = new String[] { "teamName", "villageID",
					"townID" };
			Object[] propValue = new Object[] { teamName, villageID, townID };
			List<Team> teamList = teamService.queryByProerties(propName,
					propValue);
			Team entity = new Team();
			entity.setTeamName(teamName);
			entity.setVillageID(villageID);
			entity.setTownID(townID);
			entity.setZoneID(zoneID);
			entity.setMark(mark);
			if ("" == teamID) {// 党小组ID不存在，新增验证
				if (null != teamList && teamList.size() > 0) {
					information = false;
				} else {
					teamService.persist(entity);
				}
			} else {// 党小组ID存在，更新验证
				if (null != teamList) {
					for (int i = 0; i < teamList.size(); i++) {
						Team team = teamList.get(i);
						if (!teamID.equals(team.getId())) {
							information = false;
						}
					}
				}
				if (information) {
					Team temp = teamService.get(teamID);
					temp.setTeamName(teamName);
					temp.setVillageID(villageID);
					temp.setTownID(townID);
					temp.setZoneID(zoneID);
					temp.setMark(mark);
					teamService.update(temp);
				}
			}
			if (information) {
				returnString = "{success:true,information:'保存成功'}";
			} else {
				returnString = "{success:false,information:'党小组名称存在，保存失败'}";
			}
		} else {
			returnString = "{success:false,information:'当前用户权限不足'}";
		}
		writeJSON(response, returnString);
	}
}
