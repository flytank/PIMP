package com.app.logic;

import java.io.IOException;

import javax.servlet.Servlet;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import com.app.bean.BaseRequestBean;
import com.app.bean.BaseResponseBean;

/**
 * APP接口的控制类
 * 
 */
public class ClientServerController implements Servlet {

	private static final Logger log = Logger.getLogger(ClientServerController.class);

	private WebApplicationContext wac;

	private ILogicExecuteWorkerEngine logicExecuteWorkerEngin;

	private ITransmission transmission;

	public void destroy() {

	}

	public ServletConfig getServletConfig() {
		return null;
	}

	public String getServletInfo() {
		return null;
	}

	public void init(ServletConfig servletConfig) throws ServletException {
		wac = WebApplicationContextUtils.getWebApplicationContext(servletConfig.getServletContext());
		logicExecuteWorkerEngin = (ILogicExecuteWorkerEngine) wac.getBean("logicExecuteWorkerEnginBean");
		log.debug("logicExecuteWorkerEngin is:[" + logicExecuteWorkerEngin + "]");
		transmission = (ITransmission) wac.getBean("transmissionBean");
		log.debug("transmission is:[" + transmission + "]");
	}

	public void service(ServletRequest req, ServletResponse resp) throws ServletException, IOException {
		HttpServletRequest request = (HttpServletRequest) req;
		HttpServletResponse response = (HttpServletResponse) resp;
		if (null != transmission && null != logicExecuteWorkerEngin) {
			String json = transmission.resv(request);
			BaseRequestBean brb = logicExecuteWorkerEngin.trans(json);
			if (null != brb) {
				ILogicFace logic = logicExecuteWorkerEngin.getILogicFaceByActionCode(brb.getActionCode());
				if (null != logic) {
					BaseResponseBean brespon = (BaseResponseBean) logic.logic(wac, brb);
					if (null != brespon) {
						transmission.resp(response, brespon);
					}
				}
			} else {

			}
		}

	}

}
