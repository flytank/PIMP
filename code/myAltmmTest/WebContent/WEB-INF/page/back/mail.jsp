<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}"></c:set>

<link rel="stylesheet" href="${contextPath}/static/assets/css/jquery.gritter.css" />

<!-- ajax layout which only needs content area -->
<div class="page-header">
	<h1>
		邮件收发
		<small>
			<i class="ace-icon fa fa-angle-double-right"></i>
			实时的新邮件提醒，流畅的邮件收发体验(除了写信的发送邮件功能，其他暂时只提供静态页面模板参考。)
		</small>
	</h1>
</div><!-- /.page-header -->

<div class="row">
	<div class="col-xs-12">
		<!-- PAGE CONTENT BEGINS -->
		<div class="row">
			<div class="col-xs-12">
				<!-- #section:pages/inbox -->
				<div class="tabbable">
					<ul id="inbox-tabs" class="inbox-tabs nav nav-tabs padding-16 tab-size-bigger tab-space-1">
						<!-- #section:pages/inbox.compose-btn -->
						<li class="li-new-mail pull-right">
							<a data-toggle="tab" href="#write" data-target="write" class="btn-new-mail">
								<span class="btn btn-purple no-border">
									<i class="ace-icon fa fa-envelope bigger-130"></i>
									<span class="bigger-110">写信</span>
								</span>
							</a>
						</li><!-- /.li-new-mail -->

						<!-- /section:pages/inbox.compose-btn -->
						<li class="active">
							<a data-toggle="tab" href="#inbox" data-target="inbox">
								<i class="blue ace-icon fa fa-inbox bigger-130"></i>
								<span class="bigger-110">收件箱</span>
							</a>
						</li>

						<li>
							<a data-toggle="tab" href="#sent" data-target="sent">
								<i class="orange ace-icon fa fa-location-arrow bigger-130"></i>
								<span class="bigger-110">已发送</span>
							</a>
						</li>

						<li>
							<a data-toggle="tab" href="#draft" data-target="draft">
								<i class="green ace-icon fa fa-pencil bigger-130"></i>
								<span class="bigger-110">草稿箱</span>
							</a>
						</li>
					</ul>

					<div class="tab-content no-border no-padding">
						<div id="inbox" class="tab-pane in active">
							<div class="message-container">
								<!-- #section:pages/inbox.navbar -->
								<div id="id-message-list-navbar" class="message-navbar clearfix">
									<div class="message-bar">
										<div class="message-infobar" id="id-message-infobar">
											<span class="blue bigger-150">收件箱</span>
											<span class="grey bigger-110">(2封未读邮件)</span>
										</div>

										<div class="message-toolbar hide">
											<div class="inline position-relative align-left">
												<button type="button" class="btn-white btn-primary btn btn-xs dropdown-toggle" data-toggle="dropdown">
													<span class="bigger-110">操作</span>

													<i class="ace-icon fa fa-caret-down icon-on-right"></i>
												</button>

												<ul class="dropdown-menu dropdown-lighter dropdown-caret dropdown-125">
													<li>
														<a href="#">
															<i class="ace-icon fa fa-mail-reply blue"></i>&nbsp; 回复
														</a>
													</li>

													<li>
														<a href="#">
															<i class="ace-icon fa fa-mail-forward green"></i>&nbsp; 转发
														</a>
													</li>

													<li>
														<a href="#">
															<i class="ace-icon fa fa-folder-open orange"></i>&nbsp; 存档
														</a>
													</li>

													<li class="divider"></li>

													<li>
														<a href="#">
															<i class="ace-icon fa fa-eye blue"></i>&nbsp; 标记为已读邮件
														</a>
													</li>

													<li>
														<a href="#">
															<i class="ace-icon fa fa-eye-slash green"></i>&nbsp; 标记为未读邮件
														</a>
													</li>

													<li>
														<a href="#">
															<i class="ace-icon fa fa-flag-o red"></i>&nbsp; 标记星标
														</a>
													</li>

													<li class="divider"></li>

													<li>
														<a href="#">
															<i class="ace-icon fa fa-trash-o red bigger-110"></i>&nbsp; 删除
														</a>
													</li>
												</ul>
											</div>

											<button type="button" class="btn btn-xs btn-white btn-primary">
												<i class="ace-icon fa fa-trash-o bigger-125 orange"></i>
												<span class="bigger-110">删除</span>
											</button>
										</div>
									</div>

									<div>
										<div class="messagebar-item-left">
											<label class="inline middle">
												<input type="checkbox" id="id-toggle-all" class="ace" />
												<span class="lbl"></span>
											</label>

											&nbsp;
											<div class="inline position-relative">
												<a href="#" data-toggle="dropdown" class="dropdown-toggle">
													<i class="ace-icon fa fa-caret-down bigger-125 middle"></i>
												</a>

												<ul class="dropdown-menu dropdown-lighter dropdown-100">
													<li>
														<a id="id-select-message-all" href="#">全选</a>
													</li>

													<li>
														<a id="id-select-message-none" href="#">反选</a>
													</li>

													<li class="divider"></li>

													<li>
														<a id="id-select-message-unread" href="#">未读</a>
													</li>

													<li>
														<a id="id-select-message-read" href="#">已读</a>
													</li>
												</ul>
											</div>
										</div>

										<!-- #section:pages/inbox.navbar-search -->
										<div class="nav-search minimized">
											<form class="form-search">
												<span class="input-icon">
													<input type="text" autocomplete="off" class="input-small nav-search-input" placeholder="邮件全文检索 ..." />
													<i class="ace-icon fa fa-search nav-search-icon"></i>
												</span>
											</form>
										</div>

										<!-- /section:pages/inbox.navbar-search -->
									</div>
								</div>

								<div id="id-message-item-navbar" class="hide message-navbar clearfix">
									<div class="message-bar">
										<div class="message-toolbar">
											<div class="inline position-relative align-left">
												<button type="button" class="btn-white btn-primary btn btn-xs dropdown-toggle" data-toggle="dropdown">
													<span class="bigger-110">操作</span>

													<i class="ace-icon fa fa-caret-down icon-on-right"></i>
												</button>

												<ul class="dropdown-menu dropdown-lighter dropdown-caret dropdown-125">
													<li>
														<a href="#">
															<i class="ace-icon fa fa-mail-reply blue"></i>&nbsp; 回复
														</a>
													</li>

													<li>
														<a href="#">
															<i class="ace-icon fa fa-mail-forward green"></i>&nbsp; 转发
														</a>
													</li>

													<li>
														<a href="#">
															<i class="ace-icon fa fa-folder-open orange"></i>&nbsp; 存档
														</a>
													</li>

													<li class="divider"></li>

													<li>
														<a href="#">
															<i class="ace-icon fa fa-eye blue"></i>&nbsp; 标记为已读邮件
														</a>
													</li>

													<li>
														<a href="#">
															<i class="ace-icon fa fa-eye-slash green"></i>&nbsp; 标记为未读邮件
														</a>
													</li>

													<li>
														<a href="#">
															<i class="ace-icon fa fa-flag-o red"></i>&nbsp; 标记星标
														</a>
													</li>

													<li class="divider"></li>

													<li>
														<a href="#">
															<i class="ace-icon fa fa-trash-o red bigger-110"></i>&nbsp; 删除
														</a>
													</li>
												</ul>
											</div>

											<button type="button" class="btn btn-xs btn-white btn-primary">
												<i class="ace-icon fa fa-trash-o bigger-125 orange"></i>
												<span class="bigger-110">删除</span>
											</button>
										</div>
									</div>

									<div>
										<div class="messagebar-item-left">
											<a href="#" class="btn-back-message-list">
												<i class="ace-icon fa fa-arrow-left blue bigger-110 middle"></i>
												<b class="bigger-110 middle">返回</b>
											</a>
										</div>

										<div class="messagebar-item-right">
											<i class="ace-icon fa fa-clock-o bigger-110 orange"></i>
											<span class="grey">今天, 7:15 pm</span>
										</div>
									</div>
								</div>

								<div id="id-message-new-navbar" class="hide message-navbar clearfix">
									<div class="message-bar">
										<div class="message-toolbar">
											<button type="button" class="btn btn-xs btn-white btn-primary">
												<i class="ace-icon fa fa-floppy-o bigger-125"></i>
												<span class="bigger-110">存草稿</span>
											</button>

											<button type="button" class="btn btn-xs btn-white btn-primary">
												<i class="ace-icon fa fa-times bigger-125 orange2"></i>
												<span class="bigger-110">关闭</span>
											</button>
										</div>
									</div>

									<div>
										<div class="messagebar-item-left">
											<a href="#" class="btn-back-message-list">
												<i class="ace-icon fa fa-arrow-left bigger-110 middle blue"></i>
												<b class="middle bigger-110">返回</b>
											</a>
										</div>

										<div class="messagebar-item-right">
											<span class="inline btn-send-message">
												<button id="sendEmailButton" type="button" class="btn btn-sm btn-primary no-border btn-white btn-round">
													<span class="bigger-110">发送</span>

													<i class="ace-icon fa fa-arrow-right icon-on-right"></i>
												</button>
											</span>
										</div>
									</div>
								</div>

								<!-- /section:pages/inbox.navbar -->
								<div class="message-list-container">
									<!-- #section:pages/inbox.message-list -->
									<div class="message-list" id="message-list">
										<!-- #section:pages/inbox.message-list.item -->
										<div class="message-item message-unread">
											<label class="inline">
												<input type="checkbox" class="ace" />
												<span class="lbl"></span>
											</label>

											<i class="message-star ace-icon fa fa-star orange2"></i>
											<span class="sender" title="JavaEEFramework">JavaEEFramework</span>
											<span class="time">1:33 下午</span>

											<span class="summary">
												<span class="text">
													通用后台管理系统（ExtJS 5.1 + Hibernate 4.3.8 + Spring MVC 4.0.9）
												</span>
											</span>
										</div>

										<!-- /section:pages/inbox.message-list.item -->

										<!-- #section:pages/inbox.message-list.item -->
										<div class="message-item message-unread">
											<label class="inline">
												<input type="checkbox" class="ace" />
												<span class="lbl"></span>
											</label>

											<i class="message-star ace-icon fa fa-star-o light-grey"></i>

											<span class="sender" title="altmm">
												altmm
												<span class="light-grey">(4)</span>
											</span>
											<span class="time">7:15 下午</span>

											<span class="attachment">
												<i class="ace-icon fa fa-paperclip"></i>
											</span>

											<span class="summary">
												<span class="badge badge-pink mail-tag"></span>
												<span class="text">
													通用后台管理系统（ExtJS 5.1 + Hibernate 4.3.8 + Spring MVC 4.0.9）
												</span>
											</span>
										</div>
										<!-- /section:pages/inbox.message-list.item -->
										
										<!-- #section:pages/inbox.message-list.item -->
										<div class="message-item">
											<label class="inline">
												<input type="checkbox" class="ace" />
												<span class="lbl"></span>
											</label>

											<i class="message-star ace-icon fa fa-star-o light-grey"></i>
											<span class="sender" title="广告邮件">广告邮件</span>
											<span class="time">3月3日</span>

											<span class="attachment">
												<i class="ace-icon fa fa-paperclip"></i>
											</span>

											<span class="summary">
												<span class="message-flags">
													<i class="ace-icon fa fa-flag fa-flip-horizontal light-grey"></i>
												</span>
												<span class="text">
													来自QQ邮箱的贺卡
												</span>
											</span>
										</div>
										<!-- /section:pages/inbox.message-list.item -->
									</div>

									<!-- /section:pages/inbox.message-list -->
								</div>

								<!-- #section:pages/inbox.message-footer -->
								<div class="message-footer clearfix">
									<div class="pull-left"> 共 3 封 </div>

									<div class="pull-right">
										<div class="inline middle"> 1/1页 </div>

										&nbsp; &nbsp;
										<ul class="pagination middle">
											<li class="disabled">
												<span>
													<i class="ace-icon fa fa-step-backward middle"></i>
												</span>
											</li>

											<li class="disabled">
												<span>
													<i class="ace-icon fa fa-caret-left bigger-140 middle"></i>
												</span>
											</li>

											<li>
												<span>
													<input value="1" maxlength="3" type="text" />
												</span>
											</li>

											<li class="disabled">
												<a href="#">
													<i class="ace-icon fa fa-caret-right bigger-140 middle"></i>
												</a>
											</li>

											<li class="disabled">
												<a href="#">
													<i class="ace-icon fa fa-step-forward middle"></i>
												</a>
											</li>
										</ul>
									</div>
								</div>

								<div class="hide message-footer message-footer-style2 clearfix">

									<div class="pull-right">
										<div class="inline middle"> 1/2封 </div>

										&nbsp; &nbsp;
										<ul class="pagination middle">
											<li class="disabled">
												<span>
													<i class="ace-icon fa fa-angle-left bigger-150"></i>
												</span>
											</li>

											<li>
												<a href="#">
													<i class="ace-icon fa fa-angle-right bigger-150"></i>
												</a>
											</li>
										</ul>
									</div>
								</div>

								<!-- /section:pages/inbox.message-footer -->
							</div>
						</div>
					</div><!-- /.tab-content -->
				</div><!-- /.tabbable -->

				<!-- /section:pages/inbox -->
			</div><!-- /.col -->
		</div><!-- /.row -->

		<form id="id-message-form" class="hide form-horizontal message-form col-xs-12" method="POST">
			<!-- #section:pages/inbox.compose -->
			<div>
				<div class="form-group">
					<label class="col-sm-3 control-label no-padding-right" for="form-field-recipient">收件人:</label>

					<div class="col-sm-6 col-xs-12">
						<div class="input-icon block col-xs-12 no-padding">
							<input type="text" class="col-xs-12" name="recipient" id="form-field-recipient" placeholder="" />
							<i class="ace-icon fa fa-user"></i>
						</div>
					</div>
				</div>

				<div class="hr hr-18 dotted"></div>

				<div class="form-group">
					<label class="col-sm-3 control-label no-padding-right" for="form-field-subject">主题:</label>

					<div class="col-sm-6 col-xs-12">
						<div class="input-icon block col-xs-12 no-padding">
							<input maxlength="100" type="text" class="col-xs-12" name="subject" id="form-field-subject" placeholder="主题" />
							<i class="ace-icon fa fa-comment-o"></i>
						</div>
					</div>
				</div>

				<div class="hr hr-18 dotted"></div>

				<div class="form-group">
					<label class="col-sm-3 control-label no-padding-right">
						<span class="inline space-24 hidden-480"></span>
						正文:
					</label>

					<!-- #section:plugins/editor.wysiwyg -->
					<div class="col-sm-9">
						<div class="wysiwyg-editor"></div>
					</div>
					<!-- /section:plugins/editor.wysiwyg -->
				</div>

				<div class="hr hr-18 dotted"></div>

				<div class="form-group no-margin-bottom">
					<label class="col-sm-3 control-label no-padding-right">附件:</label>

					<div class="col-sm-9">
						<div id="form-attachments">
							<!-- #section:custom/file-input -->
							<input type="file" name="attachment[]" />
							<!-- /section:custom/file-input -->
						</div>
						<div id="form-attachments-tip"></div>
					</div>
				</div>

				<div class="align-right">
					<!-- 
					<button id="id-add-attachment" type="button" class="btn btn-sm btn-danger">
						<i class="ace-icon fa fa-paperclip bigger-140"></i>
						添加附件
					</button>
					-->
					<button id="id-submit-attachment" type="submit" class="btn btn-sm btn-primary">
						<i class="ace-icon fa fa-paperclip bigger-140"></i>
						提交附件
					</button>
				</div>

				<div class="space"></div>
				<div id="form-field-attachmentpaths" style="display: none;"></div>
			</div>
			<!-- /section:pages/inbox.compose -->
		</form>

		<div class="hide message-content" id="id-message-content">
			<!-- #section:pages/inbox.message-header -->
			<div class="message-header clearfix">
				<div class="pull-left">
					<div class="space-4"></div>

					<i class="ace-icon fa fa-star orange2"></i>

					&nbsp;
					<a href="#" class="sender">Java框架</a>

					&nbsp;
					<i class="ace-icon fa fa-clock-o bigger-110 orange middle"></i>
					<span class="time grey">今天, 7:15 pm</span>
				</div>

				<div class="pull-right action-buttons">
					<a href="#">
						<i class="ace-icon fa fa-reply green icon-only bigger-130"></i>
					</a>

					<a href="#">
						<i class="ace-icon fa fa-mail-forward blue icon-only bigger-130"></i>
					</a>

					<a href="#">
						<i class="ace-icon fa fa-trash-o red icon-only bigger-130"></i>
					</a>
				</div>
			</div>

			<!-- /section:pages/inbox.message-header -->
			<div class="hr hr-double"></div>

			<!-- #section:pages/inbox.message-body -->
			<div class="message-body">
				<p>
					1、系统导入后发布到应用服务器，例如tomcat上即可运行。
				</p>
				<p>
					2、导入项目后请将项目编码设置为UTF-8，不是GBK。
				</p>
			</div>

			<!-- /section:pages/inbox.message-body -->
			<div class="hr hr-double"></div>

			<!-- #section:pages/inbox.message-attachment -->
			<div class="message-attachment clearfix">
				<div class="attachment-title">
					<span class="blue bolder bigger-110">附件</span>
					&nbsp;
					<span class="grey">(2 files, 4.5 MB)</span>

					<div class="inline position-relative">
						<a href="#" data-toggle="dropdown" class="dropdown-toggle">
							&nbsp;
							<i class="ace-icon fa fa-caret-down bigger-125 middle"></i>
						</a>

						<ul class="dropdown-menu dropdown-lighter">
							<li>
								<a href="#">转存到中转站</a>
							</li>

							<li>
								<a href="#">转存到微云</a>
							</li>
						</ul>
					</div>
				</div>

				&nbsp;
				<ul class="attachment-list pull-left list-unstyled">
					<li>
						<a href="#" class="attached-file">
							<i class="ace-icon fa fa-file-o bigger-110"></i>
							<span class="attached-name">Document1.pdf</span>
						</a>

						<span class="action-buttons">
							<a href="#">
								<i class="ace-icon fa fa-download bigger-125 blue"></i>
							</a>

							<a href="#">
								<i class="ace-icon fa fa-trash-o bigger-125 red"></i>
							</a>
						</span>
					</li>

					<li>
						<a href="#" class="attached-file">
							<i class="ace-icon fa fa-film bigger-110"></i>
							<span class="attached-name">Sample.mp4</span>
						</a>

						<span class="action-buttons">
							<a href="#">
								<i class="ace-icon fa fa-download bigger-125 blue"></i>
							</a>

							<a href="#">
								<i class="ace-icon fa fa-trash-o bigger-125 red"></i>
							</a>
						</span>
					</li>
				</ul>

				<div class="attachment-images pull-right">
					<div class="vspace-4-sm"></div>

					<div>
						<img width="36" alt="image 4" src="${contextPath}/static/assets/images/gallery/thumb-4.jpg" />
						<img width="36" alt="image 3" src="${contextPath}/static/assets/images/gallery/thumb-3.jpg" />
						<img width="36" alt="image 2" src="${contextPath}/static/assets/images/gallery/thumb-2.jpg" />
						<img width="36" alt="image 1" src="${contextPath}/static/assets/images/gallery/thumb-1.jpg" />
					</div>
				</div>
			</div>

			<!-- /section:pages/inbox.message-attachment -->
		</div><!-- /.message-content -->

		<!-- PAGE CONTENT ENDS -->
	</div><!-- /.col -->
</div><!-- /.row -->

<!-- page specific plugin scripts -->
<script type="text/javascript">
	var scripts = [null,"${contextPath}/static/assets/js/bootstrap-tag.js","${contextPath}/static/assets/js/jquery.hotkeys.js","${contextPath}/static/assets/js/bootstrap-wysiwyg.js","${contextPath}/static/assets/js/jquery.gritter.js",null]
	$(".page-content-area").ace_ajax("loadScripts", scripts, function() {
	  	 //inline scripts related to this page
		 jQuery(function($){
			//handling tabs and loading/displaying relevant messages and forms
			//not needed if using the alternative view, as described in docs
			$("#inbox-tabs a[data-toggle='tab']").on("show.bs.tab", function (e) {
				var currentTab = $(e.target).data("target");
				if(currentTab == "write") {
					Inbox.show_form();
				}
				else if(currentTab == "inbox") {
					Inbox.show_list();
				}
			});
		
			//basic initializations
			$(".message-list .message-item input[type=checkbox]").removeAttr("checked");
			$(".message-list").on("click", ".message-item input[type=checkbox]" , function() {
				$(this).closest(".message-item").toggleClass("selected");
				if(this.checked) Inbox.display_bar(1);//display action toolbar when a message is selected
				else {
					Inbox.display_bar($(".message-list input[type=checkbox]:checked").length);
					//determine number of selected messages and display/hide action toolbar accordingly
				}		
			});
		
			//check/uncheck all messages
			$("#id-toggle-all").removeAttr("checked").on("click", function(){
				if(this.checked) {
					Inbox.select_all();
				} else Inbox.select_none();
			});
			
			//select all
			$("#id-select-message-all").on("click", function(e) {
				e.preventDefault();
				Inbox.select_all();
			});
			
			//select none
			$("#id-select-message-none").on("click", function(e) {
				e.preventDefault();
				Inbox.select_none();
			});
			
			//select read
			$("#id-select-message-read").on("click", function(e) {
				e.preventDefault();
				Inbox.select_read();
			});
		
			//select unread
			$("#id-select-message-unread").on("click", function(e) {
				e.preventDefault();
				Inbox.select_unread();
			});
		
			//display first message in a new area
			$(".message-list .message-item:eq(0) .text").on("click", function() {
				//show the loading icon
				$(".message-container").append("<div class='message-loading-overlay'><i class='fa-spin ace-icon fa fa-spinner orange2 bigger-160'></i></div>");
				$(".message-inline-open").removeClass("message-inline-open").find(".message-content").remove();
				var message_list = $(this).closest(".message-list");
				$("#inbox-tabs a[href='#inbox']").parent().removeClass("active");
				//some waiting
				setTimeout(function() {
					//hide everything that is after .message-list (which is either .message-content or .message-form)
					message_list.next().addClass("hide");
					$(".message-container").find(".message-loading-overlay").remove();
					//close and remove the inline opened message if any!
					//hide all navbars
					$(".message-navbar").addClass("hide");
					//now show the navbar for single message item
					$("#id-message-item-navbar").removeClass("hide");
					//hide all footers
					$(".message-footer").addClass("hide");
					//now show the alternative footer
					$(".message-footer-style2").removeClass("hide");
					//move .message-content next to .message-list and hide .message-list
					$(".message-content").removeClass("hide").insertAfter(message_list.addClass("hide"));
					//add scrollbars to .message-body
					$(".message-content .message-body").ace_scroll({
						size: 150,
						mouseWheelLock: true,
						styleClass: "scroll-visible"
					});
				}, 500 + parseInt(Math.random() * 500));
			});
		
			//display second message right inside the message list
			$(".message-list .message-item:eq(1) .text").on("click", function(){
				var message = $(this).closest(".message-item");
				//if message is open, then close it
				if(message.hasClass("message-inline-open")) {
					message.removeClass("message-inline-open").find(".message-content").remove();
					return;
				}
				$(".message-container").append("<div class='message-loading-overlay'><i class='fa-spin ace-icon fa fa-spinner orange2 bigger-160'></i></div>");
				setTimeout(function() {
					$(".message-container").find(".message-loading-overlay").remove();
					message.addClass("message-inline-open").append("<div class='message-content' />")
					var content = message.find(".message-content:last").html( $("#id-message-content").html() );
					//remove scrollbar elements
					content.find(".scroll-track").remove();
					content.find(".scroll-content").children().unwrap();
					content.find(".message-body").ace_scroll({
						size: 150,
						mouseWheelLock: true,
						styleClass: "scroll-visible"
					});
				}, 500 + parseInt(Math.random() * 500));
				
			});
		
			//back to message list
			$(".btn-back-message-list").on("click", function(e) {
				e.preventDefault();
				$("#inbox-tabs a[href='#inbox']").tab("show");
			});
		
			//hide message list and display new message form
			/**
			$(".btn-new-mail").on("click", function(e){
				e.preventDefault();
				Inbox.show_form();
			});
			*/
		
			var Inbox = {
				//displays a toolbar according to the number of selected messages
				display_bar : function (count) {
					if(count == 0) {
						$("#id-toggle-all").removeAttr("checked");
						$("#id-message-list-navbar .message-toolbar").addClass("hide");
						$("#id-message-list-navbar .message-infobar").removeClass("hide");
					}
					else {
						$("#id-message-list-navbar .message-infobar").addClass("hide");
						$("#id-message-list-navbar .message-toolbar").removeClass("hide");
					}
				}
				,
				select_all : function() {
					var count = 0;
					$(".message-item input[type=checkbox]").each(function(){
						this.checked = true;
						$(this).closest(".message-item").addClass("selected");
						count++;
					});
					$("#id-toggle-all").get(0).checked = true;
					Inbox.display_bar(count);
				}
				,
				select_none : function() {
					$(".message-item input[type=checkbox]").removeAttr("checked").closest(".message-item").removeClass("selected");
					$("#id-toggle-all").get(0).checked = false;
					Inbox.display_bar(0);
				}
				,
				select_read : function() {
					$(".message-unread input[type=checkbox]").removeAttr("checked").closest(".message-item").removeClass("selected");
					var count = 0;
					$(".message-item:not(.message-unread) input[type=checkbox]").each(function(){
						this.checked = true;
						$(this).closest(".message-item").addClass("selected");
						count++;
					});
					Inbox.display_bar(count);
				}
				,
				select_unread : function() {
					$(".message-item:not(.message-unread) input[type=checkbox]").removeAttr("checked").closest(".message-item").removeClass("selected");
					var count = 0;
					$(".message-unread input[type=checkbox]").each(function(){
						this.checked = true;
						$(this).closest(".message-item").addClass("selected");
						count++;
					});
					Inbox.display_bar(count);
				}
			}
		
			//show message list (back from writing mail or reading a message)
			Inbox.show_list = function() {
				$(".message-navbar").addClass("hide");
				$("#id-message-list-navbar").removeClass("hide");
				$(".message-footer").addClass("hide");
				$(".message-footer:not(.message-footer-style2)").removeClass("hide");
				$(".message-list").removeClass("hide").next().addClass("hide");
				//hide the message item / new message window and go back to list
			}
		
			//show write mail form
			Inbox.show_form = function() {
				if($(".message-form").is(":visible")) return;
				if(!form_initialized) {
					initialize_form();
				}
				var message = $(".message-list");
				$(".message-container").append("<div class='message-loading-overlay'><i class='fa-spin ace-icon fa fa-spinner orange2 bigger-160'></i></div>");
				setTimeout(function() {
					message.next().addClass("hide");
					$(".message-container").find(".message-loading-overlay").remove();
					$(".message-list").addClass("hide");
					$(".message-footer").addClass("hide");
					$(".message-form").removeClass("hide").insertAfter(".message-list");
					$(".message-navbar").addClass("hide");
					$("#id-message-new-navbar").removeClass("hide");
					//reset form??
					$(".message-form .wysiwyg-editor").empty();
					$(".message-form .ace-file-input").closest(".file-input-container:not(:first-child)").remove();
					$(".message-form input[type=file]").ace_file_input("reset_input");
					$(".message-form").get(0).reset();
				}, 300 + parseInt(Math.random() * 300));
			};
		
			var form_initialized = false;
			function initialize_form() {
				if(form_initialized) return;
				form_initialized = true;
				//intialize wysiwyg editor
				$(".message-form .wysiwyg-editor").ace_wysiwyg({
					toolbar:
					[
						"bold",
						"italic",
						"strikethrough",
						"underline",
						null,
						"justifyleft",
						"justifycenter",
						"justifyright",
						null,
						"createLink",
						"unlink",
						null,
						"undo",
						"redo"
					]
				}).prev().addClass("wysiwyg-style1");
		
				//file input
				$(".message-form input[type=file]").ace_file_input().closest(".ace-file-input").addClass("width-90 inline").wrap("<div class='form-group file-input-container'><div class='col-sm-7'></div></div>");
				
				/**
				//Add Attachment,the button to add a new file input
				$("#id-add-attachment").on("click", function(){
					$("#form-attachments-tip").html("");
					var file_input = $("<input type="file" name="attachment[]" />").appendTo("#form-attachments");
					file_input.ace_file_input();
					file_input.closest(".ace-file-input").addClass("width-90 inline").wrap("<div class="form-group file-input-container"><div class="col-sm-7"></div></div>").parent()
					.append("<div class="action-buttons pull-right col-xs-1"><a href="#" data-action="delete" class="middle"><i class="ace-icon fa fa-trash-o red bigger-130 middle"></i></a></div>").find("a[data-action=delete]").on("click", function(e){
						//the button that removes the newly inserted file input
						e.preventDefault();
						$(this).closest(".file-input-container").hide(300, function(){ $(this).remove() });
					});
				});
				**/
			}//initialize_form
			
			/**
			//turn the recipient field into a tag input field!
			var tag_input = $("#form-field-recipient");
			try { 
				tag_input.tag({placeholder:tag_input.attr("placeholder")});
			} catch(e) {}
			*/
			/**
			//and add form reset functionality
			$("#id-message-form").on("reset", function(){
				$(".message-form .message-body").empty();
				$(".message-form .ace-file-input:not(:first-child)").remove();
				$(".message-form input[type=file]").ace_file_input("reset_input_ui");
				var val = tag_input.data("value");
				tag_input.parent().find(".tag").remove();
				$(val.split(",")).each(function(k,v){
					tag_input.before("<span class="tag">"+v+"<button class="close" type="button">&times;</button></span>");
				});
			});
			*/
			
			//发送邮件
			$("#sendEmailButton").click(function () {
			    if ($("#form-field-recipient").val() == "") {
					$.gritter.add({
		                title: "系统信息",
		                text: "请填写收件人",
		                class_name: "gritter-warning gritter-center"
		            });
			        return;
			    } else if ($("#form-field-subject").val() == "") {
					$.gritter.add({
		                title: "系统信息",
		                text: "请填写主题",
		                class_name: "gritter-warning gritter-center"
		            });
			        return;
			    } else {
			    	$.ajax({
						dataType : "json",
						url : "${contextPath}/sys/mail/sendMail",
						type : "post",
						data : {
							recipient : $("#form-field-recipient").val(),
							subject : $("#form-field-subject").val(),
							message : $(".message-form .wysiwyg-editor").html(),
							attachmentpaths : $("#form-field-attachmentpaths").html(),
							originalFilenames : $("#form-attachments-tip").html()
						},
						complete : function(xmlRequest) {
							var returninfo = eval("(" + xmlRequest.responseText + ")");
							$.gritter.add({
				                title: "系统信息",
				                text: returninfo.result,
				                class_name: "gritter-success gritter-center"
				            });
						}
					});
			    }
			});
		
		});
	
	});
</script>
<script type="text/javascript">
	jQuery(function($) {
		var $form = $("#id-message-form");
		// you can have multiple files, or a file input with "multiple" attribute
		var file_input = $form.find("input[type=file]");
		var upload_in_progress = false;
		file_input.ace_file_input({
			//style : "well",
			btn_choose : "选择或拖拽上传",
			btn_change : "变更文件",
			droppable : true,
			thumbnail : "large",
			maxSize : 2097152,// bytes
			//allowExt : [ "jpeg", "jpg", "png", "gif" ],
			//allowMime : [ "image/jpg", "image/jpeg", "image/png", "image/gif" ],
			denyExt :  ["exe"],
			before_remove : function() {
				if (upload_in_progress)
					return false;// if we are in the middle of uploading a file, don"t allow resetting file input
				return true;
			},
			preview_error : function(filename, code) {
				// code = 1 means file load error
				// code = 2 image load error (possibly file is not an image)
				// code = 3 preview failed
			}
		});
		file_input.on("file.error.ace", function(ev, info) {
			if (info.error_count["ext"] || info.error_count["mime"])
				$.gritter.add({
	                title: "系统信息",
	                text: "文件格式不正确！不能上传可执行文件！",
	                class_name: "gritter-warning gritter-center"
	            });
			if (info.error_count["size"])
				$.gritter.add({
	                title: "系统信息",
	                text: "文件大小不能超过2mb！",
	                class_name: "gritter-warning gritter-center"
	            });
			// you can reset previous selection on error
			// ev.preventDefault();
			// file_input.ace_file_input("reset_input");
		});
		var ie_timeout = null;// a time for old browsers uploading via iframe
		$form.on("submit", function(e) {
			e.preventDefault();
			var files = file_input.data("ace_input_files");
			if (!files || files.length == 0)
				return false;// no files selected
			var deferred;
			if ("FormData" in window) {
				// for modern browsers that support FormData and uploading files via ajax we can do >>> var formData_object = new FormData($form[0]);
				// but IE10 has a problem with that and throws an exception and also browser adds and uploads all selected files, not the filtered ones. and drag&dropped files won"t be uploaded as well
				// so we change it to the following to upload only our filtered files and to bypass IE10"s error and to include drag&dropped files as well
				formData_object = new FormData();// create empty FormData object
				/**
				$.each($form.serializeArray(), function(i, item) {// serialize our form (which excludes file inputs)
					formData_object.append(item.name, item.value);// add them one by one to our FormData
				});
				**/
				// and then add files
				$form.find("input[type=file]").each(function() {
					var field_name = $(this).attr("name");
					// for fields with "multiple" file support, field name should be something like `myfile[]`
					var files = $(this).data("ace_input_files");
					if (files && files.length > 0) {
						for (var f = 0; f < files.length; f++) {
							formData_object.append(field_name, files[f]);
						}
					}
				});
				upload_in_progress = true;
				file_input.ace_file_input("loading", true);
				deferred = $.ajax({
					url : "${contextPath}/sys/mail/sendMailAttachment",
					type : $form.attr("method"),
					processData : false,// important
					contentType : false,// important
					dataType : "json",
					data : formData_object,
					xhr : function() {
						var req = $.ajaxSettings.xhr();
						if (req && req.upload) {
							req.upload.addEventListener("progress", function(e) {
								if (e.lengthComputable) {
									var done = e.loaded || e.position, total = e.total || e.totalSize;
									var percent = parseInt((done / total) * 100) + "%";
								}
							}, false);
						}
						return req;
					},
					beforeSend : function() {
					},
					success : function() {
					}
				})
			} else {
				// for older browsers that don"t support FormData and uploading files via ajax.we use an iframe to upload the form(file) without leaving the page
				deferred = new $.Deferred; // create a custom deferred object
				var temporary_iframe_id = "temporary-iframe-" + (new Date()).getTime() + "-" + (parseInt(Math.random() * 1000));
				var temp_iframe = $("<iframe id='" + temporary_iframe_id + "' name='" + temporary_iframe_id + "' frameborder='0' width='0' height='0' src='about:blank' style='position:absolute; z-index:-1; visibility: hidden;'></iframe>").insertAfter($form);
				$form.append("<input type='hidden' name='temporary-iframe-id' value='" + temporary_iframe_id + "' />");
				temp_iframe.data("deferrer", deferred);
				// we save the deferred object to the iframe and in our server side response.we use "temporary-iframe-id" to access iframe and its deferred object
				$form.attr({
					method : "POST",
					enctype : "multipart/form-data",
					target : temporary_iframe_id
				});
				upload_in_progress = true;
				file_input.ace_file_input("loading", true);// display an overlay with loading icon
				$form.get(0).submit();
				// if we don"t receive a response after 30 seconds, let"s declare it as failed!
				ie_timeout = setTimeout(function() {
					ie_timeout = null;
					temp_iframe.attr("src", "about:blank").remove();
					deferred.reject({
						"status" : "fail",
						"message" : "Timeout!"
					});
				}, 30000);
			}
			// deferred callbacks, triggered by both ajax and iframe solution
			deferred.done(function(result) {// success
				var res = result;//the `result` is formatted by your server side response and is arbitrary
				if(res.status == "OK"){
					$("#form-attachments-tip").append(res.originalFilename+" ");
					$("#form-field-attachmentpaths").append(res.url+",");
				}
			}).fail(function(result) {// failure
				alert("There was an error");
			}).always(function() {// called on both success and failure
				if (ie_timeout)
					clearTimeout(ie_timeout)
				ie_timeout = null;
				upload_in_progress = false;
				file_input.ace_file_input("loading", false);
			});
			deferred.promise();
		});
		// when "reset" button of form is hit, file field will be reset, but the custom UI won"t.so you should reset the ui on your own
		$form.on("reset", function() {
			$(this).find("input[type=file]").ace_file_input("reset_input_ui");
		});
		if (location.protocol == "file:")
			alert("For uploading to server, you should access this page using 'http' protocal, i.e. via a webserver.");
	});
</script>
