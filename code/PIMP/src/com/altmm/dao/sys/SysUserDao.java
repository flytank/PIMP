package com.altmm.dao.sys;

import java.util.List;
import java.util.Map;

import com.altmm.model.sys.SysUser;

import core.dao.Dao;

/**
 * 用户的数据持久层的接口
 * 
 */
public interface SysUserDao extends Dao<SysUser> {
	/**
	 * @Method getObjectListByQuery
	 * @category 通过sql语句获得对象列表
	 * @author xumin
	 * @param @param sql
	 * @param @return
	 * @return List<Map<String,Object>>
	 * @date 2016年3月19日 上午10:59:14
	 */
	List<Map<String, Object>> getObjectListByQuery(String sql);

	/**
	 * @Method getObjectByQuery
	 * @category 通过sql语句获得字符串列表
	 * @author xumin
	 * @param @param queryString
	 * @param @return
	 * @return List<String>
	 * @date 2016年3月19日 上午10:59:33
	 */
	List<Object> getObjectByQuery(String queryString);
}
