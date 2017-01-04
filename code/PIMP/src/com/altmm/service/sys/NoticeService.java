package com.altmm.service.sys;

import java.util.List;

import com.altmm.model.sys.Notice;

import core.service.Service;

/**
 * @file NoticeService.java
 * @category 公告表的业务逻辑层的接口
 * @author xumin
 * @date 2016年4月5日 下午4:40:23
 */
public interface NoticeService extends Service<Notice> {
	/**
	 * @Method queryNoticeCnList
	 * @category 获取公告表信息（将数据库查询出来的信息再处理，增加字段的中文意思）
	 * @author xumin
	 * @param @param resultList
	 * @param @return
	 * @return List<Notice>
	 * @date 2016年3月23日 下午3:09:15
	 */
	List<Notice> queryNoticeCnList(List<Notice> resultList);
}
