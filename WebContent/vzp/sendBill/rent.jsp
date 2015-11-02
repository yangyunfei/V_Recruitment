<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
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
<jsp:include page="../../inc.jsp"></jsp:include>
<script type="text/javascript"
	src="<%=basePath%>js/download.js?v=201507311347"></script>
<title>约看列表</title>

<script type="text/javascript">
	var dataGrid;
	$(function() {
		var xzq = $('#xzq')
				.combobox(
						{
							url : '${pageContext.request.contextPath}/jf/areaBusinessController/selectAllBigDistrict',
							editable : false,
							valueField : 'name',
							textField : 'name',
							onSelect : function(record) {
								if (record != null)
									sq
											.combobox({
												disabled : false,
												url : '${pageContext.request.contextPath}/jf/areaBusinessController/selectBusinessArea?id='
														+ record.id,
												valueField : 'name',
												textField : 'name'
											});
							}
						});
		var sq = $('#sq').combobox({
			disabled : true,
			valueField : 'id',
			textField : 'name'
		});
		dataGrid = $('#dataGrid')
				.datagrid(
						{
							url : '${pageContext.request.contextPath}/jf/sendBillController/entrustData',
							fit : true,
							fitColumns : false,
							border : true,
							pagination : true,
							idField : 'id',
							pageSize : 10,
							singleSelect : true,
							pageList : [ 10, 20, 30, 40, 50 ],
							sortName : 'createtime',
							sortOrder : 'desc',
							checkOnSelect : false,
							selectOnCheck : false,
							singleSelect : true,
							nowrap : false,
							rownumbers : true,
							columns : [ [
									{
										field : 'id',
										title : '约看标识',
										width : 80,
										sortable : true
									},
									{
										field : 'entrust_code',
										title : '约看编码',
										width : 100,
										sortable : true
									},
									{
										field : 'store_id',
										title : '商铺标识',
										width : 80,
										sortable : true
									},
									{
										field : 'store_code',
										title : '商铺编码',
										width : 120,
										sortable : true,
										formatter : function(value, row, index) {
											var str = $
													.formatString(
															'<a href="javascript:void(0);" onclick="view({0},\'{1}\');">{2} <\/a>',
															row.store_id,
															value, value);
											return str;
										}
									},
									{
										field : 'customer_id',
										title : '客户标识',
										width : 80,
										sortable : true,

									},
									{
										field : 'phone',
										title : '客户手机号',
										width : 100,
										sortable : true,

									},
									{
										field : 'source',
										title : '来源',
										width : 100,
										formatter : function(value, row, index) {
											if (value = 1) {
												return "当前推广";
											}else if (value = 2) {
												return "库存";
											}else if (value = 3) {
												return "经纪人推荐";
											}else if (value = 4) {
												return "app添加";
											}else if (value = 6) {
												return "Android";
											}else if (value = 7) {
												return "IOS";
											}
										}

									},
									{
										field : 'createtime',
										title : '约看提交时间',
										width : 180,
										sortable : true
									},
									{
										field : 'entrust_date',
										title : '约看时间',
										width : 100,
										formatter : function(value, row, index) {
											if (value = 0) {
												return "随时";
											} else if(value = 1) {
												return "工作日";
											} else if(value = 2) {
												return "周末";
											}
										}
									},
									{
										field : 'entrust_tel',
										title : '约看联系电话',
										width : 180,
										sortable : true
									},
									{
										field : 'regn',
										title : '行政区',
										width : 80
									},
									{
										field : 'business',
										title : '商圈',
										width : 80,
										sortable : true
									},
									{
										field : 'billcount',
										title : '是否派单',
										width : 80,
										formatter : function(value, row, index) {
											if (value <= 0) {
												return "否";
											} else {
												return "是";
											}
										}
									},
									{
										field : 'type',
										title : '类型',
										width : 80,
										formatter : function(value, row, index) {
											if (value == 0) {
												return "app约看";
											} else if (value == 1) {
												return "一带多看约看 ";
											}
										}
									},
									{
										field : 'action',
										title : '操作',
										width : 80,
										formatter : function(value, row, index) {
											var str = $
													.formatString(
															'<a href="javascript:void(0);" onclick="viewEntrustDetail({0})">派单 <\/a>',
															row.id);
											return str;
										}
									} ] ],
							toolbar : '#toolbar',
							onLoadSuccess : function() {
								$('#searchForm table').show();
								parent.$.messager.progress('close');
								$(this).datagrid('tooltip');
							}
						});
	});

	function searchEntrustInfo() {
		var comboxValue = $('#xzq').combobox('getValue');
		if (comboxValue == 1) {
			$("#dataGrid").datagrid('load', {});
		}
		$("#dataGrid").datagrid('load',
				$.serializeObject($("#entrustInfoForm").form()));
	}
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
	function cleanEntrustInfo() {
		//清空方法 1
		$("#entrustInfoForm").form('clear');
		$("#dataGrid").datagrid('load', {});
		//清空方法 2
		/*$("#dataGrid").datagrid('load', {});
		$("#entrustInfoForm").find("input").val('');*/
	}

	function viewEntrustDetail(id) {
		var url = "${pageContext.request.contextPath}/jf/sendBillController/toSendBill?entrustID="
				+ id;
		var title = '约看派单';
		window.parent.parent.addTab2(title, url);
	}
	function exportReport() {
		var opt = dataGrid.datagrid('options');
		var sec = {
			sort : opt.sortName,
			order : opt.sortOrder
		};
		$.extend(true, sec, $.serializeObject($('#entrustInfoForm')));
		console.log(sec);
		download(
				'${pageContext.request.contextPath}/jf/exportExcelController/excel?tab=v_entrust',
				sec, 'POST');
	}
</script>
<style type="text/css">
table input {
	width: 130px;
}
</style>
</head>

<body>
	<div class="easyui-layout" data-options="fit : true,border : false">
		<div data-options="region:'north',title:'查询条件',border:false"
			style="height: 100px">
			<form id="entrustInfoForm" action="" method="">
				<table width="100%">
					<tr>
						<td>客户手机号:</td>
						<td><input class="easyui-textbox" name="sec.phone.s.eq"
							data-options="prompt:'请输入手机号'"></td>
						<td>目标行政区：</td>
						<td><input class="easyui-combobox" style="width: 100px;"
							name="sec.regn.s.eq" id="xzq"
							data-options="
                    method:'get',
                    valueField:'name',
                    textField:'name',
                    multiple:false,
            ">
						</td>
						<td>目标商圈：</td>
						<td><input class="easyui-combobox" style="width: 100px;"
							name="sec.business.s.eq" id="sq"
							data-options="
            valueField:'name',
            textField:'name',
            ">
						</td>
					</tr>
					<tr>
						<td>约看提交日期：</td>
						<td><input class="easyui-datebox" style="width: 100px;"
							name="sec.createtime.dt.ge"
							data-options="validType:'md[\'10/11/2012\']'"></input>&nbsp;至&nbsp;
							<input class="easyui-datebox" style="width: 100px;"
							name="sec.createtime.dt.le"
							data-options="validType:'md[\'10/11/2012\']'"></input></td>

						<td>约看类型：</td>
						<td><select  name="sec.type.s.eq"  class="easyui-combobox" style="width: 100px;" panelHeight="75">
							     <option value="">不限</option>
								<option value="0">app约看</option>
								<option value="1">一带多看约看</option>
						</select></td>
					</tr>
				</table>
			</form>

		</div>
		<div data-options="region:'center',border:false">
			<table id="dataGrid"></table>
		</div>
	</div>
	<div id="toolbar" style="display: none;">
		<a href="javascript:void(0);" class="easyui-linkbutton"
			data-options="iconCls:'brick_add',plain:true"
			onclick="searchEntrustInfo();">查询</a><a href="javascript:void(0);"
			class="easyui-linkbutton"
			data-options="iconCls:'brick_delete',plain:true"
			onclick="cleanEntrustInfo();">清空查询</a>
		<c:if
			test="${fn:contains(modules, '/jf/exportExcelController/rentExcel')}">
			<a href="javascript:void(0);" class="easyui-linkbutton"
				data-options="iconCls:'box',plain:true" onclick="exportReport();">导出报表</a>
		</c:if>
	</div>
</body>
</html>