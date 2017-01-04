package com.altmm.dao.sys.impl;

import org.springframework.stereotype.Repository;

import com.altmm.dao.sys.RoleAuthorityDao;
import com.altmm.model.sys.RoleAuthority;

import core.dao.BaseDao;

/**
 * 角色权限的数据持久层的实现类
 * 
 */
@Repository
public class RoleAuthorityDaoImpl extends BaseDao<RoleAuthority>implements RoleAuthorityDao {

	public RoleAuthorityDaoImpl() {
		super(RoleAuthority.class);
	}

}
