package com.altmm.service.sys.impl;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.altmm.dao.sys.TeamDao;
import com.altmm.dao.sys.TownDao;
import com.altmm.dao.sys.VillageDao;
import com.altmm.dao.sys.ZoneDao;
import com.altmm.model.sys.Team;
import com.altmm.model.sys.Town;
import com.altmm.model.sys.Village;
import com.altmm.model.sys.Zone;
import com.altmm.service.sys.TeamService;

import core.service.BaseService;

/**
 * @file TeamServiceImpl.java
 * @category 党小组的业务逻辑层的实现
 * @author xumin
 * @date 2016年3月23日 下午3:06:23
 */
@Service
public class TeamServiceImpl extends BaseService<Team> implements TeamService {

	private TeamDao teamDao;
	@Resource
	private TownDao townDao;// 乡镇表的接口
	@Resource
	private VillageDao villageDao;// 自然村表的接口
	@Resource
	private ZoneDao zoneDao;// 区域表的接口

	@Resource
	public void setTeamDao(TeamDao teamDao) {
		this.teamDao = teamDao;
		this.dao = teamDao;
	}

	// 获取党小组信息（将数据库查询出来的信息再处理，增加字段的中文意思）
	@Override
	public List<Team> queryTeamCnList(List<Team> resultList) {
		List<Team> teamList = new ArrayList<Team>();
		for (Team entity : resultList) {
			Team team = new Team();
			team = entity;

			if (null != team.getVillageID() && !team.getVillageID().isEmpty()) {
				// 查询自然村编码
				Village obj = villageDao.get(team.getVillageID());
				if (null != obj) {
					team.setVillageCn(obj.getName());
				}
			}
			if (null != team.getTownID() && !team.getTownID().isEmpty()) {
				// 查询乡镇编码
				Town obj = townDao.get(team.getTownID());
				if (null != obj) {
					team.setTownCn(obj.getName());
				}
			}
			if (null != team.getZoneID() && !team.getZoneID().isEmpty()) {
				// 查询区域编码
				Zone obj = zoneDao.get(team.getZoneID());
				if (null != obj) {
					team.setZoneCn(obj.getName());
				}
			}

			teamList.add(team);
		}
		return teamList;
	}

	// 获取党小组信息（将数据库查询出来的信息再处理，增加字段的中文意思）,将党小组名称加上**镇**村
	@Override
	public List<Team> queryTeamCn2List(List<Team> resultList) {
		List<Team> teamList = new ArrayList<Team>();
		for (Team entity : resultList) {
			Team team = new Team();
			team = entity;
			if (null != team.getVillageID() && !team.getVillageID().isEmpty()) {
				// 查询自然村编码
				Village obj = villageDao.get(team.getVillageID());
				if (null != obj) {
					team.setVillageCn(obj.getName());
				}
			}
			if (null != team.getTownID() && !team.getTownID().isEmpty()) {
				// 查询乡镇编码
				Town obj = townDao.get(team.getTownID());
				if (null != obj) {
					team.setTownCn(obj.getName());
				}
			}
			if (null != team.getZoneID() && !team.getZoneID().isEmpty()) {
				// 查询区域编码
				Zone obj = zoneDao.get(team.getZoneID());
				if (null != obj) {
					team.setZoneCn(obj.getName());
				}
			}
			String name = "";// 党小组名称
			if (null != team.getTownCn() && !team.getTownCn().isEmpty()) {
				name = team.getTownCn();
			}
			if (null != team.getVillageCn() && !team.getVillageCn().isEmpty()) {
				name += team.getVillageCn();
			}
			if ("" != name) {
				name += team.getTeamName();
				team.setTeamName(name);
			}
			teamList.add(team);
		}
		return teamList;
	}

}
