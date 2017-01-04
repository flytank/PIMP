<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}"></c:set>

<!-- ajax layout which only needs content area -->
<div class="page-header">
	<h1>
		${sessionScope.SESSION_SYS_USER.userName}
		<small>
			<i class="ace-icon fa fa-angle-double-right"></i>
			管理系统
		</small>
	</h1>
</div><!-- /.page-header -->

<!-- <div class="row">
	<div class="col-xs-12">
	</div>/.col
</div>/.row -->
<div class="col-sm-3">
	<div class="infobox-left-img"><img src="${contextPath}/static/assets/images/square-blue.png"></div>
	<div class="infobox-left-span"><span>全区积分信息</span></div>
</div>
<div class="col-sm-9 infobox-container">
	<!-- #section:pages/dashboard.infobox -->
	<div class="infobox infobox-black">
		<div class="infobox-icon">
			<img src="${contextPath}/static/assets/images/hzzs.png" height="60"
				width="60" />
		</div>

		<div class="infobox-data">
			<span class="infobox-data-number" id="hzzs">${栾城镇}</span>
			<div class="infobox-content">栾城镇</div>
		</div>
	</div>

	<div class="infobox infobox-black">
		<div class="infobox-icon">
			<img src="${contextPath}/static/assets/images/hhb.png" height="60"
				width="60" />
		</div>

		<div class="infobox-data">
			<span class="infobox-data-number" id="hhb">${楼底镇 }</span>
			<div class="infobox-content">楼底镇</div>
		</div>
	</div>

	<div class="infobox infobox-black">
		<div class="infobox-icon">
			<img src="${contextPath}/static/assets/images/zghs.png" height="60"
				width="60" />
		</div>

		<div class="infobox-data">
			<span class="infobox-data-number" id="zghs">${冶河镇 }</span>
			<div class="infobox-content">冶河镇</div>
		</div>
	</div>

	<div class="infobox-container" style="width: 100%;">

		<div class="infobox infobox-black">
			<div class="infobox-icon">
				<img src="${contextPath}/static/assets/images/ssrc.png" height="60"
					width="60" />
			</div>

			<div class="infobox-data">
				<span class="infobox-data-number" id="sshz">${窦妪镇 }</span>
				<div class="infobox-content">窦妪镇</div>
			</div>
		</div>

		<div class="infobox infobox-black">
			<div class="infobox-icon">
				<img src="${contextPath}/static/assets/images/cwsyl.png" height="60"
					width="60" />
			</div>

			<div class="infobox-data">
				<span class="infobox-data-number" id="cwsyl">${西营乡 }</span>
				<div class="infobox-content">西营乡</div>
			</div>
		</div>

		<div class="infobox infobox-black">
			<div class="infobox-icon">
				<img src="${contextPath}/static/assets/images/pjzyts.png"
					height="60" width="60" />
			</div>

			<div class="infobox-data">
				<span class="infobox-data-number" id="pjzyts">${南高乡 }</span>
				<div class="infobox-content">南高乡</div>
			</div>
		</div>
		
	</div>
	<div class="infobox-container" style="width: 100%;">
		<div class="infobox infobox-black">
			<div class="infobox-icon">
				<img src="${contextPath}/static/assets/images/pjzyts.png"
					height="60" width="60" />
			</div>

			<div class="infobox-data">
				<span class="infobox-data-number" id="pjzyts">${柳林屯乡 }</span>
				<div class="infobox-content">柳林屯乡</div>
			</div>
		</div>
	</div>
</div>
<!-- page specific plugin scripts -->

<!--[if lte IE 8]>
  <script src="${contextPath}/static/assets/js/excanvas.js"></script>
<![endif]-->
<script type="text/javascript">
		var scripts = [ null, "${contextPath}/static/assets/js/jquery-ui.custom.js", "${contextPath}/static/assets/js/jquery.ui.touch-punch.js", "${contextPath}/static/assets/js/jquery.easypiechart.js", "${contextPath}/static/assets/js/jquery.sparkline.js",
        		"${contextPath}/static/assets/js/flot/jquery.flot.js", "${contextPath}/static/assets/js/flot/jquery.flot.pie.js", "${contextPath}/static/assets/js/flot/jquery.flot.resize.js", "${contextPath}/static/assets/js/activities-serverload.js", null ]
        $('.page-content-area').ace_ajax('loadScripts', scripts, function() {
        	// inline scripts related to this page
        	jQuery(function($) {
        		
        		
        	})
        });
		
</script>
