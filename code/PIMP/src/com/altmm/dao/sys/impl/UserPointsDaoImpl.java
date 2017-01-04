package com.altmm.dao.sys.impl;

import org.springframework.stereotype.Repository;

import com.altmm.dao.sys.UserPointsDao;
import com.altmm.model.sys.UserPoints;

import core.dao.BaseDao;

/**
 * @file UserPointsDaoImpl.java
 * @category 用户积分表的数据持久层的实现类
 * @author xumin
 * @date 2016年3月22日 下午3:09:33
 */
@Repository
public class UserPointsDaoImpl extends BaseDao<UserPoints> implements
		UserPointsDao {

	public UserPointsDaoImpl() {
		super(UserPoints.class);
	}

}
