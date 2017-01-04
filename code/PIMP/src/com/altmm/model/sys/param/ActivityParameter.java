package com.altmm.model.sys.param;

import java.util.Date;

import core.support.ExtJSBaseParameter;

/**
 * @file ActivityParameter.java
 * @category 活动的参数类
 * @author xumin
 * @date 2016年3月19日 下午4:30:50
 */
public class ActivityParameter extends ExtJSBaseParameter {

	private static final long serialVersionUID = -3875699195009777588L;
	private String villageCn;// 自然村名称
	private String townCn;// 乡镇名称
	private String zoneCn;// 区域名称
	private String scopeCn;// 活动范围
	private String dutyCn;// 职责名称
	private String isShowCn;// 是否展示
	private Boolean $eq_isShow;// 匹配是否展示
	private String $like_subject;// 蘑菇匹配名称
	private String $eq_townID;// 匹配乡镇
	private String $eq_villageID;// 匹配自然村
	private Date $ge_startDate; // 开始时间
	private Date $le_startDate; // 开始时间

	public Boolean get$eq_isShow() {
		return $eq_isShow;
	}

	public void set$eq_isShow(Boolean $eq_isShow) {
		this.$eq_isShow = $eq_isShow;
	}

	public String getVillageCn() {
		return villageCn;
	}

	public void setVillageCn(String villageCn) {
		this.villageCn = villageCn;
	}

	public String getTownCn() {
		return townCn;
	}

	public void setTownCn(String townCn) {
		this.townCn = townCn;
	}

	public String getZoneCn() {
		return zoneCn;
	}

	public void setZoneCn(String zoneCn) {
		this.zoneCn = zoneCn;
	}

	public String getScopeCn() {
		return scopeCn;
	}

	public void setScopeCn(String scopeCn) {
		this.scopeCn = scopeCn;
	}

	public String getDutyCn() {
		return dutyCn;
	}

	public void setDutyCn(String dutyCn) {
		this.dutyCn = dutyCn;
	}

	public String getIsShowCn() {
		return isShowCn;
	}

	public void setIsShowCn(String isShowCn) {
		this.isShowCn = isShowCn;
	}

	public String get$like_subject() {
		return $like_subject;
	}

	public void set$like_subject(String $like_subject) {
		this.$like_subject = $like_subject;
	}

	public String get$eq_townID() {
		return $eq_townID;
	}

	public void set$eq_townID(String $eq_townID) {
		this.$eq_townID = $eq_townID;
	}

	public String get$eq_villageID() {
		return $eq_villageID;
	}

	public void set$eq_villageID(String $eq_villageID) {
		this.$eq_villageID = $eq_villageID;
	}

	public Date get$ge_startDate() {
		return $ge_startDate;
	}

	public void set$ge_startDate(Date $ge_startDate) {
		this.$ge_startDate = $ge_startDate;
	}

	public Date get$le_startDate() {
		return $le_startDate;
	}

	public void set$le_startDate(Date $le_startDate) {
		this.$le_startDate = $le_startDate;
	}

}
