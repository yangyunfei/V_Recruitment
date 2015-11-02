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
<title>录入应聘者信息</title>
<script src="http://code.jquery.com/jquery-1.11.0.min.js"></script>
<link rel="stylesheet" type="text/css" href="style/style.css" />
<script type="text/javascript" src="<%=basePath %>js/job.js"></script>
<script type="text/javascript" src="<%=basePath %>js/jquery.form.js"></script>
<script type="text/javascript" src="<%=basePath %>js/validate.js"></script>
<script type="text/javascript" src="<%=basePath %>js/loading.js"></script>
<script type="text/javascript">

$(function() {
	var matchFlag = -1;
	$("#assistantId").click(function(){
		window.location.href="${basePath}searchRecruitmentInformation.do";
	}); //推荐
	
	$("#matchingId").click(function(){
		matchFlag= 1;
		window.location.href= "${basePath}assistantView.do?matchFlag="+matchFlag;
	}); //待匹配人员
	
	$("#matched").click(function(){
		matchFlag= 2;
		window.location.href= "${basePath}assistantView.do?matchFlag="+matchFlag;
	}); //匹配中人员
	
	$("#matchSucc").click(function(){
		matchFlag= 3;
		window.location.href= "${basePath}assistantView.do?matchFlag="+matchFlag;
	}); //匹配成功人员
	
	$("#matchFailed").click(function(){
		matchFlag= 4;
		window.location.href= "${basePath}assistantView.do?matchFlag="+matchFlag;
	}); //匹配失败

});
</script>

<style type="text/css">
	.divLeft {
		margin:auto;
		text-align: left;
		font-size: 15px;
		width:100%;
		height: 40px;
		line-height:40px;
		font-weight:bold;
		color: #999;
		background-color: #ffffff;
		border: 0px;
	}
	
	hr{
		width: 100%;
		background-color: #bab5b5;
		border: 0px;
		height: 2px;
	}
	
	.one {
		padding-left:2.5%;
	}
	
	.two {
		position: absolute;left:90%;
	}
	
	.mids {
	background-color: #ffffff;
	}
</style>
</head>

<body>
<div id = "leo" ></div>
<div class="main">
    <!-- head start -->
    <div class="head">
    </div>
    <!-- head end -->
    <!-- mid start -->
    <div class="mid" style="padding-top: 12%;">
    	<div class="divLeft" style="background-color: #ececec"></div>
    	<div class="mids">
    			<hr/>
        		<div class="divLeft" id="assistantId"><span class="one">我要推荐</span><span class="two">&gt;</span></div>
	    		<hr/>
    	</div>
    	<div class="mids">
    			<hr/>
	        	<div class="divLeft" id="matchingId"><span class="one">待匹配人员</span><span class="two">&gt;</span></div>
	    		<hr/>
	    		<div class="divLeft" id="matched"><span class="one">匹配中人员</span><span class="two">&gt;</span></div>
	 			<hr/>
	    		<div class="divLeft" id="matchSucc"><span class="one">匹配成功人员</span><span class="two">&gt;</span></div>
	    		<hr/>
	    		<div class="divLeft" id="matchFailed"><span class="one">失效人员</span><span class="two">&gt;</span></div>
	    		<hr/>
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
