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
import org.hibernate.annotations.GenericGenerator;

import com.altmm.model.sys.param.SysUserParameter;

import core.support.DateSerializer;

/**
 * @file SysUser.java
 * @category 用户的实体类
 * @author xumin
 * @date 2016年3月20日 下午4:21:59
 */
@Entity
@Table(name = "sys_user")
@Cache(region = "all", usage = CacheConcurrencyStrategy.NONSTRICT_READ_WRITE)
@JsonIgnoreProperties(value = { "maxResults", "firstResult", "topCount",
		"sortColumns", "cmd", "queryDynamicConditions", "sortedConditions",
		"dynamicProperties", "success", "message", "sortColumnsString", "flag" })
public class SysUser extends SysUserParameter {

	private static final long serialVersionUID = -2278993643720206152L;
	// 各个字段的含义请查阅文档的数据库结构部分

	@Id
	@GenericGenerator(name = "idGenerator", strategy = "uuid")
	@GeneratedValue(generator = "idGenerator")
	@Column(name = "UUID")
	private String id;
	@Column(name = "loginName", length = 40, nullable = false, unique = true)
	private String loginName;// 登录名
	@Column(name = "name", length = 50, nullable = false)
	private String userName;// 姓名
	@Column(name = "sex", length = 5)
	private String sex; // 性别
	@Column(name = "IDCard", length = 40)
	private String idCard;// 身份证
	@Column(name = "birthday")
	@Temporal(TemporalType.DATE)
	private Date birthday;// 出生日期
	@Column(name = "education", length = 50)
	private String education;// 学历
	@Column(name = "position", length = 50)
	private String position;// 职位
	@Column(name = "identity", nullable = false)
	private int identity;// 身份，1为党员，2为入党积极分子，3为群众
	@Column(name = "sortID", length = 40)
	private String sortID;// 党员类别编码
	@Column(name = "teamID", length = 40)
	private String teamID;// 党小组
	@Column(name = "villageID", length = 40)
	private String villageID;// 所属自然村编码
	@Column(name = "townID", length = 40)
	private String townID;// 所属乡镇编码
	@Column(name = "zoneID", length = 40)
	private String zoneID;// 所属区域编码
	@Column(name = "password")
	private String password;// 密码
	@Column(name = "role", length = 40, nullable = false)
	private String role;// 角色
	@Column(name = "status", nullable = false)
	private int status;// 状态，1为已激活，2为未激活，3为停用
	@Column(name = "createTime")
	private Date createTime;// 创建时间
	@Column(name = "points")
	private Double points;// 用户总积分

	public Double getPoints() {
		return points;
	}

	public void setPoints(Double points) {
		this.points = points;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getSex() {
		return sex;
	}

	public void setSex(String sex) {
		this.sex = sex;
	}

	public String getIdCard() {
		return idCard;
	}

	public void setIdCard(String idCard) {
		this.idCard = idCard;
	}

	public String getEducation() {
		return education;
	}

	public void setEducation(String education) {
		this.education = education;
	}

	public String getPosition() {
		return position;
	}

	public void setPosition(String position) {
		this.position = position;
	}

	public String getSortID() {
		return sortID;
	}

	public void setSortID(String sortID) {
		this.sortID = sortID;
	}

	public String getTeamID() {
		return teamID;
	}

	public void setTeamID(String teamID) {
		this.teamID = teamID;
	}

	public String getVillageID() {
		return villageID;
	}

	public void setVillageID(String villageID) {
		this.villageID = villageID;
	}

	public String getTownID() {
		return townID;
	}

	public void setTownID(String townID) {
		this.townID = townID;
	}

	public String getZoneID() {
		return zoneID;
	}

	public void setZoneID(String zoneID) {
		this.zoneID = zoneID;
	}

	public int getIdentity() {
		return identity;
	}

	public void setIdentity(int identity) {
		this.identity = identity;
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

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

	public String getLoginName() {
		return loginName;
	}

	public void setLoginName(String loginName) {
		this.loginName = loginName;
	}

	@JsonSerialize(using = DateSerializer.class)
	public Date getBirthday() {
		return birthday;
	}

	public void setBirthday(Date birthday) {
		this.birthday = birthday;
	}

	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}

}