package com.altmm.test;

import com.app.bean.UpdateUserPwdRequestBean;

import core.util.AppSendUtils;

/**
 * 测试APP接口
 */
public class TestApp {

	public static void main(String[] args) {
		UpdateUserPwdRequestBean plrb = new UpdateUserPwdRequestBean();
		plrb.setUsername("杨添");
		plrb.setPassword("123456");
		String result = AppSendUtils.SendToUrlByBean(plrb); // 根据用户名修改密码
		System.out.println(result);
	}

}
