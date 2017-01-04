package com.altmm.service.sys;

import java.util.List;

import com.altmm.model.sys.Activity;

import core.service.Service;

/**
 * @file ActivityService.java
 * @category 活动的业务逻辑层的接口
 * @author xumin
 * @date 2016年4月5日 下午3:44:22
 */
public interface ActivityService extends Service<Activity> {
	/**
	 * @Method queryActivityCnList
	 * @category 获取活动信息（将数据库查询出来的信息再处理，增加字段的中文意思）
	 * @author xumin
	 * @param @param resultList
	 * @param @return
	 * @return List<Activity>
	 * @date 2016年3月23日 下午3:09:15
	 */
	List<Activity> queryActivityCnList(List<Activity> resultList);
}
