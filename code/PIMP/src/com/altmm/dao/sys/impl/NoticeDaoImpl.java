package com.altmm.dao.sys.impl;

import org.springframework.stereotype.Repository;

import com.altmm.dao.sys.NoticeDao;
import com.altmm.model.sys.Notice;

import core.dao.BaseDao;

/**
 * @file NoticeDaoImpl.java
 * @category 公示表的数据持久层的实现类
 * @author xumin
 * @date 2016年3月23日 下午2:05:47
 */
@Repository
public class NoticeDaoImpl extends BaseDao<Notice> implements NoticeDao {

	public NoticeDaoImpl() {
		super(Notice.class);
	}
}
