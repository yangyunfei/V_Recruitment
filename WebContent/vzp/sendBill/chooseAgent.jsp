<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<script type="text/javascript">
	var dataGrid;
	$(function() {
		dataGrid = $('#agentDataGrid').datagrid({
			url : '${pageContext.request.contextPath}/jf/sendBillController/chooseAgent',
			fit : true,
			fitColumns : true,
			border : false,
			pagination : false,
			idField : 'id',
			pageSize : 20,
			pageList : [ 10, 20, 30, 40, 50 ],
			sortName : 'id',
			sortOrder : 'asc',
			singleSelect : true,
			nowrap : false,
			columns : [ [ {
				field : 'id',
				title : '标识',
				width : 80,
				checkbox : true
			},
			{
				field : 'pager',
				title : '带看人系统号',
				width : 80,
				sortable : true
			},
			{
				field : 'name',
				title : '带看人姓名',
				width : 80,
				sortable : true
			},
			{
				field : 'phone',
				title : '带看人电话',
				width : 80,
				sortable : true
			}] ],
			onLoadSuccess : function() {
				parent.$.messager.progress('close');
			}
		});

	});
	
	function searchFun(){
		$('#agentDataGrid').datagrid('load',$.serializeObject($('#agentSearchDiv Input')));
	}
</script>
	<div id="agentSearchDiv" class="easyui-panel" data-options="fit : true,border : false">
		<input id="agentIdSearch" name="agentIdSearch" class="easyui-searchbox" prompt="请输入带看人系统号进行查询" style="width:450px;" searcher="searchFun" >
		<table id="agentDataGrid"></table>
	</div>
</body>
</html>