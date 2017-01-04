package com.altmm.dao.sys.impl;

import org.springframework.stereotype.Repository;

import com.altmm.dao.sys.TownDao;
import com.altmm.model.sys.Town;

import core.dao.BaseDao;

/**
 * @file TownDaoImpl.java
 * @category 乡镇表的数据持久层的实现类
 * @author xumin
 * @date 2016年3月20日 下午4:38:10
 */
@Repository
public class TownDaoImpl extends BaseDao<Town> implements TownDao {

	public TownDaoImpl() {
		super(Town.class);
	}

}
