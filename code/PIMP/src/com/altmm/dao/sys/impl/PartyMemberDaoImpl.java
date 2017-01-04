package com.altmm.dao.sys.impl;

import org.springframework.stereotype.Repository;

import com.altmm.dao.sys.PartyMemberDao;
import com.altmm.model.sys.PartyMember;

import core.dao.BaseDao;

/**
 * @file PartyMemberDaoImpl.java
 * @category 党员类别表的数据持久层的实现类
 * @author xumin
 * @date 2016年3月20日 下午4:55:33
 */
@Repository
public class PartyMemberDaoImpl extends BaseDao<PartyMember> implements
		PartyMemberDao {

	public PartyMemberDaoImpl() {
		super(PartyMember.class);
	}

}
