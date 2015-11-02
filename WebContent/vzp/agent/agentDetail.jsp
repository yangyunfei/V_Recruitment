<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<title>派单记录查询</title>
<jsp:include page="../../inc.jsp"></jsp:include>
<script type="text/javascript">
	var dataGrid;
	$(function() {
		dataGrid = $('#dataGrid')
				.datagrid(
						{
							url : '${pageContext.request.contextPath}/jf/agentController/getSendbillDataByAgentID?sec.agent_id.s.eq=${id}',
							fit : true,
							border : false,
							pagination : true,
							idField : 'id',
							pageSize : 10,
							singleSelect : true, 
							pageList : [ 10, 20, 30, 40, 50 ],
							sortName : 'createdate',
							sortOrder : 'desc',
							checkOnSelect : false,
							selectOnCheck : false,
							nowrap : true,
							rownumbers : true,
							columns : [ [
									{
										field : 'rt_code',
										title : '派单编号',
										sortable : true
									},
									{
										field : 'store_num',
										title : '商铺编码',
										formatter : function(value, row, index) {
											if (value != null) {
												var str = $
														.formatString(
																'<a href="javascript:void(0);" onclick="view({0},\'{1}\');">{2} <\/a>',
																row.store_id,
																value, value);
												return str;
											}
										}
									}, {
										field : 'customer_code',
										title : '客户编号',
									/* ,
									formatter : function(value, row, index) {
										if (value != null) {
											var str = $.formatString(
													'<a href="javascript:void(0);" onclick="cusView(\'{0}\',\'{1}\');" >'
															+ value
															+ '</a>',
													row.customer_id, row.customer_code);
											return str;
										}
									} */
									},  {
										field : 'createdate',
										title : '派单日期',
										sortable : true
									},  {
										field : 'receivedate',
										title : '接单日期',
									}, {
										field : 'last_state_date',
										title : '更新日期',
										sortable : true
									}, {
										field : 'state',
										title : '订单状态',
										sortable : true
									}, {
										field : 'customerapp_point',
										title : '客户评分',
									}, {
										field : 'remark',
										title : '客户备注',
									} ] ],
							toolbar : '#toolbar',
							onLoadSuccess : function() {
								$('#searchForm table').show();
								parent.$.messager.progress('close');
								$(this).datagrid('tooltip');
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
	function cusView(id, cusid) {
		dataGrid.datagrid('unselectAll').datagrid('uncheckAll');
		parent.addTab({
			url : '${pageContext.request.contextPath}/jf/cusController/view/'
					+ id,
			title : '客户详情-' + cusid,
			iconCls : 'status_online'
		});
	}
</script>
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
		<div data-options="region:'north',title:'经纪人信息',border:false"
			style="height: 100px">
			<table style="width: 90%; margin-left: 5%; margin-top: 10px">
				<tr>
					<td class="td1">系统号：${agent.pager }</td>
					<td>姓名：${agent.realname }</td>
				</tr>
				<tr>
					<td class="td1">电话：${agent.phone }</td>
					<td>角色：${agent.type}</td>
				</tr>
			</table>
		</div>
		<div data-options="region:'center',border:true,title:'带看历史'">
			<table id="dataGrid" style="width: 100%"></table>
		</div>
	</div>
</body>
</html>