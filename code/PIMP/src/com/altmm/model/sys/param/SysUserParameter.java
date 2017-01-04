package com.altmm.model.sys.param;

import core.support.ExtJSBaseParameter;

/**
 * 用户的参数类
 * 
 */
public class SysUserParameter extends ExtJSBaseParameter {

	private static final long serialVersionUID = 7656443663108619135L;
	private String sortCn;// 党员类别名称
	private String teamCn;// 党小组名称
	private String villageCn;// 自然村名称
	private String townCn;// 乡镇名称
	private String zoneCn;// 区域名称
	private String statusCn;// 状态名称
	private String roleCn;// 角色名称
	private String identityCn;// 身份名称
	private String $like_loginName;// 蘑菇匹配登录名
	private String $like_userName;// 蘑菇匹配用户名
	private String $like_idCard;// 蘑菇匹配身份证
	private String $eq_townID;// 匹配乡镇
	private String $eq_villageID;// 匹配自然村
	private String $ne_role;// 不等于该角色
	private Integer $eq_identity;// 匹配用户身份
	private Integer $ne_identity;// 不匹配用户身份

	public Integer get$ne_identity() {
		return $ne_identity;
	}

	public void set$ne_identity(Integer $ne_identity) {
		this.$ne_identity = $ne_identity;
	}

	public String getSortCn() {
		return sortCn;
	}

	public void setSortCn(String sortCn) {
		this.sortCn = sortCn;
	}

	public String getTeamCn() {
		return teamCn;
	}

	public void setTeamCn(String teamCn) {
		this.teamCn = teamCn;
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

	public String getStatusCn() {
		return statusCn;
	}

	public void setStatusCn(String statusCn) {
		this.statusCn = statusCn;
	}

	public String getRoleCn() {
		return roleCn;
	}

	public void setRoleCn(String roleCn) {
		this.roleCn = roleCn;
	}

	public String getIdentityCn() {
		return identityCn;
	}

	public void setIdentityCn(String identityCn) {
		this.identityCn = identityCn;
	}

	public String get$like_loginName() {
		return $like_loginName;
	}

	public void set$like_loginName(String $like_loginName) {
		this.$like_loginName = $like_loginName;
	}

	public String get$like_userName() {
		return $like_userName;
	}

	public void set$like_userName(String $like_userName) {
		this.$like_userName = $like_userName;
	}

	public String get$like_idCard() {
		return $like_idCard;
	}

	public void set$like_idCard(String $like_idCard) {
		this.$like_idCard = $like_idCard;
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

	public String get$ne_role() {
		return $ne_role;
	}

	public void set$ne_role(String $ne_role) {
		this.$ne_role = $ne_role;
	}

	public Integer get$eq_identity() {
		return $eq_identity;
	}

	public void set$eq_identity(Integer $eq_identity) {
		this.$eq_identity = $eq_identity;
	}

}
