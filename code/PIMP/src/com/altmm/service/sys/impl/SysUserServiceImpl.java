package com.altmm.service.sys.impl;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Service;

import com.altmm.core.Constant;
import com.altmm.dao.sys.PartyMemberDao;
import com.altmm.dao.sys.RoleDao;
import com.altmm.dao.sys.SysUserDao;
import com.altmm.dao.sys.TeamDao;
import com.altmm.dao.sys.TownDao;
import com.altmm.dao.sys.VillageDao;
import com.altmm.dao.sys.ZoneDao;
import com.altmm.model.sys.PartyMember;
import com.altmm.model.sys.Role;
import com.altmm.model.sys.SysUser;
import com.altmm.model.sys.Team;
import com.altmm.model.sys.Town;
import com.altmm.model.sys.Village;
import com.altmm.model.sys.Zone;
import com.altmm.service.sys.SysUserService;

import core.service.BaseService;

/**
 * 用户的业务逻辑层的实现
 * 
 */
@Service
public class SysUserServiceImpl extends BaseService<SysUser> implements
		SysUserService {

	private SysUserDao sysUserDao;// 用户接口
	@Resource
	private PartyMemberDao partyMemberDao;// 党员类别表接口
	@Resource
	private TeamDao teamDao;// 党小组接口
	@Resource
	private TownDao townDao;// 乡镇表的接口
	@Resource
	private VillageDao villageDao;// 自然村表的接口
	@Resource
	private ZoneDao zoneDao;// 区域表的接口
	@Resource
	private RoleDao roleDao;// 角色接口

	@Resource
	public void setSysUserDao(SysUserDao sysUserDao) {
		this.sysUserDao = sysUserDao;
		this.dao = sysUserDao;
	}

	// 获取用户信息（将数据库查询出来的信息再处理，增加字段的中文意思）

	public List<SysUser> querySysUserCnList(List<SysUser> resultList) {
		List<SysUser> sysUserList = new ArrayList<SysUser>();
		for (SysUser entity : resultList) {
			SysUser sysUser = new SysUser();
			sysUser = entity;
			if (1 == sysUser.getIdentity()) {// 身份
				sysUser.setIdentityCn("党员");
			} else if (2 == sysUser.getIdentity()) {
				sysUser.setIdentityCn("入党积极分子");
			} else if (3 == sysUser.getIdentity()) {
				sysUser.setIdentityCn("群众");
			} else {
				sysUser.setIdentityCn("未知");
			}
			if (null != sysUser.getSortID() && !sysUser.getSortID().isEmpty()) {
				// 查询党员类别名称
				PartyMember obj = partyMemberDao.get(sysUser.getSortID());
				if (null != obj) {
					sysUser.setSortCn(obj.getPartyName());
				}
			}
			if (null != sysUser.getTeamID() && !sysUser.getTeamID().isEmpty()) {
				// 查询党小组名称
				Team obj = teamDao.get(sysUser.getTeamID());
				if (null != obj) {
					sysUser.setTeamCn(obj.getTeamName());
				}
			}
			if (null != sysUser.getVillageID()
					&& !sysUser.getVillageID().isEmpty()) {
				// 查询自然村编码
				Village obj = villageDao.get(sysUser.getVillageID());
				if (null != obj) {
					sysUser.setVillageCn(obj.getName());
				}
			}
			if (null != sysUser.getTownID() && !sysUser.getTownID().isEmpty()) {
				// 查询乡镇编码
				Town obj = townDao.get(sysUser.getTownID());
				if (null != obj) {
					sysUser.setTownCn(obj.getName());
				}
			}
			if (null != sysUser.getZoneID() && !sysUser.getZoneID().isEmpty()) {
				// 查询区域编码
				Zone obj = zoneDao.get(sysUser.getZoneID());
				if (null != obj) {
					sysUser.setZoneCn(obj.getName());
				}
			}
			if (null != entity.getRole() && !sysUser.getRole().isEmpty()) {
				// 查询角色编码
				Role obj = roleDao.getByProerties("roleKey", entity.getRole());
				if (null != obj) {
					sysUser.setRoleCn(obj.getDescription());
				}
			}
			if (1 == sysUser.getStatus()) {
				sysUser.setStatusCn("已激活");
			} else if (2 == sysUser.getStatus()) {
				sysUser.setStatusCn("未激活");
			} else if (3 == sysUser.getStatus()) {
				sysUser.setStatusCn("停用");
			} else {
				sysUser.setStatusCn("未知");
			}
			sysUserList.add(sysUser);
		}
		return sysUserList;
	}

	// 获取用户信息（将数据库查询出来的信息再处理，增加字段的中文意思）

	public SysUser querySysUserCn(SysUser entity) {
		SysUser sysUser = new SysUser();
		sysUser = entity;
		if (1 == sysUser.getIdentity()) {// 身份
			sysUser.setIdentityCn("党员");
		} else if (2 == sysUser.getIdentity()) {
			sysUser.setIdentityCn("入党积极分子");
		} else if (3 == sysUser.getIdentity()) {
			sysUser.setIdentityCn("群众");
		} else {
			sysUser.setIdentityCn("未知");
		}
		if (null != sysUser.getSortID() && !sysUser.getSortID().isEmpty()) {
			// 查询党员类别名称
			PartyMember obj = partyMemberDao.get(sysUser.getSortID());
			if (null != obj) {
				sysUser.setSortCn(obj.getPartyName());
			}
		}
		if (null != sysUser.getTeamID() && !sysUser.getTeamID().isEmpty()) {
			// 查询党小组名称
			Team obj = teamDao.get(sysUser.getTeamID());
			if (null != obj) {
				sysUser.setTeamCn(obj.getTeamName());
			}
		}
		if (null != sysUser.getVillageID() && !sysUser.getVillageID().isEmpty()) {
			// 查询自然村编码
			Village obj = villageDao.get(sysUser.getVillageID());
			if (null != obj) {
				sysUser.setVillageCn(obj.getName());
			}
		}
		if (null != sysUser.getTownID() && !sysUser.getTownID().isEmpty()) {
			// 查询乡镇编码
			Town obj = townDao.get(sysUser.getTownID());
			if (null != obj) {
				sysUser.setTownCn(obj.getName());
			}
		}
		if (null != sysUser.getZoneID() && !sysUser.getZoneID().isEmpty()) {
			// 查询区域编码
			Zone obj = zoneDao.get(sysUser.getZoneID());
			if (null != obj) {
				sysUser.setZoneCn(obj.getName());
			}
		}
		if (null != entity.getRole() && !sysUser.getRole().isEmpty()) {
			// 查询角色编码
			Role obj = roleDao.getByProerties("roleKey", entity.getRole());
			if (null != obj) {
				sysUser.setRoleCn(obj.getDescription());
			}
		}
		if (1 == sysUser.getStatus()) {
			sysUser.setStatusCn("已激活");
		} else if (2 == sysUser.getStatus()) {
			sysUser.setStatusCn("未激活");
		} else if (3 == sysUser.getStatus()) {
			sysUser.setStatusCn("停用");
		} else {
			sysUser.setStatusCn("未知");
		}
		return sysUser;
	}

	// 获取个人资料信息（将数据库查询出来的信息再处理，增加头像）

	// public SysUser getSysUserWithAvatar(SysUser sysuser) { SysUser entity =
	// new SysUser(); entity.setId(sysuser.getId());
	// entity.setUserName(sysuser.getUserName());
	// entity.setSex(sysuser.getSex()); entity.setEmail(sysuser.getEmail());
	// entity.setPhone(sysuser.getPhone());
	// entity.setBirthday(sysuser.getBirthday());
	// entity.setPassword(sysuser.getPassword());
	// entity.setRole(sysuser.getRole()); entity.setStatus(sysuser.getStatus());
	// entity.setLastLoginTime(sysuser.getLastLoginTime());
	//
	// Attachment attachment = attachmentDao .getByProerties(new String[] {
	// "type", "typeId" }, new Object[] { (short) 1, sysuser.getId() });
	//
	//
	// if (null != attachment) { entity.setFilePath(attachment.getFilePath()); }
	// else { entity.setFilePath("/static/assets/avatars/profile-pic.jpg"); }
	//
	// return entity; }
	//

	/*
	 * public String updateSysUser(UpdateUserPwdRequestBean brb) {
	 * brb.setPassword(MD5.crypt(brb.getPassword()));
	 * sysUserDao.updateByProperties("userName", brb.getUsername(), "password",
	 * brb.getPassword()); return "success"; }
	 */
	/**
	 * @Method JudgeRole
	 * @category 根据乡镇村判断当前用户是否有此区域操作权限
	 * @author xumin
	 * @param @param townID
	 * @param @param villageID
	 * @param @param request
	 * @param @param response
	 * @param @return
	 * @return boolean
	 * @date 2016年4月16日 下午7:59:22
	 */
	public boolean JudgeRole(String townID, String villageID,
			HttpServletRequest request, HttpServletResponse response) {
		SysUser loginUser = (SysUser) request.getSession().getAttribute(
				Constant.SESSION_SYS_USER);
		boolean information = true;
		if (Constant.ROLE_ADMIN.equals(loginUser.getRole())) {// 超级管理员
			information = true;
		} else if (Constant.ROLE_ZONE.equals(loginUser.getRole())) {// 区域管理员
			information = true;
		} else if (Constant.ROLE_TOWN.equals(loginUser.getRole())) {// 乡镇管理员
			if (townID.equals(loginUser.getTownID())) {// 同乡镇
				information = true;
			} else {
				information = false;
			}
		} else if (Constant.ROLE_VILLAGE.equals(loginUser.getRole())) {// 自然村管理员
			if (townID.equals(loginUser.getTownID())
					&& villageID.equals(loginUser.getVillageID())) {// 同乡镇村
				information = true;
			} else {
				information = false;
			}
		} else {
			information = false;
		}
		return information;
	}
}
