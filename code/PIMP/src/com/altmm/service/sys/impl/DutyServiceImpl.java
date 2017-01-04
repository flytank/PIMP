package com.altmm.service.sys.impl;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.altmm.dao.sys.DutyDao;
import com.altmm.model.sys.Duty;
import com.altmm.service.sys.DutyService;
import core.service.BaseService;


/**
 * @file DutyServiceImpl.java
 * @category 职责的业务逻辑层实现
 * @author taotouhong
 * @date 2016年3月28日 下午9:05:48
 */
@Service
public class DutyServiceImpl extends BaseService<Duty>implements DutyService{
	private  DutyDao dutyDao;

	public DutyDao getDutyDao() {
		return dutyDao;
	}
	@Resource
	public void setDutyDao(DutyDao dutyDao) {
		this.dao = dutyDao;
		this.dutyDao = dutyDao;
	}

	public List<Duty> queryAllDutyList(String globalDutyKey, List<Duty> mainDutyList) {
		List<Duty> dutyList = dutyDao.queryByProerties("id", globalDutyKey);
		return dutyList;
	}
}
