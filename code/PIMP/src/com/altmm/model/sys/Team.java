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

import com.altmm.model.sys.param.TeamParameter;

/**
 * @file Team.java
 * @category 党小组的实体类
 * @author xumin
 * @date 2016年3月19日 下午5:06:51
 */
@Entity
@Table(name = "team")
@Cache(region = "all", usage = CacheConcurrencyStrategy.NONSTRICT_READ_WRITE)
@JsonIgnoreProperties(value = { "maxResults", "firstResult", "topCount",
		"sortColumns", "cmd", "queryDynamicConditions", "sortedConditions",
		"dynamicProperties", "success", "message", "sortColumnsString", "flag" })
public class Team extends TeamParameter {

	private static final long serialVersionUID = 3784246890734517235L;
	@Id
	@GenericGenerator(name = "idGenerator", strategy = "uuid")
	@GeneratedValue(generator = "idGenerator")
	@Column(name = "teamID")
	private String id;// 党小组编码
	@Column(name = "teamName", length = 100, nullable = false)
	private String teamName;// 党小组名称
	@Column(name = "villageID", length = 40)
	private String villageID;// 所属自然村编码
	@Column(name = "townID", length = 40)
	private String townID;// 所属乡镇编码
	@Column(name = "zoneID", length = 40)
	private String zoneID;// 所属区域编码
	@Column(name = "mark", length = 100)
	private String mark;// 备注

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getTeamName() {
		return teamName;
	}

	public void setTeamName(String teamName) {
		this.teamName = teamName;
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

	public String getMark() {
		return mark;
	}

	public void setMark(String mark) {
		this.mark = mark;
	}

}