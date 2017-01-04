package com.altmm.model.sys.param;

import core.support.ExtJSBaseParameter;

/**
 * 部门的参数类
 * 
 */
public class DepartmentParameter extends ExtJSBaseParameter {

	private String $eq_departmentKey;
	private String $like_departmentValue;
	private String parentDepartmentValue;

	public String get$eq_departmentKey() {
		return $eq_departmentKey;
	}

	public void set$eq_departmentKey(String $eq_departmentKey) {
		this.$eq_departmentKey = $eq_departmentKey;
	}

	public String get$like_departmentValue() {
		return $like_departmentValue;
	}

	public void set$like_departmentValue(String $like_departmentValue) {
		this.$like_departmentValue = $like_departmentValue;
	}

	public String getParentDepartmentValue() {
		return parentDepartmentValue;
	}

	public void setParentDepartmentValue(String parentDepartmentValue) {
		this.parentDepartmentValue = parentDepartmentValue;
	}

}
