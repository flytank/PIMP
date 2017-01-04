package com.altmm.service.sys.impl;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.altmm.dao.sys.ActivityDao;
import com.altmm.dao.sys.DutyDao;
import com.altmm.dao.sys.TownDao;
import com.altmm.dao.sys.VillageDao;
import com.altmm.dao.sys.ZoneDao;
import com.altmm.model.sys.Activity;
import com.altmm.model.sys.Duty;
import com.altmm.model.sys.Town;
import com.altmm.model.sys.Village;
import com.altmm.model.sys.Zone;
import com.altmm.service.sys.ActivityService;

import core.service.BaseService;

/**
 * @file ActivityServiceImpl.java
 * @category 活动的业务逻辑层的实现
 * @author xumin
 * @date 2016年4月5日 下午3:45:51
 */
@Service
public class ActivityServiceImpl extends BaseService<Activity> implements
		ActivityService {

	private ActivityDao activityDao;
	@Resource
	private TownDao townDao;// 乡镇表的接口
	@Resource
	private VillageDao villageDao;// 自然村表的接口
	@Resource
	private ZoneDao zoneDao;// 区域表的接口
	@Resource
	private DutyDao dutyDao;// 职责表的接口

	@Resource
	public void setActivityDao(ActivityDao activityDao) {
		this.activityDao = activityDao;
		this.dao = activityDao;
	}

	// 获取活动信息（将数据库查询出来的信息再处理，增加字段的中文意思）
	@Override
	public List<Activity> queryActivityCnList(List<Activity> resultList) {
		List<Activity> teamList = new ArrayList<Activity>();
		for (Activity entity : resultList) {
			Activity activity = new Activity();
			activity = entity;
			if (null != activity.getVillageID()
					&& !activity.getVillageID().isEmpty()) { // 查询自然村编码
				Village obj = villageDao.get(activity.getVillageID());
				if (null != obj) {
					activity.setVillageCn(obj.getName());
				}
			}
			if (null != activity.getTownID() && !activity.getTownID().isEmpty()) { // 查询乡镇编码
				Town obj = townDao.get(activity.getTownID());
				if (null != obj) {
					activity.setTownCn(obj.getName());
				}
			}
			if (null != activity.getZoneID() && !activity.getZoneID().isEmpty()) { // 查询区域编码
				Zone obj = zoneDao.get(activity.getZoneID());
				if (null != obj) {
					activity.setZoneCn(obj.getName());
				}
			}
			if (1 == activity.getScope()) {// 1为区域
				activity.setScopeCn("区域");
			} else if (2 == activity.getScope()) {// 2为乡镇
				activity.setScopeCn("乡镇");
			} else if (3 == activity.getScope()) {// 3为自然村
				activity.setScopeCn("自然村");
			}
			if (null != activity.getDutyCode()
					&& !activity.getDutyCode().isEmpty()) {// 查询职责编码
				Duty obj = dutyDao.get(activity.getDutyCode());
				if (null != obj) {
					activity.setDutyCn(obj.getDutyName());
				}

			}
			activity.setIsShowCn(true == activity.getIsShow() ? "是" : "否");
			teamList.add(activity);
		}
		return teamList;
	}

}
