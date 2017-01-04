package com.altmm.dao.sys.impl;

import org.springframework.stereotype.Repository;

import com.altmm.dao.sys.MailDao;
import com.altmm.model.sys.Mail;

import core.dao.BaseDao;

/**
 * 邮件的数据持久层的实现类
 * 
 */
@Repository
public class MailDaoImpl extends BaseDao<Mail>implements MailDao {

	public MailDaoImpl() {
		super(Mail.class);
	}

}
