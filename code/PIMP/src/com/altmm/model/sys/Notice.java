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
import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;
import org.hibernate.annotations.GenericGenerator;

import com.altmm.model.sys.param.NoticeParameter;

/**
 * @file Notice.java
 * @category 公示表的实体类
 * @author xumin
 * @date 2016年3月23日 下午2:01:51
 */
@Entity
@Table(name = "notice")
@Cache(region = "all", usage = CacheConcurrencyStrategy.NONSTRICT_READ_WRITE)
@JsonIgnoreProperties(value = { "maxResults", "firstResult", "topCount",
		"sortColumns", "cmd", "queryDynamicConditions", "sortedConditions",
		"dynamicProperties", "success", "message", "sortColumnsString", "flag" })
public class Notice extends NoticeParameter {

	private static final long serialVersionUID = -804270136373543621L;
	@Id
	@GenericGenerator(name = "idGenerator", strategy = "uuid")
	@GeneratedValue(generator = "idGenerator")
	@Column(name = "UUID")
	private String id;
	@Column(name = "subject", length = 100, nullable = false)
	private String subject;// 主题
	@Column(name = "content", length = 255)
	private String content; // 内容
	@Column(name = "scope")
	private int scope;// 公示范围，1为区域，2为乡镇，3为自然村
	@Column(name = "villageID", length = 40)
	private String villageID;// 所属自然村编码
	@Column(name = "townID", length = 40)
	private String townID;// 所属乡镇编码
	@Column(name = "zoneID", length = 40)
	private String zoneID;// 所属区域编码

	@Column(name = "time")
	@Temporal(TemporalType.DATE)
	private Date createTime;// 时间
	@Column(name = "user", length = 40)
	private String user;// 公告者用户主键
	@Column(name = "mark", length = 100)
	private String mark;// 备注
	@Column(name = "isShow")
	private Boolean isShow;// 是否展示，false为不展示

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getSubject() {
		return subject;
	}

	public void setSubject(String subject) {
		this.subject = subject;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}

	public String getUser() {
		return user;
	}

	public void setUser(String user) {
		this.user = user;
	}

	public String getMark() {
		return mark;
	}

	public void setMark(String mark) {
		this.mark = mark;
	}

	public Boolean getIsShow() {
		return isShow;
	}

	public void setIsShow(Boolean isShow) {
		this.isShow = isShow;
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

	public int getScope() {
		return scope;
	}

	public void setScope(int scope) {
		this.scope = scope;
	}

}