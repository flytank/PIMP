package com.altmm.model.sys.param;

import core.support.ExtJSBaseParameter;

/**
 * @file TeamParameter.java
 * @category 党小组的参数类
 * @author xumin
 * @date 2016年3月19日 下午4:40:11
 */
public class TeamParameter extends ExtJSBaseParameter {

	private static final long serialVersionUID = -7810396618090134699L;
	private String villageCn;// 自然村名称
	private String townCn;// 乡镇名称
	private String zoneCn;// 区域名称
	private String $like_teamName;// 蘑菇匹配名称
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

	public String get$like_teamName() {
		return $like_teamName;
	}

	public void set$like_teamName(String $like_teamName) {
		this.$like_teamName = $like_teamName;
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

}
