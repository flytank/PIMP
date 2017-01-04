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

import com.altmm.model.sys.param.ZoneParameter;

/**
 * @file Zone.java
 * @category 区域表的实体类
 * @author xumin
 * @date 2016年3月20日 下午4:26:48
 */
@Entity
@Table(name = "zone")
@Cache(region = "all", usage = CacheConcurrencyStrategy.NONSTRICT_READ_WRITE)
@JsonIgnoreProperties(value = { "maxResults", "firstResult", "topCount",
		"sortColumns", "cmd", "queryDynamicConditions", "sortedConditions",
		"dynamicProperties", "success", "message", "sortColumnsString", "flag" })
public class Zone extends ZoneParameter {

	private static final long serialVersionUID = -1738391302340318895L;
	@Id
	@GenericGenerator(name = "idGenerator", strategy = "uuid")
	@GeneratedValue(generator = "idGenerator")
	@Column(name = "zoneCode")
	private String id; // 区域编码
	@Column(name = "zoneName", length = 50, nullable = false)
	private String name;// 区域名称
	@Column(name = "cityCode", length = 40)
	private String cityCode; // 所属城市

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getCityCode() {
		return cityCode;
	}

	public void setCityCode(String cityCode) {
		this.cityCode = cityCode;
	}
}