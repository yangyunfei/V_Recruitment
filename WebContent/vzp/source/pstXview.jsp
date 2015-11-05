<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<title>求职者基本信息</title>
<jsp:include page="../../inc.jsp"></jsp:include>、
</head>
<body>
	<div class="easyui-layout" data-options="fit : true,border : false">
		
			<table style="width: 90%; margin-left: 5% ;margin-right:5%; margin-top: 10px">
				<tr>
					<td class="td1">姓名</td>
					<td>${pt.name }</td>
				</tr>
				<tr>
					<td class="td1">联系方式</td>
					<td>${pt.phone}</td>
				</tr>
				<tr>
					<td class="td1">年龄</td>
					<td>${pt.age}</td>
				</tr>
				<tr>
					<td class="td1">学历</td>
					<td> 
					<c:if test="${0 == pt.degree}">其他</c:if>
					<c:if test="${1 == pt.degree}">专科</c:if>
					<c:if test="${2 == pt.degree}">本科</c:if>
					<c:if test="${0 == pt.degree}">硕士及以上</c:if>
					</td>
				</tr>
				<tr>
					<td class="td1">毕业院校</td>
					<td>${pt.school_name}</td>
				</tr>
				<tr>
					<td class="td1">学校级别</td>
					<td>${pt.school_level}</td>
				</tr>
				<tr>
					<td class="td1">现居住地</td>
					<td>${pt.address}</td>
				</tr>
				<tr>
					<td class="td1">渠道来源</td>
					<td>
						<c:if test="${0 == pt.degree}">其他端口</c:if>
						<c:if test="${1 == pt.degree}">58同城</c:if>
						<c:if test="${2 == pt.degree}">赶集网</c:if>
						<c:if test="${3 == pt.degree}">前程无忧</c:if>
						<c:if test="${4 == pt.degree}">智联招聘</c:if>
						<c:if test="${5 == pt.degree}">中华英才网</c:if>
						<c:if test="${6 == pt.degree}">转介绍</c:if>
					</td>
					
				</tr>
				<tr>
					<td class="td1">录入时间</td>
					<td>${pt.createtime}</td>
				</tr>
			</table>
			
	</div>
</body>
</html>