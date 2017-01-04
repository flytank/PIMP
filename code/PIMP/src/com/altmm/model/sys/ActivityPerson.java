package com.altmm.model.sys;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

import org.codehaus.jackson.annotate.JsonIgnoreProperties;
import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;
import org.hibernate.annotations.GenericGenerator;

import com.altmm.model.sys.param.ActivityPersonParameter;

/**
 * @file ActivityPerson.java
 * @category 活动人员表的实体类
 * @author xumin
 * @date 2016年3月23日 下午1:47:51
 */
@Entity
@Table(name = "activityperson")
@Cache(region = "all", usage = CacheConcurrencyStrategy.NONSTRICT_READ_WRITE)
@JsonIgnoreProperties(value = { "maxResults", "firstResult", "topCount",
		"sortColumns", "cmd", "queryDynamicConditions", "sortedConditions",
		"dynamicProperties", "success", "message", "sortColumnsString", "flag" })
public class ActivityPerson extends ActivityPersonParameter {

	private static final long serialVersionUID = -1281823572303905016L;
	@Id
	@GenericGenerator(name = "idGenerator", strategy = "uuid")
	@GeneratedValue(generator = "idGenerator")
	@Column(name = "UUID")
	private String id;// 主键
	@Column(name = "actvityCode", length = 40, nullable = false)
	private String activityID;// 活动主键
	@Column(name = "userCode", length = 40, nullable = false)
	private String userID; // 用户主键
	@Column(name = "isAddPoints")
	private Boolean isAddPoints;// 是否添加积分，true为已对参加人员添加积分
	@Column(name = "mark", length = 100)
	private String mark;// 备注

	public Boolean getIsAddPoints() {
		return isAddPoints;
	}

	public void setIsAddPoints(Boolean isAddPoints) {
		this.isAddPoints = isAddPoints;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getActivityID() {
		return activityID;
	}

	public void setActivityID(String activityID) {
		this.activityID = activityID;
	}

	public String getUserID() {
		return userID;
	}

	public void setUserID(String userID) {
		this.userID = userID;
	}

	public String getMark() {
		return mark;
	}

	public void setMark(String mark) {
		this.mark = mark;
	}

}