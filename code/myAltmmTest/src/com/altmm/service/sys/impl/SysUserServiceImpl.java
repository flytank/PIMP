package com.altmm.service.sys.impl;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Service;

import com.altmm.dao.sys.AttachmentDao;
import com.altmm.dao.sys.DepartmentDao;
import com.altmm.dao.sys.SysUserDao;
import com.altmm.model.sys.Attachment;
import com.altmm.model.sys.Department;
import com.altmm.model.sys.SysUser;
import com.altmm.service.sys.SysUserService;
import com.app.bean.UpdateUserPwdRequestBean;

import core.service.BaseService;
import core.util.MD5;

/**
 * 用户的业务逻辑层的实现
 * 
 */
@Service
public class SysUserServiceImpl extends BaseService<SysUser>implements SysUserService {

	private SysUserDao sysUserDao;
	@Resource
	private AttachmentDao attachmentDao;
	@Resource
	private DepartmentDao departmentDao;

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
			sysUser.setId(entity.getId());
			sysUser.setUserName(entity.getUserName());
			sysUser.setSex(entity.getSex());
			if (entity.getSex() == 1) {
				sysUser.setSexCn("男");
			} else if (entity.getSex() == 2) {
				sysUser.setSexCn("女");
			}
			sysUser.setEmail(entity.getEmail());
			sysUser.setPhone(entity.getPhone());
			sysUser.setBirthday(entity.getBirthday());
			sysUser.setDepartmentKey(entity.getDepartmentKey());
			if (StringUtils.isNotBlank(sysUser.getDepartmentKey())) {
				Department department = departmentDao.getByProerties("departmentKey", sysUser.getDepartmentKey());
				sysUser.setDepartmentValue(department.getDepartmentValue());
			}
			sysUser.setPassword(entity.getPassword());
			sysUser.setRole(entity.getRole());
			if (entity.getRole().equals("ROLE_ADMIN")) {
				sysUser.setRoleCn("超级管理员");
			} else if (entity.getRole().equals("ROLE_RESTRICTED_ADMIN")) {
				sysUser.setRoleCn("普通管理员");
			} else if (entity.getRole().equals("ROLE_USER")) {
				sysUser.setRoleCn("普通用户");
			}
			if (entity.getStatus() == true) {
				sysUser.setStatusCn("是");
			} else {
				sysUser.setStatusCn("否");
			}
			sysUser.setLastLoginTime(entity.getLastLoginTime());
			sysUserList.add(sysUser);
		}
		return sysUserList;
	}

	// 获取个人资料信息（将数据库查询出来的信息再处理，增加头像）

	public SysUser getSysUserWithAvatar(SysUser sysuser) {
		SysUser entity = new SysUser();
		entity.setId(sysuser.getId());
		entity.setUserName(sysuser.getUserName());
		entity.setSex(sysuser.getSex());
		entity.setEmail(sysuser.getEmail());
		entity.setPhone(sysuser.getPhone());
		entity.setBirthday(sysuser.getBirthday());
		entity.setPassword(sysuser.getPassword());
		entity.setRole(sysuser.getRole());
		entity.setStatus(sysuser.getStatus());
		entity.setLastLoginTime(sysuser.getLastLoginTime());
		Attachment attachment = attachmentDao.getByProerties(new String[] { "type", "typeId" },
				new Object[] { (short) 1, sysuser.getId() });
		if (null != attachment) {
			entity.setFilePath(attachment.getFilePath());
		} else {
			entity.setFilePath("/static/assets/avatars/profile-pic.jpg");
		}
		return entity;
	}

	public String updateSysUser(UpdateUserPwdRequestBean brb) {
		brb.setPassword(MD5.crypt(brb.getPassword()));
		sysUserDao.updateByProperties("userName", brb.getUsername(), "password", brb.getPassword());
		return "success";
	}

}
