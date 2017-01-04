package com.app.bean;

/**
 * APP接口的实体Bean的请求端（根据用户名更新密码）
 * 
 */
public class UpdateUserPwdRequestBean extends BaseRequestBean {

	private String username; // 用户名

	private String password; // 密码

	public UpdateUserPwdRequestBean() {
		this.setActionCode("1302");
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

}
