package com.altmm.service.sys;

import java.util.List;

import com.altmm.model.sys.Authority;

import core.service.Service;

/**
 * 菜单的业务逻辑层的接口
 * 
 */
public interface AuthorityService extends Service<Authority> {

	// 只有角色编码是ROLE_ADMIN、ROLE_RESTRICTED_ADMIN和ROLE_USER才可以访问此方法
	// 获取一级菜单和二次菜单
	// @PreAuthorize("hasRole('zone') or hasRole('town') or hasRole('village') or hasRole('ROLE_ADMIN') or hasRole('ROLE_USER')")
	List<Authority> queryAllMenuList(String globalRoleKey,
			List<Authority> mainMenuList);

}
