package com.altmm.model.sys.param;

import core.support.ExtJSBaseParameter;

/**
 * @file NoticeParameter.java
 * @category 公示表的参数类
 * @author xumin
 * @date 2016年3月23日 下午2:00:37
 */
public class NoticeParameter extends ExtJSBaseParameter {

	private static final long serialVersionUID = 1168235323966946452L;
	private String villageCn;// 自然村名称
	private String townCn;// 乡镇名称
	private String zoneCn;// 区域名称
	private String userCn;// 用户名称
	private String scopeCn;// 活动范围
	private String isShowCn;// 是否展示

	private Boolean $eq_isShow;// 匹配是否展示
	private String $like_subject;// 蘑菇匹配主题
	private String $eq_townID;// 匹配乡镇
	private String $eq_villageID;// 匹配自然村

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

	public String getUserCn() {
		return userCn;
	}

	public void setUserCn(String userCn) {
		this.userCn = userCn;
	}

	public String getScopeCn() {
		return scopeCn;
	}

	public void setScopeCn(String scopeCn) {
		this.scopeCn = scopeCn;
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

	public String getIsShowCn() {
		return isShowCn;
	}

	public void setIsShowCn(String isShowCn) {
		this.isShowCn = isShowCn;
	}

	public Boolean get$eq_isShow() {
		return $eq_isShow;
	}

	public void set$eq_isShow(Boolean $eq_isShow) {
		this.$eq_isShow = $eq_isShow;
	}

}
