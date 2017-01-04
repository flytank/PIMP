package com.altmm.controller.sys;

import java.io.IOException;
import java.io.OutputStream;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.commons.beanutils.ConvertUtils;
import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.altmm.core.Constant;
import com.altmm.core.JavaEEFrameworkBaseController;
import com.altmm.model.sys.Information;
import com.altmm.service.sys.InformationService;

import core.support.ExtJSBaseParameter;
import core.support.JqGridPageView;
import core.support.QueryResult;

/**
 * 信息发布的控制层
 * 
 */
@Controller
@RequestMapping("/sys/information")
public class InformationController extends JavaEEFrameworkBaseController<Information>implements Constant {

	@Resource
	private InformationService informationService;

	// 查询信息发布的表格，包括分页、搜索和排序
	@RequestMapping(value = "/getInformation", method = { RequestMethod.POST, RequestMethod.GET })
	public void getInformation(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Integer firstResult = Integer.valueOf(request.getParameter("page"));
		Integer maxResults = Integer.valueOf(request.getParameter("rows"));
		String sortedObject = request.getParameter("sidx");
		String sortedValue = request.getParameter("sord");
		String filters = request.getParameter("filters");
		Information information = new Information();
		if (StringUtils.isNotBlank(filters)) {
			JSONObject jsonObject = JSONObject.fromObject(filters);
			JSONArray jsonArray = (JSONArray) jsonObject.get("rules");
			for (int i = 0; i < jsonArray.size(); i++) {
				JSONObject result = (JSONObject) jsonArray.get(i);
				if (result.getString("field").equals("title") && result.getString("op").equals("cn")) {
					information.set$like_title(result.getString("data"));
				}
			}
			if (((String) jsonObject.get("groupOp")).equalsIgnoreCase("OR")) {
				information.setFlag("OR");
			} else {
				information.setFlag("AND");
			}
		}
		information.setFirstResult((firstResult - 1) * maxResults);
		information.setMaxResults(maxResults);
		Map<String, String> sortedCondition = new HashMap<String, String>();
		sortedCondition.put(sortedObject, sortedValue);
		information.setSortedConditions(sortedCondition);
		QueryResult<Information> queryResult = informationService.doPaginationQuery(information);
		JqGridPageView<Information> informationListView = new JqGridPageView<Information>();
		informationListView.setMaxResults(maxResults);
		List<Information> informationHTMLList = informationService
				.queryInformationHTMLList(queryResult.getResultList());
		informationListView.setRows(informationHTMLList);
		informationListView.setRecords(queryResult.getTotalCount());
		writeJSON(response, informationListView);
	}

	// 全文检索信息
	@RequestMapping(value = "/getInformationHibernateSearch", method = { RequestMethod.POST, RequestMethod.GET })
	public void getInformationHibernateSearch(HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		String luceneName = request.getParameter("luceneName");
		// Integer firstResult = Integer.valueOf(request.getParameter("page"));
		// Integer maxResults = Integer.valueOf(request.getParameter("rows"));
		Integer firstResult = 1;
		Integer maxResults = 10;
		Information information = new Information();
		information.setFirstResult((firstResult - 1) * maxResults);
		information.setMaxResults(maxResults);
		JqGridPageView<Information> informationListView = new JqGridPageView<Information>();
		informationListView.setMaxResults(maxResults);
		List<Information> informationLuceneList = informationService.queryByInformationName(luceneName);
		informationListView.setRows(informationLuceneList);
		informationListView.setRecords(informationLuceneList.size());
		writeJSON(response, informationListView);
	}

	// 保存信息发布的实体Bean

	@RequestMapping(value = "/saveInformation", method = { RequestMethod.POST, RequestMethod.GET })
	public void doSave(Information entity, HttpServletRequest request, HttpServletResponse response)
			throws IOException {
		ExtJSBaseParameter parameter = ((ExtJSBaseParameter) entity);
		if (CMD_EDIT.equals(parameter.getCmd())) {
			informationService.update(entity);
		} else if (CMD_NEW.equals(parameter.getCmd())) {
			informationService.persist(entity);
		}
		parameter.setSuccess(true);
		writeJSON(response, parameter);
	}

	// 操作信息发布的删除、导出Excel、字段判断和保存
	@RequestMapping(value = "/operateInformation", method = { RequestMethod.POST, RequestMethod.GET })
	public void operateInformation(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String oper = request.getParameter("oper");
		String id = request.getParameter("id");
		if (oper.equals("del")) {
			String[] ids = id.split(",");
			deleteInformation(request, response, (Long[]) ConvertUtils.convert(ids, Long.class));
		} else if (oper.equals("excel")) {
			response.setContentType("application/msexcel;charset=UTF-8");
			try {
				response.addHeader("Content-Disposition", "attachment;filename=file.xls");
				OutputStream out = response.getOutputStream();
				out.write(request.getParameter("csvBuffer").getBytes());
				out.flush();
				out.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else {
			Map<String, Object> result = new HashMap<String, Object>();
			String title = request.getParameter("title");
			String author = request.getParameter("author");
			String content = request.getParameter("content");
			if (StringUtils.isBlank(title)) {
				response.setStatus(HttpServletResponse.SC_LENGTH_REQUIRED);
				result.put("message", "请填写标题");
				writeJSON(response, result);
			} else {
				Information entity = new Information();
				entity.setTitle(title);
				entity.setAuthor(author);
				entity.setContent(content);
				entity.setRefreshTime(new Date());
				if (StringUtils.isNotBlank(id)) {
					entity.setId(Long.valueOf(id));
					entity.setCmd("edit");
					doSave(entity, request, response);
				} else {
					entity.setCmd("new");
					doSave(entity, request, response);
				}
			}
		}
	}

	// 删除信息发布
	@RequestMapping("/deleteInformation")
	public void deleteInformation(HttpServletRequest request, HttpServletResponse response,
			@RequestParam("ids") Long[] ids) throws IOException {
		boolean flag = informationService.deleteByPK(ids);
		if (flag) {
			writeJSON(response, "{success:true}");
		} else {
			writeJSON(response, "{success:false}");
		}
	}

}
