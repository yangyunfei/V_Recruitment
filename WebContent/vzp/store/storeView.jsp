<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<title>商铺浏览量</title>
<jsp:include page="../../inc.jsp"></jsp:include>

<script type="text/javascript">
	var dataGrid;
	$(function() {
		dataGrid = $('#dataGrid')
				.datagrid(
						{
							url : '${pageContext.request.contextPath}/jf/storeViewController/dataGrid',
							fit : true,
							fitColumns : false,
							border : false,
							pagination : true,
							idField : 'id',
							pageSize : 20,
							pageList : [ 10, 20, 30, 40, 50 ],
							sortName : 'dt',
							sortOrder : 'desc',
							singleSelect : true,
							checkOnSelect : false,
							selectOnCheck : false,
							nowrap : false,
							onLoadSuccess : function() {
								parent.$.messager.progress('close');
							},
							columns : [ [
									{
										field : 'id',
										title : '商铺标识',
										width : 100,
										checkbox : true
									},
									{
										field : 'dt',
										title : '访问日期',
										width : 80,
										sortable : true
									},
									{
										field : 'count',
										title : '访问量',
										width : 50,
										sortable : true
									},
									{
										field : 'store_id',
										title : '商铺编码',
										width : 100,
										sortable : true,
										formatter : function(value, row, index) {
											var str = $
													.formatString(
															'<a href="javascript:void(0);" onclick="view({0},\'{1}\');">{2} <\/a>',
															row.id, value,
															value);
											return str;
										}
									}, {
										field : 'store_name',
										title : '商铺名称',
										width : 300,
										sortable : true
									},{
										field : 'name',
										title : '商圈',
										width : 100,
										sortable : true
									} ] ],
							toolbar : '#toolbar',
							onLoadSuccess : function() {
								$('#searchForm table').show();
								parent.$.messager.progress('close');

								//$(this).datagrid('tooltip');
							}

						});
	});

	function view(id, storeid) {
		dataGrid.datagrid('unselectAll').datagrid('uncheckAll');
		parent
				.addTab({
					url : '${pageContext.request.contextPath}/jf/storeController/view?id='
							+ id,
					title : '查看商铺-' + storeid,
					iconCls : 'status_online'
				});
	}

	function searchFun() {
		dataGrid.datagrid('load', $.serializeObject($('#searchForm')));
	}
	function excel() {
		parent.$.messager.progress({
			title : '提示',
			text : '数据处理中，请稍后....'
		});
		var opt = dataGrid.datagrid('options');
		var sec = {
			sort : opt.sortName,
			order : opt.sortOrder
		};
		$.extend(true, sec, $.serializeObject($('#searchForm')));
		$
				.download(
						'${pageContext.request.contextPath}/jf/storeViewController/excel?tab=special',
						sec, 'POST');
		parent.$.messager.progress('close');
	}
	function cleanFun() {
		$('#searchForm input').val('');
		dataGrid.datagrid('load', {});
	}
</script>
</head>
<body>
	<div class="easyui-layout" data-options="fit : true,border : false">
		<div data-options="region:'north',title:'查询条件',border:false"
			style="height: 60px; width: 6900px;">
			<form id="searchForm">
				<table style="display: none;">
					<tr>
						<td width="80" align="right">商铺编码</td>
						<td width="130"><input name="spbm"
							placeholder="请输入商铺编码" /></td>
						<!-- <td width="80" align="right">访问日期</td>
						<td width="130"><input name="fwrq"
							placeholder="请输入日期，格式例如：00-00" /></td> -->
						<td width="80" align="right">访问时间</td>
						<td width="220"><input class="easyui-datebox"
							style="width: 90px;" id="startTime"
							name="startTime" placeholder="点击选择时间"
							data-options="validType:'md[\'10/11/2012\']'"></input>至 <input
							style="width: 90px;" class="easyui-datebox" id="endTime"
							name="endTime" placeholder="点击选择时间"
							data-options="validType:'md[\'10/11/2012\']'"></td>
					</tr>
				</table>

			</form>
		</div>
		<div data-options="region:'center',border:false">
			<table id="dataGrid"></table>
		</div>
	</div>
	<div id="toolbar" style="display: none;">
		<c:if
			test="${fn:contains(modules, '/jf/storeViewController/storeViewExcel')}">
			<a onclick="excel();" href="javascript:void(0);"
				class="easyui-linkbutton"
				data-options="plain:true,iconCls:'cog_add'">导出浏览信息</a>
		</c:if>
		<a href="javascript:void(0);" class="easyui-linkbutton"
			data-options="iconCls:'brick_add',plain:true" onclick="searchFun();">查&nbsp;&nbsp;询</a><a
			href="javascript:void(0);" class="easyui-linkbutton"
			data-options="iconCls:'brick_delete',plain:true"
			onclick="cleanFun();">清空查询</a>
	</div>

</body>
<script type="text/javascript">
	$(function() {
		var xzq = $('#xzq')
				.combobox(
						{
							url : '${pageContext.request.contextPath}/jf/areaBusinessController/selectAllBigDistrict',
							editable : true,
							valueField : 'id',
							textField : 'name',
							onSelect : function(record) {

								if (record != null)
									sq
											.combobox({
												disabled : false,
												method : 'get',
												url : '${pageContext.request.contextPath}/jf/areaBusinessController/selectBusinessArea?id='
														+ record.id,
												valueField : 'id',
												textField : 'name'
											});
							}
						});
		var sq = $('#sq').combobox({
			disabled : true,
			valueField : 'id',
			textField : 'name'
		});
	});
</script>

</html>