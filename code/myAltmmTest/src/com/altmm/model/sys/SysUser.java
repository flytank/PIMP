package com.altmm.model.sys;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import org.codehaus.jackson.annotate.JsonIgnoreProperties;
import org.codehaus.jackson.map.annotate.JsonSerialize;
import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;

import com.altmm.model.sys.param.SysUserParameter;
import com.google.common.base.Objects;

import core.support.DateSerializer;
import core.support.DateTimeSerializer;

/**
 * 用户的实体类
 * 
 */
@Entity
@Table(name = "sys_user")
@Cache(region = "all", usage = CacheConcurrencyStrategy.NONSTRICT_READ_WRITE)
@JsonIgnoreProperties(value = { "maxResults", "firstResult", "topCount", "sortColumns", "cmd", "queryDynamicConditions",
		"sortedConditions", "dynamicProperties", "success", "message", "sortColumnsString", "flag" })
public class SysUser extends SysUserParameter {

	// 各个字段的含义请查阅文档的数据库结构部分
	private static final long serialVersionUID = 822330369002149147L;
	@Id
	@GeneratedValue
	@Column(name = "id")
	private Long id;
	@Column(name = "user_name", length = 40, nullable = false)
	private String userName;
	@Column(name = "sex")
	private Short sex;
	@Column(name = "email", length = 30, nullable = false, unique = true)
	private String email;
	@Column(name = "phone", length = 20)
	private String phone;
	@Column(name = "birthday")
	@Temporal(TemporalType.DATE)
	private Date birthday;
	@Column(name = "department_key", length = 20)
	private String departmentKey;
	@Column(name = "password", length = 35, nullable = false)
	private String password;
	@Column(name = "role", length = 40, nullable = false)
	private String role;
	@Column(name = "status", nullable = false)
	private Boolean status;
	@Column(name = "last_logintime")
	@Temporal(TemporalType.TIMESTAMP)
	private Date lastLoginTime;

	public SysUser() {

	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public Short getSex() {
		return sex;
	}

	public void setSex(Short sex) {
		this.sex = sex;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	@JsonSerialize(using = DateSerializer.class)
	public Date getBirthday() {
		return birthday;
	}

	public void setBirthday(Date birthday) {
		this.birthday = birthday;
	}

	public String getDepartmentKey() {
		return departmentKey;
	}

	public void setDepartmentKey(String departmentKey) {
		this.departmentKey = departmentKey;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getRole() {
		return role;
	}

	public void setRole(String role) {
		this.role = role;
	}

	public Boolean getStatus() {
		return status;
	}

	public void setStatus(Boolean status) {
		this.status = status;
	}

	@JsonSerialize(using = DateTimeSerializer.class)
	public Date getLastLoginTime() {
		return lastLoginTime;
	}

	public void setLastLoginTime(Date lastLoginTime) {
		this.lastLoginTime = lastLoginTime;
	}

	public boolean equals(Object obj) {
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		final SysUser other = (SysUser) obj;
		return Objects.equal(this.id, other.id) && Objects.equal(this.userName, other.userName)
				&& Objects.equal(this.sex, other.sex) && Objects.equal(this.email, other.email)
				&& Objects.equal(this.phone, other.phone) && Objects.equal(this.birthday, other.birthday)
				&& Objects.equal(this.departmentKey, other.departmentKey)
				&& Objects.equal(this.password, other.password) && Objects.equal(this.role, other.role)
				&& Objects.equal(this.status, other.status) && Objects.equal(this.lastLoginTime, other.lastLoginTime);
	}

	public int hashCode() {
		return Objects.hashCode(this.id, this.userName, this.sex, this.email, this.phone, this.birthday,
				this.departmentKey, this.password, this.role, this.status, this.lastLoginTime);
	}

}