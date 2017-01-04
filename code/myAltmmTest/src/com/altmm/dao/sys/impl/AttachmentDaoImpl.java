package com.altmm.dao.sys.impl;

import java.util.List;

import org.hibernate.Query;
import org.hibernate.SQLQuery;
import org.springframework.stereotype.Repository;

import com.altmm.dao.sys.AttachmentDao;
import com.altmm.model.sys.Attachment;

import core.dao.BaseDao;

/**
 * 附件的数据持久层的实现类
 * 
 */
@Repository
public class AttachmentDaoImpl extends BaseDao<Attachment>implements AttachmentDao {

	public AttachmentDaoImpl() {
		super(Attachment.class);
	}

	// 此方法仅作代码写法演示，与功能模块无关

	public List<Object[]> queryFlowerList(String epcId) {
		Query query = this.getSession().createSQLQuery(
				"select ft.name,group_concat(a.file_path),ft.description,f.epc_id from um_type ft inner join jeefw f on ft.id=f.type_id left join attachment a on a.umtype_id=ft.id where f.epc_id=? group by a.file_name");
		query.setParameter(0, epcId);
		return query.list();
	}

	// 此方法仅作代码写法演示，与功能模块无关

	public void deleteAttachmentByForestryTypeId(Long umTypeId) {
		Query query = this.getSession().createSQLQuery("delete from attachment where umtype_id = :umTypeId");
		query.setParameter("umTypeId", umTypeId);
		query.executeUpdate();
	}

	// 此方法仅作代码写法演示，与功能模块无关

	public List<Object[]> querySensorList() {
		SQLQuery query = this.getSession().createSQLQuery(
				"select s.sensor_id,s.xcoordinate,s.ycoordinate,f.name,ft.description from sensor s,jeefw f,um_type ft where s.epc_id = f.epc_id and f.type_id = ft.id and s.type = 1 and s.xcoordinate is not null and s.ycoordinate is not null");
		return query.list();
	}

}
