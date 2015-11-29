<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>用户分析</title>
</head>
<body>
	用户 : ${user.name}<br>
	处理招聘总数 : ${total}<br>
	<table>
		<tr>
		<td>时间</td><td>待处理</td><td>待初试</td><td>待复试</td><td>待培训</td><td>待入职</td><td>已入职</td><td>已失效</td><td>总数</td>
		</tr>
		<tr>
		<td>总计</td><td>${ totalBean.suspending }</td><td>${ totalBean.waitfirstinterview }</td><td>${ totalBean.waitsecondinterview }</td><td>${ totalBean.waittrain }</td><td>${ totalBean.waitentrant }</td><td>${ totalBean.hasentrant }</td><td>${ totalBean.invalid }</td><td>${total}</td>
		</tr>
		<c:forEach items="${monthList}" varStatus="status" var="data"> 
		    <tr>
		       <td>${data.date}</td><td>${ data.suspending }</td><td>${ data.waitfirstinterview }</td><td>${ data.waitsecondinterview }</td><td>${ data.waittrain }</td><td>${ data.waitentrant }</td><td>${ data.hasentrant }</td><td>${ data.invalid }</td><td>${ data.total }</td>       
			</tr>
       </c:forEach>
	
	</table>

	

</body>
</html>