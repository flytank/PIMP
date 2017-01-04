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
										+ item.name + "</option>";
								$("#queryVillageID").append(ui);
							});
						}
					});
					document.getElementById("queryVillageID").disabled = false;
				}else{
					$("#queryVillageID").empty();
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
			var queryTeamName = $("#queryTeamName").val();
			if (queryTeamName!=null && queryTeamName!='') {
				jsonData += "{'field' : 'teamName', 'op' : 'cn', 'data' : '" + encodeURI(queryTeamName) + "'}";
			}
			jsonData += "], 'groupOp':'AND'}";
			$("#grid-table").jqGrid('setGridParam',{
		        datatype:'json',
		        postData:{'filters':jsonData}, //发送数据
		        page:1
		    }).trigger("reloadGrid"); //重新载入
		});
		$("#queryTeamName").keydown(function(event) {
		    if (event.keyCode == "13") {
		        $('#query').click();
		    }
		}); 
		$("#reset").on("click", function() {
			if(role==roles.admin||role==roles.zone){
				$("#queryTownID").val("");
				$("#queryVillageID").val("");
				$("#queryTeamName").val("");	
			}
			if(role==roles.town){
				$("#queryVillageID").val("");
				$("#queryTeamName").val("");	
			}
			if(role==roles.village){
				$("#queryTeamName").val("");	
			}
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
			<label>乡镇:</label> 
			<select id="queryTownID" name="queryTownID"></select>
			<label>村:</label> 
			<select id="queryVillageID" name="queryVillageID" disabled="disabled"></select>
			<label>名称:</label> 
			<input id="queryTeamName" name="queryTeamName" size="10" class="cond-input-text"/>
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
						党小组信息
					</div>
				</div>
				<div class="modal-body" style="max-height: 500px;overflow-y: scroll;">
					<div id="modal-tip" class="red clearfix"></div>
					<input id="selectTeamID" name="selectTeamID" type="hidden" /><!-- 党小组ID -->
					<div class="widget-box widget-color-blue2">
						<div class="widget-body">
							<div class="widget-main padding-8">
							   <form id="validationAddTeamForm" method="post" action="#">
								<table id="information" class="table table-striped table-bordered table-hover">
									<tr>
									<td class='hidden-480' width='110px'>乡镇:</td>
									<td>
										<select id='selectTownID' name='selectTownID'></select>
									</td>
									</tr>
									<tr>
									<td class='hidden-480' width='110px'>村:</td>
									<td>
										<select id='selectVillageID' name='selectVillageID' ></select>
									</td>
									</tr>
									<tr>
									<td class='hidden-480' width='110px'>党小组名称:</td>
									<td>
										<input type='text' id='selectTeamName' name='selectTeamName' size='40' class='form-control limited' maxlength='100'>
									</td>
									</tr>
									<tr>
									<td class='hidden-480' width='110px'>备注:</td>
									<td>
									<input type='text' id='selectMark' name='selectMark' size='40' class='form-control limited' >
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
		var scripts = [ null, "${contextPath}/static/assets/js/date-time/bootstrap-datepicker.js", 
		                "${contextPath}/static/assets/js/date-time/locales/bootstrap-datepicker.zh-CN.js",  
		                "${contextPath}/static/assets/js/jqGrid/jquery.jqGrid.js", 
						"${contextPath}/static/assets/js/jqGrid/i18n/grid.locale-cn.js",
						"${contextPath}/static/assets/js/jquery-ui.js",
						"${contextPath}/static/assets/js/jquery.gritter.js",
		                null ];
		var role='${sessionScope.SESSION_SYS_USER.role}';
		var townName='${sessionScope.SESSION_SYS_USER.townCn}';
		var townID='${sessionScope.SESSION_SYS_USER.townID}';
		var villageName='${sessionScope.SESSION_SYS_USER.villageCn}';
		var villageID='${sessionScope.SESSION_SYS_USER.villageID}';
		$(function(){
			$("#selectTownID").ready(function() {
				if(role==roles.admin||role==roles.zone)
				{
					$.ajax({
						type : "POST",
						url : "${contextPath}/sys/resource/getTownListByZoneID",
						data : {
							zoneID : '0001'
						},
						success : function(data) {
							var dataObj = eval("(" + data + ")");
							$("#selectTownID").empty();
							$("#queryTownID").empty();
							var ui = "<option value=''>-请选择-</option>";
							$("#selectTownID").append(ui);
							$("#queryTownID").append(ui);
							$.each(dataObj, function(i, item) {
								var ui = "<option value='"+item.id+"'>"
									+ item.name + "</option>";
								$("#selectTownID").append(ui);
								$("#queryTownID").append(ui);
							});
						}
					});
					$("#selectTownID").change(function() {
						var selectTownID = $("#selectTownID").val().trim();
						if("" != selectTownID){
							$.ajax({
								type : "POST",
								async: false,
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
											+ item.name + "</option>";
										$("#selectVillageID").append(ui);
									});
								}
							});
							document.getElementById("selectVillageID").disabled = false;
						}else{
							$("#selectVillageID").empty();
							document.getElementById("selectVillageID").disabled = true;
						}
					})
				 }
				else if(role==roles.town){
					var op="<option value='"+townID+"' selected >"+townName+"</option>";
					$("#selectTownID").append(op);
					$("#queryTownID").append(op);
					$("#queryTownID").prop("disabled",true);
					$("#selectTownID").prop("disabled",true);
					$("#queryVillageID").prop("disabled",false);
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
								$("#queryVillageID").empty();
								var ui = "<option value=''>-请选择-</option>";
//								$("#selectVillageID").append(ui);
								$("#queryVillageID").append(ui);
								$.each(dataObj, function(i, item) {
									var ui = "<option value='"+item.id+"'>"
										+ item.name + "</option>";
									$("#selectVillageID").append(ui);
								});
							}
						});
				}
				else if(role==roles.village){
					var op="<option value='"+townID+"' selected >"+townName+"</option>";
					$("#selectTownID").append(op);
					$("#queryTownID").append(op);
					$("#selectTownID").prop("disabled",true);
					$("#queryTownID").prop("disabled",true);	
					var opv="<option value='"+villageID+"' selected >"+villageName+"</option>";
					$("#selectVillageID").append(opv);
					$("#queryVillageID").append(opv);
					$("#selectTownID").prop("disabled",true);
					$("#queryTownID").prop("disabled",true);
				}
				else{
//					alert("common people");
				} 
			})
		})
		function LookData(id){
			$("#selectTeamID").val(id);
			$.ajax({
				url : "${contextPath}/sys/team/getTeamById",
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
					$("#selectTownID").val(obj.townID);
					$("#selectVillageID").val(obj.villageID);
					$("#selectTeamName").val(obj.teamName);
					$("#selectMark").val(obj.mark);
					document.getElementById("selectVillageID").disabled = false;
				}
			});
			$("#modal-table").modal("toggle");
		}
		
		///添加党小组表单输入信息验证
		$("#submitButton").bind("click", function() {
			$('#validationAddTeamForm').submit();
		});
// 		冶河镇端固庄村001党小组
		jQuery.validator.addMethod("valTeamName", function(value, element) {
			var a=$("#selectTownID").find("option:selected").text();
			var b=$("#selectVillageID").find("option:selected").text();
			var tel =new RegExp(a+b+"\\d*"+"党小组");
			return this.optional(element) || (tel.test(value)); 
			}, "党小组命名不正确！(**镇**村**党小组)");
		$('#validationAddTeamForm').validate({
			errorElement : 'span',
			errorClass : 'help-block',
			focusInvalid : false,
			ignore : "",
			rules : {
				selectTownID : {
					required : true
				},
				selectVillageID : {
					required : true
				},
				selectTeamName : {
					required : true,
					valTeamName:true
				},
				selectMark : {
					maxlength:255
				}
			},
			messages : {
				selectTownID : {
					required:"请选择乡镇！"
				},
				selectVillageID : {
				    required:"请选择村！"
				},
				selectTeamName:{
					required:"党小组名称不能为空！"
				},
				selectMark : {
					maxlength:"最多可输入255个字符！"
				}
			},
			highlight : function(e) {
				$(e).closest('td').removeClass('help-block').addClass('has-error');
			},
			success : function(e) {
				$(e).closest('span').removeClass('has-error');// .addClass('has-info');
				$(e).remove();
			},
			errorPlacement : function(error, element) {
// 				error.insertAfter(element.parent());
				error.appendTo( element.parent("td") );
				//error.appendTo('#invalid');
			},
			submitHandler : function(form) {
				$.ajax({
					dataType : "json",
					url : "${contextPath}/sys/team/verifySaveTeam",
					type : "post",
					data : {
						teamID : $("#selectTeamID").val().trim(),
						townID : $("#selectTownID").val().trim(),
						villageID : $("#selectVillageID").val().trim(),
						teamName : $("#selectTeamName").val().trim(),
						zoneID : '0001',//默认区域为0001，栾城区
						mark : $("#selectMark").val().trim()
					},
					complete : function(response){
						var mark = eval("(" + response.responseText + ")"); 
						if(mark){
							$("#modal-table").modal("toggle");
						 	$('#query').click();
						}else{
							markTxt = '该党小组已存在';
							promptInfo(markTxt,"warning,center");
							return false;
						}
					}
				});
			},
			invalidHandler : function(form) {
			}
		});
		
// 		$('#submitButton').on('click', function() {
// 			var selectTeamID = $("#selectTeamID").val().trim();
// 			var selectTownID = $("#selectTownID").val().trim();
// 			var selectVillageID = $("#selectVillageID").val().trim();
// 			var selectTeamName = $("#selectTeamName").val().trim();
// 			var selectMark = $("#selectMark").val().trim();
// 			var mark = false;
// 			var markTxt = "";
// 			if(''==selectTownID || ''==selectVillageID){
// 				mark = true;
// 				markTxt = '乡镇、村不能为空';
// 			}else if(''==selectTeamName && ''==selectTeamName){
// 				mark = true;
// 				markTxt = '党小组名称不能为空';
// 			}else if(/[~#^$@%&!*]/gi.test(selectTeamName)){
// 				mark = true;
// 				markTxt = '党小组名称不能输入特殊符号';
// 			}
// 			if(mark){
// 				promptInfo(markTxt,"warning,center");
// 				return false;
// 			}else{
// 				$.ajax({
// 					url : "${contextPath}/sys/team/verifySaveTeam",
// 					data : {
// 						teamID : selectTeamID,
// 						townID : selectTownID,
// 						villageID : selectVillageID,
// 						teamName : selectTeamName,
// 						zoneID : '0001',//默认区域为0001，栾城区
// 						mark : selectMark
// 					},
// 					dataType : "json",
// 					type : "post",
// 					complete : function(response){
// 						var mark = eval("(" + response.responseText + ")"); 
// 						if(mark.success){
// 							$("#modal-table").modal("toggle");
// 						 	$('#query').click();
// 						}else{
// 							promptInfo(mark.information,"warning,center");
// 							return false;
// 						}
// 					}
// 				})  
				
// 			}
// 		})
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
        			url : "${contextPath}/sys/team/getTeam",
        			datatype : "json",
        			height : 450,
        			colNames : ['', 'ID', '区域','乡镇', '村' , '名称', '备注', '操作'],
        			colModel : [ {
        				name : '',
        				index : '',
        				width : 50,
        				hidden : true,
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
        					editformbutton:false, editOptions:{recreateForm:true, beforeShowForm:beforeEditCallback}
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
        				name : 'teamName',
        				index : 'teamName',
        				label : '名称',
        				width : 100,
        				editable : false,
        				editoptions : {size : "20", maxlength : "32", readonly : true},
        				searchoptions : {sopt : ['cn']},
        				editrules : {required : true}
        			}, {
        				name : 'mark',
        				index : 'mark',
        				label : '备注',
        				width : 80,
        				editable : true,
        				search : false
        			}, {
        				name : 'HANDLE',
        				index : 'id',
        				label : '操作',
        				width : 110,
        				editable : false,
        				search : false,
        				view : false
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
        			editurl : "${contextPath}/sys/team/operateTeam",
        			//caption : "用户管理列表",
        			//autowidth : true,
        			gridComplete : function(){
        				var ids = jQuery(grid_selector).jqGrid('getDataIDs');
        				for(var i = 0; i < ids.length; i++){
        					var id = ids[i];
        					look = "<a href='#page/team' onclick='LookData(\"" + id + "\")'>修改</a>";		
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
						if(role==roles.admin||role==roles.zone){
							$("#selectTeamID").val("");
							$("#selectTownID").val("");
							$("#selectVillageID").val("");
							$("#selectTeamName").val("");
							$("#selectMark").val("");
							document.getElementById("selectVillageID").disabled = true;
							document.getElementById("selectVillageID").disabled = true;
						}else if(role==roles.town){
							$("#selectTeamID").val("");
							$("#selectVillageID").val("");
							$("#selectTeamName").val("");
							$("#selectMark").val("");
						}else if(role==roles.village){
							$("#selectTeamID").val("");
							$("#selectTeamName").val("");
							$("#selectMark").val("");
						}
						$("#modal-table").modal("toggle");
					},       
					position:"first"
				});
        		
        		
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
        		
        	});
        });
</script>
