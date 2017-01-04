package com.altmm.model.sys.param;

import java.util.Date;

import core.support.ExtJSBaseParameter;

/**
 * @file userPointsParameter.java
 * @category 用户积分表的参数类
 * @author xumin
 * @date 2016年3月22日 下午2:51:42
 */
public class UserPointsParameter extends ExtJSBaseParameter {

	private static final long serialVersionUID = -871561635738403575L;

	private Date $ge_time; // 开始时间
	private Date $le_time; // 开始时间

	public Date get$ge_time() {
		return $ge_time;
	}

	public void set$ge_time(Date $ge_time) {
		this.$ge_time = $ge_time;
	}

	public Date get$le_time() {
		return $le_time;
	}

	public void set$le_time(Date $le_time) {
		this.$le_time = $le_time;
	}

}
