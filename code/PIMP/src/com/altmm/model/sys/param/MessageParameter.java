package com.altmm.model.sys.param;

import core.support.ExtJSBaseParameter;

/**
 * @file MessageParameter.java
 * @category 留言表的参数类
 * @author xumin
 * @date 2016年3月23日 下午2:06:41
 */
public class MessageParameter extends ExtJSBaseParameter {

	private static final long serialVersionUID = -4586243989296447020L;
	private String userCn;// 用户名称
	private String sourceCn;// 来源名称
	private String messageCn;// 留言对象名称

	public String getUserCn() {
		return userCn;
	}

	public void setUserCn(String userCn) {
		this.userCn = userCn;
	}

	public String getSourceCn() {
		return sourceCn;
	}

	public void setSourceCn(String sourceCn) {
		this.sourceCn = sourceCn;
	}

	public String getMessageCn() {
		return messageCn;
	}

	public void setMessageCn(String messageCn) {
		this.messageCn = messageCn;
	}

}
