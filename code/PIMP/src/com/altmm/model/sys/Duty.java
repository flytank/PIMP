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

import com.altmm.model.sys.param.DutyParameter;

/**
 * @file Duty.java
 * @category 职责字典表的实体类
 * @author xumin
 * @date 2016年3月22日 下午2:47:57
 */
@Entity
@Table(name = "duty")
@Cache(region = "all", usage = CacheConcurrencyStrategy.NONSTRICT_READ_WRITE)
@JsonIgnoreProperties(value = { "maxResults", "firstResult", "topCount",
		"sortColumns", "cmd", "queryDynamicConditions", "sortedConditions",
		"dynamicProperties", "success", "message", "sortColumnsString", "flag" })
public class Duty extends DutyParameter {

	private static final long serialVersionUID = -6814257955560870784L;
	@Id
	@GenericGenerator(name = "idGenerator", strategy = "uuid")
	@GeneratedValue(generator = "idGenerator")
	@Column(name = "dutyCode")
	private String id; // 职责编码
	@Column(name = "dutyName", length = 100, nullable = false)
	private String dutyName;// 职责名称
	@Column(name = "mark", length = 100)
	private String mark; // 备注
	@Column(name = "points")
	private Double points;// 总分，该职责不能超过这个分值

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getDutyName() {
		return dutyName;
	}

	public void setDutyName(String dutyName) {
		this.dutyName = dutyName;
	}

	public String getMark() {
		return mark;
	}

	public void setMark(String mark) {
		this.mark = mark;
	}

	public Double getPoints() {
		return points;
	}

	public void setPoints(Double points) {
		this.points = points;
	}

}