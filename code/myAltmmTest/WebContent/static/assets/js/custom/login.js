function getContextPath() {
	var pathName = document.location.pathname;
	var index = pathName.substr(1).indexOf("/");
	var result = pathName.substr(0, index + 1);
	return result;
}

jQuery(function($) {
	$(document).on('click', '.toolbar a[data-target]', function(e) {
		e.preventDefault();
		var target = $(this).data('target');
		$('.widget-box.visible').removeClass('visible');// hide others
		$(target).addClass('visible');// show target
	});

	// 登录页面切换背景图
	$('#btn-login-dark').on('click', function(e) {
		$('body').attr('class', 'login-layout');
		e.preventDefault();
	});
	$('#btn-login-light').on('click', function(e) {
		$('body').attr('class', 'login-layout light-login');
		e.preventDefault();
	});
	$('#btn-login-blur').on('click', function(e) {
		$('body').attr('class', 'login-layout blur-login');
		e.preventDefault();
	});

	// 验证找回密码表单
	$("#retrieveButton").bind("click", function() {
		$('#validationRetrieveForm').submit();
	});
	$('#validationRetrieveForm').validate({
		errorElement : 'div',
		errorClass : 'help-block',
		focusInvalid : false,
		ignore : "",
		rules : {
			email : {
				required : true,
				email : true
			}
		},
		messages : {
			email : {
				required : "请填写邮箱",
				email : "请填写正确的邮箱"
			}
		},
		highlight : function(e) {
			$(e).closest('label').removeClass('has-info').addClass('has-error');
		},
		success : function(e) {
			$(e).closest('label').removeClass('has-error');// .addClass('has-info');
			$(e).remove();
		},
		errorPlacement : function(error, element) {
			error.insertAfter(element.parent());
		},
		submitHandler : function(form) {
			$.ajax({
				dataType : "json",
				url : getContextPath() + "/sys/sysuser/retrievePassword",
				type : "post",
				data : {
					email : $('#retrieveEmail').val()
				},
				complete : function(xmlRequest) {
					var returninfo = eval("(" + xmlRequest.responseText + ")");
					if (returninfo.result == 1) {
						$("#retrieveTip").html("找回密码邮件已经发到你的邮箱");
					} else if (returninfo.result == -1) {
						$("#retrieveTip").html("密保邮箱不存在，请重新输入");
					}
				}
			});
		},
		invalidHandler : function(form) {
		}
	});

	// 按回车键触发登录事件
	$(document).keydown(function(event) {
		var key = window.event ? event.keyCode : event.which;
		if (key == 13) {
			$('#validationLoginForm').submit();
		}
	});

	// 验证登录表单
	$("#loginButton").bind("click", function() {
		$('#validationLoginForm').submit();
	});
	$('#validationLoginForm').validate({
		errorElement : 'div',
		errorClass : 'help-block',
		focusInvalid : false,
		ignore : "",
		rules : {
			email : {
				required : true,
				email : true
			},
			password : {
				required : true,
				minlength : 6,
				maxlength : 14
			}
		},
		messages : {
			email : {
				required : "请填写邮箱",
				email : "请填写正确的邮箱"
			},
			password : {
				required : "请输入密码",
				minlength : "密码长度至少为6个字符",
				maxlength : "密码长度至多为14个字符"
			}
		},
		highlight : function(e) {
			$(e).closest('label').removeClass('has-info').addClass('has-error');
		},
		success : function(e) {
			$(e).closest('label').removeClass('has-error');// .addClass('has-info');
			$(e).remove();
		},
		errorPlacement : function(error, element) {
			error.insertAfter(element.parent());
			//error.appendTo('#invalid');
		},
		submitHandler : function(form) {
			$.ajax({
				dataType : "json",
				url : getContextPath() + "/sys/sysuser/login",
				type : "post",
				data : {
					email : $('#loginEmail').val(),
					password : $('#loginPassword').val()
				},
				complete : function(xmlRequest) {
					var returninfo = eval("(" + xmlRequest.responseText + ")");
					if (returninfo.result == 1) {
						document.location.href = getContextPath() + "/sys/sysuser/home";
					} else if (returninfo.result == -1) {
						$("#loginTip").html("用户名有误或已被禁用");
					} else if (returninfo.result == -2) {
						$("#loginTip").html("密码错误");
					} else {
						$("#loginTip").html("服务器错误");
					}
				}
			});
		},
		invalidHandler : function(form) {
		}
	});

	$('[data-rel=tooltip]').tooltip({
		container : 'body'
	});
	
	$('#birthday').datepicker({
	    format: 'yyyy-mm-dd',
	    language: 'zh-CN'
	});

	// 验证注册表单
	$("#registerButton").bind("click", function() {
		$('#validationRegisterForm').submit();
	});
	$('#validationRegisterForm').validate({
		errorElement : 'div',
		errorClass : 'help-block',
		focusInvalid : false,
		ignore : "",
		rules : {
			userName : {
				required : true,
				maxlength : 40
			},
			sex : {
				required : true
			},
			email : {
				required : true,
				email : true,
				maxlength : 30
			},
			phone : {
				required : false,
				maxlength : 20
			},
			birthday : {
				required : false
			},
			password : {
				required : true,
				minlength : 6,
				maxlength : 14
			},
			repeatPassword : {
				required : true,
				minlength : 6,
				maxlength : 14,
				equalTo : "#password"
			},
			agree : {
				required : true,
			}
		},
		messages : {
			userName : {
				required : "请填写姓名",
				maxlength : "姓名长度至多为40个字符"
			},
			sex : "请选择性别",
			email : {
				required : "请填写邮箱",
				email : "请填写正确的邮箱",
				maxlength : "邮箱长度至多为30个字符"
			},
			phone : {
				required : "请填写联系电话",
				maxlength : "联系电话长度至多为20个字符"
			},
			password : {
				required : "请输入密码",
				minlength : "密码长度至少为6个字符",
				maxlength : "密码长度至多为14个字符"
			},
			repeatPassword : {
				required : "请输入确认密码",
				minlength : "确认密码长度至少为6个字符",
				maxlength : "确认密码长度至多为14个字符",
				equalTo : "密码和确认密码不一致"
			},
			agree : "您还未接受用户协议"
		},
		highlight : function(e) {
			$(e).closest('label').removeClass('has-info').addClass('has-error');
		},
		success : function(e) {
			$(e).closest('label').removeClass('has-error');// .addClass('has-info');
			$(e).remove();
		},
		errorPlacement : function(error, element) {
			error.insertAfter(element.parent());
		},
		submitHandler : function(form) {
			$.ajax({
				dataType : "json",
				url : getContextPath() + "/sys/sysuser/register",
				type : "post",
				data : {
					userName : $('#userName').val(),
					sex : $("input[name='sex']:checked").val(),
					email : $('#email').val(),
					phone : $('#phone').val(),
					birthday : $('#birthday').val(),
					password : $('#password').val()
				},
				complete : function(xmlRequest) {
					var returninfo = eval("(" + xmlRequest.responseText + ")");
					if (returninfo.result == 1) {
						document.location.href = getContextPath() + "/sys/sysuser/home";
					} else if (returninfo.result == -1) {
						$("#registerTip").html("此邮箱已被注册");
					} else {
						$("#registerTip").html("服务器错误");
					}
				}
			});
		},
		invalidHandler : function(form) {
		}
	});
});
