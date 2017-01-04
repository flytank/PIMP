package com.altmm.service.sys;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.altmm.model.sys.SysUser;

import core.service.Service;

/**
 * 用户的业务逻辑层的接口
 * 
 */
public interface SysUserService extends Service<SysUser> {

	// 获取用户信息（将数据库查询出来的信息再处理，增加字段的中文意思）
	List<SysUser> querySysUserCnList(List<SysUser> resultList);

	// 获取用户信息（将数据库查询出来的信息再处理，增加字段的中文意思）
	SysUser querySysUserCn(SysUser resultList);

	// 获取个人资料信息（将数据库查询出来的信息再处理，增加头像）
	// SysUser getSysUserWithAvatar(SysUser sysuser);
	//
	// String updateSysUser(UpdateUserPwdRequestBean brb);
	/**
	 * @Method JudgeRole
	 * @category 根据角色、乡镇村判断当前用户是否有此操作权限
	 * @author xumin
	 * @param @param townID
	 * @param @param villageID
	 * @param @param request
	 * @param @param response
	 * @param @return
	 * @return boolean
	 * @date 2016年4月16日 下午7:59:22
	 */
	public boolean JudgeRole(String townID, String villageID,
			HttpServletRequest request, HttpServletResponse response);
}
