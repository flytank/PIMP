package com.altmm.controller.sys;

import java.io.IOException;
import java.io.OutputStream;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.altmm.core.Constant;
import com.altmm.core.JavaEEFrameworkBaseController;
import com.altmm.model.sys.Message;
import com.altmm.service.sys.MessageService;

import core.support.ExtJSBaseParameter;
import core.support.JqGridPageView;
import core.support.QueryResult;

/**
 * @file MessageController.java
 * @category 留言表的控制层
 * @author xumin
 * @date 2016年4月5日 下午4:11:19
 */
@Controller
@RequestMapping("/sys/message")
public class MessageController extends JavaEEFrameworkBaseController<Message>
		implements Constant {

	@Resource
	private MessageService messageService;

	// 查询留言表的表格，包括分页、搜索和排序
	@RequestMapping(value = "/getMessage", method = { RequestMethod.POST,
			RequestMethod.GET })
	public void getMessage(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		Integer firstResult = Integer.valueOf(request.getParameter("page"));
		Integer maxResults = Integer.valueOf(request.getParameter("rows"));
		String sortedObject = request.getParameter("sidx");
		String sortedValue = request.getParameter("sord");
		String filters = request.getParameter("filters");
		Message obj = new Message();
		if (StringUtils.isNotBlank(filters)) {
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			JSONObject jsonObject = JSONObject.fromObject(filters);
			JSONArray jsonArray = (JSONArray) jsonObject.get("rules");
			// for (int i = 0; i < jsonArray.size(); i++) {
			// JSONObject result = (JSONObject) jsonArray.get(i);
			// if (result.getString("field").equals("subject")
			// && result.getString("op").equals("cn")) {// 蘑菇留言表主题
			// obj.set$like_subject(result.getString("data"));
			// } else if (result.getString("field").equals("townID")
			// && result.getString("op").equals("eq")) {// 匹配乡镇
			// obj.set$eq_townID(result.getString("data"));
			// } else if (result.getString("field").equals("villageID")
			// && result.getString("op").equals("eq")) {// 匹配自然村
			// obj.set$eq_villageID(result.getString("data"));
			// } else if (result.getString("field").equals("startDate")
			// && result.getString("op").equals("ge")) {// 匹配自然村
			// obj.set$ge_startDate(sdf.parse(result.getString("data")
			// + " 00:00:00"));
			// } else if (result.getString("field").equals("startDate")
			// && result.getString("op").equals("le")) {// 匹配自然村
			// obj.set$ge_startDate(sdf.parse(result.getString("data")
			// + " 23:59:59"));
			// }
			// }
			// if (((String) jsonObject.get("groupOp")).equalsIgnoreCase("OR"))
			// {
			// obj.setFlag("OR");
			// } else {
			// obj.setFlag("AND");
			// }
		}
		obj.setFirstResult((firstResult - 1) * maxResults);
		obj.setMaxResults(maxResults);
		Map<String, String> sortedCondition = new HashMap<String, String>();
		sortedCondition.put(sortedObject, sortedValue);
		obj.setSortedConditions(sortedCondition);
		QueryResult<Message> queryResult = messageService
				.doPaginationQuery(obj);
		JqGridPageView<Message> roleListView = new JqGridPageView<Message>();
		roleListView.setMaxResults(maxResults);
		List<Message> messageCnList = messageService
				.queryMessageCnList(queryResult.getResultList());
		roleListView.setRows(messageCnList);
		roleListView.setRecords(queryResult.getTotalCount());
		writeJSON(response, roleListView);
	}

	// 保存留言表的实体Bean
	@RequestMapping(value = "/saveMessage", method = { RequestMethod.POST,
			RequestMethod.GET })
	public void doSave(Message entity, HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		ExtJSBaseParameter parameter = ((ExtJSBaseParameter) entity);
		if (CMD_EDIT.equals(parameter.getCmd())) {
			messageService.update(entity);
		} else if (CMD_NEW.equals(parameter.getCmd())) {
			messageService.persist(entity);
		}
		parameter.setSuccess(true);
		writeJSON(response, parameter);
	}

	// 操作留言表的删除、导出Excel、字段判断和保存
	@RequestMapping(value = "/operateMessage", method = { RequestMethod.POST,
			RequestMethod.GET })
	public void operateMessage(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		String oper = request.getParameter("oper");
		String id = request.getParameter("id");
		if (oper.equals("del")) {
			String[] ids = id.split(",");
			deleteMessage(request, response, ids);
		} else if (oper.equals("excel")) {
			response.setContentType("application/msexcel;charset=UTF-8");
			try {
				response.addHeader("Content-Disposition",
						"attachment;filename=file.xls");
				OutputStream out = response.getOutputStream();
				out.write(request.getParameter("csvBuffer").getBytes());
				out.flush();
				out.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else {
			// Map<String, Object> result = new HashMap<String, Object>();
			// String roleKey = request.getParameter("roleKey");
			// String roleValue = request.getParameter("roleValue");
			// String description = request.getParameter("description");
			// Message role = null;
			// if (oper.equals("edit")) {
			// role = messageService.get(Long.valueOf(id));
			// }
			// Message roleKeyMessage =
			// messageService.getByProerties("roleKey",
			// roleKey);
			// if (StringUtils.isBlank(roleKey) ||
			// StringUtils.isBlank(roleValue)) {
			// response.setStatus(HttpServletResponse.SC_LENGTH_REQUIRED);
			// result.put("message", "请填写留言表编码和留言表名称");
			// writeJSON(response, result);
			// } else if (null != roleKeyMessage && oper.equals("add")) {
			// response.setStatus(HttpServletResponse.SC_CONFLICT);
			// result.put("message", "此留言表编码已存在，请重新输入");
			// writeJSON(response, result);
			// } else if (null != roleKeyMessage
			// && !role.getMessageKey().equalsIgnoreCase(roleKey)
			// && oper.equals("edit")) {
			// response.setStatus(HttpServletResponse.SC_CONFLICT);
			// result.put("message", "此留言表编码已存在，请重新输入");
			// writeJSON(response, result);
			// } else {
			// Message entity = new Message();
			// entity.setMessageKey(roleValue);
			// entity.setMessageValue(roleValue);
			// entity.setDescription(description);
			// if (oper.equals("edit")) {
			// entity.setId(Long.valueOf(id));
			// entity.setCmd("edit");
			// doSave(entity, request, response);
			// } else if (oper.equals("add")) {
			// entity.setCmd("new");
			// doSave(entity, request, response);
			// }
			// }
		}
	}

	// 删除留言表
	@RequestMapping("/deleteMessage")
	public void deleteMessage(HttpServletRequest request,
			HttpServletResponse response, @RequestParam("ids") String[] ids)
			throws IOException {
		boolean flag = messageService.deleteByPK(ids);
		if (flag) {
			writeJSON(response, "{success:true}");
		} else {
			writeJSON(response, "{success:false}");
		}
	}

	/**
	 * @Method getMessageById
	 * @category 通过留言表ID获取留言表信息
	 * @author xumin
	 * @param @param request
	 * @param @param response
	 * @param @throws Exception
	 * @return void
	 * @date 2016年3月23日 下午3:40:41
	 */
	@RequestMapping(value = "/getMessageById", method = { RequestMethod.POST,
			RequestMethod.GET })
	public void getMessageById(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		String id = request.getParameter("id");
		Message message = messageService.get(id);
		writeJSON(response, message);
	}

	/**
	 * @Method verifySaveMessage
	 * @category 验证并保存留言表对象
	 * @author xumin
	 * @param @param request
	 * @param @param response
	 * @param @throws Exception
	 * @return void
	 * @date 2016年3月24日 下午2:34:02
	 */
	@RequestMapping(value = "/verifySaveMessage", method = {
			RequestMethod.POST, RequestMethod.GET })
	public void verifySaveMessage(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		String messageID = request.getParameter("messageID");// 留言表编码
		String messageName = request.getParameter("messageName");// 留言表名称
		String villageID = request.getParameter("villageID");// 自然村编码
		String townID = request.getParameter("townID");// 乡镇编码
		String zoneID = request.getParameter("zoneID");// 区域编码
		String mark = request.getParameter("mark");// 备注
		String[] propName = new String[] { "messageName", "villageID", "townID" };
		Object[] propValue = new Object[] { messageName, villageID, townID };
		List<Message> messageList = messageService.queryByProerties(propName,
				propValue);
		Message entity = new Message();
		// entity.setMessageName(messageName);
		// entity.setVillageID(villageID);
		// entity.setTownID(townID);
		// entity.setZoneID(zoneID);
		// entity.setMark(mark);
		boolean information = true;
		if ("" == messageID) {// 留言表ID不存在，新增验证
			if (null != messageList && messageList.size() > 0) {
				information = false;
			} else {
				messageService.persist(entity);
			}
		} else {// 留言表ID存在，更新验证
			if (null != messageList) {
				for (int i = 0; i < messageList.size(); i++) {
					Message message = messageList.get(i);
					if (!messageID.equals(message.getId())) {
						information = false;
					}
				}
			}
			if (information) {
				entity.setId(messageID);
				messageService.update(entity);
			}
		}
		writeJSON(response, information);
	}
}
