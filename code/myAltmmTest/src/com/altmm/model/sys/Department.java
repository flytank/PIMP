package com.altmm.model.sys;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

import org.codehaus.jackson.annotate.JsonIgnoreProperties;
import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;

import com.altmm.model.sys.param.DepartmentParameter;
import com.google.common.base.Objects;

/**
 * 部门的实体类
 * 
 */
@Entity
@Table(name = "department")
@Cache(region = "all", usage = CacheConcurrencyStrategy.NONSTRICT_READ_WRITE)
@JsonIgnoreProperties(value = { "maxResults", "firstResult", "topCount", "sortColumns", "cmd", "queryDynamicConditions",
		"sortedConditions", "dynamicProperties", "success", "message", "sortColumnsString", "flag" })
public class Department extends DepartmentParameter {

	// 各个字段的含义请查阅文档的数据库结构部分
	private static final long serialVersionUID = -2240384171336800410L;
	@Id
	@GeneratedValue
	@Column(name = "id")
	private Long id;
	@Column(name = "department_key", length = 20, nullable = false, unique = true)
	private String departmentKey;
	@Column(name = "department_value", length = 40, nullable = false)
	private String departmentValue;
	@Column(name = "parent_departmentkey", length = 20)
	private String parentDepartmentkey;
	@Column(name = "description", length = 200)
	private String description;

	public Department() {

	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getDepartmentKey() {
		return departmentKey;
	}

	public void setDepartmentKey(String departmentKey) {
		this.departmentKey = departmentKey;
	}

	public String getDepartmentValue() {
		return departmentValue;
	}

	public void setDepartmentValue(String departmentValue) {
		this.departmentValue = departmentValue;
	}

	public String getParentDepartmentkey() {
		return parentDepartmentkey;
	}

	public void setParentDepartmentkey(String parentDepartmentkey) {
		this.parentDepartmentkey = parentDepartmentkey;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public boolean equals(Object obj) {
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		final Department other = (Department) obj;
		return Objects.equal(this.id, other.id) && Objects.equal(this.departmentKey, other.departmentKey)
				&& Objects.equal(this.departmentValue, other.departmentValue)
				&& Objects.equal(this.parentDepartmentkey, other.parentDepartmentkey)
				&& Objects.equal(this.description, other.description);
	}

	public int hashCode() {
		return Objects.hashCode(this.id, this.departmentKey, this.departmentValue, this.parentDepartmentkey,
				this.description);
	}

}
