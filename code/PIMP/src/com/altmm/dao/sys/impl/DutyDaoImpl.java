package com.altmm.dao.sys.impl;

import org.springframework.stereotype.Repository;

import com.altmm.dao.sys.DutyDao;
import com.altmm.model.sys.Duty;

import core.dao.BaseDao;

/**
 * @file DutyDaoImpl.java
 * @category 职责表的数据持久层的实现类
 * @author xumin
 * @date 2016年3月22日 下午3:08:17
 */
@Repository
public class DutyDaoImpl extends BaseDao<Duty> implements DutyDao {

	public DutyDaoImpl() {
		super(Duty.class);
	}

}
