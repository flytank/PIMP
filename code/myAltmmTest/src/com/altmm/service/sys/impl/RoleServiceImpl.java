package com.altmm.service.sys.impl;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.altmm.dao.sys.RoleDao;
import com.altmm.model.sys.Role;
import com.altmm.service.sys.RoleService;

import core.service.BaseService;

/**
 * 角色的业务逻辑层的实现
 * 
 */
@Service
public class RoleServiceImpl extends BaseService<Role>implements RoleService {

	private RoleDao roleDao;

	@Resource
	public void setRoleDao(RoleDao roleDao) {
		this.roleDao = roleDao;
		this.dao = roleDao;
	}

}
