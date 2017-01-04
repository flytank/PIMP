package com.altmm.controller.sys;

import java.io.File;
import java.io.IOException;
import java.io.OutputStream;
import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.lang.time.DateFormatUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.authority.AuthorityUtils;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.support.RequestContext;

import com.altmm.core.Constant;
import com.altmm.core.JavaEEFrameworkBaseController;
import com.altmm.model.sys.Authority;
import com.altmm.model.sys.SysUser;
import com.altmm.model.sys.Town;
import com.altmm.service.sys.AuthorityService;
import com.altmm.service.sys.ResourceService;
import com.altmm.service.sys.SysUserService;

import core.support.ExtJSBaseParameter;
import core.support.JqGridPageView;
import core.support.QueryResult;
import core.util.JavaEEFrameworkUtils;
import core.util.MD5;

/**
 * @file SysUserController.java
 * @category 用户的控制层
 * @author xumin
 * @date 2016年3月30日 下午6:29:06
 */
@Controller
@RequestMapping("/sys/sysuser")
public class SysUserController extends JavaEEFrameworkBaseController<SysUser>
		implements Constant {

	private static final Log log = LogFactory.getLog(SysUserController.class);
	@Resource
	private SysUserService sysUserService;
	@Resource
	private AuthorityService authorityService;
	@Resource
	private ResourceService resourceService;

	private static SimpleDateFormat dateFormat = new SimpleDateFormat(
			"yyyy-MM-dd");

	/**
	 * @Method login
	 * @category 登录
	 * @author xumin
	 * @param @param sysUserModel
	 * @param @param request
	 * @param @param response
	 * @param @throws IOException
	 * @return void
	 * @date 2016年3月30日 下午6:29:19
	 */
	@RequestMapping("/login")
	public void login(SysUser sysUserModel, HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		Map<String, Object> result = new HashMap<String, Object>();
		SysUser sysUser = sysUserService.getByProerties("loginName",
				sysUserModel.getLoginName());
		try {
			if (sysUser == null || sysUser.getStatus() != 1) { // 用户名有误或已被禁用
				result.put("result", -1);
				writeJSON(response, result);
				return;
			}
			if (!sysUser.getPassword().equals(
					MD5.crypt(sysUserModel.getPassword()))) { // 密码错误
				result.put("result", -2);
				writeJSON(response, result);
				return;
			}
			sysUser = sysUserService.querySysUserCn(sysUser);
			request.getSession().setAttribute(SESSION_SYS_USER, sysUser);
			result.put("result", 1);
			writeJSON(response, result);
		} catch (Exception e) {
			e.printStackTrace();
			result.put("result", -3);
			writeJSON(response, result);
		}
	}

	// 注册
	@RequestMapping("/register")
	public void register(SysUser sysUserModel, HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		// Map<String, Object> result = new HashMap<String, Object>();
		// SysUser emailSysUser = sysUserService.getByProerties("loginName",
		// sysUserModel.getLoginName());
		// if (emailSysUser != null) {
		// result.put("result", -1);
		// writeJSON(response, result);
		// return;
		// }
		// SysUser sysUser = new SysUser();
		// sysUser.setUserName(sysUserModel.getUserName());
		// sysUser.setSex(sysUserModel.getSex());
		// sysUser.setEmail(sysUserModel.getEmail());
		// sysUser.setPhone(sysUserModel.getPhone());
		// sysUser.setBirthday(sysUserModel.getBirthday());
		// sysUser.setPassword(MD5.crypt(sysUserModel.getPassword()));
		// sysUser.setRole("ROLE_USER");
		// sysUser.setStatus(false);
		// sysUserService.persist(sysUser);
		// request.getSession().setAttribute(SESSION_SYS_USER, sysUser);
		// result.put("result", 1);
		// writeJSON(response, result);
	}

	// 获取个人资料信息
	@RequestMapping("/sysuserprofile")
	public ModelAndView sysuserprofile(HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		SysUser sysuser = sysUserService.get(((SysUser) request.getSession()
				.getAttribute(SESSION_SYS_USER)).getId());
		// SysUser sysUserWithAvatar = sysUserService
		// .getSysUserWithAvatar(sysuser);
		return new ModelAndView("back/sysuserprofile", "sysuser", sysuser);
	}

	// 登出
	@RequestMapping("/logout")
	public void logout(HttpServletRequest request, HttpServletResponse response)
			throws IOException {
		request.getSession().removeAttribute(SESSION_SYS_USER);
		response.sendRedirect("/PIMP/login.jsp");
	}

	// 发送邮件找回密码
	@RequestMapping("/retrievePassword")
	public void retrievePassword(HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		// Map<String, Object> result = new HashMap<String, Object>();
		// String email = request.getParameter("email");
		// SysUser sysUser = sysUserService.getByProerties("email", email);
		// if (sysUser == null || sysUser.getStatus() == true) { // 用户名有误或已被禁用
		// result.put("result", -1);
		// writeJSON(response, result);
		// return;
		// }
		// SimpleEmail emailUtil = new SimpleEmail();
		// emailUtil.setCharset("utf-8");
		// emailUtil.setHostName("smtp.163.com");
		// try {
		// emailUtil.addTo(email, sysUser.getUserName());
		// emailUtil.setAuthenticator(new DefaultAuthenticator(
		// "javaeeframework@163.com", "abcd123456"));// 参数是您的真实邮箱和密码
		// emailUtil.setFrom("javaeeframework@163.com", "研发中心");
		// emailUtil.setSubject("研发中心密码找回");
		// emailUtil.setMsg("本邮件发送仅提供例子，需要您二次开发。" + sysUser.getUserName()
		// + "，您的登录密码是：" + sysUser.getPassword());
		// emailUtil.send();
		// } catch (Exception e) {
		// e.printStackTrace();
		// }
		// result.put("result", 1);
		// writeJSON(response, result);
	}

	/**
	 * @Method updatePassword
	 * @category 更改当前用户密码
	 * @author xumin
	 * @param @param request
	 * @param @param response
	 * @param @throws IOException
	 * @return void
	 * @date 2016年4月10日 下午2:37:52
	 */
	@RequestMapping(value = "/updatePassword", method = { RequestMethod.POST,
			RequestMethod.GET })
	public void updatePassword(HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			String old_password = request.getParameter("old_password");
			String password = request.getParameter("password");
			SysUser loginUser = (SysUser) request.getSession().getAttribute(
					SESSION_SYS_USER);
			if (!loginUser.getPassword().equals(MD5.crypt(old_password))) {
				result.put("success", "原密码错误");
			} else {
				loginUser.setPassword(MD5.crypt(password));
				sysUserService.update(loginUser);
				result.put("success", "密码修改成功");
			}
			writeJSON(response, result);
		} catch (Exception e) {
			e.printStackTrace();
			result.put("success", "密码修改失败");
			writeJSON(response, result);
		}
	}

	/**
	 * @Method resetPassword
	 * @category 重置密码
	 * @author xumin
	 * @param @param request
	 * @param @param response
	 * @param @throws IOException
	 * @return void
	 * @date 2016年4月10日 下午2:58:29
	 */
	@RequestMapping(value = "/resetPassword", method = { RequestMethod.POST,
			RequestMethod.GET })
	public void resetPassword(HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			String id = request.getParameter("id");
			sysUserService.updateByProperties("id", id, "password",
					MD5.crypt("123456"));
			result.put("success", "密码修改成功");
			writeJSON(response, result);
		} catch (Exception e) {
			e.printStackTrace();
			result.put("success", "密码修改失败");
			writeJSON(response, result);
		}
	}

	// 查询用户的表格，包括分页、搜索和排序
	@RequestMapping(value = "/getSysUser", method = { RequestMethod.POST,
			RequestMethod.GET })
	public void getSysUser(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		SysUser loginUser = (SysUser) request.getSession().getAttribute(
				SESSION_SYS_USER);
		Integer firstResult = Integer.valueOf(request.getParameter("page"));
		Integer maxResults = Integer.valueOf(request.getParameter("rows"));
		String sortedObject = request.getParameter("sidx");
		String sortedValue = request.getParameter("sord");
		String filters = request.getParameter("filters");
		SysUser sysUser = new SysUser();
		if (StringUtils.isNotBlank(filters)) {
			JSONObject jsonObject = JSONObject.fromObject(filters);
			JSONArray jsonArray = (JSONArray) jsonObject.get("rules");
			for (int i = 0; i < jsonArray.size(); i++) {
				JSONObject result = (JSONObject) jsonArray.get(i);
				if (result.getString("field").equals("townID")
						&& result.getString("op").equals("eq")) {// 匹配乡镇
					sysUser.set$eq_townID(result.getString("data"));
				} else if (result.getString("field").equals("villageID")
						&& result.getString("op").equals("eq")) {// 匹配自然村
					sysUser.set$eq_villageID(result.getString("data"));
				} else if (result.getString("field").equals("loginName")
						&& result.getString("op").equals("cn")) {// 蘑菇匹配登录名
					sysUser.set$like_loginName(result.getString("data"));
				} else if (result.getString("field").equals("userName")
						&& result.getString("op").equals("cn")) {// 蘑菇匹配用户名称
					sysUser.set$like_userName(result.getString("data"));
				} else if (result.getString("field").equals("IDCard")
						&& result.getString("op").equals("cn")) {// 蘑菇匹配身份证
					sysUser.set$like_idCard(result.getString("data"));
				}
			}
			if (((String) jsonObject.get("groupOp")).equalsIgnoreCase("OR")) {
				sysUser.setFlag("OR");
			} else {
				sysUser.setFlag("AND");
			}
		}
		if (Constant.ROLE_ADMIN.equals(loginUser.getRole())) {// 超级管理员

		} else {
			sysUser.set$ne_role(Constant.ROLE_ADMIN);// 不匹配超级管理员
		}
		sysUser.setFirstResult((firstResult - 1) * maxResults);
		sysUser.setMaxResults(maxResults);
		Map<String, String> sortedCondition = new HashMap<String, String>();
		sortedCondition.put(sortedObject, sortedValue);
		sortedCondition.put("createTime", "desc");// 创建时间
		sysUser.setSortedConditions(sortedCondition);
		QueryResult<SysUser> queryResult = sysUserService
				.doPaginationQuery(sysUser);
		JqGridPageView<SysUser> sysUserListView = new JqGridPageView<SysUser>();
		sysUserListView.setMaxResults(maxResults);
		List<SysUser> sysUserCnList = sysUserService
				.querySysUserCnList(queryResult.getResultList());
		sysUserListView.setRows(sysUserCnList);
		sysUserListView.setRecords(queryResult.getTotalCount());
		writeJSON(response, sysUserListView);
	}

	/**
	 * @Method getParty
	 * @category 获得党员或者入党积极分子列表
	 * @author xumin
	 * @param @param request
	 * @param @param response
	 * @param @throws Exception
	 * @return void
	 * @date 2016年3月30日 下午2:49:24
	 */
	@RequestMapping(value = "/getParty", method = { RequestMethod.POST,
			RequestMethod.GET })
	public void getParty(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		SysUser loginUser = (SysUser) request.getSession().getAttribute(
				SESSION_SYS_USER);
		Integer firstResult = Integer.valueOf(request.getParameter("page"));
		Integer maxResults = Integer.valueOf(request.getParameter("rows"));
		String sortedObject = request.getParameter("sidx");
		String sortedValue = request.getParameter("sord");
		String filters = request.getParameter("filters");
		SysUser sysUser = new SysUser();
		if (StringUtils.isNotBlank(filters)) {
			JSONObject jsonObject = JSONObject.fromObject(filters);
			JSONArray jsonArray = (JSONArray) jsonObject.get("rules");
			for (int i = 0; i < jsonArray.size(); i++) {
				JSONObject result = (JSONObject) jsonArray.get(i);
				if (result.getString("field").equals("townID")
						&& result.getString("op").equals("eq")) {// 匹配乡镇
					sysUser.set$eq_townID(result.getString("data"));
				} else if (result.getString("field").equals("villageID")
						&& result.getString("op").equals("eq")) {// 匹配自然村
					sysUser.set$eq_villageID(result.getString("data"));
				} else if (result.getString("field").equals("loginName")
						&& result.getString("op").equals("cn")) {// 蘑菇匹配登录名
					sysUser.set$like_loginName(result.getString("data"));
				} else if (result.getString("field").equals("userName")
						&& result.getString("op").equals("cn")) {// 蘑菇匹配用户名称
					sysUser.set$like_userName(result.getString("data"));
				} else if (result.getString("field").equals("IDCard")
						&& result.getString("op").equals("cn")) {// 蘑菇匹配身份证
					sysUser.set$like_idCard(result.getString("data"));
				} else if (result.getString("field").equals("identity")
						&& result.getString("op").equals("eq")) {// 身份，1为党员，2为入党积极分子，3为群众
					sysUser.set$eq_identity(null == result.getString("data") ? 1
							: Integer.parseInt(result.getString("data")));
				}
			}
			if (((String) jsonObject.get("groupOp")).equalsIgnoreCase("OR")) {
				sysUser.setFlag("OR");
			} else {
				sysUser.setFlag("AND");
			}
		}
		sysUser.setFirstResult((firstResult - 1) * maxResults);
		sysUser.setMaxResults(maxResults);
		if (null != loginUser) {// 匹配当前用户角色信息
			if (Constant.ROLE_ADMIN.equals(loginUser.getRole())) {// 超级管理员

			} else {
				sysUser.set$ne_role(Constant.ROLE_ADMIN);// 不匹配超级管理员
				if (Constant.ROLE_ZONE.equals(loginUser.getRole())) {// 区域管理员
				} else if (Constant.ROLE_TOWN.equals(loginUser.getRole())) {// 乡镇管理员
					sysUser.set$eq_townID(loginUser.getTownID());
				} else if (Constant.ROLE_VILLAGE.equals(loginUser.getRole())) {// 村管理员
					sysUser.set$eq_townID(loginUser.getTownID());
					sysUser.set$eq_villageID(loginUser.getVillageID());
				} else {
					sysUser.set$eq_townID(loginUser.getTownID());
					sysUser.set$eq_villageID(loginUser.getVillageID());
				}
			}

		}
		Map<String, String> sortedCondition = new HashMap<String, String>();
		sortedCondition.put(sortedObject, sortedValue);
		sortedCondition.put("createTime", "desc");// 创建时间
		sysUser.setSortedConditions(sortedCondition);
		QueryResult<SysUser> queryResult = sysUserService
				.doPaginationQuery(sysUser);
		JqGridPageView<SysUser> sysUserListView = new JqGridPageView<SysUser>();
		sysUserListView.setMaxResults(maxResults);
		List<SysUser> sysUserCnList = sysUserService
				.querySysUserCnList(queryResult.getResultList());
		sysUserListView.setRows(sysUserCnList);
		sysUserListView.setRecords(queryResult.getTotalCount());
		writeJSON(response, sysUserListView);
	}

	// 保存用户的实体Bean
	@RequestMapping(value = "/saveSysUser", method = { RequestMethod.POST,
			RequestMethod.GET })
	public void doSave(SysUser entity, HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		ExtJSBaseParameter parameter = ((ExtJSBaseParameter) entity);
		if (CMD_EDIT.equals(parameter.getCmd())) {
			SysUser sysUser = sysUserService.get(entity.getId());
			entity.setPassword(sysUser.getPassword());
			// entity.setLastLoginTime(sysUser.getLastLoginTime());
			sysUserService.update(entity);
		} else if (CMD_NEW.equals(parameter.getCmd())) {
			entity.setCreateTime(new Date());
			entity.setPassword(MD5.crypt("123456")); // 初始化密码为123456
			sysUserService.persist(entity);
		}
		parameter.setSuccess(true);
		writeJSON(response, parameter);
	}

	// 操作用户的删除、导出Excel、字段判断和保存
	@RequestMapping(value = "/operateSysUser", method = { RequestMethod.POST,
			RequestMethod.GET })
	public void operateSysUser(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		String oper = request.getParameter("oper");
		String id = request.getParameter("id");
		if (oper.equals("del")) {
			String[] ids = id.split(",");
			deleteSysUser(request, response, ids);
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
			String userName = request.getParameter("userName");// 姓名
			String sex = request.getParameter("sex");// 性别
			String IDCard = request.getParameter("IDCard");// 身份证
			String birthday = request.getParameter("birthday");// 出生日期
			String education = request.getParameter("education");// 学历
			String position = request.getParameter("position");// 职位
			String sortID = request.getParameter("sortID");// 党员类别编码
			String teamID = request.getParameter("teamID");// 党小组
			String villageID = request.getParameter("villageID");// 所属自然村编码
			String townID = request.getParameter("townID");// 所属乡镇编码
			String zoneID = request.getParameter("zoneID");// 所属区域编码
			String identity = request.getParameter("identity");// 身份
			String role = request.getParameter("role");// 角色
			String status = request.getParameter("status");// 状态，1为已激活，2为未激活，3为停用
			String loginName = request.getParameter("loginName");// 登录名
			SysUser sysUser = null;
			if (oper.equals("edit")) {
				sysUser = sysUserService.get(id);
			}
			SysUser IDCardUser = sysUserService
					.getByProerties("idCard", IDCard);
			SysUser loginNameUser = sysUserService.getByProerties("loginName",
					loginName);
			if (null != IDCardUser && oper.equals("add")) {
				response.setStatus(HttpServletResponse.SC_CONFLICT);
				result.put("message", "此身份证已存在，请重新输入");
				writeJSON(response, result);
			} else if (null != loginNameUser && oper.equals("add")) {
				response.setStatus(HttpServletResponse.SC_CONFLICT);
				result.put("message", "此登录名已存在，请重新输入");
				writeJSON(response, result);
			} else if (null != sysUser
					&& (!sysUser.getId().equals(IDCardUser.getId()))) {
				response.setStatus(HttpServletResponse.SC_CONFLICT);
				result.put("message", "此身份证已存在，请重新输入");
				writeJSON(response, result);
			} else if (null != sysUser
					&& (!sysUser.getLoginName().equals(
							IDCardUser.getLoginName()))) {
				response.setStatus(HttpServletResponse.SC_CONFLICT);
				result.put("message", "此登录名已存在，请重新输入");
				writeJSON(response, result);
			} else {
				SysUser entity = new SysUser();
				entity.setUserName(userName);// 用户名
				entity.setSex(sex);// 性别
				entity.setIdCard(IDCard);// 身份证
				if (StringUtils.isNotBlank(birthday)) {
					entity.setBirthday(dateFormat.parse(birthday));// 出生日期
				}
				entity.setEducation(education);// 学历
				entity.setPosition(position);// 职位
				entity.setSortID(sortID);// 党员类别编码
				entity.setTeamID(teamID);// 党小组
				entity.setVillageID(villageID);// 所属自然村编码
				entity.setTownID(townID);// 所属乡镇编码
				entity.setZoneID(zoneID);// 所属区域编码
				entity.setIdentity(Integer.parseInt(identity));// 身份
				entity.setRole(role);// 角色
				entity.setStatus(Integer.parseInt(status));// 状态，1为已激活，2为未激活，3为停用
				entity.setLoginName(loginName);// 登录名
				if (oper.equals("edit")) {
					entity.setId(id);
					entity.setCmd("edit");
					doSave(entity, request, response);
				} else if (oper.equals("add")) {
					entity.setCmd("new");
					doSave(entity, request, response);
				}
			}
		}
	}

	// 保存个人资料
	@RequestMapping(value = "/saveSysUserProfile", method = {
			RequestMethod.POST, RequestMethod.GET })
	public void saveSysUserProfile(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		// Long sysUserId = ((SysUser) request.getSession().getAttribute(
		// SESSION_SYS_USER)).getId();
		// SysUser sysUser = sysUserService.get(sysUserId);
		// SysUser entity = new SysUser();
		// entity.setId(sysUserId);
		// entity.setUserName(request.getParameter("userName"));
		// entity.setSex(Short.valueOf(request.getParameter("sex")));
		// entity.setEmail(request.getParameter("email"));
		// entity.setPhone(request.getParameter("phone"));
		// if (null != request.getParameter("birthday")) {
		// entity.setBirthday(dateFormat.parse(request
		// .getParameter("birthday")));
		// }
		// entity.setRole(sysUser.getRole());
		// entity.setStatus(sysUser.getStatus());
		// entity.setPassword(sysUser.getPassword());
		// entity.setLastLoginTime(sysUser.getLastLoginTime());
		// sysUserService.update(entity);
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("success", true);
		writeJSON(response, result);
	}

	// 删除用户
	@RequestMapping("/deleteSysUser")
	public void deleteSysUser(HttpServletRequest request,
			HttpServletResponse response, @RequestParam("ids") String[] ids)
			throws IOException {
		if (Arrays.asList(ids).contains(Long.valueOf("1"))) {
			writeJSON(response,
					"{success:false,message:'删除项包含超级管理员，超级管理员不能删除！'}");
		} else {
			boolean flag = sysUserService.deleteByPK(ids);
			if (flag) {
				writeJSON(response, "{success:true}");
			} else {
				writeJSON(response, "{success:false}");
			}
		}
	}

	// 即时更新个人资料的字段
	@RequestMapping(value = "/updateSysUserField", method = {
			RequestMethod.POST, RequestMethod.GET })
	public void updateSysUserField(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		Long id = Long.valueOf(request.getParameter("pk"));
		String name = request.getParameter("name");
		String value = request.getParameter("value");
		if (name.equals("userName")) {
			sysUserService.updateByProperties("id", id, "userName", value);
		} else if (name.equals("sex")) {
			sysUserService.updateByProperties("id", id, "sex",
					Short.valueOf(value));
		} else if (name.equals("email")) {
			sysUserService.updateByProperties("id", id, "email", value);
		} else if (name.equals("phone")) {
			sysUserService.updateByProperties("id", id, "phone", value);
		} else if (name.equals("birthday")) {
			if (null != value) {
				sysUserService.updateByProperties("id", id, "birthday",
						dateFormat.parse(value));
			}
		}
	}

	/**
	 * @Method verifySaveUser
	 * @category 验证并保存用户信息
	 * @author xumin
	 * @param @param request
	 * @param @param response
	 * @param @throws Exception
	 * @return void
	 * @date 2016年3月28日 上午10:33:37
	 */
	@RequestMapping(value = "/verifySaveUser", method = { RequestMethod.POST,
			RequestMethod.GET })
	public void verifySaveUser(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		String userID = request.getParameter("userID");// 用户编码
		String loginName = request.getParameter("loginName");// 登录名
		String userName = request.getParameter("userName");// 姓名
		String sex = request.getParameter("sex");// 性别
		String IDCard = request.getParameter("IDCard");// 身份证
		String birthday = request.getParameter("birthday");// 出生日期
		String education = request.getParameter("education");// 学历
		String position = request.getParameter("position");// 职位
		String identity = request.getParameter("identity");// 身份
		String sortID = request.getParameter("sortID");// 党员类别编码
		String teamID = request.getParameter("teamID");// 党小组
		String villageID = request.getParameter("villageID");// 所属自然村编码
		String townID = request.getParameter("townID");// 所属乡镇编码
		String zoneID = request.getParameter("zoneID");// 所属区域编码
		String role = request.getParameter("role");// 角色
		String status = request.getParameter("status");// 状态，1为已激活，2为未激活，3为停用
		List<SysUser> loginNameList = sysUserService.queryByProerties(
				"loginName", loginName);// 登录名称一致的用户列表
		List<SysUser> IDCardList = sysUserService.queryByProerties("idCard",
				IDCard);// 身份证一致的用户列表
		SysUser user = new SysUser();
		user.setLoginName(loginName);
		user.setUserName(userName);
		user.setSex(sex);
		user.setIdCard(IDCard);
		if (StringUtils.isNotBlank(birthday)) {
			user.setBirthday(dateFormat.parse(birthday));// 出生日期
		}
		user.setEducation(education);
		user.setPosition(position);
		if (StringUtils.isNotBlank(identity)) {
			user.setIdentity(Integer.parseInt(identity));
		}
		user.setSortID(sortID);
		user.setTeamID(teamID);
		user.setVillageID(villageID);
		user.setTownID(townID);
		user.setZoneID(zoneID);
		user.setRole(role);
		if (StringUtils.isNotBlank(status)) {
			user.setStatus(Integer.parseInt(status));
		}
		boolean information = true;
		if ("" == userID) {// 用户ID不存在，新增验证
			if (null != loginNameList && loginNameList.size() > 0) {
				information = false;
			} else if (null != IDCardList && IDCardList.size() > 0) {
				information = false;
			} else {
				user.setPoints(Double.parseDouble("0"));
				user.setPassword(MD5.crypt("123456"));
				user.setCreateTime(new Date());
				sysUserService.persist(user);
			}
		} else {// 用户ID存在，更新验证
			if (null != loginNameList) {
				for (int i = 0; i < loginNameList.size(); i++) {
					SysUser team = loginNameList.get(i);
					if (!userID.equals(team.getId())) {
						information = false;
					}
				}
			} else if (null != IDCardList) {
				for (int i = 0; i < IDCardList.size(); i++) {
					SysUser team = IDCardList.get(i);
					if (!userID.equals(team.getId())) {
						information = false;
					}
				}
			}
			if (information) {
				SysUser oldUser = sysUserService.get(userID);
				oldUser.setLoginName(loginName);
				oldUser.setUserName(userName);
				oldUser.setSex(sex);
				oldUser.setIdCard(IDCard);
				if (StringUtils.isNotBlank(birthday)) {
					oldUser.setBirthday(dateFormat.parse(birthday));// 出生日期
				}
				oldUser.setEducation(education);
				oldUser.setPosition(position);
				if (StringUtils.isNotBlank(identity)) {
					oldUser.setIdentity(Integer.parseInt(identity));
				}
				oldUser.setSortID(sortID);
				oldUser.setTeamID(teamID);
				oldUser.setVillageID(villageID);
				oldUser.setTownID(townID);
				oldUser.setZoneID(zoneID);
				oldUser.setRole(role);
				if (StringUtils.isNotBlank(status)) {
					oldUser.setStatus(Integer.parseInt(status));
				}
				sysUserService.update(oldUser);
			}
		}
		writeJSON(response, information);
	}

	private static SimpleDateFormat sdf = new SimpleDateFormat(
			"yyyyMMddHHmmssSSS");

	// 上传个人资料的头像
	@RequestMapping(value = "/uploadAttachement", method = RequestMethod.POST)
	public void uploadAttachement(
			@RequestParam(value = "avatar", required = false) MultipartFile file,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		RequestContext requestContext = new RequestContext(request);
		JSONObject json = new JSONObject();
		if (!file.isEmpty()) {
			if (file.getSize() > 2097152) {
				json.put("message", requestContext.getMessage("g_fileTooLarge"));
			} else {
				try {
					String originalFilename = file.getOriginalFilename();
					String fileName = sdf.format(new Date())
							+ JavaEEFrameworkUtils.getRandomString(3)
							+ originalFilename.substring(originalFilename
									.lastIndexOf("."));
					File filePath = new File(getClass()
							.getClassLoader()
							.getResource("/")
							.getPath()
							.replace(
									"/WEB-INF/classes/",
									"/static/upload/img/"
											+ DateFormatUtils.format(
													new Date(), "yyyyMM")));
					if (!filePath.exists()) {
						filePath.mkdirs();
					}
					file.transferTo(new File(filePath.getAbsolutePath() + "\\"
							+ fileName));
					String destinationFilePath = "/static/upload/img/"
							+ DateFormatUtils.format(new Date(), "yyyyMM")
							+ "/" + fileName;
					String sysUserId = ((SysUser) request.getSession()
							.getAttribute(SESSION_SYS_USER)).getId();
					// attachmentService.deleteByProperties(new String[] {
					// "type",
					// "typeId" }, new Object[] { (short) 1, sysUserId });
					// Attachment attachment = new Attachment();
					// attachment.setFileName(originalFilename);
					// attachment.setFilePath(destinationFilePath);
					// attachment.setType((short) 1);
					// attachment.setTypeId(sysUserId);
					// attachmentService.persist(attachment);
					json.put("status", "OK");
					json.put("url", request.getContextPath()
							+ destinationFilePath);
					json.put("message",
							requestContext.getMessage("g_uploadSuccess"));
				} catch (Exception e) {
					e.printStackTrace();
					json.put("message",
							requestContext.getMessage("g_uploadFailure"));
				}
			}
		} else {
			json.put("message", requestContext.getMessage("g_uploadNotExists"));
		}
		writeJSON(response, json.toString());
	}

	// 跳转到主页，获取菜单并授权
	@RequestMapping("/home")
	public ModelAndView home(HttpServletRequest request,
			HttpServletResponse response) {
		if (request.getSession().getAttribute(SESSION_SYS_USER) == null) {
			return new ModelAndView();
		} else {
			SysUser sysUser = (SysUser) request.getSession().getAttribute(
					SESSION_SYS_USER);
			String globalRoleKey = sysUser.getRole();
			try {
				Authentication authentication = new UsernamePasswordAuthenticationToken(
						sysUser.getId(), sysUser.getPassword(),
						AuthorityUtils.createAuthorityList(globalRoleKey));
				SecurityContextHolder.getContext().setAuthentication(
						authentication);
				HttpSession httpSession = request.getSession(true);
				httpSession.setAttribute("SPRING_SECURITY_AUTHORITIES",
						SecurityContextHolder.getContext().getAuthentication()
								.getAuthorities());
				Map<String, String> sortedCondition = new HashMap<String, String>();
				sortedCondition.put("sequence", "ASC");
				List<Authority> mainMenuList = authorityService
						.queryByProerties("parentMenuCode", "0",
								sortedCondition);
				List<Authority> allMenuList = authorityService
						.queryAllMenuList(globalRoleKey, mainMenuList);
				return new ModelAndView("back/index", "authorityList",
						allMenuList);
			} catch (Exception e) {
				e.printStackTrace();
				log.error(e.toString());
				return new ModelAndView();
			}
		}
	}

	/**
	 * @Method getUserById
	 * @category 通过用户主键获取用户信息
	 * @author xumin
	 * @param @param request
	 * @param @param response
	 * @param @throws Exception
	 * @return void
	 * @date 2016年3月26日 下午2:29:34
	 */
	@RequestMapping(value = "/getUserById", method = { RequestMethod.POST,
			RequestMethod.GET })
	public void getUserById(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		String id = request.getParameter("id");
		SysUser user = sysUserService.get(id);
		writeJSON(response, user);
	}

	/**
	 * @Method getUserListByUserName
	 * @category 通过用户名称获取用户列表
	 * @author xumin
	 * @param @param request
	 * @param @param response
	 * @param @throws Exception
	 * @return void
	 * @date 2016年4月10日 下午4:10:16
	 */
	@RequestMapping(value = "/getUserListByUserName", method = {
			RequestMethod.POST, RequestMethod.GET })
	public void getUserListByUserName(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		String userName = request.getParameter("userName");
		SysUser sysUser = new SysUser();
		sysUser.set$like_userName(userName);
		sysUser.set$ne_identity(3);// 1为党员，2为入党积极分子，3为群众
		QueryResult<SysUser> queryResult = sysUserService
				.doPaginationQuery(sysUser);
		List<SysUser> sysUserCnList = sysUserService
				.querySysUserCnList(queryResult.getResultList());
		writeJSON(response, sysUserCnList);
	}

	/**
	 * @Method authorityFilter
	 * @category 防止非法进入
	 * @author xumin
	 * @param @param menuCode
	 * @param @param request
	 * @param @param response
	 * @param @throws IOException
	 * @return void
	 * @date 2016年3月26日 下午2:10:41
	 */
	public boolean authorityFilter(String menuCode, HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		Boolean mark = false;
		if (request.getSession().getAttribute(SESSION_SYS_USER) == null) {
			mark = false;
		} else {
			SysUser sysUser = (SysUser) request.getSession().getAttribute(
					SESSION_SYS_USER);
			try {
				List<Authority> authorityList = resourceService
						.getAuthorityListByRole(sysUser.getRole());
				for (int i = 0; i < authorityList.size(); i++) {
					if (authorityList.get(i).getMenuCode().equals(menuCode)) {
						mark = true;
						break;
					}
				}
			} catch (Exception e) {
				e.printStackTrace();
				mark = false;
			}
		}
		if (!mark) {
			logout(request, response);// 退出登录
		}
		return mark;
	}

	/** 以下方法是根据路径跳转到页面 **/

	@RequestMapping("/sysuser")
	public String sysuser(HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		authorityFilter("sysuser", request, response);
		return "back/sysuser";
	}

	@RequestMapping("/homepage")
	public String homepage(HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		List<Town> townList = resourceService.getTownListByZoneID("0001");
		for (int i = 0; i < townList.size(); i++) {
			Town town = townList.get(i);
			String points = resourceService.getPointsByTown(town.getId());
			request.setAttribute(town.getName(), points);
		}
		return "back/homepage";
	}

	@RequestMapping("/role")
	public String role(HttpServletRequest request, HttpServletResponse response)
			throws IOException {
		authorityFilter("role", request, response);
		return "back/role";
	}

	@RequestMapping("/authority")
	public String authority(HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		authorityFilter("authority", request, response);
		return "back/authority";
	}

	@RequestMapping("/error404")
	public String error404(HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		return "back/error404";
	}

	@RequestMapping("/error500")
	public String error500(HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		return "back/error500";
	}

	/**
	 * @category 党小组页面
	 */
	@RequestMapping("/team")
	public String team(HttpServletRequest request, HttpServletResponse response)
			throws IOException {
		authorityFilter("team", request, response);
		return "back/team";
	}

	/**
	 * @category 活动详情页面
	 */
	@RequestMapping("/activity")
	public String activity(HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		authorityFilter("activity", request, response);
		return "back/activity";
	}

	/**
	 * @category 党员管理页面
	 */
	@RequestMapping("/party")
	public String party(HttpServletRequest request, HttpServletResponse response)
			throws IOException {
		authorityFilter("party", request, response);
		return "back/party";
	}

	/**
	 * @category 入党积极分子管理页面
	 */
	@RequestMapping("/activist")
	public String activist(HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		authorityFilter("activist", request, response);
		return "back/activist";
	}

	/**
	 * @Method duty
	 * @category 职责管理页面
	 * @author taotouhong
	 * @param @param request
	 * @param @param response
	 * @param @return
	 * @param @throws IOException
	 * @return String
	 * @date 2016年3月30日 下午10:26:18
	 */
	@RequestMapping("/duty")
	public String duty(HttpServletRequest request, HttpServletResponse response)
			throws IOException {
		authorityFilter("duty", request, response);
		return "back/duty";
	}

	/**
	 * @category 积分管理页面
	 */
	@RequestMapping("/userpoints")
	public String point(HttpServletRequest request, HttpServletResponse response)
			throws IOException {
		authorityFilter("userpoints", request, response);
		return "back/userpoints";
	}

	/**
	 * @category 活动详情查看页面
	 */
	@RequestMapping("/look_activity")
	public String look_activity(HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		authorityFilter("look_activity", request, response);
		return "back/look_activity";
	}

	/**
	 * @category 公示信息查看
	 */
	@RequestMapping("/look_notice")
	public String look_notice(HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		authorityFilter("look_notice", request, response);
		return "back/look_notice";
	}

	/**
	 * @category 公示信息详情管理
	 */
	@RequestMapping("/notice")
	public String notice(HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		authorityFilter("notice", request, response);
		return "back/notice";
	}

	/**
	 * @category 积分信息查看
	 */
	@RequestMapping("/look_userpoints")
	public String look_userpoints(HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		authorityFilter("look_userpoints", request, response);
		return "back/look_userpoints";
	}
}
