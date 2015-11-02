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
	//判断当前页数和总页数是否相等 -- 相等则隐藏加载更多
	$(function(){
		$("#jl").click(function(){
			window.location.href="loginTurnXq.do";
		});	
		
		$("#zl").click(function(){
			//window.location.href="assistantMain.do";
			window.location.href="${pageContext.request.contextPath}/jf/empController/add"
		});
	});
});
</script>
<style type="text/css">
	.loginbtn {
		height: 45px;
	}
	.back {
		 background:#FFF url('images/BG.png')top center no-repeat; background-size:cover
	}
	.head {
		padding-top : 8%;
		text-align: center;
		font-size: 20px;
		font-weight: bold;
	}
	
	.title {
		padding-top : 20%;
		text-align: left;
		font-size: 40px;
		color:#1b5e20;
		padding-left:7.5%;
		font-weight: bold;
	}
	
	.titleSecond {
		text-align: left;
		font-size: 25px;
		color:#1b5e20;
		padding-left:7.5%;
		font-weight: bold;
	}
	.loginbtn{
		background-color:#1b5e20;
		border-left:0px;border-top:0px;border-right:0px;border-bottom:1px;
	}
</style>
</head>

<body class="back">
<div class="main">
    <!-- head start -->
    <!-- head end -->
    <!-- mid start -->
    <div class="title">招聘推荐</div>
    <div class="mid" style="padding-top: 40%"><div>
    <!-- <div class="btn" id="clickMore"><div class="loginbtn" style="width: 85%;margin:0 auto"><input  id="jl" type="button" value="我要招人" /></div></div>-->
    <div class="btn" id="clickMore"><div class="loginbtn" style="width: 85%;margin:0 auto"><input  id="zl" type="button" value="我要推荐" /></div></div>
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
