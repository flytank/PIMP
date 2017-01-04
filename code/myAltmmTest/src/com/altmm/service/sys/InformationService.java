package com.altmm.service.sys;

import java.util.List;

import com.altmm.model.sys.Information;

import core.service.Service;

/**
 * 信息发布的业务逻辑层的接口
 * 
 */
public interface InformationService extends Service<Information> {

	// 获取信息，包括内容的HTML和过滤HTML两部分
	List<Information> queryInformationHTMLList(List<Information> resultList);

	// 生成信息的索引
	void indexingInformation();

	// 全文检索信息
	List<Information> queryByInformationName(String name);

}
