package com.altmm.controller.sys;

import java.io.IOException;
import java.io.OutputStream;
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
import com.altmm.model.sys.Bqxx;
import com.altmm.service.sys.BqxxService;

import core.support.ExtJSBaseParameter;
import core.support.JqGridPageView;
import core.support.QueryResult;

/**
 * 病区信息的控制层
 * 
 */
@Controller
@RequestMapping("/sys/bqxx")
public class BqxxController extends JavaEEFrameworkBaseController<Bqxx>
		implements Constant {

	@Resource
	private BqxxService bqxxService;

	// 查询字典的表格，包括分页、搜索和排序
	@RequestMapping(value = "/getBqxx", method = { RequestMethod.POST,
			RequestMethod.GET })
	public void getBqxx(HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		Integer firstResult = Integer.valueOf(request.getParameter("page"));
		Integer maxResults = Integer.valueOf(request.getParameter("rows"));
		String sortedObject = request.getParameter("sidx");
		String sortedValue = request.getParameter("sord");
		String filters = request.getParameter("filters");
		Bqxx bqxx = new Bqxx();
		if (StringUtils.isNotBlank(filters)) {
			JSONObject jsonObject = JSONObject.fromObject(filters);
			JSONArray jsonArray = (JSONArray) jsonObject.get("rules");
			for (int i = 0; i < jsonArray.size(); i++) {
				JSONObject result = (JSONObject) jsonArray.get(i);
				if (result.getString("field").equals("bqmc")
						&& result.getString("op").equals("eq")) {
					bqxx.set$eq_bqmc(result.getString("data"));
				}
				if (result.getString("field").equals("bqlx")
						&& result.getString("op").equals("cn")) {
					bqxx.set$like_bqlx(result.getString("data"));
				}
			}
			if (((String) jsonObject.get("groupOp")).equalsIgnoreCase("OR")) {
				bqxx.setFlag("OR");
			} else {
				bqxx.setFlag("AND");
			}
		}
		bqxx.setFirstResult((firstResult - 1) * maxResults);
		bqxx.setMaxResults(maxResults);
		Map<String, String> sortedCondition = new HashMap<String, String>();
		sortedCondition.put(sortedObject, sortedValue);
		bqxx.setSortedConditions(sortedCondition);
		QueryResult<Bqxx> queryResult = bqxxService.doPaginationQuery(bqxx);
		JqGridPageView<Bqxx> bqxxListView = new JqGridPageView<Bqxx>();
		bqxxListView.setMaxResults(maxResults);
		List<Bqxx> bqxxWithSubList = bqxxService
				.queryBqxxWithSubList(queryResult.getResultList());
		bqxxListView.setRows(bqxxWithSubList);
		bqxxListView.setRecords(queryResult.getTotalCount());
		writeJSON(response, bqxxListView);
	}

	// 保存字典的实体Bean
	@RequestMapping(value = "/saveBqxx", method = { RequestMethod.POST,
			RequestMethod.GET })
	public void doSave(Bqxx entity, HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		ExtJSBaseParameter parameter = ((ExtJSBaseParameter) entity);
		if (CMD_EDIT.equals(parameter.getCmd())) {
			bqxxService.update(entity);
		} else if (CMD_NEW.equals(parameter.getCmd())) {
			bqxxService.persist(entity);
		}
		parameter.setSuccess(true);
		writeJSON(response, parameter);
	}

	// 操作字典的删除、导出Excel、字段判断和保存
	@RequestMapping(value = "/operateBqxx", method = { RequestMethod.POST,
			RequestMethod.GET })
	public void operateBqxx(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		String oper = request.getParameter("oper");
		String id = request.getParameter("id");
		if (oper.equals("del")) {
			String[] ids = id.split(",");
			deleteBqxx(request, response,
					(String[]) ConvertUtils.convert(ids, String.class));
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
			Map<String, Object> result = new HashMap<String, Object>();
			String bqmc = request.getParameter("bqmc");
			String bqlx = request.getParameter("bqlx");
			Long czdrcf = Long.parseLong(request.getParameter("czdrcf"));
			Long dytzyz = Long.parseLong(request.getParameter("dytzyz"));
			Long zdcfyz = Long.parseLong(request.getParameter("zdcfyz"));
			String zdcfsj = request.getParameter("zdcfsj");
			Bqxx bqxx = null;
			if (oper.equals("edit")) {
				bqxx = bqxxService.get(id);
			}
			Bqxx mcBqxx = bqxxService.getByProerties("bqmc", bqmc);
			if (StringUtils.isBlank(bqmc) || StringUtils.isBlank(bqlx)) {
				response.setStatus(HttpServletResponse.SC_LENGTH_REQUIRED);
				result.put("message", "请填写病区名称和类型");
				writeJSON(response, result);
			} else if (null != mcBqxx && oper.equals("add")) {
				response.setStatus(HttpServletResponse.SC_CONFLICT);
				result.put("message", "此病区名称已存在，请重新输入");
				writeJSON(response, result);
			} else {
				Bqxx entity = new Bqxx();
				entity.setBqmc(bqmc);
				entity.setBqlx(bqlx);
				entity.setCzdrcf(czdrcf);
				entity.setDytzyz(dytzyz);
				entity.setZdcfyz(zdcfyz);
				entity.setZdcfsj(zdcfsj);
				if (oper.equals("edit")) {
					entity.setBqid(id);
					entity.setCmd("edit");
					doSave(entity, request, response);
				} else if (oper.equals("add")) {
					entity.setCmd("new");
					doSave(entity, request, response);
				}
			}
		}
	}

	// 删除字典
	@RequestMapping("/deleteBqxx")
	public void deleteBqxx(HttpServletRequest request,
			HttpServletResponse response, @RequestParam("ids") String[] ids)
			throws IOException {
		boolean flag = bqxxService.deleteByPK(ids);
		if (flag) {
			writeJSON(response, "{success:true}");
		} else {
			writeJSON(response, "{success:false}");
		}
	}

}
