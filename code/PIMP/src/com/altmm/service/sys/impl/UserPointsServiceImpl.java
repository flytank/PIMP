package com.altmm.service.sys.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.altmm.dao.sys.ActivityDao;
import com.altmm.dao.sys.DutyDao;
import com.altmm.dao.sys.SysUserDao;
import com.altmm.dao.sys.TownDao;
import com.altmm.dao.sys.UserPointsDao;
import com.altmm.dao.sys.VillageDao;
import com.altmm.dao.sys.ZoneDao;
import com.altmm.model.sys.Activity;
import com.altmm.model.sys.SysUser;
import com.altmm.model.sys.Town;
import com.altmm.model.sys.UserPoints;
import com.altmm.model.sys.Village;
import com.altmm.service.sys.UserPointsService;

import core.service.BaseService;

/**
 * @file UserPointsServiceImpl.java
 * @category 用户积分详情的业务逻辑层的实现
 * @author xumin
 * @date 2016年4月10日 下午9:40:35
 */
@Service
public class UserPointsServiceImpl extends BaseService<UserPoints> implements
		UserPointsService {

	private UserPointsDao userpointsDao;
	@Resource
	private TownDao townDao;// 乡镇表的接口
	@Resource
	private VillageDao villageDao;// 自然村表的接口
	@Resource
	private ZoneDao zoneDao;// 区域表的接口
	@Resource
	private SysUserDao userDao;// 用户表的接口
	@Resource
	private DutyDao dutyDao;// 职责表的接口
	@Resource
	private ActivityDao activityDao;// 活动表的接口

	@Resource
	public void setUserPointsDao(UserPointsDao userpointsDao) {
		this.userpointsDao = userpointsDao;
		this.dao = userpointsDao;
	}

	/**
	 * @category 获取用户积分列表
	 */
	@Override
	public Map<String, Object> getUserPointsList(String userId) {
		// 查询用户信息
		SysUser user = userDao.get(userId);
		if (null != user.getVillageID() && !user.getVillageID().isEmpty()) {
			// 查询自然村编码
			Village obj = villageDao.get(user.getVillageID());
			if (null != obj) {
				user.setVillageCn(obj.getName());
			}
		}
		if (null != user.getTownID() && !user.getTownID().isEmpty()) {
			// 查询乡镇编码
			Town obj = townDao.get(user.getTownID());
			if (null != obj) {
				user.setTownCn(obj.getName());
			}
		}
		// 查询用户积分信息
		String[] propName = new String[] { "userID", "isEffect" };
		Object[] propValue = new Object[] { userId, true };
		List<UserPoints> userPointsList = userpointsDao.queryByProerties(
				propName, propValue);
		// 查询职责列表
		String sql = "";
		if (null != user.getSortID() && !"".equals(user.getSortID())) {
			sql = "select dutyCode,dutyName,mark,points "
					+ " from duty where dutyCode in (select dutyCode "
					+ " from partyduty where partyCode = '" + user.getSortID()
					+ "')";
		} else {
			sql = "select * from duty";
		}
		List<Map<String, Object>> dutyList = userDao.getObjectListByQuery(sql);
		List<Map<String, Object>> mapList = new ArrayList<Map<String, Object>>();
		List<Map<String, Object>> pointsMapList = new ArrayList<Map<String, Object>>();// 用户积分详情列表
		System.out.println("xxxxxxxxxxxxxxxxxx");
		for (int j = 0; j < userPointsList.size(); j++) {
			Map<String, Object> pointsMap = new HashMap<String, Object>();
			UserPoints userpoints = userPointsList.get(j);
			if (1 == userpoints.getSource()) {// 活动
				Activity activity = activityDao.get(userpoints.getSourceID());
				if (null != activity) {
					pointsMap.put("id", userpoints.getId());
					pointsMap.put("userID", userpoints.getUserID());
					pointsMap.put("source", userpoints.getSource());
					pointsMap.put("sourceID", userpoints.getSourceID());
					pointsMap.put("points", userpoints.getPoints());
					pointsMap.put("time", userpoints.getTime());
					pointsMap.put("isEffect", userpoints.getIsEffect());
					pointsMap.put("mark", userpoints.getMark());
					pointsMap.put("dutyID", activity.getDutyCode());
					pointsMap.put("sourceName", activity.getSubject());
					pointsMap.put("sourcePoints", userpoints.getPoints());
				}
			} else if (2 == userpoints.getSource()) {// 职责
				pointsMap.put("id", userpoints.getId());
				pointsMap.put("userID", userpoints.getUserID());
				pointsMap.put("source", userpoints.getSource());
				pointsMap.put("sourceID", userpoints.getSourceID());
				pointsMap.put("points", userpoints.getPoints());
				pointsMap.put("time", userpoints.getTime());
				pointsMap.put("isEffect", userpoints.getIsEffect());
				pointsMap.put("mark", userpoints.getMark());
				pointsMap.put("dutyID", userpoints.getSourceID());
				pointsMap.put("sourcePoints", userpoints.getPoints());
			}
			if (null != pointsMap && !pointsMap.isEmpty()) {
				pointsMapList.add(pointsMap);
			}
		}
		Map<String, Object> Data = new HashMap<String, Object>();
		Double totalPoints = 0.0;// 总分
		if (null != dutyList && !dutyList.isEmpty()) {
			for (int i = 0; i < dutyList.size(); i++) {
				Map<String, Object> duty = dutyList.get(i);
				String dutyCode = (String) duty.get("dutyCode");
				String dutyName = (String) duty.get("dutyName");
				String mark = (String) duty.get("mark");
				Double points = (Double) duty.get("points");
				List<Map<String, Object>> dutyPointsList = new ArrayList<Map<String, Object>>();
				Double allpoints = 0.0;
				for (int j = 0; j < pointsMapList.size(); j++) {
					Map<String, Object> pointsMap = pointsMapList.get(j);
					if (dutyCode.equals((String) pointsMap.get("dutyID"))) {
						Double myPoints = (Double) pointsMap.get("points");
						allpoints += myPoints;
						if (2 == (int) pointsMap.get("source")) {// 职责
							pointsMap.put("sourceName", dutyName);
						}
						pointsMap.put("points", points);
						dutyPointsList.add(pointsMap);
					}
				}
				if (null != points) {
					if (allpoints > points) {
						allpoints = points;
					}
				}
				totalPoints += allpoints;
				if (null == dutyPointsList || dutyPointsList.isEmpty()) {
					Map<String, Object> pointsMap = new HashMap<String, Object>();
					pointsMap.put("id", "");
					pointsMap.put("userID", "");
					pointsMap.put("source", 2);
					pointsMap.put("sourceID", dutyCode);
					pointsMap.put("sourceName", dutyName);
					pointsMap.put("points", points);
					pointsMap.put("time", new Date());
					pointsMap.put("isEffect", true);
					pointsMap.put("mark", "");
					pointsMap.put("dutyID", dutyCode);
					pointsMap.put("sourcePoints", 0);
					dutyPointsList.add(pointsMap);
				}
				duty.put("allpoints", allpoints);
				duty.put("dutyPointsList", dutyPointsList);
				mapList.add(duty);
			}
		}
		Data.put("dutyList", mapList);
		Data.put("totalpoints", totalPoints);
		Data.put("userId", user.getId());
		Data.put("idCard", user.getIdCard());
		Data.put("userName", user.getUserName());
		Data.put("villageCn", user.getVillageCn());
		Data.put("townCn", user.getTownCn());
		return Data;
	}

	/**
	 * 更新用户表用户积分值
	 */
	@Override
	public Boolean updateUserPoints(String userId) {
		// 查询用户信息
		SysUser user = userDao.get(userId);
		// 查询用户积分信息
		String[] propName = new String[] { "userID", "isEffect" };
		Object[] propValue = new Object[] { userId, true };
		List<UserPoints> userPointsList = userpointsDao.queryByProerties(
				propName, propValue);
		// 查询职责列表
		String sql = "";
		if (null != user.getSortID() && !"".equals(user.getSortID())) {
			sql = "select dutyCode,dutyName,mark,points "
					+ " from duty where dutyCode in (select dutyCode "
					+ " from partyduty where partyCode = '" + user.getSortID()
					+ "')";
		} else {
			sql = "select * from duty";
		}
		List<Map<String, Object>> dutyList = userDao.getObjectListByQuery(sql);
		// List<Map<String, Object>> mapList = new ArrayList<Map<String,
		// Object>>();
		List<Map<String, Object>> pointsMapList = new ArrayList<Map<String, Object>>();// 用户积分详情列表
		for (int j = 0; j < userPointsList.size(); j++) {
			Map<String, Object> pointsMap = new HashMap<String, Object>();
			UserPoints userpoints = userPointsList.get(j);
			if (1 == userpoints.getSource()) {// 活动
				Activity activity = activityDao.get(userpoints.getSourceID());
				if (null != activity) {
					pointsMap.put("id", userpoints.getId());
					pointsMap.put("userID", userpoints.getUserID());
					pointsMap.put("source", userpoints.getSource());
					pointsMap.put("sourceID", userpoints.getSourceID());
					pointsMap.put("points", userpoints.getPoints());
					pointsMap.put("time", userpoints.getTime());
					pointsMap.put("isEffect", userpoints.getIsEffect());
					pointsMap.put("mark", userpoints.getMark());
					pointsMap.put("dutyID", activity.getDutyCode());
					pointsMap.put("sourceName", activity.getSubject());
					pointsMap.put("sourcePoints", userpoints.getPoints());
				}
			} else if (2 == userpoints.getSource()) {// 职责
				pointsMap.put("id", userpoints.getId());
				pointsMap.put("userID", userpoints.getUserID());
				pointsMap.put("source", userpoints.getSource());
				pointsMap.put("sourceID", userpoints.getSourceID());
				pointsMap.put("points", userpoints.getPoints());
				pointsMap.put("time", userpoints.getTime());
				pointsMap.put("isEffect", userpoints.getIsEffect());
				pointsMap.put("mark", userpoints.getMark());
				pointsMap.put("dutyID", userpoints.getSourceID());
				pointsMap.put("sourcePoints", userpoints.getPoints());
			}
			if (null != pointsMap && !pointsMap.isEmpty()) {
				pointsMapList.add(pointsMap);
			}
		}
		Double totalPoints = 0.0;// 总分
		if (null != dutyList && !dutyList.isEmpty()) {
			for (int i = 0; i < dutyList.size(); i++) {
				Map<String, Object> duty = dutyList.get(i);
				String dutyCode = (String) duty.get("dutyCode");
				// String dutyName = (String) duty.get("dutyName");
				Double points = (Double) duty.get("points");
				// List<Map<String, Object>> dutyPointsList = new
				// ArrayList<Map<String, Object>>();
				Double allpoints = 0.0;
				for (int j = 0; j < pointsMapList.size(); j++) {
					Map<String, Object> pointsMap = pointsMapList.get(j);
					if (dutyCode.equals((String) pointsMap.get("dutyID"))) {
						Double myPoints = (Double) pointsMap.get("points");
						allpoints += myPoints;
						// if (2 == (int) pointsMap.get("source")) {// 职责
						// pointsMap.put("sourceName", dutyName);
						// }
						// dutyPointsList.add(pointsMap);
					}
				}
				if (null != points) {
					if (allpoints > points) {
						allpoints = points;
					}
				}
				totalPoints += allpoints;
				// if (null == dutyPointsList || dutyPointsList.isEmpty()) {
				// Map<String, Object> pointsMap = new HashMap<String,
				// Object>();
				// pointsMap.put("id", "");
				// pointsMap.put("userID", "");
				// pointsMap.put("source", 2);
				// pointsMap.put("sourceID", dutyCode);
				// pointsMap.put("sourceName", dutyName);
				// pointsMap.put("points", points);
				// pointsMap.put("time", new Date());
				// pointsMap.put("isEffect", true);
				// pointsMap.put("mark", "");
				// pointsMap.put("dutyID", dutyCode);
				// pointsMap.put("sourcePoints", 0);
				// dutyPointsList.add(pointsMap);
				// }
				// duty.put("allpoints", allpoints);
				// duty.put("dutyPointsList", dutyPointsList);
				// mapList.add(duty);
			}
		}
		user.setPoints(totalPoints);
		userDao.update(user);
		return true;
	}
}
