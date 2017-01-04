package com.altmm.dao.sys;

import java.util.List;

import com.altmm.model.sys.Information;

import core.dao.Dao;

/**
 * 信息发布的数据持久层的接口
 * 
 */
public interface InformationDao extends Dao<Information> {

	// 生成信息的索引
	void indexingInformation();

	// 全文检索信息
	List<Information> queryByInformationName(String name);

}
