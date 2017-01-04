package com.altmm.dao.sys.impl;

import org.springframework.stereotype.Repository;

import com.altmm.dao.sys.AuthorityDao;
import com.altmm.model.sys.Authority;

import core.dao.BaseDao;

/**
 * 菜单的数据持久层的实现类
 * 
 */
@Repository
public class AuthorityDaoImpl extends BaseDao<Authority>implements AuthorityDao {

	public AuthorityDaoImpl() {
		super(Authority.class);
	}

}
