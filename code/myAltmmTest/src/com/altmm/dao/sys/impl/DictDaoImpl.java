package com.altmm.dao.sys.impl;

import org.springframework.stereotype.Repository;

import com.altmm.dao.sys.DictDao;
import com.altmm.model.sys.Dict;

import core.dao.BaseDao;

/**
 * 字典的数据持久层的实现类
 * 
 */
@Repository
public class DictDaoImpl extends BaseDao<Dict>implements DictDao {

	public DictDaoImpl() {
		super(Dict.class);
	}

}
