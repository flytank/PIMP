package com.altmm.dao.sys.impl;

import org.springframework.stereotype.Repository;

import com.altmm.dao.sys.TeamDao;
import com.altmm.model.sys.Team;

import core.dao.BaseDao;

/**
 * @file TeamDaoImpl.java
 * @category 党小组的数据持久层的实现类
 * @author xumin
 * @date 2016年3月20日 下午4:56:19
 */
@Repository
public class TeamDaoImpl extends BaseDao<Team> implements TeamDao {

	public TeamDaoImpl() {
		super(Team.class);
	}

}
