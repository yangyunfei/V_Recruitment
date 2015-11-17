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
		dataGrid = $('#schoolDataGrid').datagrid({
			url : '${pageContext.request.contextPath}/jf/commonController/chooseSchool',
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
				field : 'name',
				title : '学校名称',
				width : 150,
				sortable : true
			},
			{
				field : 'education_level',
				title : '办学层次',
				width : 150,
				sortable : true
			},
			{
				field : 'school_level',
				title : '学校级别',
				width : 150,
				sortable : true
			}] ],
			onLoadSuccess : function() {
				parent.$.messager.progress('close');
			}
		});

	});
	
	function searchFun(){
		$('#schoolDataGrid').datagrid('load',$.serializeObject($('#schoolSearchDiv Input')));
	}
</script>
	<div id="schoolSearchDiv" class="easyui-panel" data-options="fit : true,border : false">
		<input id="schoolname" name="schoolname" class="easyui-searchbox" prompt="请输入学校名称进行查询" style="width:450px;" searcher="searchFun" >
		<table id="schoolDataGrid"></table>
	</div>
</body>
</html>