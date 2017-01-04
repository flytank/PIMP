package com.altmm.dao.sys;

import java.util.List;

import com.altmm.model.sys.Attachment;

import core.dao.Dao;

/**
 * 附件的数据持久层的接口
 * 
 */
public interface AttachmentDao extends Dao<Attachment> {

	List<Object[]> queryFlowerList(String epcId);

	void deleteAttachmentByForestryTypeId(Long umTypeId);

	List<Object[]> querySensorList();

}
