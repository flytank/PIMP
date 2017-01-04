package com.app.logic;

import java.io.StringReader;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.Map.Entry;

import org.apache.log4j.Logger;

import com.app.bean.BaseRequestBean;
import com.google.gson.Gson;
import com.google.gson.stream.JsonReader;

/**
 * APP接口的业务逻辑执行引擎接口的实现类
 * 
 */
public class LogicExecuteWorkerEngine implements ILogicExecuteWorkerEngine {

	private String actionKey = "actionCode";

	public String getActionKey() {
		return actionKey;
	}

	public void setActionKey(String actionKey) {
		this.actionKey = actionKey;
	}

	private static final Logger log = Logger.getLogger(LogicExecuteWorkerEngine.class);

	private Map<String, Class> requestClassPool = new HashMap<String, Class>();

	private Map<String, ILogicFace> logicPool;

	public ILogicFace getILogicFaceByActionCode(String actionCode) {
		if (null != logicPool) {
			return this.logicPool.get(actionCode);
		} else {
			return null;
		}
	}

	public void setLogicPool(Map<String, ILogicFace> logicPool) {
		this.logicPool = logicPool;

	}

	public void setRequestBeanTrans(Map<String, String> class_map) {
		if (null != class_map) {
			Iterator<Entry<String, String>> itor = class_map.entrySet().iterator();
			while (itor.hasNext()) {
				Entry<String, String> entry = itor.next();
				String key_code = entry.getKey();
				String class_info = entry.getValue();
				try {
					Class clazz = Class.forName(class_info);
					requestClassPool.put(key_code, clazz);
				} catch (Exception e) {
					log.debug("class:[" + class_info + "] is not catch class_info");
				}
			}
		}

	}

	public BaseRequestBean trans(String json) {
		Gson gson = new Gson();
		try {
			String key_code = getActionKey(json, actionKey);
			Class target_class = this.requestClassPool.get(key_code);
			if (null != target_class) {
				BaseRequestBean brb = (BaseRequestBean) gson.fromJson(json, target_class);
				return brb;
			} else {
				return null;
			}
		} catch (Exception e) {
			log.debug(e, e);
			return null;
		}

	}

	/***************
	 * 从JSON中抽取对应字段的值
	 * 
	 * @param s
	 * @param actionKey
	 * @return
	 * @throws Exception
	 */
	private String getActionKey(String s, String actionKey) throws Exception {
		String key = "";
		JsonReader jr = new JsonReader(new StringReader(s));
		try {
			jr.beginObject();
			while (jr.hasNext()) {
				String keyName = jr.nextName();
				if (actionKey.equals(keyName)) {
					key = jr.nextString();
				} else {
					jr.skipValue();
				}
			}
			jr.endObject();
		} catch (Exception e) {
			log.debug(e, e);
			throw e;
		}
		return key;
	}

}
