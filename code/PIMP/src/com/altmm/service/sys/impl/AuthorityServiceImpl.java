package com.altmm.service.sys.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.altmm.dao.sys.AuthorityDao;
import com.altmm.dao.sys.RoleAuthorityDao;
import com.altmm.model.sys.Authority;
import com.altmm.model.sys.RoleAuthority;
import com.altmm.service.sys.AuthorityService;

import core.service.BaseService;

/**
 * 菜单的业务逻辑层的实现
 * 
 */
@Service
public class AuthorityServiceImpl extends BaseService<Authority> implements
		AuthorityService {

	private AuthorityDao authorityDao;
	@Resource
	private RoleAuthorityDao roleAuthorityDao;

	@Resource
	public void setAuthorityDao(AuthorityDao authorityDao) {
		this.authorityDao = authorityDao;
		this.dao = authorityDao;
	}

	// 获取一级菜单和二次菜单

	public List<Authority> queryAllMenuList(String globalRoleKey,
			List<Authority> mainMenuList) {
		List<RoleAuthority> roleAuthorityList = roleAuthorityDao
				.queryByProerties("roleKey", globalRoleKey);
		List<String> menuCodeList = new ArrayList<String>();
		for (int j = 0; j < roleAuthorityList.size(); j++) {
			menuCodeList.add(roleAuthorityList.get(j).getMenuCode());
		}
		List<Authority> authorityList = new ArrayList<Authority>();
		Map<String, String> sortedCondition = new HashMap<String, String>();
		sortedCondition.put("sequence", "ASC");
		for (Authority entity : mainMenuList) {
			Authority authority = new Authority();
			authority.setId(entity.getId());
			authority.setMenuCode(entity.getMenuCode());
			authority.setMenuName(entity.getMenuName());
			authority.setMenuClass(entity.getMenuClass());
			authority.setDataUrl(entity.getDataUrl());
			authority.setSequence(entity.getSequence());
			authority.setParentMenuCode(entity.getParentMenuCode());
			List<Authority> subAuthorityList = authorityDao.queryByProerties(
					"parentMenuCode", entity.getMenuCode(), sortedCondition);
			List<Authority> resultSubAuthorityList = new ArrayList<Authority>();
			for (int i = 0; i < subAuthorityList.size(); i++) {
				if (menuCodeList
						.contains(subAuthorityList.get(i).getMenuCode())) {
					resultSubAuthorityList.add(subAuthorityList.get(i));
				}
			}
			authority.setSubAuthorityList(resultSubAuthorityList);
			if (resultSubAuthorityList.size() == 0) {
				authorityList.add(null);
			} else {
				authorityList.add(authority);
			}
		}
		return authorityList;
	}

}
