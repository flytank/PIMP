package com.altmm.dao.sys.impl;

import org.springframework.stereotype.Repository;

import com.altmm.dao.sys.VillageDao;
import com.altmm.model.sys.Village;

import core.dao.BaseDao;

/**
 * @file VillageDaoImpl.java
 * @category 自然村表的数据持久层的实现类
 * @author xumin
 * @date 2016年3月20日 下午4:38:57
 */
@Repository
public class VillageDaoImpl extends BaseDao<Village> implements VillageDao {

	public VillageDaoImpl() {
		super(Village.class);
	}

}
