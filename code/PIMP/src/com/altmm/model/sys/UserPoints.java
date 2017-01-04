package com.altmm.model.sys;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

import org.codehaus.jackson.annotate.JsonIgnoreProperties;
import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;
import org.hibernate.annotations.GenericGenerator;

import com.altmm.model.sys.param.UserPointsParameter;

/**
 * @file UserPoints.java
 * @category 用户积分表的实体类
 * @author xumin
 * @date 2016年3月22日 下午2:53:30
 */
@Entity
@Table(name = "userpoints")
@Cache(region = "all", usage = CacheConcurrencyStrategy.NONSTRICT_READ_WRITE)
@JsonIgnoreProperties(value = { "maxResults", "firstResult", "topCount",
		"sortColumns", "cmd", "queryDynamicConditions", "sortedConditions",
		"dynamicProperties", "success", "message", "sortColumnsString", "flag" })
public class UserPoints extends UserPointsParameter {

	private static final long serialVersionUID = 1527497859277599777L;
	@Id
	@GenericGenerator(name = "idGenerator", strategy = "uuid")
	@GeneratedValue(generator = "idGenerator")
	@Column(name = "UUID")
	private String id; // 主键
	@Column(name = "userUUID", length = 40, nullable = false)
	private String userID;// 用户主键
	@Column(name = "source")
	private int source; // 积分来源, 1为活动，2为职责
	@Column(name = "sourceCode", length = 40)
	private String sourceID;// 积分来源编码
	@Column(name = "points")
	private Double points;// 积分
	@Column(name = "time")
	private Date time; // 时间
	@Column(name = "isEffect")
	private Boolean isEffect;// 是否有效
	@Column(name = "mark")
	private String mark;// 备注

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public int getSource() {
		return source;
	}

	public void setSource(int source) {
		this.source = source;
	}

	public String getUserID() {
		return userID;
	}

	public void setUserID(String userID) {
		this.userID = userID;
	}

	public String getSourceID() {
		return sourceID;
	}

	public void setSourceID(String sourceID) {
		this.sourceID = sourceID;
	}

	public Double getPoints() {
		return points;
	}

	public void setPoints(Double points) {
		this.points = points;
	}

	public Date getTime() {
		return time;
	}

	public void setTime(Date time) {
		this.time = time;
	}

	public Boolean getIsEffect() {
		return isEffect;
	}

	public void setIsEffect(Boolean isEffect) {
		this.isEffect = isEffect;
	}

	public String getMark() {
		return mark;
	}

	public void setMark(String mark) {
		this.mark = mark;
	}

}