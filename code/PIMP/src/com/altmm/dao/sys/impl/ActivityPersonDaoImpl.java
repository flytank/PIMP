package com.altmm.dao.sys.impl;

import org.springframework.stereotype.Repository;

import com.altmm.dao.sys.ActivityPersonDao;
import com.altmm.model.sys.ActivityPerson;

import core.dao.BaseDao;

/**
 * @file ActivityPersonDaoImpl.java
 * @category 活动人员表的数据持久层的实现类
 * @author xumin
 * @date 2016年3月23日 下午1:59:30
 */
@Repository
public class ActivityPersonDaoImpl extends BaseDao<ActivityPerson> implements
		ActivityPersonDao {

	public ActivityPersonDaoImpl() {
		super(ActivityPerson.class);
	}
}
