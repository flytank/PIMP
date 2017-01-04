package com.altmm.dao.sys.impl;

import org.springframework.stereotype.Repository;

import com.altmm.dao.sys.ZoneDao;
import com.altmm.model.sys.Zone;

import core.dao.BaseDao;

/**
 * @file ZoneDaoImpl.java
 * @category 区域表的数据持久层的实现类
 * @author xumin
 * @date 2016年3月20日 下午4:39:34
 */
@Repository
public class ZoneDaoImpl extends BaseDao<Zone> implements ZoneDao {

	public ZoneDaoImpl() {
		super(Zone.class);
	}

}
