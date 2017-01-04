package com.altmm.dao.sys.impl;

import org.springframework.stereotype.Repository;

import com.altmm.dao.sys.GongzuoliuDao;
import com.altmm.model.sys.Gongzuoliu;

import core.dao.BaseDao;

/**
 * 字典的数据持久层的实现类
 * 
 */
@Repository
public class GongzuoliuDaoImpl extends BaseDao<Gongzuoliu> implements
		GongzuoliuDao {

	public GongzuoliuDaoImpl() {
		super(Gongzuoliu.class);
	}

}
