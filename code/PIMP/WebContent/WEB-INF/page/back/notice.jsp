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
					document.getElementById("selectVillageID").disabled = true;
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
			var querySubject = $("#querySubject").val();
			if (querySubject!=null && querySubject!='') {
				jsonData += "{'field' : 'subject', 'op' : 'cn', 'data' : '" + querySubject + "'}";
			}
			jsonData += "], 'groupOp':'AND'}";
			$("#grid-table").jqGrid('setGridParam',{
		        datatype:'json',
		        postData:{'filters':jsonData}, //发送数据
		        page:1
		    }).trigger("reloadGrid"); //重新载入
		});
		$("#querySubject").keydown(function(event) {
		    if (event.keyCode == "13") {
		        $('#query').click();
		    }
		}); 
		$("#reset").on("click", function() {
			$("#queryTownID").val("");
			$("#queryVillageID").val("");
			$("#querySubject").val("");
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
			<label>名称：</label> 
			<input id="querySubject" name="querySubject" size="10" class="cond-input-text"/>
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
						公示信息
					</div>
				</div>
				<div class="modal-body" style="max-height: 500px;overflow-y: scroll;">
					<div id="modal-tip" class="red clearfix"></div>
					<input id="selectNoticeID" name="selectNoticeID" type="hidden" /><!-- 党小组ID -->
					<div class="widget-box widget-color-blue2">
						<div class="widget-body">
							<div class="widget-main padding-8">
							  <form id="validationAddNoticeForm" method="post" action="#">
								<table id="information" class="table table-striped table-bordered table-hover">
									<tr>
									<td class='hidden-480' width='110px'>主题</td>
									<td><input type='text' id='selectSubject' name='selectSubject' size='40' class='form-control limited' maxlength='100'></td>
									</tr>
									<tr>
									<td class='hidden-480' width='110px'>内容</td>
									<td>
<!-- 										<input type='text' id='selectContent' name='selectContent' size='40' class='form-control limited' maxlength='100'> -->
											<textarea id="selectContent" name="selectContent" rows="3" cols="50" wrap="soft" class='form-control limited' placeholder="活动内容"></textarea>
									</td>
									</tr>
									<tr>
									<td class='hidden-480' width='110px'>公示范围</td>
									<td>
										<select id='selectScope' name='selectScope'>
											<option value=''>-请选择-</option>
											<option value='1'>区域</option>
											<option value='2'>乡镇</option>
											<option value='3'>村</option>
										</select>
									</td>
									</tr>
									<tr>
									<td class='hidden-480' width='110px'>乡镇</td>
									<td>
									<select id='selectTownID' name='selectTownID'>
									<option value=''> </option>
									</select>
									</td>
									</tr>
									<tr>
									<td class='hidden-480' width='110px'>村</td>
									<td>
									<select id='selectVillageID' name='selectVillageID'>
									<option value=''> </option>
									</select>
									</td>
									</tr>
									<tr>
									<td class='hidden-480' width='110px'>是否展示</td>
									<td><select id='selectIsShow' name='selectIsShow'>
											<option value=''>-请选择-</option>
											<option value='是'>是</option>
											<option value='否'>否</option>
										</select>
									</td>
									</tr>
									<tr>
									<td class='hidden-480' width='110px'>备注</td>
									<td><input type='text' id='selectMark' name='selectMark' size='40' class='form-control limited' maxlength='100'></td>
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
						"${contextPath}/static/assets/js/jquery-ui.js",
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
						$.each(dataObj, function(i, item) {
							var ui = "<option value='"+item.id+"'>"
									+ item.name + "</option>"
							$("#selectTownID").append(ui);
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
						$("#selectVillageID").val("");
						document.getElementById("selectVillageID").disabled = true;
					}
				});
			})
		})
		///添加通知表单输入信息验证
		$("#submitButton").bind("click", function() {
			$('#validationAddNoticeForm').submit();
		});
		$('#validationAddNoticeForm').validate({
			errorElement : 'span',
			errorClass : 'help-block',
			focusInvalid : false,
			ignore : "",
			rules : {
				selectSubject : {
					required : true
				},
				selectContent : {
					required : true,
					maxlength : 255
				},
				selectScope : {
					required : true
				},
				selectTownID : {
					required : true
				},
				selectVillageID : {
					required : true
				},
				selectIsShow : {
					required : true
				},
				selectMark : {
					maxlength : 255
				}
			},
			messages : {
				selectTownID : {
					required : "请选择乡镇！"
				},
				selectVillageID : {
					required : "请选择村！"
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
				var selectNoticeID = $("#selectNoticeID").val().trim();
				var selectSubject = $("#selectSubject").val().trim();// 主题
				var selectContent = $("#selectContent").val().trim();// 内容
				var selectScope = $("#selectScope").val();// 公示范围，1为区域，2为乡镇，3为自然村	
				var selectTownID = $("#selectTownID").val();// 所属乡镇编码
				var selectVillageID = $("#selectVillageID").val();// 所属自然村编码
				var selectIsShow = $("#selectIsShow").val();// 是否展示，false为不展示
				var selectMark = $("#selectMark").val().trim();// 备注
				$.ajax({
					url : "${contextPath}/sys/notice/verifySaveNotice",
					data : {
						noticeID : selectNoticeID,
						subject : selectSubject,
						content : selectContent,
						scope : selectScope,
						zoneID : '0001',//默认区域为0001，栾城区
						townID : selectTownID,
						villageID : selectVillageID,
						isShow : selectIsShow,
						mark : selectMark
					},
					dataType : "json",
					type : "post",
					complete : function(response){
						var mark = eval("(" + response.responseText + ")"); 
						if(mark.success){
							$("#modal-table").modal("toggle");
						 	$('#query').click();
						}else{
							promptInfo(mark.information,"warning,center");
							return false;
						}
					}
				})  
			},
			invalidHandler : function(form) {
			}
		});
		function LookData(id){
			$("#selectNoticeID").val(id);
			$.ajax({
				url : "${contextPath}/sys/notice/getNoticeById",
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
					$("#selectSubject").val("");
					$("#selectContent").val("");
					$("#selectScope").val("");
					$("#selectTownID").val("");
					$("#selectVillageID").val("");
					$("#selectIsShow").val("");
					$("#selectMark").val("");
					$("#selectSubject").val(obj.subject);
					$("#selectContent").val(obj.content);
					$("#selectScope").val(obj.scope);
					$("#selectTownID").val(obj.townID);
					$("#selectVillageID").val(obj.villageID);
					$("#selectIsShow").val(obj.isShowCn);
					$("#selectMark").val(obj.selectMark);				}
			});
			$("#modal-table").modal("toggle");
		}
// 		$('#submitButton').on('click', function() {
// 			var selectNoticeID = $("#selectNoticeID").val().trim();
// 			var selectSubject = $("#selectSubject").val().trim();// 主题
// 			var selectContent = $("#selectContent").val().trim();// 内容
// 			var selectScope = $("#selectScope").val();// 公示范围，1为区域，2为乡镇，3为自然村	
// 			var selectTownID = $("#selectTownID").val();// 所属乡镇编码
// 			var selectVillageID = $("#selectVillageID").val();// 所属自然村编码
// 			var selectIsShow = $("#selectIsShow").val();// 是否展示，false为不展示
// 			var selectMark = $("#selectMark").val().trim();// 备注
// 			var mark = false;
// 			var markTxt = "";
// 			if('' == selectSubject || '' == selectContent){
// 				mark = true;
// 				markTxt = '主题、内容不能为空';
// 			}else if('' == selectScope){
// 				mark = true;
// 				markTxt = '公示范围不能为空';
// 			}else if(2==selectScope && ''==selectTownID){
// 				mark = true;
// 				markTxt = '公示范围为乡镇，乡镇选择不能为空';
// 			}else if(3==selectScope && (''==selectTownID || '' == selectVillageID)){
// 				mark = true;
// 				markTxt = '公示范围为自然村,乡镇选择、村选择不能为空';
// 			}else if('' == selectIsShow){
// 				mark = true;
// 				markTxt = '是否展示不能为空';
// 			}
// 			if(mark){
// 				promptInfo(markTxt,"warning,center");
// 				return false;
// 			}else{
// 				$.ajax({
// 					url : "${contextPath}/sys/notice/verifySaveNotice",
// 					data : {
// 						noticeID : selectNoticeID,
// 						subject : selectSubject,
// 						content : selectContent,
// 						scope : selectScope,
// 						zoneID : '0001',//默认区域为0001，栾城区
// 						townID : selectTownID,
// 						villageID : selectVillageID,
// 						isShow : selectIsShow,
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
        			url : "${contextPath}/sys/notice/getNotice",
        			datatype : "json",
        			height : 450,
        			colNames : ['', 'ID', '主题','内容', '公示范围', 
        			            '乡镇', '村' , '发表时间', '公告者', 
        			            '是否展示', '备注', '操作'],
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
        				name : 'subject',
        				index : 'subject',
        				label : '主题',
        				width : 80,
        				editable : true,
        				search : false
        			}, {
        				name : 'content',
        				index : 'content',
        				label : '内容',
        				width : 80,
        				editable : true,
        				search : false
        			},  {
        				name : 'scopeCn',
        				index : 'scope',
        				label : '公示范围',
        				width : 80,
        				editable : true,
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
        				name : 'createTime',
        				index : 'createTime',
        				label : '发表时间',
        				width : 80,
        				editable : true,
        				search : false
        			}, {
        				name : 'userCn',
        				index : 'user',
        				label : '公告者',
        				width : 80,
        				editable : true,
        				search : false
        			}, {
        				name : 'isShowCn',
        				index : 'isShow',
        				label : '是否展示',
        				width : 80,       		
        				editable : true,
        				search : false
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
        			editurl : "${contextPath}/sys/notice/operateNotice",
        			//caption : "用户管理列表",
        			//autowidth : true,
        			gridComplete : function(){
        				var ids = jQuery(grid_selector).jqGrid('getDataIDs');
        				for(var i = 0; i < ids.length; i++){
        					var id = ids[i];
        					look = "<a href='#page/notice' onclick='LookData(\"" + id + "\")'>修改</a>";		
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
        			view : false,
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
						$("#selectNoticeID").val("");
						$("#selectSubject").val("");
						$("#selectContent").val("");
						$("#selectScope").val("");
						$("#selectTownID").val("");
						$("#selectVillageID").val("");
						$("#selectIsShow").val("");
						$("#selectMark").val("");
						//document.getElementById("selectTownID").disabled = true;
						//document.getElementById("selectVillageID").disabled = true;
						$("#modal-table").modal("toggle");
					},       
					position:"first"
				});
        		
        		// add custom button to export the data to excel
        		
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
