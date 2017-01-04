package com.altmm.service.sys;

import java.util.List;

import com.altmm.model.sys.Team;

import core.service.Service;

/**
 * @file TeamService.java
 * @category 党小组的业务逻辑层的接口
 * @author xumin
 * @date 2016年3月23日 下午3:05:30
 */
public interface TeamService extends Service<Team> {
	/**
	 * @Method queryTeamCnList
	 * @category 获取党小组信息（将数据库查询出来的信息再处理，增加字段的中文意思）
	 * @author xumin
	 * @param @param resultList
	 * @param @return
	 * @return List<Team>
	 * @date 2016年3月23日 下午3:09:15
	 */
	List<Team> queryTeamCnList(List<Team> resultList);

	/**
	 * @Method queryTeamCn2List
	 * @category 获取党小组信息（将数据库查询出来的信息再处理，增加字段的中文意思）,将党小组名称加上**镇**村
	 * @author xumin
	 * @param @param resultList
	 * @param @return
	 * @return List<Team>
	 * @date 2016年3月26日 下午3:05:13
	 */
	List<Team> queryTeamCn2List(List<Team> resultList);
}
