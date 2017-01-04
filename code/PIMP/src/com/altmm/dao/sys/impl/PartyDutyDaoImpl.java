package com.altmm.dao.sys.impl;

import org.springframework.stereotype.Repository;

import com.altmm.dao.sys.PartyDutyDao;
import com.altmm.model.sys.PartyDuty;

import core.dao.BaseDao;

/**
 * @file PartyDutyDaoImpl.java
 * @category 党员类别职责表的数据持久层的实现类
 * @author xumin
 * @date 2016年3月22日 下午3:08:51
 */
@Repository
public class PartyDutyDaoImpl extends BaseDao<PartyDuty> implements
		PartyDutyDao {

	public PartyDutyDaoImpl() {
		super(PartyDuty.class);
	}

}
