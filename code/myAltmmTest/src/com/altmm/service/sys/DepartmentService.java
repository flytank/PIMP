package com.altmm.service.sys;

import java.util.List;

import com.altmm.model.sys.Department;

import core.service.Service;

/**
 * 部门的业务逻辑层的接口
 * 
 */
public interface DepartmentService extends Service<Department> {

	// 获取包含部门中文名称的列表
	List<Department> queryDepartmentCnList(List<Department> resultList);

}
