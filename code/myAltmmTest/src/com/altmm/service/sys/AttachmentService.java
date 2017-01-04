package com.altmm.service.sys;

import java.util.List;

import com.altmm.model.sys.Attachment;

import core.service.Service;

/**
 * 附件的业务逻辑层的接口
 * 
 */
public interface AttachmentService extends Service<Attachment> {

	List<Object[]> queryFlowerList(String epcId);

	void deleteAttachmentByForestryTypeId(Long umTypeId);

	List<Object[]> querySensorList();

}
