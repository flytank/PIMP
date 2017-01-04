package com.altmm.service.sys.impl;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.altmm.dao.sys.GongzuoliuDao;
import com.altmm.model.sys.Gongzuoliu;
import com.altmm.service.sys.GongzuoliuService;

import core.service.BaseService;

/**
 * 字典的业务逻辑层的实现
 * 
 */
@Service
public class GongzuoliuServiceImpl extends BaseService<Gongzuoliu> implements
		GongzuoliuService {

	private GongzuoliuDao gongzuoliuDao;

	@Resource
	public void setGongzuoliuDao(GongzuoliuDao gongzuoliuDao) {
		this.gongzuoliuDao = gongzuoliuDao;
		this.dao = gongzuoliuDao;
	}

	public List<Gongzuoliu> queryGongzuoliuWithSubList(
			List<Gongzuoliu> resultList) {
		List<Gongzuoliu> dictList = new ArrayList<Gongzuoliu>();
		for (Gongzuoliu entity : resultList) {
			Gongzuoliu dict = new Gongzuoliu();
			dict.setId(entity.getId());
			dict.setDictKey(entity.getDictKey());
			dict.setDictValue(entity.getDictValue());
			dict.setSequence(entity.getSequence());
			dict.setParentDictkey(entity.getParentDictkey());
			dictList.add(dict);
		}
		return dictList;
	}

}
