package com.altmm.dao.sys.impl;

import java.util.List;
import java.util.Map;

import org.hibernate.Query;
import org.hibernate.transform.Transformers;
import org.springframework.stereotype.Repository;

import com.altmm.dao.sys.SysUserDao;
import com.altmm.model.sys.SysUser;

import core.dao.BaseDao;

/**
 * 用户的数据持久层的实现类
 * 
 */
@Repository
public class SysUserDaoImpl extends BaseDao<SysUser> implements SysUserDao {

	public SysUserDaoImpl() {
		super(SysUser.class);
	}

	// 通过sql语句获得对象列表
	@Override
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> getObjectListByQuery(String sql) {
		Query query = this.getSession().createSQLQuery(sql)
				.setResultTransformer(Transformers.ALIAS_TO_ENTITY_MAP);
		return query.list();
	}

	// 通过sql语句获得字符串列表
	@Override
	@SuppressWarnings("unchecked")
	public List<Object> getObjectByQuery(String sql) {
		Query query = this.getSession().createSQLQuery(sql);
		return query.list();
	}
}
