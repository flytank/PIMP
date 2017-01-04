package com.altmm.service.sys;

import java.util.List;

import com.altmm.model.sys.Bqxx;

import core.service.Service;

/**
 * 病区信息的业务逻辑层的接口
 * 
 */
public interface BqxxService extends Service<Bqxx> {

	List<Bqxx> queryBqxxWithSubList(List<Bqxx> resultList);

}
