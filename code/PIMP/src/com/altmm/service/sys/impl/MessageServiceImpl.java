package com.altmm.service.sys.impl;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.altmm.dao.sys.ActivityDao;
import com.altmm.dao.sys.DutyDao;
import com.altmm.dao.sys.MessageDao;
import com.altmm.dao.sys.SysUserDao;
import com.altmm.model.sys.Activity;
import com.altmm.model.sys.Duty;
import com.altmm.model.sys.Message;
import com.altmm.model.sys.SysUser;
import com.altmm.service.sys.MessageService;

import core.service.BaseService;

/**
 * @file MessageServiceImpl.java
 * @category 留言表的业务逻辑层的实现
 * @author xumin
 * @date 2016年4月5日 下午4:41:54
 */
@Service
public class MessageServiceImpl extends BaseService<Message> implements
		MessageService {

	private MessageDao messageDao;
	@Resource
	private SysUserDao userDao;// 用户表的接口
	@Resource
	private ActivityDao activityDao;// 活动表的接口
	@Resource
	private DutyDao dutyDao;// 职责表的接口

	@Resource
	public void setMessageDao(MessageDao messageDao) {
		this.messageDao = messageDao;
		this.dao = messageDao;
	}

	// 获取留言表信息（将数据库查询出来的信息再处理，增加字段的中文意思）
	@Override
	public List<Message> queryMessageCnList(List<Message> resultList) {
		List<Message> teamList = new ArrayList<Message>();
		for (Message entity : resultList) {
			Message message = new Message();
			message = entity;
			if (null != message.getUser() && !message.getUser().isEmpty()) {// 查询用户编码
				SysUser obj = userDao.get(message.getUser());
				if (null != obj) {
					message.setUserCn(obj.getUserName());
				}
			}
			if (1 == message.getMessageSource()) {// 留言对象来源，1为活动，2为公示
				message.setSourceCn("活动");
				if (null != message.getMessageID()
						&& !message.getMessageID().isEmpty()) {// 查询活动编码
					Activity obj = activityDao.get(message.getMessageID());
					if (null != obj) {
						message.setMessageCn(obj.getSubject());
					}
				}
			} else if (2 == message.getMessageSource()) {// 留言对象来源，1为活动，2为公示
				message.setSourceCn("公示");
				if (null != message.getMessageID()
						&& !message.getMessageID().isEmpty()) {// 查询职责编码
					Duty obj = dutyDao.get(message.getMessageID());
					if (null != obj) {
						message.setMessageCn(obj.getDutyName());
					}
				}
			}
			teamList.add(message);
		}
		return teamList;
	}
}
