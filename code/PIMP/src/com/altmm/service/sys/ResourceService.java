package com.altmm.service.sys;

import java.util.List;

import com.altmm.model.sys.Authority;
import com.altmm.model.sys.PartyMember;
import com.altmm.model.sys.SysUser;
import com.altmm.model.sys.Town;
import com.altmm.model.sys.Village;

import core.service.Service;

/**
 * @file ResourceService.java
 * @category 资源信息的业务逻辑层的接口
 * @author xumin
 * @date 2016年3月21日 下午1:37:31
 */
public interface ResourceService extends Service<SysUser> {
	/**
	 * @Method getVillageListByTownID
	 * @category 通过乡镇编码获取自然村列表
	 * @author xumin
	 * @param @param townID
	 * @param @return
	 * @return List<Village>
	 * @date 2016年3月21日 下午1:49:41
	 */
	List<Village> getVillageListByTownID(String townID);

	/**
	 * @Method getTownListByZoneID
	 * @category 通过区域编码获取乡镇列表
	 * @author xumin
	 * @param @param zoneID
	 * @param @return
	 * @return List<Town>
	 * @date 2016年3月21日 下午1:50:13
	 */
	List<Town> getTownListByZoneID(String zoneID);

	/**
	 * @Method getVillageByVillageID
	 * @category 通过自然村编码获取自然村对象
	 * @author xumin
	 * @param @param villageID
	 * @param @return
	 * @return Village
	 * @date 2016年3月24日 下午2:12:49
	 */
	Village getVillageByVillageID(String villageID);

	/**
	 * @Method getTownByTownID
	 * @category 通过乡镇编码获取乡镇对象
	 * @author xumin
	 * @param @param townID
	 * @param @return
	 * @return Town
	 * @date 2016年3月24日 下午2:13:29
	 */
	Town getTownByTownID(String townID);

	/**
	 * @Method getPartyMemberList
	 * @category 获得所有党员类别数据列表
	 * @author xumin
	 * @param @return
	 * @return List<PartyMember>
	 * @date 2016年3月26日 上午11:19:02
	 */
	List<PartyMember> getPartyMemberList();

	/**
	 * @Method getAuthorityListByRole
	 * @category 通过角色编码获取该角色拥有的菜单列表
	 * @author xumin
	 * @param @param role
	 * @param @return
	 * @return List<Authority>
	 * @date 2016年3月26日 上午11:53:30
	 */
	List<Authority> getAuthorityListByRole(String role);

	/**
	 * @Method getPointsByTown
	 * @category 获取每个乡镇的积分总数
	 * @author xumin
	 * @param @param townId
	 * @param @return
	 * @return String
	 * @date 2016年4月20日 下午10:37:32
	 */
	String getPointsByTown(String townId);
	
	/**
	 * 
	 * @Method checkLoginName
	 * @category 验证登录名输入得唯一性
	 * @author taotouhong
	 * @return SysUser
	 * @date 2016年4月18日 下午10:52:48
	 */
	public SysUser checkLoginName(String loginName);

}
