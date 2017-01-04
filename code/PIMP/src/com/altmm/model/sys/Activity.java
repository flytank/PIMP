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

import com.altmm.model.sys.param.ActivityParameter;

/**
 * @file Activity.java
 * @category 活动的实体类
 * @author xumin
 * @date 2016年3月19日 下午4:31:08
 */
@Entity
@Table(name = "activity")
@Cache(region = "all", usage = CacheConcurrencyStrategy.NONSTRICT_READ_WRITE)
@JsonIgnoreProperties(value = { "maxResults", "firstResult", "topCount",
		"sortColumns", "cmd", "queryDynamicConditions", "sortedConditions",
		"dynamicProperties", "success", "message", "sortColumnsString", "flag" })
public class Activity extends ActivityParameter {

	private static final long serialVersionUID = 3293972769950494311L;

	@Id
	@GenericGenerator(name = "idGenerator", strategy = "uuid")
	@GeneratedValue(generator = "idGenerator")
	@Column(name = "UUID")
	private String id;
	@Column(name = "subject", length = 100, nullable = false)
	private String subject;// 主题
	@Column(name = "content", length = 255)
	private String content; // 内容
	@Column(name = "startDate")
	@Temporal(TemporalType.DATE)
	private Date startDate;// 开始时间
	@Column(name = "endDate")
	@Temporal(TemporalType.DATE)
	private Date endDate;// 截止时间
	@Column(name = "scope")
	private int scope;// 活动范围，1为区域，2为乡镇，3为自然村
	@Column(name = "villageID", length = 40)
	private String villageID;// 所属自然村编码
	@Column(name = "townID", length = 40)
	private String townID;// 所属乡镇编码
	@Column(name = "zoneID", length = 40)
	private String zoneID;// 所属区域编码
	@Column(name = "place", length = 100)
	private String place;// 地点
	@Column(name = "dutyCode", length = 40)
	private String dutyCode;// 职责编码，参照职责表的主键

	@Column(name = "points")
	private Double points;// 本次活动积分，积分不能超过职责积分
	@Column(name = "isShow")
	private Boolean isShow;// 是否展示，false为不展示

	@Column(name = "mark", length = 100)
	private String mark;// 备注
	@Column(name = "activityPic", length = 200)
	private String activityPic;// 图片

	@Column(name = "createTime")
	private Date createTime;// 创建时间

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

	public Date getStartDate() {
		return startDate;
	}

	public void setStartDate(Date startDate) {
		this.startDate = startDate;
	}

	public Date getEndDate() {
		return endDate;
	}

	public void setEndDate(Date endDate) {
		this.endDate = endDate;
	}

	public String getPlace() {
		return place;
	}

	public void setPlace(String place) {
		this.place = place;
	}

	public String getMark() {
		return mark;
	}

	public void setMark(String mark) {
		this.mark = mark;
	}

	public String getActivityPic() {
		return activityPic;
	}

	public void setActivityPic(String activityPic) {
		this.activityPic = activityPic;
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

	public String getDutyCode() {
		return dutyCode;
	}

	public void setDutyCode(String dutyCode) {
		this.dutyCode = dutyCode;
	}

	public Double getPoints() {
		return points;
	}

	public void setPoints(Double points) {
		this.points = points;
	}

	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}

}