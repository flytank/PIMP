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
		个人资料
	</h1>
</div><!-- /.page-header -->

<div class="row">
	<div class="col-xs-12">
		<!-- PAGE CONTENT BEGINS -->
		<div class="clearfix">

		</div>

		<div>
			<div class="hide">
				<div class="col-xs-12 col-sm-9">
					<!-- #section:pages/profile.info -->
					<div class="profile-user-info profile-user-info-striped">
						<div class="profile-info-row">
							<div class="profile-info-name">性别 </div>
							<div class="profile-info-value">
								<span class="editable" id="sex">
									<c:set var="id" value="${sysuser.id}" />
									<c:set var="sex" value="${sysuser.sex}" />
									<%-- <c:choose>
										<c:when test="${sysuser.sex == 1}">男</c:when>
										<c:otherwise>女</c:otherwise>
									</c:choose> --%>
								</span>
							</div>
						</div>
						

					</div>

					<!-- /section:pages/profile.info -->
					<div class="space-20"></div>

				</div>
			</div>
		</div>

		<div class="">
			<div id="user-profile-3" class="user-profile row">
				<div class="col-sm-offset-1 col-sm-10">

					<div class="space"></div>

					<form class="form-horizontal">
						<input id="userId" type="hidden" value="${sysuser.id}"/>
						<div class="tabbable">
							<ul class="nav nav-tabs padding-16">
								<li class="active">
									<a data-toggle="tab" href="#edit-basic">
										<i class="green ace-icon fa fa-pencil-square-o bigger-125"></i>
										基本信息
									</a>
								</li>

								<li id="editPassword">
									<a data-toggle="tab" href="#edit-password">
										<i class="blue ace-icon fa fa-key bigger-125"></i>
										修改密码
									</a>
								</li>
							</ul>

							<div class="tab-content profile-edit-tab-content">
								<div id="edit-basic" class="tab-pane in active">
									<div class="space-10"></div>
									<div class="space-10"></div>
									<div class="space-10"></div>

									<div class="row">
										<div class="vspace-12-sm"></div>

										<div class="col-xs-12 col-sm-8">
											<div class="form-group">
												<label class="col-sm-4 control-label no-padding-right" for="form-field-dlmc">登录名称</label>

												<div class="col-sm-8">
													<input class="col-xs-12 col-sm-10" type="text" id="form-field-dlmc" placeholder="" value="${sysuser.loginName}" disabled="disabled" />
												</div>
											</div>
											<div class="form-group">
												<label class="col-sm-4 control-label no-padding-right" for="form-field-userName" >姓名</label>

												<div class="col-sm-8">
													<input class="col-xs-12 col-sm-10" type="text" id="form-field-userName" placeholder="" value="${sysuser.userName}" disabled="disabled"/>
												</div>
											</div>
											<div class="form-group">
												<label class="col-sm-4 control-label no-padding-right" for="form-field-idCard" >身份证号</label>

												<div class="col-sm-8">
													<input class="col-xs-12 col-sm-10" type="text" id="form-field-idCard" placeholder="" value="${sysuser.idCard}" disabled="disabled"/>
												</div>
											</div>
											<div class="space-4"></div>
											
											<div class="form-group">
												<label class="col-sm-4 control-label no-padding-right">性别</label>
		
												<div class="col-sm-8">
													<label class="inline">
														<input name="sex" type="radio" class="ace" value="1" 
														<c:choose><c:when test="${sysuser.sex == '男'}">checked</c:when></c:choose> 
														disabled="disabled"/>
														<span class="lbl middle">男</span>
													</label>
													&nbsp; &nbsp; &nbsp;
													<label class="inline">
														<input name="sex" type="radio" class="ace" value="2" 
														<c:choose><c:when test="${sysuser.sex == '女'}">checked</c:when></c:choose> 
														disabled="disabled"/>
														<span class="lbl middle">女</span>
													</label>
													&nbsp; &nbsp; &nbsp;
													<label class="inline">
														<input name="sex" type="radio" class="ace" value="9" 
														<c:choose><c:when test="${sysuser.sex != '男' && sysuser.sex != '女'}">checked</c:when></c:choose> 
														disabled="disabled"/>
														<span class="lbl middle">未知</span>
													</label> 
												</div>
											</div>
											
											<div class="space-4"></div>
											
											<div class="form-group">
												<label class="col-sm-4 control-label no-padding-right" for="form-field-birthday">生日</label>

												<div class="col-sm-8">
													<input class="col-xs-12 col-sm-10" type="text" id="form-field-birthday" placeholder="" value="${sysuser.birthday}" disabled="disabled" />
												</div>
											</div>			
											<div class="space-4"></div>
											
											<div class="form-group">
												<label class="col-sm-4 control-label no-padding-right" for="form-field-education" >学历</label>

												<div class="col-sm-8">
													<input class="col-xs-12 col-sm-10" type="text" id="form-field-education" placeholder="" value="${sysuser.education}" disabled="disabled"/>
												</div>
											</div>
											<div class="space-4"></div>
											
											<div class="form-group">
												<label class="col-sm-4 control-label no-padding-right" for="form-field-position" >职位</label>

												<div class="col-sm-8">
													<input class="col-xs-12 col-sm-10" type="text" id="form-field-position" placeholder="" value="${sysuser.position}" disabled="disabled"/>
												</div>
											</div>
											<%-- <div class="form-group">
												<label class="col-sm-4 control-label no-padding-right"
													for="phone">联系电话</label>

												<div class="col-sm-8">
													<span class="input-icon input-icon-right"> <input
														type="text" id="phone" value="${sysuser.lxdh}"
														name="phone" /> <i
														class="ace-icon fa fa-phone fa-flip-horizontal"></i>
													</span>
												</div>
											</div>  --%>

											<%-- <div class="space-4"></div>
											<div class="form-group">
												<label class="col-sm-4 control-label no-padding-right"
													for="address">详细地址</label>

												<div class="col-sm-8">
													<span class="input-icon input-icon-right"> <input
														type="text" id="address" value="${sysuser.xxdz}"
														name="address" /> <i
														class="ace-icon fa fa-location-arrow fa-flip-horizontal"></i>
													</span>
												</div>
											</div> --%>
										</div>
									</div>
								</div>

								<div id="edit-password" class="tab-pane">
									<div class="space-10"></div>
									<div class="form-group">
										<label class="col-sm-3 control-label no-padding-right" for="old_password">原密码</label>

										<div class="col-sm-9">
											<div class="clearfix">
												<input type="password" id="old_password" name="old_password"/>
											</div>
										</div>
									</div>

									<div class="space-4"></div>
									<div class="form-group">
										<label class="col-sm-3 control-label no-padding-right" for="password">新密码</label>

										<div class="col-sm-9">
											<div class="clearfix">
												<input type="password" id="password" name="password"/>
											</div>
										</div>
									</div>

									<div class="space-4"></div>

									<div class="form-group">
										<label class="col-sm-3 control-label no-padding-right" for="confirm_password">确认密码</label>

										<div class="col-sm-9">
											<div class="clearfix">
												<input type="password" id="confirm_password" name="confirm_password"/>
											</div>
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
								<button class="btn btn-info" type="reset">
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
	var scripts = [null,"${contextPath}/static/assets/js/jquery-ui.custom.js",
	               "${contextPath}/static/assets/js/jquery.ui.touch-punch.js",
	               "${contextPath}/static/assets/js/jquery.gritter.js",
	               "${contextPath}/static/assets/js/date-time/bootstrap-datepicker.js",
	               "${contextPath}/static/assets/js/date-time/locales/bootstrap-datepicker.zh-CN.js",
	               "${contextPath}/static/assets/js/select2.js",
	               "${contextPath}/static/assets/js/x-editable/bootstrap-editable.js",
	               "${contextPath}/static/assets/js/x-editable/ace-editable.js",
	               "${contextPath}/static/assets/js/jquery.validate.js",
	               "${contextPath}/static/assets/js/jquery.maskedinput.js", null]
	$('.page-content-area').ace_ajax('loadScripts', scripts, function() {
	    //inline scripts related to this page
	    jQuery(function($) {

	        //editables on first profile page
	        $.fn.editable.defaults.mode = 'inline';
	        $.fn.editableform.loading = "<div class='editableform-loading'><i class='ace-icon fa fa-spinner fa-spin fa-2x light-blue'></i></div>";
	        $.fn.editableform.buttons = '<button type="submit" class="btn btn-info editable-submit"><i class="ace-icon fa fa-check"></i></button>' +
	            '<button type="button" class="btn editable-cancel"><i class="ace-icon fa fa-times"></i></button>';
			/**
	            // 管理员 不修改密码 add by xuanhy 2015-7-24
	        if($('#userId').val() == '1') {
	        	$('#editPassword').attr('style', 'display:none');
	        } else {
	        	$('#editPassword').removeAttr('style');
	        }
			**/
	        
	        //select2 editable 实现网页文本即时编辑
	        /* $('#xm').editable({
                type: 'text',
                pk: '${id}',
                name: 'xm',
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
	            pk: '${id}',
	            value: '${sex}',
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
	    	$('#form-field-birthday').datepicker({
	    	    format: 'yyyy-mm-dd',
	    	    language: 'zh-CN'
	    	});


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
			
			/* $.mask.definitions['~']='[+-]';
			jQuery.validator.addMethod("phone", function (value, element) {
				var format = /^(0|86|17951)?(13[0-9]|15[012356789]|17[0678]|18[0-9]|14[57])[0-9]{8}$/;
				var mobile = /^(((13[0-9]{1})|(15[0-9]{1}))+\d{8})$/; 
				var tel = /^\d{3,4}-?\d{7,9}$/; 
				return this.optional(element) || (tel.test(value) || mobile.test(value) || format.test(value)); 
			}, "请输入合法的联系电话");
			jQuery.validator.addMethod("address", function(value, element){
				return this.optional(element) || /^[\w\u4e00-\u9fa5]++$/.test(value);
			}, "输入包括空格或特殊字符不合法，请重新输入"); */
			
			$('.form-horizontal').validate({
				errorElement: 'div',
				errorClass: 'help-block',
				focusInvalid: false,
				ignore: "",
				onsubmit: true,
				rules: {
					password: {
						required: true,
						minlength: 6,
						maxlength: 16
					},
					confirm_password: {
						required: true,
						minlength: 6,
						maxlength: 16,
						equalTo: "#password"
					}/*,
					phone: {
						required: true,
						phone: 'required'
					},
					address :{
						required: true,
						address: 'required'
					}*/
				},
				messages: {
					password: {
						required: "请输入一个密码.",
						minlength:$.validator.format("新密码长度至少为{0}个字符"),
						maxlength:$.validator.format("新密码长度至多为{0}个字符")
					},
					confirm_password: {
						required: "请输入确认密码.",
						minlength:$.validator.format("确认密码长度至少为{0}个字符"),
						maxlength:$.validator.format("确认密码长度至多为{0}个字符"),
						equalTo: "新密码和确认密码不一样，请重新输入"
					}/*,
					phone : {
						required: "请输入联系电话."
					},
					address : {
						required: "请输入联系地址."
					}*/
				},
				highlight: function (e) {
					$(e).closest('.form-group').addClass('has-error');
				},
				success: function (e) {
					$(e).closest('.form-group').removeClass('has-error');//.addClass('has-info');
 					//$(e).remove();
				},
				errorPlacement: function (error, element) {
					if(element.is('input[type=checkbox]') || element.is('input[type=radio]')) {
						var controls = element.closest('div[class*="col-"]');
						if(controls.find(':checkbox,:radio').length > 1) controls.append(error);
						else error.insertAfter(element.nextAll('.lbl:eq(0)').eq(0));
					}
					else if(element.is('.select2')) {
						error.insertAfter(element.siblings('[class*="select2-container"]:eq(0)'));
					}
					else if(element.is('.chosen-select')) {
						error.insertAfter(element.siblings('[class*="chosen-container"]:eq(0)'));
					}
					else error.insertAfter(element.parent());
				},
				invalidHandler: function (form) {
				},
				submitHandler: function (form) {
				}
			});
			
			$('#submitButton').on('click', function() {
				if ($("#editPassword").html().indexOf('aria-expanded="true"') > -1) {
					var password = /^[a-zA-z0-9_]{6,}$/
					if(!password.test($('#password').val()) ){  
						promptInfo("密码只能包含数字、字母及下划线，请重新输入","warning,center");
						return false;  
				    } 
					if($('#password').val() != $('#confirm_password').val()){  
						promptInfo("两次密码不一样，请重新输入","warning,center");
						return false;  
				    } 
					if($('#password').val() != '' && $('#password').val() == $('#confirm_password').val()&& $('#password').val().length>=6){
						$.ajax({
							dataType : "json",
							url : "${contextPath}/sys/sysuser/updatePassword",
							type : "post",
							data : {
								old_password : $("#old_password").val(),
								password : $('#password').val()
							},
							success : function(xmlRequest) {
								promptInfo(xmlRequest.success,"success,center");
							}
						});
					} else if ($('#password').val() == '' || $('#confirm_password').val() == ''||$('#password').val().length<6) {
						var text = "";
						if ($('#password').val() == '') {
							text = "请输入密码";
						} else if ($('#confirm_password').val() == '') {
							text = "请输入确认密码";
						}else if ($('#password').val().length<6) {
							text = "密码长度应至少为6个字符";
						}
						promptInfo(text,"warning,center");
						return false;
					} else {
						return false;
					}
				} else {
					var format = /^(0|86|17951)?(13[0-9]|15[012356789]|17[0678]|18[0-9]|14[57])[0-9]{8}$/;
					var moblie = /^(((13[0-9]{1})|(15[0-9]{1}))+\d{8})$/;  
					var tel =/^\d{3,4}-?\d{7,9}$/;
					if($('#phone').val().trim()==''||!format.test($('#phone').val().trim())){  
						promptInfo("请输入合法的联系电话","warning,center");
						return false;  
				    } 
					var addr =  /^[\u4e00-\u9fa5][0-9a-zA-Z\u4e00-\u9fa5]*$/;
					if($('#address').val().trim()=='' || !addr.test($('#address').val().trim()) ){  
						promptInfo("输入必须以汉字开，且不能输入空格或特殊字符，请重新输入","warning,center");
						return false;  
				    } 
					if ($("#phone").val().trim()!="" && $("#address").val().trim()!="") {
						$.ajax({
							dataType : "json",
							url : "${contextPath}/sys/sysuser/saveSysUserProfile",
							type : "post",
							data : {
								sex : $("input[name='sex']:checked").val(),
								dlmc : $('#form-field-dlmc').val(),
								userName : $('#form-field-userName').val(),
								birthday: $('#form-field-birthday').val(),
								phone : $('#phone').val(),
								address : $('#address').val()
							},
							success : function(data) {
								promptInfo("基本信息修改成功","success,center");
							}
						});
					} else {
						var text = "";
						if ($('#phone').val() == '') {
							text = "请输入手机号";
						} else if ($('#address').val() == '') {
							text = "请输入地址";
						}
						promptInfo(text,"warning,center");
					}
				}
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
