package com.altmm.dao.sys.impl;

import org.springframework.stereotype.Repository;

import com.altmm.dao.sys.HonorDao;
import com.altmm.model.sys.Honor;

import core.dao.BaseDao;

/**
 * @file HonorDaoImpl.java
 * @category 表彰表的数据持久层的实现类
 * @author xumin
 * @date 2016年3月23日 下午2:19:29
 */
@Repository
public class HonorDaoImpl extends BaseDao<Honor> implements HonorDao {

	public HonorDaoImpl() {
		super(Honor.class);
	}
}
