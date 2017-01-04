package com.altmm.dao.sys.impl;

import org.springframework.stereotype.Repository;

import com.altmm.dao.sys.ActivityDao;
import com.altmm.model.sys.Activity;

import core.dao.BaseDao;

/**
 * @file ActivityDaoImpl.java
 * @category 活动表的数据持久层的实现类
 * @author xumin
 * @date 2016年3月20日 下午5:10:29
 */
@Repository
public class ActivityDaoImpl extends BaseDao<Activity> implements ActivityDao {

	public ActivityDaoImpl() {
		super(Activity.class);
	}
}
