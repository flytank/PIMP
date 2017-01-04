package com.altmm.service.sys.impl;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.altmm.dao.sys.ActivityDao;
import com.altmm.dao.sys.ActivityPersonDao;
import com.altmm.dao.sys.DutyDao;
import com.altmm.dao.sys.SysUserDao;
import com.altmm.dao.sys.TownDao;
import com.altmm.dao.sys.VillageDao;
import com.altmm.dao.sys.ZoneDao;
import com.altmm.model.sys.Activity;
import com.altmm.model.sys.ActivityPerson;
import com.altmm.model.sys.SysUser;
import com.altmm.service.sys.ActivityPersonService;

import core.service.BaseService;

/**
 * @file ActivityPersonServiceImpl.java
 * @category 活动人员的业务逻辑层的实现
 * @author xumin
 * @date 2016年4月10日 下午9:45:59
 */
@Service
public class ActivityPersonServiceImpl extends BaseService<ActivityPerson>
		implements ActivityPersonService {

	private ActivityPersonDao activityPersonDao;
	@Resource
	private SysUserDao userDao;// 用户表的接口
	@Resource
	private ActivityDao activityDao;// 活动表的接口
	@Resource
	private TownDao townDao;// 乡镇表的接口
	@Resource
	private VillageDao villageDao;// 自然村表的接口
	@Resource
	private ZoneDao zoneDao;// 区域表的接口
	@Resource
	private DutyDao dutyDao;// 职责表的接口

	@Resource
	public void setActivityPersonDao(ActivityPersonDao activityPersonDao) {
		this.activityPersonDao = activityPersonDao;
		this.dao = activityPersonDao;
	}

	/**
	 * 获取活动人员信息（将数据库查询出来的信息再处理，增加字段的中文意思）
	 */
	@Override
	public List<ActivityPerson> queryActivityPersonCnList(
			List<ActivityPerson> resultList) {
		List<ActivityPerson> personList = new ArrayList<ActivityPerson>();
		for (ActivityPerson entity : resultList) {
			ActivityPerson person = new ActivityPerson();
			person = entity;
			if (null != person.getActivityID()
					&& !person.getActivityID().isEmpty()) {
				Activity obj = activityDao.get(person.getActivityID());
				if (null != obj) {
					person.setActivityCn(obj.getSubject());
				}
			}
			if (null != person.getUserID() && !person.getUserID().isEmpty()) {// 查询用户编码
				SysUser obj = userDao.get(person.getUserID());
				if (null != obj) {
					person.setUserCn(obj.getUserName());
					person.setIdNoCn(obj.getIdCard());
				}
			}

			personList.add(person);
		}
		return personList;
	}
}
