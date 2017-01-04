package com.altmm.dao.sys.impl;

import org.springframework.stereotype.Repository;

import com.altmm.dao.sys.RoleDao;
import com.altmm.model.sys.Role;

import core.dao.BaseDao;

/**
 * 角色的数据持久层的实现类
 * 
 */
@Repository
public class RoleDaoImpl extends BaseDao<Role>implements RoleDao {

	public RoleDaoImpl() {
		super(Role.class);
	}

}
