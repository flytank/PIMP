package com.altmm.model.sys.param;

import core.support.ExtJSBaseParameter;

/**
 * @file ActivityPersonParameter.java
 * @category 活动人员表的参数类
 * @author xumin
 * @date 2016年3月23日 下午1:37:59
 */
public class ActivityPersonParameter extends ExtJSBaseParameter {

	private static final long serialVersionUID = -5939012275091519816L;
	private String activityCn;// 活动名称
	private String userCn;// 用户名称
	private String idNoCn;// 身份证

	public String getIdNoCn() {
		return idNoCn;
	}

	public void setIdNoCn(String idNoCn) {
		this.idNoCn = idNoCn;
	}

	public String getActivityCn() {
		return activityCn;
	}

	public void setActivityCn(String activityCn) {
		this.activityCn = activityCn;
	}

	public String getUserCn() {
		return userCn;
	}

	public void setUserCn(String userCn) {
		this.userCn = userCn;
	}
}
