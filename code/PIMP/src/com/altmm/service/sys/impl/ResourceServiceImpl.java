package com.altmm.service.sys.impl;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.altmm.dao.sys.AuthorityDao;
import com.altmm.dao.sys.PartyMemberDao;
import com.altmm.dao.sys.RoleAuthorityDao;
import com.altmm.dao.sys.SysUserDao;
import com.altmm.dao.sys.TeamDao;
import com.altmm.dao.sys.TownDao;
import com.altmm.dao.sys.VillageDao;
import com.altmm.model.sys.Authority;
import com.altmm.model.sys.PartyMember;
import com.altmm.model.sys.RoleAuthority;
import com.altmm.model.sys.SysUser;
import com.altmm.model.sys.Town;
import com.altmm.model.sys.Village;
import com.altmm.service.sys.ResourceService;

import core.service.BaseService;

/**
 * @file ResourceServiceImpl.java
 * @category 资源的业务逻辑层的实现
 * @author xumin
 * @date 2016年3月21日 下午1:38:36
 */
@Service
public class ResourceServiceImpl extends BaseService<SysUser> implements
		ResourceService {

	private SysUserDao sysUserDao;// 用户接口
	@Resource
	private VillageDao villageDao;// 自然村接口
	@Resource
	private TownDao townDao;// 乡镇接口
	@Resource
	private PartyMemberDao sortDao;// 党员类别接口
	@Resource
	private TeamDao teamDao;// 党小组接口
	@Resource
	private AuthorityDao authorityDao;// 菜单接口
	@Resource
	private RoleAuthorityDao roleAuthorityDao;// 角色菜单接口

	@Resource
	public void setSysUserDao(SysUserDao sysUserDao) {
		this.sysUserDao = sysUserDao;
		this.dao = sysUserDao;
	}

	// 通过乡镇编码获取自然村列表
	@Override
	public List<Village> getVillageListByTownID(String townID) {
		List<Village> villageList = villageDao.queryByProerties("townCode",
				townID);
		return villageList;
	}

	// 通过区域编码获取乡镇列表
	@Override
	public List<Town> getTownListByZoneID(String zoneID) {
		List<Town> townList = townDao.queryByProerties("zoneCode", zoneID);
		return townList;
	}

	// 通过自然村编码获取自然村对象
	@Override
	public Village getVillageByVillageID(String villageID) {
		Village village = villageDao.get(villageID);
		return village;
	}

	// 通过乡镇编码获取乡镇对象
	@Override
	public Town getTownByTownID(String townID) {
		Town town = townDao.get(townID);
		return town;
	}

	// 获得所有党员类别数据列表
	@Override
	public List<PartyMember> getPartyMemberList() {
		List<PartyMember> list = sortDao.doQueryAll();
		return list;
	}

	// 通过角色编码获取该角色拥有的菜单列表
	@Override
	public List<Authority> getAuthorityListByRole(String role) {
		List<RoleAuthority> list = roleAuthorityDao.queryByProerties("roleKey",
				role);
		if (null != list && !list.isEmpty()) {
			String menuCodeList = "";
			for (int i = 0; i < list.size() - 1; i++) {
				menuCodeList += "'" + list.get(i).getMenuCode().toString()
						+ "',";
			}
			if (list.size() >= 1) {
				menuCodeList += "'"
						+ list.get(list.size() - 1).getMenuCode().toString()
						+ "'";
			}
			String sql = "select id,menu_code menuCode,menu_name menuName,menu_class menuClass,"
					+ "data_url dataUrl,sequence,parent_menucode parentMenuCode from authority "
					+ "where menu_code in (" + menuCodeList + ")";
			List<Map<String, Object>> authorityList = sysUserDao
					.getObjectListByQuery(sql);
			List<Authority> authList = new ArrayList<Authority>();
			if (null != authorityList) {
				for (int i = 0; i < authorityList.size(); i++) {
					Authority obj = new Authority();
					obj.setId(Long.valueOf(authorityList.get(i).get("id")
							.toString()));
					obj.setMenuCode(authorityList.get(i).get("menuCode")
							.toString());
					obj.setMenuName(authorityList.get(i).get("menuName")
							.toString());
					obj.setMenuClass(authorityList.get(i).get("menuClass")
							.toString());
					obj.setDataUrl(authorityList.get(i).get("dataUrl")
							.toString());
					obj.setSequence(Long.valueOf("".equals(authorityList.get(i)
							.get("sequence").toString()) ? 0 : Long
							.valueOf(authorityList.get(i).get("sequence")
									.toString())));
					obj.setParentMenuCode(authorityList.get(i)
							.get("parentMenuCode").toString());
					authList.add(obj);
				}
			}
			return authList;
		} else {
			return null;
		}
	}

	/**
	 * 获取每个乡镇的积分总数
	 */
	@Override
	public String getPointsByTown(String townId) {
		String sql = "select ifnull(sum(points),0) as sum from sys_user where townID = '"
				+ townId + "'";
		List<Object> allpoints = sysUserDao.getObjectByQuery(sql);
		return allpoints.get(0).toString();
	}
	/**
	 * 
	 * @Method checkLoginName
	 * @category 验证登录名输入得唯一性
	 * @author taotouhong
	 * @return SysUser
	 * @date 2016年4月18日 下午10:52:48
	 */
	public SysUser checkLoginName(String loginName) {
		SysUser user= sysUserDao.getByProerties("loginName", loginName);
		return user;
	}
}
