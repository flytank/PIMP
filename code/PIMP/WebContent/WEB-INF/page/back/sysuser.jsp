<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}"></c:set>

<link rel="stylesheet" href="${contextPath}/static/assets/css/jquery-ui.css" />
<link rel="stylesheet" href="${contextPath}/static/assets/css/datepicker.css" />
<link rel="stylesheet" href="${contextPath}/static/assets/css/ui.jqgrid.css" />
<link rel="stylesheet" href="${contextPath}/static/assets/css/bootstrap-datetimepicker.css" />
<link rel="stylesheet" href="${contextPath}/static/assets/css/jquery.gritter.css" />

<script type="text/javascript">
	$(function(){
		$("#queryTownID").ready(function(){
			$("#queryTownID").change(function() {
				var queryTownID = $("#queryTownID").val();
				if("" != queryTownID){
					$.ajax({
						type : "POST",
						url : "${contextPath}/sys/resource/getVillageListByTownID",
						data : {
							townID : queryTownID
						},
						success : function(data) {
							var dataObj = eval("(" + data + ")");
							$("#queryVillageID").empty();
							var ui = "<option value=''>-请选择-</option>";
							$("#queryVillageID").append(ui);
							$.each(dataObj, function(i, item) {
								var ui = "<option value='"+item.id+"'>"
										+ item.name + "</option>"
								$("#queryVillageID").append(ui);
							})
						}
					});
					document.getElementById("queryVillageID").disabled = false;
				}else{
					document.getElementById("queryVillageID").disabled = true;
				}
			});
		})
		
		$("#query").on("click", function() {
			var jsonData = "{'rules':[";
			var queryTownID = $("#queryTownID").val().trim();
			if (queryTownID!=null && queryTownID!='') {
				jsonData += "{'field' : 'townID', 'op' : 'eq', 'data' : '" + encodeURI(queryTownID) + "'},";
			}
			var queryVillageID = $("#queryVillageID").val();
			if (queryVillageID!=null && queryVillageID!='') {
				jsonData += "{'field' : 'villageID', 'op' : 'eq', 'data' : '" + encodeURI(queryVillageID) + "'},";
			}
			var queryLoginName = $("#queryLoginName").val();
			if (queryLoginName!=null && queryLoginName!='') {
				jsonData += "{'field' : 'loginName', 'op' : 'cn', 'data' : '" + queryLoginName + "'},";
			}
			var queryUserName = $("#queryUserName").val();
			if (queryUserName!=null && queryUserName!='') {
				jsonData += "{'field' : 'userName', 'op' : 'cn', 'data' : '" + queryUserName + "'},";
			}
			var queryIDCard = $("#queryIDCard").val();
			if (queryIDCard!=null && queryIDCard!='') {
				jsonData += "{'field' : 'IDCard', 'op' : 'cn', 'data' : '" + queryIDCard + "'}";
			}
			jsonData += "], 'groupOp':'AND'}";
			$("#grid-table").jqGrid('setGridParam',{
		        datatype:'json',
		        postData:{'filters':jsonData}, //发送数据
		        page:1
		    }).trigger("reloadGrid"); //重新载入
		});
		$("#queryLoginName").keydown(function(event) {
		    if (event.keyCode == "13") {
		        $('#query').click();
		    }
		}); 
		$("#queryUserName").keydown(function(event) {
		    if (event.keyCode == "13") {
		        $('#query').click();
		    }
		}); 
		$("#queryIDCard").keydown(function(event) {
		    if (event.keyCode == "13") {
		        $('#query').click();
		    }
		}); 
		$("#reset").on("click", function() {
			$("#queryTownID").val("");
			$("#queryVillageID").val("");
			$("#queryLoginName").val("");
			$("#queryUserName").val("");
			$("#queryIDCard").val("");
			$("#grid-table").jqGrid('setGridParam',{
		        datatype:'json',
		        postData:{'filters':''}, //发送数据
		        page:1
		    }).trigger("reloadGrid"); //重新载入
		});
	})
</script>
<div class="row">
	<div class="col-xs-12">
		<div class="well well-sm">
			<label>乡镇：</label> 
			<select id="queryTownID" name="queryTownID"></select>
			<label>村</label> 
			<select id="queryVillageID" name="queryVillageID" disabled="disabled"></select>
			<label>登录名称：</label> 
			<input id="queryLoginName" name="queryLoginName" size="10" class="cond-input-text"/>
			<label>用户姓名：</label> 
			<input id="queryUserName" name="queryUserName" size="10" class="cond-input-text"/>
			<label>身份证：</label> 
			<input id="queryIDCard" name="queryIDCard" size="10" class="cond-input-text"/>
			<input  id="query" name="query" class="btn btn-sm btn-primary"   type="button" value="查询" />
			<input  id="reset" name="reset" class="btn btn-sm btn-primary"   type="button" value="重置" />
		</div>
		<table id="grid-table"></table>

		<div id="grid-pager"></div>

		<script type="text/javascript">
			var $path_base = "${contextPath}/static";//in Ace demo this will be used for editurl parameter
		</script>

		<!-- PAGE CONTENT ENDS -->
	</div><!-- /.col -->
</div><!-- /.row -->
<div id="modal-table" class="modal fade" tabindex="-1" data-backdrop="static">
	<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header no-padding">
					<div class="table-header">
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true">
							<span class="white">&times;</span>
						</button>
						用户信息
					</div>
				</div>
				<div class="modal-body" style="max-height: 500px;overflow-y: scroll;">
					<div id="modal-tip" class="red clearfix"></div>
					<input id="selectUserID" name="selectUserID" type="hidden" /><!-- 党小组ID -->
					<div class="widget-box widget-color-blue2">
						<div class="widget-body">
							<div class="widget-main padding-8">
							  <form id="validationAddUserForm" method="post" action="#">
								<table id="information" class="table table-striped table-bordered table-hover">
        			            	<tr>
        			            	<td class='hidden-480' width='110px' >登录名</td>
									<td><input type='text' id='selectLoginName' name='selectLoginName' size='40' class='form-control limited' maxlength='40'></td>
									</tr>
									<tr>
        			            	<td class='hidden-480' width='110px'>姓名</td>
									<td><input type='text' id='selectUserName' name='selectUserName' size='40' class='form-control limited' maxlength='50'></td>
									</tr>
									<tr>
        			            	<td class='hidden-480' width='110px'>身份证</td>
									<td><input type='text' id='selectIDCard' name='selectIDCard' size='40' class='form-control limited' maxlength='18'></td>
									</tr>
									<tr>
									<td class='hidden-480' width='110px'>性别</td>
									<td>
										<select id='selectSex' name='selectSex'>
											<option value=''>-请选择-</option>
											<option value="男">男</option>
											<option value="女">女</option>
										</select>
									</td>
									</tr>
									<tr>
        			            	<td class='hidden-480' width='110px'>出生日期</td>
									<td><input id='selectBirthday' name='selectBirthday' size='40' class="cond-input-date" ></td>
									</tr>
									<tr>
        			            	<td class='hidden-480' width='110px'>学历</td>
									<td>
										<select id='selectEducation' name='selectEducation'>
											<option value=''>-请选择-</option>
											<option value="小学">小学</option>
											<option value="初中">初中</option>
											<option value="中专/高中">中专/高中</option>
											<option value="专科">专科</option>
											<option value="本科">本科</option>
											<option value="硕士研究生">硕士研究生</option>
											<option value="博士研究生">博士研究生</option>
											<option value="博士后">博士后</option>
										</select>
									</td>
									</tr> 
									<tr>
        			            	<td class='hidden-480' width='110px'>职位</td>
									<td><input type='text' id='selectPosition' name='selectPosition' size='40' class='form-control limited' maxlength='50'></td>
									</tr>
									<tr>
									<td class='hidden-480' width='110px'>乡镇</td>
									<td><select id='selectTownID' name='selectTownID'></select></td>
									</tr>
									<tr>
									<td class='hidden-480' width='110px'>村</td>
									<td><select id='selectVillageID' name='selectVillageID'></select></td>
									</tr>
									<tr>
									<td class='hidden-480' width='110px'>身份</td>
									<td>
										<select id='selectIdentity' name='selectIdentity'>
											<option value=''>-请选择-</option>
											<option value="1">党员</option>
											<option value="2">入党积极分子</option>
											<option value="3">群众</option>
										</select>
									</td>
									</tr>
									<tr>
									<td class='hidden-480' width='110px'>党小组</td>
									<td><select id='selectTeamID' name='selectTeamID'></select></td>
									</tr>
									<tr>
									<td class='hidden-480' width='110px'>党员类别</td>
									<td><select id='selectSortID' name='selectSortID'></select></td>
									</tr>
									<tr>
									<td class='hidden-480' width='110px'>角色</td>
									<td><select id='selectRole' name='selectRole'></select></td>
									</tr>
									<tr>
									<td class='hidden-480' width='110px'>状态</td>
									<td>
										<select id='selectStatus' name='selectStatus'>
											<option value=''>-请选择-</option>
											<option value="1">已激活</option>
											<option value="2">未激活</option>
											<option value="3">停用</option>
										</select>
									</td>
									</tr>
								</table>
							  </form>								
							</div>
						</div>
					</div>
				</div>
				<div class="modal-footer no-margin-top">
					<div class="text-center">
						<button id="submitButton" type="submit" class="btn btn-app btn-success btn-xs">
							<i class="ace-icon fa fa-floppy-o bigger-160"></i>
							保存
						</button>
						<button class="btn btn-app btn-pink btn-xs" data-dismiss="modal">
							<i class="ace-icon fa fa-share bigger-160"></i>
							取消
						</button>
					</div>
				</div> 
			</div><!-- /.modal-content -->
	</div><!-- /.modal-dialog -->
</div>
<!-- page specific plugin scripts -->
<script type="text/javascript">
		var scripts = [ null, 
		                "${contextPath}/static/assets/js/date-time/moment.zh-cn.js",
		                "${contextPath}/static/assets/js/date-time/bootstrap-datepicker.js", 
		                "${contextPath}/static/assets/js/date-time/locales/bootstrap-datepicker.zh-CN.js", 
		                "${contextPath}/static/assets/js/date-time/bootstrap-datetimepicker.js",
		                "${contextPath}/static/assets/js/jqGrid/jquery.jqGrid.js", 
		                "${contextPath}/static/assets/js/jqGrid/i18n/grid.locale-cn.js",
		                "${contextPath}/static/assets/js/jquery.gritter.js",
		                null ];
		$(function(){
			$("#selectTownID").ready(function() {
				$.ajax({
					type : "POST",
					url : "${contextPath}/sys/resource/getTownListByZoneID",
					data : {
						zoneID : '0001'
					},
					success : function(data) {
						var dataObj = eval("(" + data + ")");
						$("#selectTownID").empty();
						var ui = "<option value=''>-请选择-</option>";
						$("#selectTownID").append(ui);
						$("#queryTownID").append(ui);
						$.each(dataObj, function(i, item) {
							var ui = "<option value='"+item.id+"'>"
									+ item.name + "</option>"
							$("#selectTownID").append(ui);
							$("#queryTownID").append(ui);
						})
						var selectTownID = $("#selectTownID").val();
						$.ajax({
							type : "POST",
							url : "${contextPath}/sys/resource/getVillageListByTownID",
							data : {
								townID : selectTownID
							},
							success : function(data) {
								var dataObj = eval("(" + data + ")");
								$("#selectVillageID").empty();
								var ui = "<option value=''>-请选择-</option>";
								$("#selectVillageID").append(ui);
								$.each(dataObj, function(i, item) {
									var ui = "<option value='"+item.id+"'>"
											+ item.name + "</option>"
									$("#selectVillageID").append(ui);
								})
							}
						});
					}
				});
				$("#selectTownID").change(function() {
					var selectTownID = $("#selectTownID").val();
					if("" != selectTownID){
						$.ajax({
							type : "POST",
							url : "${contextPath}/sys/resource/getVillageListByTownID",
							data : {
								townID : selectTownID
							},
							success : function(data) {
								var dataObj = eval("(" + data + ")");
								$("#selectVillageID").empty();
								var ui = "<option value=''>-请选择-</option>";
									$("#selectVillageID").append(ui);
								$.each(dataObj, function(i, item) {
									var ui = "<option value='"+item.id+"'>"
											+ item.name + "</option>"
									$("#selectVillageID").append(ui);
								})
							}
						});
						document.getElementById("selectVillageID").disabled = false;
					}else{
						$("#selectVillageID").empty();
						document.getElementById("selectVillageID").disabled = true;
						$("#selectTeamID").empty();
						document.getElementById("selectTeamID").disabled = true;//党小组不可操作
					}
					var selectIdentity = $("#selectIdentity").val();
					var selectVillageID = $("#selectVillageID").val();
					if('' == selectIdentity || 3 == selectIdentity 
							|| '' == selectTownID || '' == selectVillageID){//身份不是党员或者入党积极分子
						document.getElementById("selectTeamID").disabled = true;//党小组不可操作
					}else{
						document.getElementById("selectTeamID").disabled = false;//党小组可操作
					}
				});
			})
			$("#selectVillageID").ready(function() {
				$("#selectVillageID").change(function(){
					var selectTownID = $("#selectTownID").val();
					var selectVillageID = $("#selectVillageID").val();
					if(""!=selectVillageID)
					{
						$.ajax({
							type : "POST",
							url : "${contextPath}/sys/resource/getTeamListByArea",
							data :{
								townID : selectTownID,
								villageID : selectVillageID
							},
							success : function(data) {
								var dataObj = eval("(" + data + ")");
								$("#selectTeamID").empty();
								var ui = "<option value=''>-请选择-</option>";
								$("#selectTeamID").append(ui);
								$.each(dataObj, function(i, item) {
									var ui = "<option value='"+item.id+"'>"
											+ item.teamName + "</option>"
									$("#selectTeamID").append(ui);
								})
								var selectIdentity = $("#selectIdentity").val();
								if('' == selectIdentity || 3 == selectIdentity 
										|| '' == selectTownID ){//身份不是党员或者入党积极分子
									document.getElementById("selectTeamID").disabled = true;//党小组不可操作
								}else{
									document.getElementById("selectTeamID").disabled = false;//党小组可操作
								}
							}
						});
					}else{
						$("#selectTeamID").empty();
						document.getElementById("selectTeamID").disabled = true;//党小组不可操作
					}
				})
			})
			//数据加载
			$("#selectSortID").ready(function() {//党员类别列表
				$.ajax({
					type : "POST",
					url : "${contextPath}/sys/resource/getPartyMemberList",
					success : function(data) {
						var dataObj = eval("(" + data + ")");
						$("#selectSortID").empty();
						var ui = "<option value=''>-请选择-</option>";
						$("#selectSortID").append(ui);
						$.each(dataObj, function(i, item) {
							var ui = "<option value='"+item.id+"'>"
									+ item.partyName + "</option>"
							$("#selectSortID").append(ui);
						})
					}
				});
			})
			$("#selectIdentity").ready(function() {//身份事件
				$("#selectIdentity").change(function() {
					var selectIdentity = $("#selectIdentity").val();
					var selectTownID = $("#selectTownID").val();
					var selectVillageID = $("#selectVillageID").val();
					if('' == selectIdentity || 3 == selectIdentity){//身份不是党员或者入党积极分子
						$("#selectSortID").val("");
						$("#selectTeamID").val("");
						if('' == selectTownID){
							document.getElementById("selectTeamID").disabled = true;//党小组不可操作
						}
						document.getElementById("selectSortID").disabled = true;//党员类别不可操作
					}else{
						document.getElementById("selectSortID").disabled = false;//党员类别可操作
						if('' != selectTownID){
							document.getElementById("selectTeamID").disabled = false;//党小组可操作
						}
					}
				})
			})
			$("#selectRole").ready(function() {//角色列表
				$.ajax({
					type : "POST",
					url : "${contextPath}/sys/resource/getRoleList",
					success : function(data) {
						var dataObj = eval("(" + data + ")");
						$("#selectRole").empty();
						var ui = "<option value=''>-请选择-</option>";
						$("#selectRole").append(ui);
						$.each(dataObj, function(i, item) {
							var ui = "<option value='"+item.roleKey+"'>"
									+ item.roleValue + "</option>"
							$("#selectRole").append(ui);
						})
					}
				});
			}) 
		});
		///添加入党积极分子表单输入信息验证
		$("#submitButton").bind("click", function() {
			$('#validationAddUserForm').submit();
		});
// 		冶河镇端固庄村001党小组
		jQuery.validator.addMethod("valTeamName", function(value, element) {
			var a=$("#selectTownID").find("option:selected").text();
			var b=$("#selectVillageID").find("option:selected").text();
			var tel =new RegExp(a+b+"\\d*"+"党小组");
			return tel.test(value); 
			}, "党小组命名不正确！(**镇**村**党小组)");
		jQuery.validator.addMethod("valName", function(value, element) {
			var tel=/^[\u4E00-\u9FA5\w\d]*$/g;                 
			return tel.test(value); 
			}, "此字段由汉字、英文字母、数字或下划线组成！");
// 		jQuery.validator.addMethod("valUniqueName", function(value, element) {
// // 			var ff;
// 			alert(value);
// 			var mark=true;
// 			$.ajax({
// 				url : "${contextPath}/sys/resource/checkUserName",
// 				data : {
// 					loginName:value
// 				},
// 				dataType : "json",
// 				type : "post",
// 				complete : function(data){
// 					alert(data);
// 					alert(data.responseTxt);
// 					//var ff=eval('(' + data.responseText + ')');
// 					alert(data.responseText.mark);
// 				}
// 			})
// // 			if(ff.mark==false){
// // 				mark=false;
// // 			}
// 			return this.optional(element) || (mark); 
// 			}, "此登录名不唯一！");
		var aCity={11:"北京",12:"天津",13:"河北",14:"山西",15:"内蒙古",
				21:"辽宁",22:"吉林",23:"黑龙江",31:"上海",32:"江苏",
				33:"浙江",34:"安徽",35:"福建",36:"江西",37:"山东",
				41:"河南",42:"湖北",43:"湖南",44:"广东",45:"广西",
				46:"海南",50:"重庆",51:"四川",52:"贵州",53:"云南",
				54:"西藏",61:"陕西",62:"甘肃",63:"青海",
				64:"宁夏",65:"新疆",71:"台湾",81:"香港",
				82:"澳门",91:"国外"};
		function isCardID(sId){
			 var iSum=0 ;
			 var info="" ;
			 if(!/^\d{17}(\d|x)$/i.test(sId)) return false;
			 sId=sId.replace(/x$/i,"a");
			 if(aCity[parseInt(sId.substr(0,2))]==null) return false;
			 sBirthday=sId.substr(6,4)+"-"+Number(sId.substr(10,2))+"-"+Number(sId.substr(12,2));
			 var d=new Date(sBirthday.replace(/-/g,"/")) ;
			 if(sBirthday!=(d.getFullYear()+"-"+ (d.getMonth()+1) + "-" + d.getDate())) return false;
			 for(var i = 17;i>=0;i --) iSum += (Math.pow(2,i) % 11) * parseInt(sId.charAt(17 - i),11) ;
			 if(iSum%11!=1) return false;
			 return true;
			}
		jQuery.validator.addMethod("valIDCard", function(value, element) {		
			return isCardID(value); 
			}, "你输入的身份证号不正确！");
		$('#validationAddUserForm').validate({
			errorElement : 'span',
			errorClass : 'help-block',
			focusInvalid : false,
			ignore : "",
			rules : {
				selectLoginName : {
					required : true,
					valName :true,
					rangelength : [2,6]
// 					remote:{                                          //验证用户名是否存在
// 			               type:"get",
// 			               dataType:"json",
// 			               url:"${contextPath}/sys/resource/getCheckUserName",             //servlet
// 			               data:{
// 			            	   selectLoginName:function(){
// 			                	   return $("#selectLoginName").val();
// 			                	 }
// 			               } 
// 			              } 
				},
				selectUserName : {
					required : true,
					valName : true,
					rangelength : [2,6]
				},
				selectIDCard : {
					required : true,
					valIDCard: true
				},
				selectSex: {
					required: true
				},
				selectBirthday : {
					required : true, 
					date : true
				},
				selectEducation: {
					required: true
				},
				selectPosition : {
					required : true,
					maxlength:255
				},
				selectTownID : {
					required : true
				},
				selectVillageID : {
					required : true
				},
				selectIdentity: {
					required: true
				},
				selectSortID : {
					required : true
				},
				selectTeamID : {
					required : true
				},
				selectRole : {
					required : true
				},
				selectStatus : {
					required : true
				}
			},
			messages : {
				selectLoginName:{
					required : "请填写登录名称！",
					rangelength : "该字段长度介于 5 和 10 之间（汉字算一个字符）"
// 					,
// 					remote:"<font color='red'>该名称已被使用！</font>"
				},
				selectUserName : {
					required : "请填写姓名！",
					rangelength : "该字段长度介于 5 和 10 之间（汉字算一个字符）"
				},
				selectIDCard : {
					required: "请填写身份证号码！"
					
				},
				selectSex : {
					required : "请选着性别！"
				},
				selectBirthday : {
					required : "请选择出生日期！"
				},
				selectEducation: {
					required: "这是必填字段！"
				},
				selectPosition : {
					required : "这是必填字段！"
				},
				selectTownID : {
					required : "请选择乡镇！"
				},
				selectVillageID : {
					required : "请选择村！"
				},
				selectIdentity: {
					required: "这是不填字段！"
				},
				selectSortID : {
					required : "请选择党员类别！"
				},
				selectTeamID : {
					required : "请选择党小组！"
				},
				selectRole : {
					required : "请选择角色！"
				},
				selectStatus : {
					required : "请选择状态！"
				}
			},
			highlight : function(e) {
				$(e).closest('tr').removeClass('help-block').addClass('has-error');
			},
			success : function(e) {
				$(e).closest('tr').removeClass('has-error');// .addClass('has-info');
				$(e).remove();
			},
			errorPlacement : function(error, element) {
// 				error.insertAfter(element.parent());
				error.appendTo( element.parent("td") );
				//error.appendTo('#invalid');
			},
			submitHandler : function(form) {
				var selectUserID = $("#selectUserID").val();
				var selectLoginName = $("#selectLoginName").val().trim();
				var selectUserName = $("#selectUserName").val().trim();
				var selectSex = $("#selectSex").val();
				var selectIDCard = $("#selectIDCard").val();
				var selectBirthday = $("#selectBirthday").val();
				var selectEducation = $("#selectEducation").val();
				var selectPosition = $("#selectPosition").val().trim();
				var selectIdentity = $("#selectIdentity").val();
				var selectSortID = $("#selectSortID").val();
				var selectTeamID = $("#selectTeamID").val();
				var selectTownID = $("#selectTownID").val();
				var selectVillageID = $("#selectVillageID").val();
				var selectRole = $("#selectRole").val();
				var selectStatus = $("#selectStatus").val();
				$.ajax({
					url : "${contextPath}/sys/sysuser/verifySaveUser",
					data : {
						userID : selectUserID,
						loginName : selectLoginName,
						userName : selectUserName,
						sex : selectSex,
						IDCard : selectIDCard,
						birthday : selectBirthday,
						education : selectEducation,
						position : selectPosition,
						identity : selectIdentity,
						sortID : selectSortID,
						teamID : selectTeamID,
						townID : selectTownID,
						villageID : selectVillageID,
						zoneID : '0001',//默认区域为0001，栾城区
						role : selectRole,
						status : selectStatus
					},
					dataType : "json",
					type : "post",
					complete : function(response){
						var mark = eval("(" + response.responseText + ")"); 
						if(mark){
							$("#modal-table").modal("toggle");
						 	$('#query').click();
						}else{
							markTxt = '此登录名称或者身份证号已存在';
							promptInfo(markTxt,"warning,center");
							return false;
						}
					}
				})
			},
			invalidHandler : function(form) {
			}
		});
		function LookData(id){
			$("#selectUserID").val(id);
			$.ajax({
				url : "${contextPath}/sys/sysuser/getUserById",
				data : {
					id : id
				},
				dataType : "json",
				type : "post",
				complete : function(response){
					var obj = eval("(" + response.responseText + ")"); 
					$.ajax({
						type : "POST",
						url : "${contextPath}/sys/resource/getVillageListByTownID",
						data : {
							townID : obj.townID
						},
						success : function(data) {
							var dataObj = eval("(" + data + ")");
							$("#selectVillageID").empty();
							$.each(dataObj, function(i, item) {
								var ui = "<option value='"+item.id+"'>"
										+ item.name + "</option>"
								$("#selectVillageID").append(ui);
							})
						}
					});
					$("#selectLoginName").val("");
					$("#selectUserName").val("");
					$("#selectSex").val("");
					$("#selectIDCard").val("");
					$("#selectBirthday").val("");
					$("#selectEducation").val("");
					$("#selectPosition").val("");
					$("#selectIdentity").val("");
					$("#selectSortID").val("");
					$("#selectTeamID").val("");
					$("#selectTownID").val("");
					$("#selectVillageID").val("");
					$("#selectRole").val("");
					$("#selectStatus").val("");
					$("#selectLoginName").val(obj.loginName);
					$("#selectUserName").val(obj.userName);
					$("#selectSex").val(obj.sex);
					$("#selectIDCard").val(obj.idCard);
					$("#selectBirthday").val(obj.birthday);
					$("#selectEducation").val(obj.education);
					$("#selectPosition").val(obj.position);
					$("#selectIdentity").val(obj.identity);
					$("#selectSortID").val(obj.sortID);
					$("#selectTeamID").val(obj.teamID);
					$("#selectTownID").val(obj.townID);
					$("#selectVillageID").val(obj.villageID);
					$("#selectRole").val(obj.role);
					$("#selectStatus").val(obj.status);
					if(null == obj.identity || '' == obj.identity || 3 == obj.identity 
							|| null == obj.townID || '' == obj.townID){//身份不是党员或者入党积极分子
						document.getElementById("selectSortID").disabled = true;//党员类别不可操作
						document.getElementById("selectTeamID").disabled = true;//党小组不可操作
					}else{
						document.getElementById("selectSortID").disabled = false;//党员类别可操作
						document.getElementById("selectTeamID").disabled = false;//党小组可操作
					}
					if(null == obj.townID || '' == obj.townID){
						document.getElementById("selectVillageID").disabled = true;//自然村不可操作
					}else{
						document.getElementById("selectVillageID").disabled = false;
					}
				}
			});
			$("#modal-table").modal("toggle");
		}
		function isDate(dateStr){ 
		    var datePat = /^(\d{4})(\-)(\d{1,2})(\-)(\d{1,2})$/;
		    var matchArray = dateStr.match(datePat);
		    if (matchArray == null) return false; 
		    var month = matchArray[3];
		    var day = matchArray[5]; 
		    var year = matchArray[1]; 
		    if (month < 1 || month > 12) return false; 
		    if (day < 1 || day > 31) return false; 
		    if ((month==4 || month==6 || month==9 || month==11) && day==31) return false; 
		    if (month == 2)
		    {
		        var isleap = (year % 4 == 0 && (year % 100 != 0 || year % 400 == 0)); 
		        if (day > 29 || (day==29 && !isleap)) return false; 
		    } 
		    return true;
		}
// 		$('#submitButton').on('click', function() {
// 			var selectUserID = $("#selectUserID").val();
// 			var selectLoginName = $("#selectLoginName").val().trim();
// 			var selectUserName = $("#selectUserName").val().trim();
// 			var selectSex = $("#selectSex").val();
// 			var selectIDCard = $("#selectIDCard").val();
// 			var selectBirthday = $("#selectBirthday").val();
// 			var selectEducation = $("#selectEducation").val();
// 			var selectPosition = $("#selectPosition").val().trim();
// 			var selectIdentity = $("#selectIdentity").val();
// 			var selectSortID = $("#selectSortID").val();
// 			var selectTeamID = $("#selectTeamID").val();
// 			var selectTownID = $("#selectTownID").val();
// 			var selectVillageID = $("#selectVillageID").val();
// 			var selectRole = $("#selectRole").val();
// 			var selectStatus = $("#selectStatus").val();
// 			var mark = false;
// 			var markTxt = "";
// 			if(''==selectLoginName){
// 				mark = true;
// 				markTxt = '登录名不能为空';
// 			}else if(''!=selectLoginName && /[~#^$@%&!*]/gi.test(selectLoginName)){
// 				mark = true;
// 				markTxt = '登录名不能输入特殊符号';
// 			}else if(''==selectUserName){
// 				mark = true;
// 				markTxt = '用户姓名不能为空';
// 			}else if(''!=selectUserName && /[~#^$@%&!*]/gi.test(selectUserName)){
// 				mark = true;
// 				markTxt = '用户姓名不能输入特殊符号';
// 			}else if(''==selectIDCard || selectIDCard.length !=  18){
// 				mark = true;
// 				markTxt = '身份证号不能为空或者身份证号位数不正确';
// 			}else if('' == selectSex){
// 				mark = true;
// 				markTxt = '性别不能为空';
// 			}else if('' == selectBirthday){
// 				mark = true;
// 				markTxt = '出生日期不能为空';
// 			} else if(!isDate(selectBirthday)){
// 				mark = true;
// 				markTxt = '出生日期格式不正确';
// 			} else if('' == selectEducation){
// 				mark = true;
// 				markTxt = '学历不能为空';
// 			}else if(''==selectIdentity){
// 				mark = true;
// 				markTxt = '身份不能为空';
// 			}else if(''==selectTownID || ''==selectVillageID){
// 				mark = true;
// 				markTxt = '乡镇、村不能为空';
// 			}else if(''!=selectIdentity && 3 != selectIdentity && '' == selectSortID){
// 				mark = true;
// 				markTxt = '党员或者入党积极分子中党员类别不能为空';
// 			}else if(''==selectRole){
// 				mark = true;
// 				markTxt = '角色不能为空';
// 			}else if(''==selectStatus){
// 				mark = true;
// 				markTxt = '用户状态不能为空';
// 			}
// 			if(mark){
// 				promptInfo(markTxt,"warning,center");
// 				return false;
// 			}else{
// 				$.ajax({
// 					url : "${contextPath}/sys/sysuser/verifySaveUser",
// 					data : {
// 						userID : selectUserID,
// 						loginName : selectLoginName,
// 						userName : selectUserName,
// 						sex : selectSex,
// 						IDCard : selectIDCard,
// 						birthday : selectBirthday,
// 						education : selectEducation,
// 						position : selectPosition,
// 						identity : selectIdentity,
// 						sortID : selectSortID,
// 						teamID : selectTeamID,
// 						townID : selectTownID,
// 						villageID : selectVillageID,
// 						zoneID : '0001',//默认区域为0001，栾城区
// 						role : selectRole,
// 						status : selectStatus
// 					},
// 					dataType : "json",
// 					type : "post",
// 					complete : function(response){
// 						var mark = eval("(" + response.responseText + ")"); 
// 						if(mark){
// 							$("#modal-table").modal("toggle");
// 						 	$('#query').click();
// 						}else{
// 							markTxt = '此登录名称或者身份证号已存在';
// 							promptInfo(markTxt,"warning,center");
// 							return false;
// 						}
// 					}
// 				})  
				
// 			}
// 		})
		function resetPassword(id){//重置密码
			$.ajax({
				dataType : "json",
				url : "${contextPath}/sys/sysuser/resetPassword",
				type : "post",
				data : {
					id : id
				},
				success : function(xmlRequest) {
					promptInfo(xmlRequest.success,"success,center");
				}
			});
		}
        $('.page-content-area').ace_ajax('loadScripts', scripts, function() {
        	// inline scripts related to this page
        	jQuery(function($) {
        		var grid_selector = "#grid-table";
        		var pager_selector = "#grid-pager";

        		// resize to fit page size
        		$(window).on('resize.jqGrid', function() {
        			$(grid_selector).jqGrid('setGridWidth', $(".page-content").width());
        		})
        		// resize on sidebar collapse/expand
        		var parent_column = $(grid_selector).closest('[class*="col-"]');
        		$(document).on('settings.ace.jqGrid', function(ev, event_name, collapsed) {
        			if (event_name === 'sidebar_collapsed' || event_name === 'main_container_fixed') {
        				// setTimeout is for webkit only to give time for DOM changes and then redraw!!!
        				setTimeout(function() {
        					$(grid_selector).jqGrid('setGridWidth', parent_column.width());
        				}, 0);
        			}
        		})

        		jQuery(grid_selector).jqGrid({
        			subGrid : false,
        			url : "${contextPath}/sys/sysuser/getSysUser",
        			datatype : "json",
        			height : 450,
        			colNames : ['', 'ID', '登录名','姓名', '性别', '身份证', '出生日期'
        			            , '学历', '职位', '身份', '党员类别', '党小组'
        			            , '区域','乡镇', '村' ,'角色', '状态', '操作'
        			            ],
        			colModel : [ {
        				name : '',
        				index : '',
        				width : 50,
        				hidden : false,
        				fixed : true,
        				sortable : false,
        				resize : false,
        				formatter : 'actions',
        				formatoptions : {
        					keys : true,
        					//delbutton : false,//disable delete button
        					delOptions : {
        						recreateForm : true,
        						beforeShowForm : beforeDeleteCallback
        					},
        					editbutton : false,
        					editformbutton:false,
        					editOptions:{recreateForm:true, beforeShowForm:beforeEditCallback}
        				}
        			}, {
        				name : 'id',
        				index : 'id',
        				label : 'ID',
        				width : 60,
        				sorttype : "string",
        				hidden: true,
        				search : false
        			}, {
        				name : 'loginName',
        				index : 'loginName',
        				label : '登录名',
        				width : 100,
        				editable : false,
        				editoptions : {size : "20", maxlength : "32", readonly : true},
        				searchoptions : {sopt : ['cn']},
        				editrules : {required : true}
        			}, {
        				name : 'userName',
        				index : 'userName',
        				label : '姓名',
        				width : 100,
        				editable : true,
        				editoptions : {size : "20", maxlength : "32"},
        				searchoptions : {sopt : ['cn']},
        				editrules : {required : true}
        			}, {
        				name : 'sex',
        				index : 'sex',
        				label : '性别',
        				width : 80,
        				editable : true,
        				edittype : "select",
        				editoptions : {value : "男:男;女:女",editDisabled: true},
        				search : false
        			},  {
        				name : 'idCard',
        				index : 'idCard',
        				label : '身份证',
        				width : 110,
        				editable : true,
        				editoptions : {size : "20", maxlength : "18"},
        				search : false
        			}, {
        				name : 'birthday',
        				index : 'birthday',
        				label : '出生日期',
        				width : 110,
        				editable : true,
        				readonly : true,
        				search : false,
        				sorttype : 'date',
        				unformat : pickDate
        			}, {
        				name : 'education',
        				index : 'education',
        				label : '学历',
        				width : 120,
        				editable : true,
        				search : false
        			}, {
        				name : 'position',
        				index : 'position',
        				label : '职位',
        				width : 100,
        				editable : true,
        				search : false
        			}, {
        				name : 'identityCn',
        				index : 'identity',
        				label : '身份',
        				width : 80,
        				editable : true,
        				edittype : "select",
        				editoptions : {value : "1:党员;2:入党积极分子;3:群众"},
        				search : false
        			}, {
        				name : 'sortCn',
        				index : 'sortID',
        				label : '党员类别',
        				width : 80,
        				search : false
        			}, {
        				name : 'teamCn',
        				index : 'teamID',
        				label : '党小组',
        				width : 80,
        				editable : true,
        				search : false
        			}, {
        				name : 'zoneCn',
        				index : 'zoneID',
        				label : '区域',
        				width : 80,
        				hidden : true,
        				editable : false,
        				search : false
        			}, {
        				name : 'townCn',
        				index : 'townID',
        				label : '乡镇',
        				width : 80,
        				editable : true,
        				search : false
        			}, {
        				name : 'villageCn',
        				index : 'villageID',
        				label : '村',
        				width : 80,
        				editable : true,
        				search : false
        			}, {
        				name : 'roleCn',
        				index : 'role',
        				label : '角色',
        				width : 80,
        				editable : true,
        				search : false
        			}, {
        				name : 'statusCn',
        				index : 'status',
        				label : '状态',
        				width : 80,
        				editable : true,
        				search : false
        			}, {
        				name : 'HANDLE',
        				index : 'id',
        				label : '操作',
        				width : 110,
        				editable : false,
        			} ],
        			//scroll : 1, // set the scroll property to 1 to enable paging with scrollbar - virtual loading of records
        			sortname : "id",
        			sortorder : "asc",
        			viewrecords : true,
        			rowNum : 10,
        			rowList : [ 10, 20, 30 ],
        			pager : pager_selector,
        			altRows : true,
        			//toppager : true,
        			multiselect : true,
        			//multikey : "ctrlKey",
        	        multiboxonly : true,
        			loadComplete : function() {
        				var table = this;
        				setTimeout(function(){
        					styleCheckbox(table);
        					updateActionIcons(table);
        					updatePagerIcons(table);
        					enableTooltips(table);
        				}, 0);
        			},
        			editurl : "${contextPath}/sys/sysuser/operateSysUser",
        			//caption : "用户管理列表",
        			//autowidth : true,
        			/**
        			grouping : true, 
        			groupingView : { 
        				 groupField : ['name'],
        				 groupDataSorted : true,
        				 plusicon : 'fa fa-chevron-down bigger-110',
        				 minusicon : 'fa fa-chevron-up bigger-110'
        			},
        			*/
        			gridComplete : function(){
        				var ids = jQuery(grid_selector).jqGrid('getDataIDs');
        				for(var i = 0; i < ids.length; i++){
        					var id = ids[i];
        					look = "<a href='#page/sysuser' onclick='LookData(\"" + id + "\")'>修改</a>&nbsp;&nbsp;&nbsp;"
        						+"<a href='#page/sysuser' onclick='resetPassword(\"" + id + "\")'>重置密码</a>";		
        					jQuery(grid_selector).jqGrid('setRowData', ids[i], {HANDLE : look});
        				}
        			}
        		});
        		
        		$(window).triggerHandler('resize.jqGrid');// trigger window resize to make the grid get the correct size
        		
        		// enable search/filter toolbar
        		// jQuery(grid_selector).jqGrid('filterToolbar',{defaultSearch:true,stringResult:true})
        		// jQuery(grid_selector).filterToolbar({});
        		// switch element when editing inline
        		function aceSwitch(cellvalue, options, cell) {
        			setTimeout(function() {
        				$(cell).find('input[type=checkbox]').addClass('ace ace-switch ace-switch-5').after('<span class="lbl"></span>');
        			}, 0);
        		}
        		
        		// enable datepicker
        		function pickDate(cellvalue, options, cell) {
        			setTimeout(function() {
        				$(cell).find('input[type=text]').datepicker({
        					format : 'yyyy-mm-dd',
        					autoclose : true,
        				    language: 'zh-CN'
        				});
        			}, 0);
        		}
        		
        		// navButtons
        		jQuery(grid_selector).jqGrid('navGrid', pager_selector, { // navbar options
        			edit : false,
        			editicon : 'ace-icon fa fa-pencil blue',
        			add : false,
        			addicon : 'ace-icon fa fa-plus-circle purple',
        			del : false,
        			delicon : 'ace-icon fa fa-trash-o red',
        			search : false,
        			searchicon : 'ace-icon fa fa-search orange',
        			refresh : false,
        			refreshicon : 'ace-icon fa fa-refresh blue',
        			view : true,
        			viewicon : 'ace-icon fa fa-search-plus grey'
        		}, {
        			// edit record form
        			// closeAfterEdit: true,
        			// width: 700,
        			recreateForm : true,
        			beforeShowForm : function(e) {
        				var form = $(e[0]);
        				form.closest('.ui-jqdialog').find('.ui-jqdialog-titlebar').wrapInner('<div class="widget-header" />')
        				style_edit_form(form);
        			},
    				errorTextFormat: function (response) {
    					var result = eval('('+response.responseText+')');
    				    return result.message;
    				}
        		}, {
        			// new record form
        			// width: 700,
        			closeAfterAdd : true,
        			recreateForm : true,
        			viewPagerButtons : false,
        			beforeShowForm : function(e) {
        				var form = $(e[0]);
        				form.closest('.ui-jqdialog').find('.ui-jqdialog-titlebar').wrapInner('<div class="widget-header" />')
        				style_edit_form(form);
        			},
    				errorTextFormat: function (response) {
    					var result = eval('('+response.responseText+')');
    				    return result.message;
    				}
        		}, {
        			// delete record form
        			recreateForm : true,
        			beforeShowForm : function(e) {
        				var form = $(e[0]);
        				if (form.data('styled'))
        					return false;
        				form.closest('.ui-jqdialog').find('.ui-jqdialog-titlebar').wrapInner('<div class="widget-header" />')
        				style_delete_form(form);
        				form.data('styled', true);
        			},
        			onClick : function(e) {
        				// alert(1);
        			}
        		}, {
        			// search form
        			recreateForm : true,
        			afterShowSearch : function(e) {
        				var form = $(e[0]);
        				form.closest('.ui-jqdialog').find('.ui-jqdialog-title').wrap('<div class="widget-header" />')
        				style_search_form(form);
        			},
        			afterRedraw : function() {
        				style_search_filters($(this));
        			},
        			multipleSearch : true 
	        		/**
	        		 * multipleGroup:true, showQuery: true
	        		 */
        		}, {
        			// view record form
        			top : 100,
        			width:550,
					left : $(".page-content").width() / 2,
        			recreateForm : true,
        			beforeShowForm : function(e) {
        				var form = $(e[0]);
        				form.closest('.ui-jqdialog').find('.ui-jqdialog-title').wrap('<div class="widget-header" />')
        			}
        		}).navButtonAdd(pager_selector,{      
					caption:"", 
					title:"添加新记录",     
					buttonicon:'ace-icon fa fa-plus-circle purple',       
					onClickButton: function(){
						$("#selectUserID").val("");
						$("#selectLoginName").val("");
						$("#selectUserName").val("");
						$("#selectSex").val("");
						$("#selectIDCard").val("");
						$("#selectBirthday").val("");
						$("#selectEducation").val("");
						$("#selectPosition").val("");
						$("#selectIdentity").val("");
						$("#selectSortID").val("");
						$("#selectTeamID").val("");
						$("#selectTownID").val("");
						$("#selectVillageID").val("");
						$("#selectRole").val("");
						$("#selectStatus").val("");
						document.getElementById("selectVillageID").disabled = true;//自然村不可操作
						document.getElementById("selectSortID").disabled = true;//党员类别不可操作
						document.getElementById("selectTeamID").disabled = true;//党小组不可操作
						$("#modal-table").modal("toggle");
					},       
					position:"first"
				});
        		
        		// add custom button to export the data to excel
				/* jQuery(grid_selector).jqGrid('navButtonAdd', pager_selector,{
				   caption : "",
			       title : "导出Excel",
			       buttonicon : "ace-icon fa fa-file-excel-o green", 
			       onClickButton : function () { 
			    	   var keys = [], ii = 0, rows = "";
			    	   var ids = $(grid_selector).getDataIDs(); // Get All IDs
			    	   var row = $(grid_selector).getRowData(ids[0]); // Get First row to get the labels
			    	   //var label = $(grid_selector).jqGrid('getGridParam','colNames');
   			    	   for (var k in row) {
			    	   	   keys[ii++] = k; // capture col names
			    	   	   rows = rows + k + "\t"; // output each Column as tab delimited
			    	   }
			    	   rows = rows + "\n"; // Output header with end of line
			    	   for (i = 0; i < ids.length; i++) {
			    	   	   row = $(grid_selector).getRowData(ids[i]); // get each row
			    	   	   for (j = 0; j < keys.length; j++)
			    	   		   rows = rows + row[keys[j]] + "\t"; // output each Row as tab delimited
			    	   	   rows = rows + "\n"; // output each row with end of line
			    	   }
			    	   rows = rows + "\n"; // end of line at the end
			    	   var form = "<form name='csvexportform' action='${contextPath}/sys/sysuser/operateSysUser?oper=excel' method='post'>";
			    	   form = form + "<input type='hidden' name='csvBuffer' value='" + rows + "'>";
			    	   form = form + "</form><script>document.csvexportform.submit();</sc" + "ript>";
			    	   OpenWindow = window.open('', '');
			    	   OpenWindow.document.write(form);
			    	   OpenWindow.document.close();
			       } 
				}); */
        		
        		function style_edit_form(form) {
        			// enable datepicker on "birthday" field and switches for "stock" field
        			form.find('input[name=birthday]').datepicker({
        				format : 'yyyy-mm-dd',
        				autoclose : true,
        			    language: 'zh-CN'
        			})

        			form.find('input[name=statusCn]').addClass('ace ace-switch ace-switch-5').after('<span class="lbl"></span>');
        			// don't wrap inside a label element, the checkbox value won't be submitted (POST'ed)
        			// .addClass('ace ace-switch ace-switch-5').wrap('<label class="inline" />').after('<span class="lbl"></span>');

        			// update buttons classes
        			var buttons = form.next().find('.EditButton .fm-button');
        			buttons.addClass('btn btn-sm').find('[class*="-icon"]').hide();// ui-icon, s-icon
        			buttons.eq(0).addClass('btn-primary').prepend('<i class="ace-icon fa fa-check"></i>');
        			buttons.eq(1).prepend('<i class="ace-icon fa fa-times"></i>')

        			buttons = form.next().find('.navButton a');
        			buttons.find('.ui-icon').hide();
        			buttons.eq(0).append('<i class="ace-icon fa fa-chevron-left"></i>');
        			buttons.eq(1).append('<i class="ace-icon fa fa-chevron-right"></i>');
        		}

        		function style_delete_form(form) {
        			var buttons = form.next().find('.EditButton .fm-button');
        			buttons.addClass('btn btn-sm btn-white btn-round').find('[class*="-icon"]').hide();// ui-icon, s-icon
        			buttons.eq(0).addClass('btn-danger').prepend('<i class="ace-icon fa fa-trash-o"></i>');
        			buttons.eq(1).addClass('btn-default').prepend('<i class="ace-icon fa fa-times"></i>')
        		}

        		function style_search_filters(form) {
        			form.find('.delete-rule').val('X');
        			form.find('.add-rule').addClass('btn btn-xs btn-primary');
        			form.find('.add-group').addClass('btn btn-xs btn-success');
        			form.find('.delete-group').addClass('btn btn-xs btn-danger');
        		}
        		function style_search_form(form) {
        			var dialog = form.closest('.ui-jqdialog');
        			var buttons = dialog.find('.EditTable')
        			buttons.find('.EditButton a[id*="_reset"]').addClass('btn btn-sm btn-info').find('.ui-icon').attr('class', 'ace-icon fa fa-retweet');
        			buttons.find('.EditButton a[id*="_query"]').addClass('btn btn-sm btn-inverse').find('.ui-icon').attr('class', 'ace-icon fa fa-comment-o');
        			buttons.find('.EditButton a[id*="_search"]').addClass('btn btn-sm btn-purple').find('.ui-icon').attr('class', 'ace-icon fa fa-search');
        		}

        		function beforeDeleteCallback(e) {
        			var form = $(e[0]);
        			if (form.data('styled'))
        				return false;
        			form.closest('.ui-jqdialog').find('.ui-jqdialog-titlebar').wrapInner('<div class="widget-header" />')
        			style_delete_form(form);
        			form.data('styled', true);
        		}

        		function beforeEditCallback(e) {
        			var form = $(e[0]);
        			form.closest('.ui-jqdialog').find('.ui-jqdialog-titlebar').wrapInner('<div class="widget-header" />')
        			style_edit_form(form);
        		}

        		// it causes some flicker when reloading or navigating grid
        		// it may be possible to have some custom formatter to do this as the grid is being created to prevent this
        		// or go back to default browser checkbox styles for the grid
        		function styleCheckbox(table) {
        			/**
        			 * $(table).find('input:checkbox').addClass('ace') .wrap('<label />') .after('<span class="lbl align-top" />') $('.ui-jqgrid-labels th[id*="_cb"]:first-child')
        			 * .find('input.cbox[type=checkbox]').addClass('ace') .wrap('<label />').after('<span class="lbl align-top" />');
        			 */
        		}

        		// unlike navButtons icons, action icons in rows seem to be hard-coded
        		// you can change them like this in here if you want
        		function updateActionIcons(table) {
        			/**
        			 * var replacement = { 'ui-ace-icon fa fa-pencil' : 'ace-icon fa fa-pencil blue', 'ui-ace-icon fa fa-trash-o' : 'ace-icon fa fa-trash-o red', 'ui-icon-disk' : 'ace-icon fa fa-check green', 'ui-icon-cancel' :
        			 * 'ace-icon fa fa-times red' }; $(table).find('.ui-pg-div span.ui-icon').each(function(){ var icon = $(this); var $class = $.trim(icon.attr('class').replace('ui-icon', '')); if($class in replacement)
        			 * icon.attr('class', 'ui-icon '+replacement[$class]); })
        			 */
        		}

        		// replace icons with FontAwesome icons like above
        		function updatePagerIcons(table) {
        			var replacement = {
        				'ui-icon-seek-first' : 'ace-icon fa fa-angle-double-left bigger-140',
        				'ui-icon-seek-prev' : 'ace-icon fa fa-angle-left bigger-140',
        				'ui-icon-seek-next' : 'ace-icon fa fa-angle-right bigger-140',
        				'ui-icon-seek-end' : 'ace-icon fa fa-angle-double-right bigger-140'
        			};
        			$('.ui-pg-table:not(.navtable) > tbody > tr > .ui-pg-button > .ui-icon').each(function() {
        				var icon = $(this);
        				var $class = $.trim(icon.attr('class').replace('ui-icon', ''));

        				if ($class in replacement)
        					icon.attr('class', 'ui-icon ' + replacement[$class]);
        			})
        		}

        		function enableTooltips(table) {
        			$('.navtable .ui-pg-button').tooltip({
        				container : 'body'
        			});
        			$(table).find('.ui-pg-div').tooltip({
        				container : 'body'
        			});
        		}

        		// var selr = jQuery(grid_selector).jqGrid('getGridParam','selrow');

        		$(document).one('ajaxloadstart.page', function(e) {
        			$(grid_selector).jqGrid('GridUnload');
        			$('.ui-jqdialog').remove();
        		});
        		
        		//出生日期选择
        		$("#selectBirthday").datetimepicker({
        			language: 'zh-CN',
        	        pickTime: false,
        	        todayBtn: true,
        	        autoclose: true,
        	        minView: '2',
        	        forceParse: false,
        	        dataFormat:"yy-mm-dd"
        		});
        	});
        });
</script>
