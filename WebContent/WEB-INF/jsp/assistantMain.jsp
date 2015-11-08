<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	basePath = basePath + "weixin" + "/";
%>
<!DOCTYPE html>
<html>
<head>
<base href="<%=basePath%>">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
<title>链家V服务</title>
<link rel="stylesheet" type="text/css" href="<%=basePath %>style/style.css" />
<script src="http://code.jquery.com/jquery-1.11.0.min.js"></script>
<script type="text/javascript" src="<%=basePath %>js/job.js"></script>
<script type="text/javascript">
$(function(){
		$("#rightStyleHr").css('visibility','hidden');
		$("#leftStyleHr").css('visibility','visible');
		$("#insertBody").show();
		$("#turnBody").hide();
		//初始化显示
		$("#leftStyle").click(function(){
			$("#rightStyleHr").css('visibility','hidden');
			$("#leftStyleHr").css('visibility','visible');
			$("#insertBody").show();
			$("#turnBody").hide();
		});	
		
		$("#rightStyle").click(function(){
			$("#leftStyleHr").css('visibility','hidden');
			$("#rightStyleHr").css('visibility','visible');
			$("#insertBody").hide();
			$("#turnBody").show();
		});
		
		$(".iconsLeft").click(function(){
			//window.location.href="${basePath}trunMain.do";	
			window.location.href="${pageContext.request.contextPath}/weixin/api/toadd"
		});
		
});
</script>
<style type="text/css">
	.buttonLeftStyle {
		margin-left:1%;
		text-align:center;
		height: 40px;
		line-height: 40px;
		font-size: 15px;
		float:left;
		width:48.5%;
		font-weight:bold;
		color:#37844d;
	}
	
	.buttonRightStyle {
		margin-right:1%;
		text-align:center;
		line-height: 40px;
		float:right;
		height: 40px;
		font-weight:bold;
		float:right;
		width:48.5%;
		font-size: 15px;
		color:#37844d;
	}
	
	.hrWidth {
	 width:65%;
	 background-color: #37844d;
	 border: 0px;
	 height: 3px;
	}
	
	.buttonCenterStyle {	
		text-align:center;
		line-height: 40px;
		float:right;
		height: 40px;
		font-weight:bold;	
		width:100%;
		font-size: 15px;
		color:#37844d;
	}
	
</style>
</head>

<body>
<div class="main">
    <!-- head start -->
    <div class="head">
    	<header>
    		<div class="iconsLeft">&lt;&nbsp;招聘推介
			</div><span id="insertInfo">
    		</span>
    		<div class="icons">
            </div>
    	</header>
    </div>
    <!-- head end -->
    <!-- mid start -->
    <div class="mid" >
    	<div >
    		<div>
    			<div id="leftStyle" class="buttonCenterStyle">
    				人员发布
    			</div>
    		</div>
    		<!-- 
    		<div><div id="leftStyle" class="buttonLeftStyle" >人员发布</div>
    		
    		<div id="rightStyle" class="buttonRightStyle" >已发布列表</div>
    		
    		</div> 
    		
    		<div><div id="leftStyleHr" class="buttonLeftStyle" ><hr class="hrWidth"/></div><div id="rightStyleHr" class="buttonRightStyle" ><hr  class="hrWidth"/></div></div>
    		-->
    	</div>
    	<div id="insertBody">
    		<jsp:include page="createCandidates.jsp"></jsp:include>
    	</div>
    	<div id="turnBody">
    		<jsp:include page="assistantRight.jsp"></jsp:include>
    	</div>
    </div>
    <!-- mid end -->
    <!-- foot start -->
    <div class="foot">
    </div>
    <!-- foot end -->
</div>
</body>
</html>
