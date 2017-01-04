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
				url : "${contextPath}/sys/resource/getAllTownListByZoneID",
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
						url : "${contextPath}/sys/resource/getAllVillageListByTownID",
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
        			url : "${contextPath}/sys/activity/getLookActivity",
        			datatype : "json",
        			height : 450,
        			colNames : ['',  'ID', '主题','内容', '开始时间','结束时间', '活动范围',  
        			            '区域','乡镇', '村' ,'地点',  '所属职责', '活动积分','是否展示','备注', '操作'],
        			colModel : [  {
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
        			},  {
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
        				name : 'startDate',
        				index : 'startDate',
        				label : '开始时间',
        				width : 80,
        				editable : true,
        				search : false
        			},  {
        				name : 'endDate',
        				index : 'endDate',
        				label : '结束时间',
        				width : 80,
        				editable : true,
        				search : false
        			}, {
        				name : 'scopeCn',
        				index : 'scope',
        				label : '活动范围',
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
        				name : 'place',
        				index : 'place',
        				label : '地点',
        				width : 100,
        				editable : false,
        				editoptions : {size : "20", maxlength : "32", readonly : true},
        				searchoptions : {sopt : ['cn']},
        				editrules : {required : true}
        			},  {
        				name : 'dutyCn',
        				index : 'dutyCode',
        				label : '所属职责',
        				width : 80,
        				editable : true,
        				search : false
        			}, {
        				name : 'points',
        				index : 'points',
        				label : '活动积分',
        				width : 80,
        				editable : true,
        				search : false
        			}, {
        				name : 'isShowCn',
        				index : 'isShow',
        				label : '是否展示',
        				width : 80, 
        				hidden : true,
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
        				hidden : true,
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
        			editurl : "${contextPath}/sys/activity/operateActivity",
        			//caption : "用户管理列表",
        			//autowidth : true,
        			gridComplete : function(){
        				/* var ids = jQuery(grid_selector).jqGrid('getDataIDs');
        				for(var i = 0; i < ids.length; i++){
        					var id = ids[i];
        					look = "<a href='#page/activity' onclick='LookData(\"" + id + "\")'>修改</a>";		
        					jQuery(grid_selector).jqGrid('setRowData', ids[i], {HANDLE : look});
        				} */
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
        		
        		//开始时间选择
        		$("#selectStartDate").datetimepicker({
        			language: 'zh-CN',
        	        pickTime: false,
        	        todayBtn: true,
        	        autoclose: true,
        	        minView: '2',
        	        forceParse: false,
        	        dataFormat:"yy-mm-dd"
        		});
        		//结束时间选择
        		$("#selectEndDate").datetimepicker({
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
