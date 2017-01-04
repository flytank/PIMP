package com.app.logic;

import org.springframework.web.context.WebApplicationContext;

/**
 * APP接口的业务处理逻辑封装接口
 * 
 */
public interface ILogicFace<BaseRequestBean, BaseResponseBean> {

	public BaseResponseBean logic(WebApplicationContext wac, BaseRequestBean brb);

}
