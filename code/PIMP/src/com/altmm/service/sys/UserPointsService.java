package com.altmm.service.sys;

import java.util.Map;

import com.altmm.model.sys.UserPoints;

import core.service.Service;

/**
 * @file UserPointsService.java
 * @category 用户积分详情的业务逻辑层的接口
 * @author xumin
 * @date 2016年4月10日 下午9:39:29
 */
public interface UserPointsService extends Service<UserPoints> {
	/**
	 * @Method getUserPointsList
	 * @category 获取用户积分列表
	 * @author xumin
	 * @param @param userId
	 * @param @return
	 * @return Map<String,Object>
	 * @date 2016年4月17日 上午7:08:02
	 */
	Map<String, Object> getUserPointsList(String userId);

	/**
	 * @Method updateUserPoints
	 * @category 更新用户表用户积分值
	 * @author xumin
	 * @param @param userId
	 * @param @return
	 * @return Boolean
	 * @date 2016年6月19日 下午8:40:50
	 */
	Boolean updateUserPoints(String userId);
}
