<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<title>推荐人信息</title>
<jsp:include page="../../inc.jsp"></jsp:include>
<style type="text/css">
p {
	margin: 0 0;
	padding: 0 0
}

.td1 {
	width: 30%;
}
</style>
</head>
<body>
	<div class="easyui-layout" data-options="fit : true,border : false">
		
			<table style="width: 70%; margin:auto; margin-top: 10px">
				<tr>
					<td >系统号：</td><td >${agent.pager }</td>				
				</tr>
				<tr>
					<td >姓名：</td><td >${agent.name }</td>	
				</tr>
				<tr>
					<td >职位：</td><td >${agent.title }</td>	
				</tr>
				<tr>
					<td >手机号：</td><td >${agent.mobile }</td>	
				</tr>
				<tr>
					<td >部门：</td>	
				</tr>
				<tr>
					<td >${agent.department }</td>
				</tr>
			</table>		
	</div>
</body>
</html>