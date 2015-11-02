<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>资讯详情</title>
<style type="text/css">
span {
	margin-left: 10px;
	font-size: 16px;
}

div, hr, span, p {
	margin: 0px 0px;
	padding: 0px 0px;
}
</style>
</head>
<body>
	<div style="width: 100%; margin-top: 2%; margin-left: 3%;">

		<p style="font-size: 24px">${news.title }</p>

		<p>
			创建时间：
			<fmt:formatDate value="${news.createdate}"
				pattern="yyyy/MM/dd  HH:mm:ss" />
			&nbsp&nbsp发布方：${news.publish }
		</p>
<div  style="border-top:  1px dashed #D4D6DB; padding-top: 10px; margin-top: 10px;">
		<p style="margin-bottom: 10px ;m">简介：${news.intro }</p>
		
			<p>${news.content }</p>
		</div>
	</div>
</body>
</html>