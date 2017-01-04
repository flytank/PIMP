package com.altmm.controller.sys;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.altmm.core.Constant;
import com.altmm.core.JavaEEFrameworkBaseController;
import com.altmm.model.sys.PartyMember;
import com.altmm.model.sys.Role;
import com.altmm.model.sys.SysUser;
import com.altmm.model.sys.Team;
import com.altmm.model.sys.Town;
import com.altmm.model.sys.Village;
import com.altmm.service.sys.ResourceService;
import com.altmm.service.sys.RoleService;
import com.altmm.service.sys.TeamService;

import core.support.QueryResult;

/**
 * @file ResourceController.java
 * @category 资源的控制层
 * @author xumin
 * @date 2016年3月21日 下午1:39:26
 */
@Controller
@RequestMapping("/sys/resource")
public class ResourceController extends JavaEEFrameworkBaseController<SysUser>
		implements Constant {
	@Resource
	private ResourceService resourceService;
	@Resource
	private RoleService roleService;// 角色
	@Resource
	private TeamService teamService;// 党小组

	/**
	 * @Method getVillageSelectListByTownID
	 * @category 通过乡镇编码获取自然村列表
	 * @author xumin
	 * @param @param request
	 * @param @param response
	 * @param @throws Exception
	 * @return void
	 * @date 2016年3月21日 下午1:53:57
	 */
	@RequestMapping(value = "/getVillageSelectListByTownID", method = {
			RequestMethod.POST, RequestMethod.GET })
	public void getVillageSelectListByTownID(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		SysUser loginUser = (SysUser) request.getSession().getAttribute(
				SESSION_SYS_USER);
		String townID = request.getParameter("townID");
		List<Village> villageList = resourceService
				.getVillageListByTownID(townID);
		StringBuilder builder = new StringBuilder();
		builder.append("<select>");
		if (ROLE_ADMIN.equals(loginUser.getRole())
				|| ROLE_ZONE.equals(loginUser.getRole())
				|| ROLE_TOWN.equals(loginUser.getRole())) {// 超级管理员 && 区域管理员 &&
															// 乡镇管理员
			for (int i = 0; i < villageList.size(); i++) {
				builder.append("<option value='" + villageList.get(i).getId()
						+ "'>" + villageList.get(i).getName() + "</option>");
			}
		} else if (ROLE_VILLAGE.equals(loginUser.getRole())) {// 自然村管理员
			for (int i = 0; i < villageList.size(); i++) {
				if (villageList.get(i).getId().equals(loginUser.getVillageID())) {
					builder.append("<option value='"
							+ villageList.get(i).getId() + "'>"
							+ villageList.get(i).getName() + "</option>");
				}
			}
		} else {
			for (int i = 0; i < villageList.size(); i++) {
				if (villageList.get(i).getId().equals(loginUser.getVillageID())) {
					builder.append("<option value='"
							+ villageList.get(i).getId() + "'>"
							+ villageList.get(i).getName() + "</option>");
				}
			}
		}
		builder.append("</select>");
		writeJSON(response, builder.toString());
	}

	/**
	 * @Method getAllVillageListByTownID
	 * @category 通过乡镇编码获取所有自然村列表
	 * @author xumin
	 * @param @param request
	 * @param @param response
	 * @param @throws Exception
	 * @return void
	 * @date 2016年4月23日 下午2:07:36
	 */
	@RequestMapping(value = "/getAllVillageListByTownID", method = {
			RequestMethod.POST, RequestMethod.GET })
	public void getAllVillageListByTownID(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		String townID = request.getParameter("townID");
		List<Village> villageList = resourceService
				.getVillageListByTownID(townID);
		writeJSON(response, villageList);
	}

	/**
	 * @Method getVillageListByTownID
	 * @category 通过乡镇编码获取自然村列表
	 * @author xumin
	 * @param @param request
	 * @param @param response
	 * @param @throws Exception
	 * @return void
	 * @date 2016年3月24日 下午1:37:12
	 */
	@RequestMapping(value = "/getVillageListByTownID", method = {
			RequestMethod.POST, RequestMethod.GET })
	public void getVillageListByTownID(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		String townID = request.getParameter("townID");
		List<Village> villageList = resourceService
				.getVillageListByTownID(townID);
		SysUser loginUser = (SysUser) request.getSession().getAttribute(
				SESSION_SYS_USER);
		List<Village> dataList = new ArrayList<Village>();
		if (ROLE_ADMIN.equals(loginUser.getRole())
				|| ROLE_ZONE.equals(loginUser.getRole())
				|| ROLE_TOWN.equals(loginUser.getRole())) {// 超级管理员 && 区域管理员 &&
															// 乡镇管理员
			dataList = villageList;
		} else if (ROLE_VILLAGE.equals(loginUser.getRole())) {// 自然村管理员
			for (int i = 0; i < villageList.size(); i++) {
				if (villageList.get(i).getId().equals(loginUser.getVillageID())) {
					dataList.add(villageList.get(i));
				}
			}
		} else {
			for (int i = 0; i < villageList.size(); i++) {
				if (villageList.get(i).getId().equals(loginUser.getVillageID())) {
					dataList.add(villageList.get(i));
				}
			}
		}
		writeJSON(response, dataList);
	}

	/**
	 * @Method getTownSelectListByZoneID
	 * @category 通过区域编码获取乡镇列表
	 * @author xumin
	 * @param @param request
	 * @param @param response
	 * @param @throws Exception
	 * @return void
	 * @date 2016年3月21日 下午1:55:11
	 */
	@RequestMapping(value = "/getTownSelectListByZoneID", method = {
			RequestMethod.POST, RequestMethod.GET })
	public void getTownSelectListByZoneID(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		SysUser loginUser = (SysUser) request.getSession().getAttribute(
				SESSION_SYS_USER);
		String zoneID = request.getParameter("zoneID");
		List<Town> townList = resourceService.getTownListByZoneID(zoneID);
		StringBuilder builder = new StringBuilder();
		builder.append("<select>");
		if (ROLE_ADMIN.equals(loginUser.getRole())
				|| ROLE_ZONE.equals(loginUser.getRole())) {// 超级管理员 && 区域管理员
			for (int i = 0; i < townList.size(); i++) {
				builder.append("<option value='" + townList.get(i).getId()
						+ "'>" + townList.get(i).getName() + "</option>");
			}
		} else if (ROLE_TOWN.equals(loginUser.getRole())
				|| ROLE_VILLAGE.equals(loginUser.getRole())) {// 乡镇管理员 &&自然村管理员
			for (int i = 0; i < townList.size(); i++) {
				if (townList.get(i).getId().equals(loginUser.getTownID())) {
					builder.append("<option value='" + townList.get(i).getId()
							+ "'>" + townList.get(i).getName() + "</option>");
				}
			}
		} else {
			for (int i = 0; i < townList.size(); i++) {
				if (townList.get(i).getId().equals(loginUser.getTownID())) {
					builder.append("<option value='" + townList.get(i).getId()
							+ "'>" + townList.get(i).getName() + "</option>");
				}
			}
		}

		builder.append("</select>");
		writeJSON(response, builder.toString());
	}

	/**
	 * @Method getTownByTownID
	 * @category 通过乡镇编码获取乡镇对象
	 * @author xumin
	 * @param @param request
	 * @param @param response
	 * @param @throws Exception
	 * @return void
	 * @date 2016年3月24日 下午2:16:01
	 */
	@RequestMapping(value = "/getTownByTownID", method = { RequestMethod.POST,
			RequestMethod.GET })
	public void getTownByTownID(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		String townID = request.getParameter("townID");
		Town town = resourceService.getTownByTownID(townID);
		writeJSON(response, town);
	}

	/**
	 * @Method getAllTownListByZoneID
	 * @category 通过区域编码获取所有乡镇列表
	 * @author xumin
	 * @param @param request
	 * @param @param response
	 * @param @throws Exception
	 * @return void
	 * @date 2016年4月23日 下午2:08:31
	 */
	@RequestMapping(value = "/getAllTownListByZoneID", method = {
			RequestMethod.POST, RequestMethod.GET })
	public void getAllTownListByZoneID(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		String zoneID = request.getParameter("zoneID");
		List<Town> townList = resourceService.getTownListByZoneID(zoneID);
		writeJSON(response, townList);
	}

	/**
	 * @Method getTownListByZoneID
	 * @category 通过区域编码获取乡镇列表
	 * @author xumin
	 * @param @param request
	 * @param @param response
	 * @param @throws Exception
	 * @return void
	 * @date 2016年3月24日 下午1:37:45
	 */
	@RequestMapping(value = "/getTownListByZoneID", method = {
			RequestMethod.POST, RequestMethod.GET })
	public void getTownListByZoneID(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		String zoneID = request.getParameter("zoneID");
		List<Town> townList = resourceService.getTownListByZoneID(zoneID);
		List<Town> dataList = new ArrayList<Town>();
		SysUser loginUser = (SysUser) request.getSession().getAttribute(
				SESSION_SYS_USER);
		if (ROLE_ADMIN.equals(loginUser.getRole())
				|| ROLE_ZONE.equals(loginUser.getRole())) {// 超级管理员 && 区域管理员
			dataList = townList;
		} else if (ROLE_TOWN.equals(loginUser.getRole())
				|| ROLE_VILLAGE.equals(loginUser.getRole())) {// 乡镇管理员 &&自然村管理员
			for (int i = 0; i < townList.size(); i++) {
				if (townList.get(i).getId().equals(loginUser.getTownID())) {
					dataList.add(townList.get(i));
				}
			}
		} else {
			for (int i = 0; i < townList.size(); i++) {
				if (townList.get(i).getId().equals(loginUser.getTownID())) {
					dataList.add(townList.get(i));
				}
			}
		}
		writeJSON(response, dataList);
	}

	/**
	 * @Method getVillageByVillageID
	 * @category 通过自然村编码获取自然村对象
	 * @author xumin
	 * @param @param request
	 * @param @param response
	 * @param @throws Exception
	 * @return void
	 * @date 2016年3月24日 下午2:17:21
	 */
	@RequestMapping(value = "/getVillageByVillageID", method = {
			RequestMethod.POST, RequestMethod.GET })
	public void getVillageByVillageID(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		String villageID = request.getParameter("villageID");
		Village village = resourceService.getVillageByVillageID(villageID);
		writeJSON(response, village);
	}

	/**
	 * @Method getRoleSelectList
	 * @category 获取所有角色数据的下拉框
	 * @author xumin
	 * @param @param request
	 * @param @param response
	 * @param @throws Exception
	 * @return void
	 * @date 2016年3月26日 上午11:13:21
	 */
	@RequestMapping(value = "/getRoleSelectList", method = {
			RequestMethod.POST, RequestMethod.GET })
	public void getRoleSelectList(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		SysUser loginUser = (SysUser) request.getSession().getAttribute(
				SESSION_SYS_USER);
		List<Role> roleList = roleService.doQueryAll();
		StringBuilder builder = new StringBuilder();
		builder.append("<select>");
		if (ROLE_ADMIN.equals(loginUser.getRole())) {// 超级管理员
			for (int i = 0; i < roleList.size(); i++) {
				builder.append("<option value='" + roleList.get(i).getRoleKey()
						+ "'>" + roleList.get(i).getRoleValue() + "</option>");
			}
		} else if (ROLE_ZONE.equals(loginUser.getRole())) {// 区域管理员
			for (int i = 0; i < roleList.size(); i++) {
				if (!ROLE_ADMIN.equals(roleList.get(i).getRoleKey())) {
					builder.append("<option value='"
							+ roleList.get(i).getRoleKey() + "'>"
							+ roleList.get(i).getRoleValue() + "</option>");
				}
			}
		} else if (ROLE_TOWN.equals(loginUser.getRole())) {// 乡镇管理员
			for (int i = 0; i < roleList.size(); i++) {
				if (!ROLE_ADMIN.equals(roleList.get(i).getRoleKey())
						&& !ROLE_ZONE.equals(roleList.get(i).getRoleKey())) {
					builder.append("<option value='"
							+ roleList.get(i).getRoleKey() + "'>"
							+ roleList.get(i).getRoleValue() + "</option>");
				}
			}
		} else if (ROLE_VILLAGE.equals(loginUser.getRole())) {// 自然村管理员
			for (int i = 0; i < roleList.size(); i++) {
				if (!ROLE_ADMIN.equals(roleList.get(i).getRoleKey())
						&& !ROLE_ZONE.equals(roleList.get(i).getRoleKey())
						&& !ROLE_TOWN.equals(roleList.get(i).getRoleKey())) {
					builder.append("<option value='"
							+ roleList.get(i).getRoleKey() + "'>"
							+ roleList.get(i).getRoleValue() + "</option>");
				}
			}
		} else {
			for (int i = 0; i < roleList.size(); i++) {
				if (!ROLE_ADMIN.equals(roleList.get(i).getRoleKey())
						&& !ROLE_ZONE.equals(roleList.get(i).getRoleKey())
						&& !ROLE_TOWN.equals(roleList.get(i).getRoleKey())
						&& !ROLE_VILLAGE.equals(roleList.get(i).getRoleKey())) {
					builder.append("<option value='"
							+ roleList.get(i).getRoleKey() + "'>"
							+ roleList.get(i).getRoleValue() + "</option>");
				}
			}
		}
		builder.append("</select>");
		writeJSON(response, builder.toString());
	}

	/**
	 * @Method getRoleList
	 * @category 获取所有角色数据列表
	 * @author xumin
	 * @param @param request
	 * @param @param response
	 * @param @throws Exception
	 * @return void
	 * @date 2016年3月26日 上午10:40:09
	 */
	@RequestMapping(value = "/getRoleList", method = { RequestMethod.POST,
			RequestMethod.GET })
	public void getRoleList(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		List<Role> roleList = roleService.doQueryAll();
		List<Role> dataList = new ArrayList<Role>();
		SysUser loginUser = (SysUser) request.getSession().getAttribute(
				SESSION_SYS_USER);
		if (ROLE_ADMIN.equals(loginUser.getRole())) {// 超级管理员
			dataList = roleList;
		} else if (ROLE_ZONE.equals(loginUser.getRole())) {// 区域管理员
			for (int i = 0; i < roleList.size(); i++) {
				if (!ROLE_ADMIN.equals(roleList.get(i).getRoleKey())) {
					dataList.add((Role) roleList.get(i));
				}
			}
		} else if (ROLE_TOWN.equals(loginUser.getRole())) {// 乡镇管理员
			for (int i = 0; i < roleList.size(); i++) {
				if (!ROLE_ADMIN.equals(roleList.get(i).getRoleKey())
						&& !ROLE_ZONE.equals(roleList.get(i).getRoleKey())) {
					dataList.add((Role) roleList.get(i));
				}
			}
		} else if (ROLE_VILLAGE.equals(loginUser.getRole())) {// 自然村管理员
			for (int i = 0; i < roleList.size(); i++) {
				if (!ROLE_ADMIN.equals(roleList.get(i).getRoleKey())
						&& !ROLE_ZONE.equals(roleList.get(i).getRoleKey())
						&& !ROLE_TOWN.equals(roleList.get(i).getRoleKey())) {
					dataList.add((Role) roleList.get(i));
				}
			}
		} else {
			for (int i = 0; i < roleList.size(); i++) {
				if (!ROLE_ADMIN.equals(roleList.get(i).getRoleKey())
						&& !ROLE_ZONE.equals(roleList.get(i).getRoleKey())
						&& !ROLE_TOWN.equals(roleList.get(i).getRoleKey())
						&& !ROLE_VILLAGE.equals(roleList.get(i).getRoleKey())) {
					dataList.add((Role) roleList.get(i));
				}
			}
		}
		writeJSON(response, dataList);
	}

	/**
	 * @Method getTeamList
	 * @category 获取所有党小组数据列表
	 * @author xumin
	 * @param @param request
	 * @param @param response
	 * @param @throws Exception
	 * @return void
	 * @date 2016年3月26日 上午11:15:41
	 */
	@RequestMapping(value = "/getTeamList", method = { RequestMethod.POST,
			RequestMethod.GET })
	public void getTeamList(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		SysUser loginUser = (SysUser) request.getSession().getAttribute(
				SESSION_SYS_USER);
		Team team = new Team();
		if (ROLE_ADMIN.equals(loginUser.getRole())) {// 超级管理员 && 区域管理员

		} else if (ROLE_TOWN.equals(loginUser.getRole())) {// 乡镇管理员
			team.set$eq_townID(loginUser.getTownID());
		} else if (ROLE_VILLAGE.equals(loginUser.getRole())) {// 自然村管理员
			team.set$eq_townID(loginUser.getTownID());
			team.set$eq_villageID(loginUser.getVillageID());
		} else {
			team.set$eq_townID(loginUser.getTownID());
			team.set$eq_villageID(loginUser.getVillageID());
		}
		// List<Team> resultList = teamService.doQueryAll();
		QueryResult<Team> queryResult = teamService.doPaginationQuery(team);
		writeJSON(response, queryResult.getResultList());
	}

	/**
	 * @Method getTeamListByArea
	 * @category 通过地区获取小组名称
	 * @author xumin
	 * @param @param request
	 * @param @param response
	 * @param @throws Exception
	 * @return void
	 * @date 2016年3月26日 下午3:35:53
	 */
	@RequestMapping(value = "/getTeamListByArea", method = {
			RequestMethod.POST, RequestMethod.GET })
	public void getTeamListByArea(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		String villageID = request.getParameter("villageID");// 村编码
		String townID = request.getParameter("townID");// 乡镇编码
		List<Team> resultList = new ArrayList<Team>();
		if (null == villageID || "" == villageID) {
			resultList = teamService.queryByProerties("townID", townID);
		} else {
			String[] propName = new String[] { "villageID", "townID" };
			Object[] propValue = new Object[] { villageID, townID };
			resultList = teamService.queryByProerties(propName, propValue);
		}
		// 将名称添上**镇**村
		// List<Team> teamList = teamService.queryTeamCn2List(resultList);
		writeJSON(response, resultList);
	}

	/**
	 * @Method getPartyMemberList
	 * @category 获取所有党员类别数据列表
	 * @author xumin
	 * @param @param request
	 * @param @param response
	 * @param @throws Exception
	 * @return void
	 * @date 2016年3月26日 上午11:21:38
	 */
	@RequestMapping(value = "/getPartyMemberList", method = {
			RequestMethod.POST, RequestMethod.GET })
	public void getPartyMemberList(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		List<PartyMember> sortList = resourceService.getPartyMemberList();
		writeJSON(response, sortList);
	}
	
	/**
	 * 
	 * @Method checkUserName
	 * @category 前端登录名输入验证唯一性
	 * @author taotouhong
	 * @return void
	 * @date 2016年4月18日 下午10:40:15
	 */
	@RequestMapping(value = "/getCheckUserName")
	public void checkUserName( HttpServletRequest request,
			HttpServletResponse response) throws Exception {
//		authorityFilter("checkUserName", request, response);
		String loginName=request.getParameter("selectLoginName");
		System.out.println("jj"+loginName);
		String flag="false";
		System.out.println("发过来了……");
		SysUser user=resourceService.checkLoginName(loginName);
		if(user!=null){
			flag="true";
		}
//		response.setContentType("text/json;charset=UTF-8");
//		PrintWriter out=response.getWriter();
//		out.write(flag);
		writeJSON(response, flag);
	}

}
