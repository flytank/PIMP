package com.altmm.controller.sys;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.altmm.core.JavaEEFrameworkBaseController;
import com.altmm.model.sys.Attachment;
import com.altmm.service.sys.AttachmentService;

/**
 * 附件的控制层
 * 
 */
@Controller
@RequestMapping("/sys/attachment")
public class AttachmentController extends JavaEEFrameworkBaseController<Attachment> {

	@Resource
	private AttachmentService attachmentService;

}
