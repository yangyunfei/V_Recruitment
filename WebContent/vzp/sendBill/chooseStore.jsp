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
		dataGrid = $('#storeDataGrid').datagrid({
			url : '${pageContext.request.contextPath}/jf/sendBillController/chooseStore',
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
				width : 150,
				checkbox : true
			},
			{
				field : 'store_id',
				title : '商铺编号',
				width : 80,
				sortable : true
			},
			{
				field : 'store_name',
				title : '商铺名称',
				width : 150,
				sortable : true
			}] ],
			onLoadSuccess : function() {
				parent.$.messager.progress('close');
			}
		});

	});
	
	function searchFun(){
		$('#storeDataGrid').datagrid('load',$.serializeObject($('#storeSearchDiv Input')));
	}
</script>
	<div id="storeSearchDiv" class="easyui-panel" data-options="fit : true,border : false">
		<input id="storeIdSearch" name="storeIdSearch" class="easyui-searchbox" prompt="请输入商铺编号进行查询" style="width:450px;" searcher="searchFun" >
		<table id="storeDataGrid"></table>
	</div>
</body>
</html>