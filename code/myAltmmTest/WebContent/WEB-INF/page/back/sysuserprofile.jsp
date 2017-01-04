<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}"></c:set>

<link rel="stylesheet" href="${contextPath}/static/assets/css/jquery-ui.custom.css" />
<link rel="stylesheet" href="${contextPath}/static/assets/css/jquery.gritter.css" />
<link rel="stylesheet" href="${contextPath}/static/assets/css/select2.css" />
<link rel="stylesheet" href="${contextPath}/static/assets/css/datepicker.css" />
<link rel="stylesheet" href="${contextPath}/static/assets/css/bootstrap-editable.css" />

<!-- ajax layout which only needs content area -->
<div class="page-header">
	<h1>
		个人资料页面
		<small>
			<i class="ace-icon fa fa-angle-double-right"></i>
			2种在线编辑风格
		</small>
	</h1>
</div><!-- /.page-header -->

<div class="row">
	<div class="col-xs-12">
		<!-- PAGE CONTENT BEGINS -->
		<div class="clearfix">
			<div class="pull-left alert alert-success no-margin">
				<button type="button" class="close" data-dismiss="alert">
					<i class="ace-icon fa fa-times"></i>
				</button>

				<i class="ace-icon fa fa-umbrella bigger-120 blue"></i>
				点击下面的图片或字段编辑 ... &nbsp;&nbsp;
			</div>

			<div class="pull-right">
				<span class="green middle bolder">切换编辑: &nbsp;</span>

				<div class="btn-toolbar inline middle no-margin">
					<div data-toggle="buttons" class="btn-group no-margin">
						<label class="btn btn-sm btn-yellow active">
							<span class="bigger-110">1</span>

							<input type="radio" value="1" />
						</label>

						<label class="btn btn-sm btn-yellow">
							<span class="bigger-110">2</span>

							<input type="radio" value="3" />
						</label>
					</div>
				</div>
			</div>
		</div>

		<div class="hr dotted"></div>

		<div>
			<div id="user-profile-1" class="user-profile row">
				<div class="col-xs-12 col-sm-3 center">
					<div>
						<!-- #section:pages/profile.picture -->
						<span class="profile-picture">
							<img id="avatar" class="editable img-responsive" alt="Alex's Avatar" src="${contextPath}/${sysuser.filePath}" />
						</span>

						<!-- /section:pages/profile.picture -->
						<div class="space-4"></div>

					</div>

					<div class="space-6"></div>

				</div>

				<div class="col-xs-12 col-sm-9">
					<div class="center">
						<span class="btn btn-app btn-sm btn-light no-hover">
							<span class="line-height-1 bigger-170 blue"> 1,411 </span>

							<br />
							<span class="line-height-1 smaller-90"> 访问  </span>
						</span>

						<span class="btn btn-app btn-sm btn-yellow no-hover">
							<span class="line-height-1 bigger-170"> 32 </span>

							<br />
							<span class="line-height-1 smaller-90"> 粉丝 </span>
						</span>

						<span class="btn btn-app btn-sm btn-pink no-hover">
							<span class="line-height-1 bigger-170"> 4 </span>

							<br />
							<span class="line-height-1 smaller-90"> 项目 </span>
						</span>

						<span class="btn btn-app btn-sm btn-grey no-hover">
							<span class="line-height-1 bigger-170"> 23 </span>

							<br />
							<span class="line-height-1 smaller-90"> 评论 </span>
						</span>

						<span class="btn btn-app btn-sm btn-success no-hover">
							<span class="line-height-1 bigger-170"> 7 </span>

							<br />
							<span class="line-height-1 smaller-90"> 相册 </span>
						</span>

						<span class="btn btn-app btn-sm btn-primary no-hover">
							<span class="line-height-1 bigger-170"> 55 </span>

							<br />
							<span class="line-height-1 smaller-90"> 互动 </span>
						</span>
					</div>

					<div class="space-12"></div>

					<!-- #section:pages/profile.info -->
					<div class="profile-user-info profile-user-info-striped">
						<div class="profile-info-row">
							<div class="profile-info-name"> 姓名  </div>
							<div class="profile-info-value">
								<span class="editable" id="userName">${sysuser.userName}</span>
							</div>
						</div>
						<div class="profile-info-row">
							<div class="profile-info-name">性别 </div>
							<div class="profile-info-value">
								<span class="editable" id="sex">
									<c:set var="id" value="${sysuser.id}" />
									<c:set var="sex" value="${sysuser.sex}" />
									<c:choose>
										<c:when test="${sysuser.sex == 1}">男</c:when>
										<c:otherwise>女</c:otherwise>
									</c:choose>
								</span>
							</div>
						</div>
						
						<div class="profile-info-row">
							<div class="profile-info-name"> 邮箱  </div>
							<div class="profile-info-value">
								<span class="editable" id="email" title="邮箱不可以更改">${sysuser.email}</span>
							</div>
						</div>

						<div class="profile-info-row">
							<div class="profile-info-name"> 联系电话  </div>
							<div class="profile-info-value">
								<span class="editable" id="phone">${sysuser.phone}</span>
							</div>
						</div>
						
						<div class="profile-info-row">
							<div class="profile-info-name"> 生日  </div>
							<div class="profile-info-value">
								<span class="editable" id="birthday">${sysuser.birthday}</span>
							</div>
						</div>
					</div>

					<!-- /section:pages/profile.info -->
					<div class="space-20"></div>

				</div>
			</div>
		</div>

		<div class="hide">
			<div id="user-profile-3" class="user-profile row">
				<div class="col-sm-offset-1 col-sm-10">
					<div class="well well-sm">
						<div class="inline middle blue bigger-110"> 个人资料完整度90%  </div>

						&nbsp; &nbsp; &nbsp;
						<div style="width:200px;" data-percent="70%" class="inline middle no-margin progress progress-striped active">
							<div class="progress-bar progress-bar-success" style="width:90%"></div>
						</div>
					</div><!-- /.well -->

					<div class="space"></div>

					<form class="form-horizontal">
						<div class="tabbable">
							<ul class="nav nav-tabs padding-16">
								<li class="active">
									<a data-toggle="tab" href="#edit-basic">
										<i class="green ace-icon fa fa-pencil-square-o bigger-125"></i>
										基本信息
									</a>
								</li>

								<li>
									<a data-toggle="tab" href="#edit-password">
										<i class="blue ace-icon fa fa-key bigger-125"></i>
										修改密码
									</a>
								</li>
							</ul>

							<div class="tab-content profile-edit-tab-content">
								<div id="edit-basic" class="tab-pane in active">
									<h4 class="header blue bolder smaller">基本信息</h4>

									<div class="row">
										<div class="vspace-12-sm"></div>

										<div class="col-xs-12 col-sm-8">
											<div class="form-group">
												<label class="col-sm-4 control-label no-padding-right" for="form-field-userName">姓名</label>

												<div class="col-sm-8">
													<input class="col-xs-12 col-sm-10" type="text" id="form-field-userName" placeholder="姓名" value="${sysuser.userName}" />
												</div>
											</div>
											
											<div class="space-4"></div>
											
											<div class="form-group">
												<label class="col-sm-4 control-label no-padding-right">性别</label>
		
												<div class="col-sm-8">
													<label class="inline">
														<input name="sex" type="radio" class="ace" value="1" <c:choose><c:when test="${sysuser.sex == 1}">checked</c:when></c:choose> />
														<span class="lbl middle">男</span>
													</label>
													&nbsp; &nbsp; &nbsp;
													<label class="inline">
														<input name="sex" type="radio" class="ace" value="2" <c:choose><c:when test="${sysuser.sex == 2}">checked</c:when></c:choose> />
														<span class="lbl middle">女</span>
													</label>
												</div>
											</div>
											
											<div class="space-4"></div>
											
											<div class="form-group">
												<label class="col-sm-4 control-label no-padding-right" for="form-field-birthday">生日</label>

												<div class="col-sm-8">
													<input class="col-xs-12 col-sm-10" type="text" id="form-field-birthday" placeholder="生日" value="${sysuser.birthday}" readonly />
												</div>
											</div>											
										</div>
									</div>

									<div class="space"></div>
									<h4 class="header blue bolder smaller">联系方式</h4>

									<div class="form-group">
										<label class="col-sm-3 control-label no-padding-right" for="form-field-email">邮箱</label>

										<div class="col-sm-9">
											<span class="input-icon input-icon-right" title="邮箱不可以更改">
												<input type="email" id="form-field-email" value="${sysuser.email}" readonly/>
												<i class="ace-icon fa fa-envelope"></i>
											</span>
										</div>
									</div>

									<div class="space-4"></div>

									<div class="form-group">
										<label class="col-sm-3 control-label no-padding-right" for="form-field-phone">联系电话</label>

										<div class="col-sm-9">
											<span class="input-icon input-icon-right">
												<input type="text" id="form-field-phone" value="${sysuser.phone}" />
												<i class="ace-icon fa fa-phone fa-flip-horizontal"></i>
											</span>
										</div>
									</div>

									<div class="space"></div>

								</div>

								<div id="edit-password" class="tab-pane">
									<div class="space-10"></div>

									<div class="form-group">
										<label class="col-sm-3 control-label no-padding-right" for="form-field-pass1">新密码</label>

										<div class="col-sm-9">
											<input type="password" id="form-field-pass1" />
										</div>
									</div>

									<div class="space-4"></div>

									<div class="form-group">
										<label class="col-sm-3 control-label no-padding-right" for="form-field-pass2">确认密码</label>

										<div class="col-sm-9">
											<input type="password" id="form-field-pass2" />
										</div>
									</div>
								</div>
							</div>
						</div>

						<div class="clearfix form-actions">
							<div class="col-md-offset-3 col-md-9">
								<button id="submitButton" class="btn btn-info" type="button">
									<i class="ace-icon fa fa-check bigger-110"></i>
									保存
								</button>
								&nbsp; &nbsp;
								<button class="btn" type="reset">
									<i class="ace-icon fa fa-undo bigger-110"></i>
									重置
								</button>
							</div>
						</div>
					</form>
				</div><!-- /.span -->
			</div><!-- /.user-profile -->
		</div>

		<!-- PAGE CONTENT ENDS -->
	</div><!-- /.col -->
</div><!-- /.row -->

<!-- page specific plugin scripts -->

<!--[if lte IE 8]>
  <script src="${contextPath}/static/assets/js/excanvas.js"></script>
<![endif]-->
<script type="text/javascript">
	var scripts = [null,"${contextPath}/static/assets/js/jquery-ui.custom.js","${contextPath}/static/assets/js/jquery.ui.touch-punch.js","${contextPath}/static/assets/js/jquery.gritter.js","${contextPath}/static/assets/js/date-time/bootstrap-datepicker.js","${contextPath}/static/assets/js/date-time/locales/bootstrap-datepicker.zh-CN.js","${contextPath}/static/assets/js/select2.js","${contextPath}/static/assets/js/x-editable/bootstrap-editable.js","${contextPath}/static/assets/js/x-editable/ace-editable.js", null]
	$('.page-content-area').ace_ajax('loadScripts', scripts, function() {
	    //inline scripts related to this page
	    jQuery(function($) {

	        //editables on first profile page
	        $.fn.editable.defaults.mode = 'inline';
	        $.fn.editableform.loading = "<div class='editableform-loading'><i class='ace-icon fa fa-spinner fa-spin fa-2x light-blue'></i></div>";
	        $.fn.editableform.buttons = '<button type="submit" class="btn btn-info editable-submit"><i class="ace-icon fa fa-check"></i></button>' +
	            '<button type="button" class="btn editable-cancel"><i class="ace-icon fa fa-times"></i></button>';

	        //select2 editable 实现网页文本即时编辑
	        $('#userName').editable({
                type: 'text',
                pk: ${id},
                name: 'userName',
                url: "${contextPath}" + "/sys/sysuser/updateSysUserField"
            });
	        var sexs = [];
	        $.each({
	            "1": "男",
	            "2": "女"
	        }, function(k, v) {
	            sexs.push({
	                id: k,
	                text: v
	            });
	        });
	        $('#sex').editable({
	            type: 'select2',
	            pk: ${id},
	            value: ${sex},
	            //onblur:'ignore',
	            source: sexs,
	            select2: {
	                'width': 140
	            },
	            name: 'sex',
	            url: "${contextPath}" + "/sys/sysuser/updateSysUserField",
	            success: function(response, newValue) {
	            }
	        });
	        //text editable
	        /**
	        $('#email').editable({
                type: 'text',
                pk: ${id},
                name: 'email',
                url: "${contextPath}" + "/sys/sysuser/updateSysUserField"
            });
	        **/
	        $('#phone').editable({
                type: 'text',
                pk: ${id},
                name: 'phone',
                url: "${contextPath}" + "/sys/sysuser/updateSysUserField"
            });
	        $('#birthday').editable({
                type: 'adate',
                pk: ${id},
                name: 'birthday',
                url: "${contextPath}" + "/sys/sysuser/updateSysUserField",
    			date: {
    				format: 'yyyy-mm-dd',
    				viewformat: 'yyyy-mm-dd',
    				weekStart: 1,
    				language: 'zh-CN'
    			}
            });
	    	$('#form-field-birthday').datepicker({
	    	    format: 'yyyy-mm-dd',
	    	    language: 'zh-CN'
	    	});

	        // *** editable avatar *** //
	        try { 
	        	//ie8 throws some harmless exceptions, so let's catch'em
	            //first let's add a fake appendChild method for Image element for browsers that have a problem with this
	            //because editable plugin calls appendChild, and it causes errors on IE at unpredicted points
	            try {
	                document.createElement('IMG').appendChild(document.createElement('B'));
	            } catch (e) {
	                Image.prototype.appendChild = function(el) {}
	            }

	            var last_gritter;
	            $('#avatar').editable({
	                type: 'image',
	                name: 'avatar',
	                value: null,
	                image: {
	                    //specify ace file input plugin's options here
	                    btn_choose: '更改头像',
	                    droppable: true,
	                    maxSize: 2097152, //~100Kb
	                    //and a few extra ones here
	                    name: 'avatar', //put the field name here as well, will be used inside the custom plugin
	                    on_error: function(error_type) { //on_error function will be called when the selected file has a problem
	                        if (last_gritter) $.gritter.remove(last_gritter);
	                        if (error_type == 1) { //file format error
	                            last_gritter = $.gritter.add({
	                                title: '文件格式不正确!',
	                                text: '请选择  jpg|gif|png 格式的图片!',
	                                class_name: 'gritter-error gritter-center'
	                            });
	                        } else if (error_type == 2) { //file size rror
	                            last_gritter = $.gritter.add({
	                                title: '文件太大!',
	                                text: '图片大小不能超过2mb!',
	                                class_name: 'gritter-error gritter-center'
	                            });
	                        } else { //other error
	                        }
	                    },
	                    on_success: function() {
	                        $.gritter.removeAll();
	                    }
	                },
	                url: function(params) {
	                    //for a working upload example you can replace the contents of this function with 
	                    //examples/profile-avatar-update.js

	                    //this is similar to the file-upload.html example
						//replace the code inside profile page where it says ***UPDATE AVATAR HERE*** with the code below
						// ***UPDATE AVATAR HERE*** //
						var submit_url = "${contextPath}" + "/sys/sysuser/uploadAttachement";//please modify submit_url accordingly
						var deferred = null;
						var avatar = '#avatar';
						
						//if value is empty (""), it means no valid files were selected
						//but it may still be submitted by x-editable plugin
						//because "" (empty string) is different from previous non-empty value whatever it was
						//so we return just here to prevent problems
						var value = $(avatar).next().find('input[type=hidden]:eq(0)').val();
						if(!value || value.length == 0) {
							deferred = new $.Deferred
							deferred.resolve();
							return deferred.promise();
						}
						
						var $form = $(avatar).next().find('.editableform:eq(0)')
						var file_input = $form.find('input[type=file]:eq(0)');
						var pk = $(avatar).attr('data-pk');//primary key to be sent to server
						
						var ie_timeout = null
						
						
						if( "FormData" in window ) {
							var formData_object = new FormData();//create empty FormData object
							
							//serialize our form (which excludes file inputs)
							$.each($form.serializeArray(), function(i, item) {
								//add them one by one to our FormData 
								formData_object.append(item.name, item.value);							
							});
							//and then add files
							$form.find('input[type=file]').each(function(){
								var field_name = $(this).attr('name');
								var files = $(this).data('ace_input_files');
								if(files && files.length > 0) {
									formData_object.append(field_name, files[0]);
								}
							});
						
							//append primary key to our formData
							formData_object.append('pk', pk);
						
							deferred = $.ajax({
										url: submit_url,
									   type: 'POST',
								processData: false,//important
								contentType: false,//important
								   dataType: 'json',//server response type
									   data: formData_object
							})
						}
						else {
							deferred = new $.Deferred
						
							var temporary_iframe_id = 'temporary-iframe-'+(new Date()).getTime()+'-'+(parseInt(Math.random()*1000));
							var temp_iframe = 
									$('<iframe id="'+temporary_iframe_id+'" name="'+temporary_iframe_id+'" \
									frameborder="0" width="0" height="0" src="about:blank"\
									style="position:absolute; z-index:-1; visibility: hidden;"></iframe>')
									.insertAfter($form);
									
							$form.append('<input type="hidden" name="temporary-iframe-id" value="'+temporary_iframe_id+'" />');
							
							//append primary key (pk) to our form
							$('<input type="hidden" name="pk" />').val(pk).appendTo($form);
							
							temp_iframe.data('deferrer' , deferred);
							//we save the deferred object to the iframe and in our server side response
							//we use "temporary-iframe-id" to access iframe and its deferred object
						
							$form.attr({
									  action: submit_url,
									  method: 'POST',
									 enctype: 'multipart/form-data',
									  target: temporary_iframe_id //important
							});
						
							$form.get(0).submit();
						
							//if we don't receive any response after 30 seconds, declare it as failed!
							ie_timeout = setTimeout(function(){
								ie_timeout = null;
								temp_iframe.attr('src', 'about:blank').remove();
								deferred.reject({'status':'fail', 'message':'Timeout!'});
							} , 30000);
						}
						
						
						//deferred callbacks, triggered by both ajax and iframe solution
						deferred.done(function(result) {//success
							var res = result;//the `result` is formatted by your server side response and is arbitrary
							if(res.status == 'OK') $(avatar).get(0).src = res.url;
							else alert(res.message);
						}).fail(function(result) {//failure
							alert("There was an error");
						}).always(function() {//called on both success and failure
							if(ie_timeout) clearTimeout(ie_timeout)
							ie_timeout = null;	
						});
						
						return deferred.promise();
	                    // ***END OF UPDATE AVATAR HERE*** //
	                },
	                success: function(response, newValue) {
	                	
	                }
	            })
	        } catch (e) {
	        	
	        }

	        /**
			//let's display edit mode by default?
			var blank_image = true;//somehow you determine if image is initially blank or not, or you just want to display file input at first
			if(blank_image) {
				$('#avatar').editable('show').on('hidden', function(e, reason) {
					if(reason == 'onblur') {
						$('#avatar').editable('show');
						return;
					}
					$('#avatar').off('hidden');
				})
			}
			*/

	        //right & left position
	        //show the user info on right or left depending on its position
	        $('#user-profile-2 .memberdiv').on('mouseenter touchstart', function() {
	            var $this = $(this);
	            var $parent = $this.closest('.tab-pane');
	            var off1 = $parent.offset();
	            var w1 = $parent.width();
	            var off2 = $this.offset();
	            var w2 = $this.width();
	            var place = 'left';
	            if (parseInt(off2.left) < parseInt(off1.left) + parseInt(w1 / 2)) place = 'right';
	            $this.find('.popover').removeClass('right left').addClass(place);
	        }).on('click', function(e) {
	            e.preventDefault();
	        });

	        ///////////////////////////////////////////
	        $('#user-profile-3').find('input[type=file]').ace_file_input({
                style: 'well',
                btn_choose: 'Change avatar',
                btn_change: null,
                no_icon: 'ace-icon fa fa-picture-o',
                thumbnail: 'large',
                droppable: true,
                allowExt: ['jpg', 'jpeg', 'png', 'gif'],
                allowMime: ['image/jpg', 'image/jpeg', 'image/png', 'image/gif']
            }).end().find('button[type=reset]').on(ace.click_event, function() {
                $('#user-profile-3 input[type=file]').ace_file_input('reset_input');
            }).end().find('.date-picker').datepicker().next().on(ace.click_event, function() {
                $(this).prev().focus();
            })

	        $('#user-profile-3').find('input[type=file]').ace_file_input('show_file_list', [{
	            type: 'image',
	            name: $('#avatar').attr('src')
	        }]);
	        
			////////////////////
			$("a[href='#edit-password']").on('shown.bs.tab', function (e) {
			});
			$('#submitButton').on('click', function() {
				if($('#form-field-pass1').val() != '' && ($('#form-field-pass1').val().length < 6 || $('#form-field-pass1').val().length > 14)){
					$.gritter.add({
		                title: '系统信息',
		                text: '新密码长度至少为6个字符，至多为14个字符',
		                class_name: 'gritter-warning gritter-center'
		            });
				}else if($('#form-field-pass1').val() != '' && $('#form-field-pass1').val() != $('#form-field-pass2').val()){
					$.gritter.add({
		                title: '系统信息',
		                text: '新密码和确认密码不一样，请重新输入',
		                class_name: 'gritter-warning gritter-center'
		            });
				}else if($('#form-field-pass1').val() != '' && $('#form-field-pass1').val() == $('#form-field-pass2').val()){
					$.ajax({
						dataType : "json",
						url : "${contextPath}" + "/sys/sysuser/resetPassword",
						type : "post",
						data : {
							password : $('#form-field-pass1').val()
						},
						complete : function(xmlRequest) {
							$.gritter.add({
				                title: '系统信息',
				                text: '密码修改成功',
				                class_name: 'gritter-success gritter-center'
				            });
						}
					});
				}else{
					$.ajax({
						dataType : "json",
						url : "${contextPath}" + "/sys/sysuser/saveSysUserProfile",
						type : "post",
						data : {
							sex : $("input[name='sex']:checked").val(),
							email : $('#form-field-email').val(),
							userName : $('#form-field-userName').val(),
							phone : $('#form-field-phone').val(),
							birthday: $('#form-field-birthday').val()
						},
						complete : function(xmlRequest) {
							$.gritter.add({
				                title: '系统信息',
				                text: '基本信息修改成功',
				                class_name: 'gritter-success gritter-center'
				            });
						}
					});					
				}
			});

	        ////////////////////
	        //change profile
	        $('[data-toggle="buttons"] .btn').on('click', function(e) {
	            var target = $(this).find('input[type=radio]');
	            var which = parseInt(target.val());
	            $('.user-profile').parent().addClass('hide');
	            $('#user-profile-' + which).parent().removeClass('hide');
	        });

	        /////////////////////////////////////
	        $(document).one('ajaxloadstart.page', function(e) {
	            //in ajax mode, remove remaining elements before leaving page
	            try {
	                $('.editable').editable('destroy');
	            } catch (e) {}
	            $('[class*=select2]').remove();
	        });
	    });

	});
</script>
