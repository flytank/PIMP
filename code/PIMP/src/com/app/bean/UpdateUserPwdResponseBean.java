package com.app.bean;

/**
 * APP接口的实体Bean的响应端（根据用户名更新密码）
 * 
 */
public class UpdateUserPwdResponseBean extends BaseResponseBean {

	private String result; // 返回结果

	public String getResult() {
		return result;
	}

	public void setResult(String result) {
		this.result = result;
	}

}
