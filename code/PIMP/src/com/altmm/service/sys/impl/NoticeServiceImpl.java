package com.altmm.service.sys.impl;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.altmm.dao.sys.ActivityDao;
import com.altmm.dao.sys.DutyDao;
import com.altmm.dao.sys.NoticeDao;
import com.altmm.dao.sys.SysUserDao;
import com.altmm.dao.sys.TownDao;
import com.altmm.dao.sys.VillageDao;
import com.altmm.dao.sys.ZoneDao;
import com.altmm.model.sys.Notice;
import com.altmm.model.sys.SysUser;
import com.altmm.model.sys.Town;
import com.altmm.model.sys.Village;
import com.altmm.model.sys.Zone;
import com.altmm.service.sys.NoticeService;

import core.service.BaseService;

/**
 * @file NoticeServiceImpl.java
 * @category 公告表的业务逻辑层的实现
 * @author xumin
 * @date 2016年4月5日 下午4:41:54
 */
@Service
public class NoticeServiceImpl extends BaseService<Notice> implements
		NoticeService {

	private NoticeDao noticeDao;
	@Resource
	private SysUserDao userDao;// 用户表的接口
	@Resource
	private ActivityDao activityDao;// 活动表的接口
	@Resource
	private DutyDao dutyDao;// 职责表的接口
	@Resource
	private TownDao townDao;// 乡镇表的接口
	@Resource
	private VillageDao villageDao;// 自然村表的接口
	@Resource
	private ZoneDao zoneDao;// 区域表的接口

	@Resource
	public void setNoticeDao(NoticeDao noticeDao) {
		this.noticeDao = noticeDao;
		this.dao = noticeDao;
	}

	// 获取公告表信息（将数据库查询出来的信息再处理，增加字段的中文意思）
	@Override
	public List<Notice> queryNoticeCnList(List<Notice> resultList) {
		List<Notice> teamList = new ArrayList<Notice>();
		for (Notice entity : resultList) {
			Notice notice = new Notice();
			notice = entity;
			if (null != notice.getUser() && !notice.getUser().isEmpty()) {// 查询用户编码
				SysUser obj = userDao.get(notice.getUser());
				if (null != obj) {
					notice.setUserCn(obj.getUserName());
				}
			}
			if (null != notice.getVillageID()
					&& !notice.getVillageID().isEmpty()) { // 查询自然村编码
				Village obj = villageDao.get(notice.getVillageID());
				if (null != obj) {
					notice.setVillageCn(obj.getName());
				}
			}
			if (null != notice.getTownID() && !notice.getTownID().isEmpty()) { // 查询乡镇编码
				Town obj = townDao.get(notice.getTownID());
				if (null != obj) {
					notice.setTownCn(obj.getName());
				}
			}
			if (null != notice.getZoneID() && !notice.getZoneID().isEmpty()) { // 查询区域编码
				Zone obj = zoneDao.get(notice.getZoneID());
				if (null != obj) {
					notice.setZoneCn(obj.getName());
				}
			}
			if (1 == notice.getScope()) {// 公示范围，1为区域，2为乡镇，3为自然村
				notice.setScopeCn("区域");
			} else if (2 == notice.getScope()) {// 公示范围，1为区域，2为乡镇，3为自然村
				notice.setScopeCn("乡镇");
			} else if (3 == notice.getScope()) {// 公示范围，1为区域，2为乡镇，3为自然村
				notice.setScopeCn("自然村");
			}
			if (notice.getIsShow()) {
				notice.setIsShowCn("是");
			} else {
				notice.setIsShowCn("否");
			}
			teamList.add(notice);
		}
		return teamList;
	}
}
