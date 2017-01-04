package com.altmm.service.sys;

import java.util.List;

import com.altmm.model.sys.Message;

import core.service.Service;

/**
 * @file MessageService.java
 * @category 留言表的业务逻辑层的接口
 * @author xumin
 * @date 2016年4月5日 下午4:39:08
 */
public interface MessageService extends Service<Message> {
	/**
	 * @Method queryMessageCnList
	 * @category 获取留言表信息（将数据库查询出来的信息再处理，增加字段的中文意思）
	 * @author xumin
	 * @param @param resultList
	 * @param @return
	 * @return List<Message>
	 * @date 2016年3月23日 下午3:09:15
	 */
	List<Message> queryMessageCnList(List<Message> resultList);
}
