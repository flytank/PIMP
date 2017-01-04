package com.altmm.dao.sys.impl;

import org.springframework.stereotype.Repository;

import com.altmm.dao.sys.MessageDao;
import com.altmm.model.sys.Message;

import core.dao.BaseDao;

/**
 * @file MessageDaoImpl.java
 * @category 留言表的数据持久层的实现类
 * @author xumin
 * @date 2016年3月23日 下午2:13:45
 */
@Repository
public class MessageDaoImpl extends BaseDao<Message> implements MessageDao {

	public MessageDaoImpl() {
		super(Message.class);
	}
}
