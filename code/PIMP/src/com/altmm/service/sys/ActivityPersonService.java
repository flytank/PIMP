package com.altmm.service.sys;

import java.util.List;

import com.altmm.model.sys.ActivityPerson;

import core.service.Service;

/**
 * @file ActivityPersonService.java
 * @category 活动人员的业务逻辑层的接口
 * @author xumin
 * @date 2016年4月10日 下午9:44:51
 */
public interface ActivityPersonService extends Service<ActivityPerson> {
	/**
	 * @Method queryActivityPersonCnList
	 * @category 获取活动人员信息（将数据库查询出来的信息再处理，增加字段的中文意思）
	 * @author xumin
	 * @param @param resultList
	 * @param @return
	 * @return List<ActivityPerson>
	 * @date 2016年4月10日 下午10:07:19
	 */
	List<ActivityPerson> queryActivityPersonCnList(
			List<ActivityPerson> resultList);
}
