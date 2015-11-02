<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html>
<html>
<head>
<base href="<%=basePath%>">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
<title>店长新消息详情</title>
<link rel="stylesheet" type="text/css" href="style/style.css" />
<script src="http://code.jquery.com/jquery-1.11.0.min.js"></script>
<script type="text/javascript" src="js/job.js"></script>

</head>

<body>
<div class="main">
    <!-- head start -->
    <div class="head">
        <header>
            <div class="goback"><span></span>返回</div>
            店长新消息详情
            <div class="iconNone">
                &nbsp;
            </div>
        </header>
    </div>
    <!-- head end -->
    <!-- mid start -->
    <div class="mid">
        <form action="" name="" method="" id="">
        	<div class="orderul">
                <ul>
                    <div class="headinfo">人员信息</div>
                    <li class="orderullih">
                        <div class="orderullilw">姓名:</div>
                        <div class="orderullirw">
                            张三
                        </div>
                    </li>
                    <li class="orderullih">
                        <div class="orderullilw">年龄:</div>
                        <div class="orderullirw">
                            22
                        </div>
                    </li>
                    <li class="orderullih">
                        <div class="orderullilw">联系方式:</div>
                        <div class="orderullirw">
                            13800138000
                        </div>
                    </li>
                    <div class="headinfo">学校信息</div>
                    <li class="orderullih">
                        <div class="orderullilw">学历:</div>
                        <div class="orderullirw">
                            本科
                        </div>
                    </li>
                    <li class="orderullih">
                        <div class="orderullilw">学校级别:</div>
                        <div class="orderullirw">
                            A级
                        </div>
                    </li>
                    <li class="orderullih">
                        <div class="orderullilw">学校全称:</div>
                        <div class="orderullirw">
                            清华大学
                        </div>
                    </li>
                    <div class="headinfo">其他信息</div>
                    <li class="orderullih">
                        <div class="orderullilw">现居住地:</div>
                        <div class="orderullirw">
                            北京朝阳区建国门
                        </div>
                    </li>
                    <li class="orderullih">
                        <div class="orderullilw">预可面试时间:</div>
                        <div class="orderullirw">
                            2014-7-26
                        </div>
                    </li>
                    <li class="orderullih">
                        <div class="orderullilw">推荐人:</div>
                        <div class="orderullirw">
                            李四
                        </div>
                    </li>
                    
                </ul>
                <div class="btn"><div class="loginbtn greenbtn"><input type="submit" value="通知面试" /></div></div>
            </div>
            

        </form>
    </div>
    <!-- mid end -->
    <!-- foot start -->
    <div class="foot">
    </div>
    <!-- foot end -->
</div>
</body>
</html>
