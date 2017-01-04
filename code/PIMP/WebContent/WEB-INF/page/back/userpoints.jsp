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
			$.ajax({
				type : "POST",
				url : "${contextPath}/sys/resource/getTownListByZoneID",
				data : {
					zoneID : '0001'
				},
				success : function(data) {
					var dataObj = eval("(" + data + ")");
					$("#selectTownID").empty();
					var ui = "<option value=''> </option>"
					$("#queryTownID").append(ui);
					$.each(dataObj, function(i, item) {
						var ui = "<option value='"+item.id+"'>"
								+ item.name + "</option>"
						$("#queryTownID").append(ui);
					})
				}
			})
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
							var ui = "<option value=''> </option>"
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
<div id="modal-table" class="modal fade text-center" tabindex="-1" data-backdrop="static">
	<div class="modal-dialog" style="display: inline-block; width: 80%;margin-left:auto;margin-right: auto;">
			<div class="modal-content" >
				<div class="modal-header no-padding text-left">
					<div class="table-header">
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true">
							<span class="white">&times;</span>
						</button>
						详细信息
					</div>
				</div>
				<div class="modal-body" style="overflow-y: scroll;">
					<div id="modal-tip" class="red clearfix"></div>					
					<div class="widget-box widget-color-blue2">
						<div class="widget-body">
							<div class="widget-main padding-8">
								<table id="ymInformation" style="margin-left:auto;margin-right: auto;width:80%; text-left">
									
								</table>
								<table id="information" class='table table-striped table-bordered table-hover' >
									
								</table>								
							</div>
							<div class="text-center">
								<button class="btn btn-app btn-pink btn-xs" data-dismiss="modal">
									<i class="ace-icon fa fa-share bigger-160"></i>
									关闭
								</button>
							</div>
						</div>
					</div>
				</div>
			</div><!-- /.modal-content -->
	</div><!-- /.modal-dialog -->
</div>
<div id="modal-table-change" class="modal fade text-center" tabindex="-1" data-backdrop="static">
	<div class="modal-dialog" style="display: inline-block; width: 80%;margin-left:auto;margin-right: auto;">
			<div class="modal-content" >
				<div class="modal-header no-padding text-left">
					<div class="table-header">
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true">
							<span class="white">&times;</span>
						</button>
						详细信息
					</div>
				</div>
				<div class="modal-body" style="overflow-y: scroll;">
					<div id="modal-tip" class="red clearfix"></div>
					<input id="userId" type="hidden" />
					<div class="widget-box widget-color-blue2">
						<div class="widget-body">
							<div class="widget-main padding-8">
								<table id="ymInformation-change" style="margin-left:auto;margin-right: auto;width:80%; text-left">
									
								</table>
								<table id="information-change" class='table table-striped table-bordered table-hover' >
									
								</table>								
							</div>
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
					</div>
				</div>
				<!-- <div class="modal-footer no-margin-top">
					
				</div> -->
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
		function LookData(id){
			$.ajax({
				url : "${contextPath}/sys/userpoints/getUserPointsList",
				data : {userID : id},
				dataType : "json",
				type : "post",
				complete : function(response){
					var data = eval("(" + response.responseText + ")"); 
					$("#ymInformation").html("<tr><td colspan='4'style='text-align: center;'>"
							+"<label style='text-align: center;font-weight: bolder;font-size: xx-large;'>"
							+"用户积分信息</label></td></tr><tr><td>乡镇："+data.townCn
							+"</label></td><td>村："+data.villageCn
							+"</td><td>姓名："+data.userName
							+"</td><td>得分："+data.totalpoints+"</td></tr>");
					$("#information").empty();
					var tableTD="<tr><th style='vertical-align:middle;text-align: center;'>职责</th>"
						+"<th style='vertical-align:middle;text-align: center;'>职责分值</th>"
						+"<th style='vertical-align:middle;text-align: center;'>详细内容</th>"
						+"<th style='vertical-align:middle;text-align: center;'>属性分值</th>"
						+"<th style='vertical-align:middle;text-align: center;'>属性得分</th>"
						+"<th style='vertical-align:middle;text-align: center;'>实得分</th></tr>";
					var index = 0;
					$(data.dutyList).each(function(){
						var duty = data.dutyList[index];
						tableTD += "<tr><td rowspan='"+duty.dutyPointsList.length
							+"' style='vertical-align:middle;text-align: center;'>"+duty.dutyName+"</td>"
							+"<td rowspan='"+duty.dutyPointsList.length
							+"' style='vertical-align:middle;text-align: center;'>"
							+(null==duty.points?"":duty.points)+ "</td>";
						if(duty.dutyPointsList.length > 1){
							var pointsIndex = 0;
							$(duty.dutyPointsList).each(function(){
								var dutyPoints = duty.dutyPointsList[pointsIndex];
								if(pointsIndex != 0){
									tableTD += "<tr>";
								}
								tableTD += "<td style='vertical-align:middle;text-align: left;'>"
									+dutyPoints.sourceName+ "</td>"
									+"<td style='vertical-align:middle;text-align: left;'>"
									+(null == dutyPoints.points?"":dutyPoints.points)+ "</td>"
									+"<td style='vertical-align:middle;text-align: left;'>"
									+dutyPoints.sourcePoints+ "</td>";
								if(pointsIndex == 0){
									tableTD += "<td rowspan='"+duty.dutyPointsList.length
									+"' style='vertical-align:middle;text-align: center;'>"+duty.allpoints+"</td>";
								}
								tableTD += "</tr>";
								pointsIndex++;
							})  
						}else{
							var dutyPoints = duty.dutyPointsList[0];
							tableTD += "<td style='vertical-align:middle;text-align: left;'>"
								+dutyPoints.sourceName+ "</td>"
								+"<td style='vertical-align:middle;text-align: left;'>"
								+(null==dutyPoints.points?"":dutyPoints.points)+ "</td>"
								+"<td style='vertical-align:middle;text-align: left;'>"
								+dutyPoints.sourcePoints+ "</td>"
								+ "<td style='vertical-align:middle;text-align: center;'>"+duty.allpoints+"</td>";
							tableTD += "</tr>";  
						}  
						index++;
					});
					$("#information").append(tableTD);	
				}
			})
			$("#modal-table").modal("toggle");
		}
		function checkNum(key, points){
			if(null != points && $("#"+key).val() > points){
				$("#"+key).val(0);
				promptInfo("输入数据不能超过属性分值","warning,center");
			}else if(null != points && $("#"+key).val() < 0){
				$("#"+key).val(0);
				promptInfo("输入数据不能小于0","warning,center");
			}
		}
		function updateData(id){
			$("#userId").val(id);
			$.ajax({
				url : "${contextPath}/sys/userpoints/getUserPointsList",
				data : {userID : id},
				dataType : "json",
				type : "post",
				complete : function(response){
					var data = eval("(" + response.responseText + ")"); 
					$("#ymInformation-change").html("<tr><td colspan='4'style='text-align: center;'>"
							+"<label style='text-align: center;font-weight: bolder;font-size: xx-large;'>"
							+"用户积分信息</label></td></tr><tr><td>乡镇："+data.townCn
							+"</label></td><td>村："+data.villageCn
							+"</td><td>姓名："+data.userName
							+"</td><td><div id='Score'>得分："+data.totalpoints+"<div></td></tr>");
					$("#information-change").empty();
					var tableTD="<tr><th style='vertical-align:middle;text-align: center;'>职责</th>"
						+"<th style='vertical-align:middle;text-align: center;'>职责分值</th>"
						+"<th style='vertical-align:middle;text-align: center;'>详细内容</th>"
						+"<th style='vertical-align:middle;text-align: center;'>属性分值</th>"
						+"<th style='vertical-align:middle;text-align: center;'>属性得分</th>"
						+"<th style='vertical-align:middle;text-align: center;'>实得分</th></tr>";
					var index = 0;
					var dutyIndex = 0;
					$(data.dutyList).each(function(){
						var duty = data.dutyList[index];
						tableTD += "<tr><td rowspan='"+duty.dutyPointsList.length
							+"' style='vertical-align:middle;text-align: center;'>"+duty.dutyName+"</td>"
							+"<td rowspan='"+duty.dutyPointsList.length
							+"' style='vertical-align:middle;text-align: center;'>"
							+(null==duty.points?"":duty.points)+ "</td>";
						if(duty.dutyPointsList.length > 1){
							var pointsIndex = 0;
							$(duty.dutyPointsList).each(function(){
								var dutyPoints = duty.dutyPointsList[pointsIndex];
								if(pointsIndex != 0){
									tableTD += "<tr>";
								}
								tableTD += "<td style='vertical-align:middle;text-align: left;'>"
									+dutyPoints.sourceName+ "</td>"
									+"<td style='vertical-align:middle;text-align: left;'>"
									+(null == dutyPoints.points?"":dutyPoints.points)+ "</td>"
									+"<td style='vertical-align:middle;text-align: left;'>"
									+"<input id='duty"+dutyIndex+"' type='number' "
									+" size='40' class='form-control limited' maxlength='100'"
									+" value='"+dutyPoints.sourcePoints+"'"
									+" onchange='checkNum(\"duty"+dutyIndex+"\",\""+dutyPoints.points+"\")'>" 
									+"<input id='points_Id"+dutyIndex+"' type='hidden' value='"+dutyPoints.id+"' />"
									+"<input id='points_UserID"+dutyIndex+"' type='hidden' value='"+dutyPoints.userID+"' />"
									+"<input id='points_source"+dutyIndex+"' type='hidden' value='"+dutyPoints.source+"' />"
									+"<input id='points_sourceID"+dutyIndex+"' type='hidden' value='"+dutyPoints.sourceID+"' />"
									+ "</td>";
								if(pointsIndex == 0){
									tableTD += "<td rowspan='"+duty.dutyPointsList.length
									+"' style='vertical-align:middle;text-align: center;'>"
									+"<div id='allpoints"+dutyIndex+"'>"+duty.allpoints+"</div>" 
									+"</td>";
								}
								tableTD += "</tr>";
								dutyIndex++;
								pointsIndex++;
							})  
						}else{
							var dutyPoints = duty.dutyPointsList[0];
							tableTD += "<td style='vertical-align:middle;text-align: left;'>"
								+dutyPoints.sourceName+ "</td>"
								+"<td style='vertical-align:middle;text-align: left;'>"
								+(null==dutyPoints.points?"":dutyPoints.points)+ "</td>"
								+"<td style='vertical-align:middle;text-align: left;'>"
								+"<input id='duty"+dutyIndex+"' type='number' "
								+" size='40' class='form-control limited' maxlength='100'"
								+" value='"+dutyPoints.sourcePoints+"'"
								+" onchange='checkNum(\"duty"+dutyIndex+"\",\""+dutyPoints.points+"\")'>"
								+"<input id='points_Id"+dutyIndex+"' type='hidden' value='"+dutyPoints.id+"' />"
								+"<input id='points_UserID"+dutyIndex+"' type='hidden' value='"+dutyPoints.userID+"' />"
								+"<input id='points_source"+dutyIndex+"' type='hidden' value='"+dutyPoints.source+"'  />"
								+"<input id='points_sourceID"+dutyIndex+"' type='hidden' value='"+dutyPoints.sourceID+"' />"
								+ "</td>"
								+ "<td style='vertical-align:middle;text-align: center;'>"
								+"<div id='allpoints"+dutyIndex+"'>"+duty.allpoints+"</div>" 
								+"</td>";
							dutyIndex++;
							tableTD += "</tr>";  
						}  
						index++;
					});
					$("#information-change").append(tableTD);
					//相应的处理操作
					$("#submitButton").unbind();
					$('#submitButton').bind('click', function() {
						var mark = true;
						var index = 0;
						var dutyIndex = 0;
						var dataArray = new Array();
						$(data.dutyList).each(function(){
							var duty = data.dutyList[index];
							if(duty.dutyPointsList.length > 1){
								var pointsIndex = 0;
								$(duty.dutyPointsList).each(function(){
									var dutyPoints = duty.dutyPointsList[pointsIndex];
									var json = "{";
									json += "'sourcePoints':'"+$("#duty"+dutyIndex).val().trim()+"',";
									json += "'Id':'"+ $("#points_Id"+dutyIndex).val()+"',";
									json += "'UserID':'"+ $("#points_UserID"+dutyIndex).val()+"',";
									json += "'source':'"+ $("#points_source"+dutyIndex).val()+"',";
									json += "'sourceID':'"+ $("#points_sourceID"+dutyIndex).val()+"'";
									json += "}";
									if(null != dutyPoints.points){
										if($("#duty"+dutyIndex).val() > dutyPoints.points){
											mark = false;
										}
									}
									dataArray.push(json); 
									dutyIndex++;
									pointsIndex++;
								})
							}else{
								var dutyPoints = duty.dutyPointsList[0];
								var json = "{";
								json += "'sourcePoints':'"+$("#duty"+dutyIndex).val().trim()+"',";
								json += "'Id':'"+ $("#points_Id"+dutyIndex).val()+"',";
								json += "'UserID':'"+ $("#points_UserID"+dutyIndex).val()+"',";
								json += "'source':'"+ $("#points_source"+dutyIndex).val()+"',";
								json += "'sourceID':'"+ $("#points_sourceID"+dutyIndex).val()+"'";
								json += "}";
								if(null != dutyPoints.points){
									if($("#duty"+dutyIndex).val() > dutyPoints.points){
										mark = false;
									}
								}
								dataArray.push(json); 
								dutyIndex++;
							}
							index++;
						}) 
						if(mark == false){
							promptInfo("该数据不能超过属性分值","warning,center");
						}else{
							var dataJson = {};
							dataJson.userID = $("#userId").val();
							dataJson.dataArray = "["+dataArray+"]";
							$.ajax({
								url : "${contextPath}/sys/userpoints/verifySaveUserPoints",
								data : dataJson,
								dataType : "json",
								type : "post",
								complete : function(response){
									//var data = eval("(" + response.responseText + ")"); 
									$("#modal-table-change").modal("toggle");
									$('#query').click();
								}
							})
						}
					}) 
					/* index = 0;
					dutyIndex = 0;
					$(data.dutyList).each(function(){
						var duty = data.dutyList[index];
						if(duty.dutyPointsList.length > 1){
							var pointsIndex = 0;
							$(duty.dutyPointsList).each(function(){
								var dutyPoints = duty.dutyPointsList[pointsIndex];
								$("#duty"+dutyIndex).onchange(function(){		
									var sourcePoints = $("#duty"+dutyIndex).val();
									alert(sourcePoints);
									if(null != dutyPoints.points){
										if(sourcePoints > dutyPoints.points){
											promptInfo("该数据不能超过属性分值","warning,center");
										}else{
											$("#allpoints"+dutyIndex).val(sourcePoints);
											var temp = 0;
											$(duty.dutyPointsList).each(function(){
												
											})
										}
									} 
								}) 
								dutyIndex++;
								pointsIndex++;
							})  
						}else{
							dutyIndex++;  
						}  
						index++;
					})  */
				} 
			})
			$("#modal-table-change").modal("toggle");
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
        			url : "${contextPath}/sys/userpoints/getParty",
        			datatype : "json",
        			height : 450,
        			colNames : ['', 'ID', '姓名', '身份证', '身份', '党员类别', '党小组'
        			            , '区域','乡镇', '村' ,'积分', '操作'
        			            ],
        			colModel : [ {
        				name : '',
        				index : '',
        				width : 50,
        				fixed : true,
        				hidden : true,
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
        				name : 'userName',
        				index : 'userName',
        				label : '姓名',
        				width : 100,
        				editable : true,
        				editoptions : {size : "20", maxlength : "32"},
        				searchoptions : {sopt : ['cn']},
        				editrules : {required : true}
        			}, {
        				name : 'idCard',
        				index : 'idCard',
        				label : '身份证',
        				width : 110,
        				editable : true,
        				editoptions : {size : "20", maxlength : "18"},
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
        				name : 'points',
        				index : 'points',
        				label : '积分',
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
        			editurl : "${contextPath}/sys/userpoints/operateSysUser",
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
        					/* look = "<a href='#page/userpoints' onclick='LookData(\"" + id + "\")'>修改</a>&nbsp;&nbsp;&nbsp;"
        						+"<a href='#page/userpoints' onclick='resetPassword(\"" + id + "\")'>重置密码</a>";		
        					jQuery(grid_selector).jqGrid('setRowData', ids[i], {HANDLE : look});  */
        					look = "<a href='#page/userpoints' title='修改' onclick='updateData(\"" + id + "\")'>修改</a>"
    						+"&nbsp;&nbsp;&nbsp;<a href='#page/userpoints' title='查看' onclick='LookData(\"" + id + "\")'>查看</a>";		
    						//jQuery(grid_selector).jqGrid('setRowData', ids[i], {More : look});
    						jQuery(grid_selector).setCell(id,"HANDLE", look, "", { title:""} );
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
			    	   var form = "<form name='csvexportform' action='${contextPath}/sys/userpoints/operateSysUser?oper=excel' method='post'>";
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
