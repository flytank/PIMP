package com.app.logic;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.Reader;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;

import com.app.bean.BaseResponseBean;
import com.google.gson.Gson;

/**
 * APP接口的协议传输接口的实现类
 * 
 */
public class Transmission implements ITransmission {

	private static final Logger log = Logger.getLogger(Transmission.class);

	private String encode = "UTF-8";

	public String getEncode() {
		return encode;
	}

	public void setEncode(String encode) {
		this.encode = encode;
	}

	public String resv(HttpServletRequest request) {
		StringBuilder sb = new StringBuilder();
		try {
			InputStream is = request.getInputStream();
			Reader reader = new InputStreamReader(is, encode);
			BufferedReader br = new BufferedReader(reader);
			String r_line = "";
			while (null != (r_line = br.readLine())) {
				// String r_line_ = new String(r_line.getBytes(),encode);
				sb.append(r_line);
			}
		} catch (IOException e) {
			log.debug(e, e);
		}
		log.debug("recv client request json is:[" + sb.toString() + "]");
		return sb.toString();
	}

	public void resp(HttpServletResponse response, BaseResponseBean brb) {
		response.setContentType("text/html;charset=UTF-8");
		Gson gson = new Gson();
		String result = gson.toJson(brb);
		log.debug("server response client json is:[" + result + "]");
		try {
			response.getWriter().write(result);
			response.flushBuffer();
		} catch (IOException e) {
			log.debug(e, e);
		}

	}

}
