package com.altmm.dao.sys.impl;

import org.springframework.stereotype.Repository;

import com.altmm.dao.sys.DepartmentDao;
import com.altmm.model.sys.Department;

import core.dao.BaseDao;

/**
 * 部门的数据持久层的实现类
 * 
 */
@Repository
public class DepartmentDaoImpl extends BaseDao<Department>implements DepartmentDao {

	public DepartmentDaoImpl() {
		super(Department.class);
	}

}
