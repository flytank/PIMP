<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}"></c:set>

<!-- Custom CSS -->
<link rel="stylesheet" href="${contextPath}/static/assets/css/chartsreports/sb-admin.css" />
<link rel="stylesheet" href="${contextPath}/static/assets/css/chartsreports/morris.css" />
    
<div id="page-wrapper">

    <div class="container-fluid">
        <!-- /.row -->
        <div class="row">
            <div class="col-lg-12">
                <div class="panel panel-primary">
                    <div class="panel-heading">
                        <h3 class="panel-title"><i class="fa fa-line-chart"></i>线形图</h3>
                    </div>
                    <div class="panel-body">
                        <div class="flot-chart">
                            <div class="flot-chart-content" id="flot-line-chart"></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- /.row -->

        <div class="row">
            <div class="col-lg-6">
                <div class="panel panel-green">
                    <div class="panel-heading">
                        <h3 class="panel-title"><i class="fa fa-pie-chart"></i>饼图</h3>
                    </div>
                    <div class="panel-body">
                        <div class="flot-chart">
                            <div class="flot-chart-content" id="flot-pie-chart"></div>
                        </div>
                        <div class="text-right">
                            <a href="#">查看详细<i class="fa fa-arrow-circle-right"></i></a>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-lg-6">
                <div class="panel panel-red">
                    <div class="panel-heading">
                        <h3 class="panel-title"><i class="fa fa-line-chart"></i>实时线形图</h3>
                    </div>
                    <div class="panel-body">
                        <div class="flot-chart">
                            <div class="flot-chart-content" id="flot-moving-line-chart"></div>
                        </div>
                        <div class="text-right">
                            <a href="#">查看详细<i class="fa fa-arrow-circle-right"></i></a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- /.row -->

        <div class="row">
            <div class="col-lg-12">
                <div class="panel panel-green">
                    <div class="panel-heading">
                        <h3 class="panel-title"><i class="fa fa-area-chart"></i>区线图</h3>
                    </div>
                    <div class="panel-body">
                        <div id="morris-area-chart"></div>
                    </div>
                </div>
            </div>
        </div>
        <!-- /.row -->

        <div class="row">
            <div class="col-lg-4">
                <div class="panel panel-yellow">
                    <div class="panel-heading">
                        <h3 class="panel-title"><i class="fa fa-pie-chart"></i>圆环图</h3>
                    </div>
                    <div class="panel-body">
                        <div id="morris-donut-chart"></div>
                        <div class="text-right">
                            <a href="#">查看详细<i class="fa fa-arrow-circle-right"></i></a>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-lg-4">
                <div class="panel panel-red">
                    <div class="panel-heading">
                        <h3 class="panel-title"><i class="fa fa-line-chart"></i>线形图</h3>
                    </div>
                    <div class="panel-body">
                        <div id="morris-line-chart"></div>
                        <div class="text-right">
                            <a href="#">查看详细<i class="fa fa-arrow-circle-right"></i></a>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-lg-4">
                <div class="panel panel-primary">
                    <div class="panel-heading">
                        <h3 class="panel-title"><i class="fa fa-bar-chart"></i>柱状图</h3>
                    </div>
                    <div class="panel-body">
                        <div id="morris-bar-chart"></div>
                        <div class="text-right">
                            <a href="#">查看详细<i class="fa fa-arrow-circle-right"></i></a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- /.row -->

    </div>
    <!-- /.container-fluid -->

</div>
<!-- /#page-wrapper -->

<!-- page specific plugin scripts -->
<script type="text/javascript">
	var scripts = [null, "${contextPath}/static/assets/js/morris/raphael.min.js", 
	               "${contextPath}/static/assets/js/morris/morris.min.js", 
	               "${contextPath}/static/assets/js/morris/morris-data.js", 
	               "${contextPath}/static/assets/js/flot/jquery.flot.js", 
	               "${contextPath}/static/assets/js/flot/jquery.flot.tooltip.min.js", 
	               "${contextPath}/static/assets/js/flot/jquery.flot.resize.js", 
	               "${contextPath}/static/assets/js/flot/jquery.flot.pie.js", 
	               "${contextPath}/static/assets/js/flot/flot-data.js", null]
	$('.page-content-area').ace_ajax('loadScripts', scripts, function() {
	  //inline scripts related to this page
	});
</script>
