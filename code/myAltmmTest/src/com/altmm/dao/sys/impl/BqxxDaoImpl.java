package com.altmm.dao.sys.impl;

import org.springframework.stereotype.Repository;

import com.altmm.dao.sys.BqxxDao;
import com.altmm.model.sys.Bqxx;

import core.dao.BaseDao;

/**
 * 病区信息的数据持久层的实现类
 * 
 */
@Repository
public class BqxxDaoImpl extends BaseDao<Bqxx> implements BqxxDao {

	public BqxxDaoImpl() {
		super(Bqxx.class);
	}

}
