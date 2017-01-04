package com.altmm.model.sys.param;

import core.support.ExtJSBaseParameter;

/**
 * 信息发布的参数类
 * 
 */
public class InformationParameter extends ExtJSBaseParameter {

	private String $like_title;
	private String contentNoHTML;

	public String get$like_title() {
		return $like_title;
	}

	public void set$like_title(String $like_title) {
		this.$like_title = $like_title;
	}

	public String getContentNoHTML() {
		return contentNoHTML;
	}

	public void setContentNoHTML(String contentNoHTML) {
		this.contentNoHTML = contentNoHTML;
	}

}
