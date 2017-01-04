package com.altmm.service.sys.impl;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.altmm.dao.sys.BqxxDao;
import com.altmm.model.sys.Bqxx;
import com.altmm.service.sys.BqxxService;

import core.service.BaseService;

/**
 * 病区信息的业务逻辑层的实现
 * 
 */
@Service
public class BqxxServiceImpl extends BaseService<Bqxx> implements BqxxService {

	private BqxxDao bqxxDao;

	@Resource
	public void setBqxxDao(BqxxDao bqxxDao) {
		this.bqxxDao = bqxxDao;
		this.dao = bqxxDao;
	}

	@Override
	public List<Bqxx> queryBqxxWithSubList(List<Bqxx> resultList) {
		List<Bqxx> bqxxList = new ArrayList<Bqxx>();
		for (Bqxx entity : resultList) {
			Bqxx bqxx = new Bqxx();
			bqxx.setBqid(entity.getBqid());
			bqxx.setBqlx(entity.getBqlx());
			bqxx.setBqmc(entity.getBqmc());
			bqxx.setCzdrcf(entity.getCzdrcf());
			bqxx.setDytzyz(entity.getDytzyz());
			bqxx.setZdcfyz(entity.getZdcfyz());
			bqxx.setZdcfsj(entity.getZdcfsj());
			bqxxList.add(bqxx);
		}
		return bqxxList;
	}

}
