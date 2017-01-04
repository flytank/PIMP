package com.altmm.service.sys;

import java.util.List;

import com.altmm.model.sys.Gongzuoliu;

import core.service.Service;

/**
 * 字典的业务逻辑层的接口
 * 
 */
public interface GongzuoliuService extends Service<Gongzuoliu> {

	List<Gongzuoliu> queryGongzuoliuWithSubList(List<Gongzuoliu> resultList);

}
