package com.altmm.service.sys.impl;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.altmm.dao.sys.RoleAuthorityDao;
import com.altmm.model.sys.RoleAuthority;
import com.altmm.service.sys.RoleAuthorityService;

import core.service.BaseService;

/**
 * 角色权限的业务逻辑层的实现
 * 
 */
@Service
public class RoleAuthorityServiceImpl extends BaseService<RoleAuthority>implements RoleAuthorityService {

	private RoleAuthorityDao roleAuthorityDao;

	@Resource
	public void setRoleAuthorityDao(RoleAuthorityDao roleAuthorityDao) {
		this.roleAuthorityDao = roleAuthorityDao;
		this.dao = roleAuthorityDao;
	}

}
