<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/css/easyui.css">
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/css/icon.css">
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/css/demo.css">
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/css/main.css">

<script type="text/javascript" src="<%=basePath%>js/jquery.min.js"></script>
<script type="text/javascript"
	src="<%=basePath%>js/jquery.easyui.min.js"></script>

<title>客户详情</title>
<style type="text/css">
* {
	font-family: Microsoft Yahei;
}

h1 {
	font-size: 16px;
}

h2 {
	font-size: 15px;
	color: #1494FF;
	text-align: center;
}

hr {
	border: 1px solid #ECECEC;
}

.content {
	padding-left: 20px;
}

.name, .cusName {
	font-size: 14px;
	color: #1494FF;
	font-weight: bold;
}

.cusName {
	border-bottom: 1px solid #1494FF;
	cursor: pointer;
}

.table2 {
	border-collapse: collapse;
	border: none;
	background: #F4F2F2;
	width: 1173px;
	font-size: 14px;
	text-align: center;
	margin-top: 15px;
}

.table2 tr:first-child td {
	height: 30px;
	font-size: 15px;
	font-weight: bold;
	color: #FFFFFF;
	background: #1394FE;
}

.tdLeft {
	text-align: left;
}

.table2 td {
	border: none;
}

.table2 tr {
	border-bottom: solid #D8D7D7 1px;
}
</style>
</head>
<body>
	<h1>客户信息</h1>
	<hr />
	<div class="content">
		<p>
			<span class="name">客户姓名：</span> <span class="val">${ctApp.name }</span>
		</p>
		<p>
			<span class="name">客户编码：</span> <span class="val">${ctApp.customer_code }</span>
		</p>
		<p>
			<span class="name">客户联系方式：</span> <span class="val">${ctApp.phone }</span>
		</p>
		<p>
			<span class="name">客户状态：</span> <span class="val"> <c:if
					test="${ctApp.state=='1'}">正常客户</c:if> <c:if test="${ctApp.state=='2'}">失效客户</c:if>
			</span>
		</p>
		<p>
			<span class="name">客户行业：</span> <span class="val">${ctRent.industry_name }</span>
		</p>
		<p>
			<span class="name">客户来源：</span> <span class="val"> <c:if
					test="${ctApp.source=='1'}">当前推广</c:if> <c:if
					test="${ctApp.source=='2'}">库存</c:if> <c:if test="${ctApp.source=='3'}">经纪人推荐</c:if>
			</span>
		</p>
		<p>
			<span class="name">客户标签：</span> <span class="val"> <c:if
					test="${ctApp.label=='1'}">品牌客户</c:if> <c:if test="${ctApp.label=='2'}">长期客户</c:if>
				<c:if test="${ctApp.label=='3'}">急需客户</c:if> <c:if
					test="${ctApp.label=='0'}">无</c:if>
			</span>
		</p>
		<p>
			<span class="name">目标行政区：</span> <span class="val">${ctRent.target_area_name }</span>
		</p>
		<p>
			<span class="name">面积范围：</span> <span class="val">${ctRent.area_min }
				~ ${ctRent.area_max }（平方米）</span>
		</p>
		<p>
			<span class="name">租金范围：</span> <span class="val">${ctRent.rent_min }
				~ ${ctRent.rent_max }（元）</span>
		</p>
	</div>

	<h1>客户描述</h1>
	<hr />
	<div class="content" style="width: 850px;">${ctRent.description }</div>

<h1>经纪人信息</h1>
<hr />
<div class="content">
	<p>
		<span class="name">经纪人系统号：</span>
		<span class="val">${ctApp.agent_number }</span>
	</p>
	<p>
		<span class="name">经纪人姓名：</span>
		<span class="val">${ctApp.agent_name }</span>
	</p>
	<p>
		<span class="name">经纪人联系方式：</span>
		<span class="val">${ctApp.agent_phone }</span>
	</p>
</div>

	<table class="table2">

		<tr>
			<td style="width: 100px;">约看商铺</td>
			<td style="width: 100px;">约看日期</td>
			<td style="width: 100px;">更新日期</td>
			<td style="width: 100px;">带看人</td>
			<td style="width: 100px;">订单状态</td>
			<td style="width: 17%;">备注</td>
		</tr>
		<c:forEach items="${examples }" var="em">
			<tr>
				<td><span class="cusName" storeId="${em.store.id }"
					spId="${em.store.store_id }">${em.store.store_name }</span></td>
				<td><fmt:formatDate value="${em.submit_time}" type="both" /></td>
				<td><fmt:formatDate value="${em.update_time}" type="both" /></td>
				<td>${em.store.charger.name }</td>
				<td><c:choose>
						<c:when test="${fn:contains(modules, 'UPDATE_PROCESS')}">
							<input class="jindu easyui-combobox" value="${em.state }"
								style="width: 70px;"
								data-options="
						valueField: 'value',
						textField: 'label',
						data: [{
							label: '推荐',
							value: '1',
							storeId:'${em.id }'
						},{
							label: '跟进',
							value: '2',
							storeId:'${em.id }'
						},{
							label: '带看',
							value: '3',
							storeId:'${em.id }'
						},
						{
							label: '在谈',
							value: '4',
							storeId:'${em.id }'
						},
						{
							label: '成交',
							value: '5',
							storeId:'${em.id }'
						},
						{
							label: '终止',
							value: '6',
							storeId:'${em.id }'
						}],
					onSelect: function(param){
								 $.ajax({
						             type: 'GET',
						             url: '${updateExample}?id='+param.storeId+'&state='+param.value,
						             data: {
						             },
						             dataType: 'text',
						             success: function(data){
											if(data=='success'){
												alert('提交成功');
											}				                    
						             },
						             error:function(e,f){
						            	 alert('提交失败');
						             }
						         });
					}
					" />
						</c:when>
						<c:otherwise>
							<c:if test="${em.state==1 }">推荐</c:if>
							<c:if test="${em.state==2 }">跟进</c:if>
							<c:if test="${em.state==3 }">带看</c:if>
							<c:if test="${em.state==4 }">在谈</c:if>
							<c:if test="${em.state==5 }">成交</c:if>
							<c:if test="${em.state==6 }">终止</c:if>
						</c:otherwise>

					</c:choose></td>
				<td class="tdLeft">${em.description }</td>
			</tr>
		</c:forEach>

	</table>

	<script type="text/javascript">
		$('.cusName')
				.click(
						function() {
							var id = $(this).attr('storeId');
							var spid = $(this).attr('spId');
							var url = '${pageContext.request.contextPath}/jf/storeController/view?id='
									+ id;
							var title = '商铺详情-' + spid;
							window.parent.addTab({
								"title" : title,
								"url" : url,
								iconCls : 'status_online'
							});
						});
	</script>
</body>
</html>