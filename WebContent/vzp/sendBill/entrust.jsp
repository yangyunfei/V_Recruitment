<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
<title>客户委托列表</title>
<script type="text/javascript">
	var dataGrid
	$(function() {
		dataGrid = $('#dataGrid')
				.datagrid(
						{
							url : '${pageContext.request.contextPath}/jf/sendBillController/rentData',
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
										title : '委托标识',
										width : 80,
										sortable : true
									},
									{
										field : 'rent_code',
										title : '委托编号',
										width : 120,
										sortable : true
									},
									{
										field : 'createtime',
										title : '委托提交日期',
										width : 180,
										sortable : true
									},
									/*
									{
										field : 'phone',
										title : '所属用户ID',
										width : 120,
										sortable : true
									},
								
									{
										field : 'phone',
										title : '所属用户ID',
										width : 80,
										sortable : true
									},	*/
									{
										field : 'customer_code',
										title : '用户编号',
										width : 120,
										sortable : true
									},
									{
										field : 'name',
										title : '用户姓名',
										width : 120,
										sortable : true
									},
									{
										field : 'phone',
										title : '用户电话',
										width : 120,
										sortable : true
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
										field : 'type',
										title : '类型',
										width : 80,
										formatter : function(value, row, index) {
											if (value == 0) {
												return " app委托";
											} else if (value == 1) {
												return "微信委托";
											} else if (value == 2) {
												return "手工委托";
											}
										}
									},
									{
										field : 'industry_name',
										title : '目标行业',
										width : 120,
										sortable : true
									},
									{
										field : 'regn',
										title : '目标行政区',
										width : 120,
										sortable : true
									},
									{
										field : 'target_area_name',
										title : '目标商圈',
										width : 120,
										sortable : true
									},
									{
										field : 'area_min',
										title : '面积最小值',
										width : 80,
										sortable : true
									},
									{
										field : 'area_max',
										title : '面积最大值',
										width : 80,
										sortable : true
									},
									{
										field : 'rent_min',
										title : '租金最小值',
										width : 80,
										sortable : true
									},
									{
										field : 'rent_max',
										title : '租金最大值',
										width : 80,
										sortable : true
									},
									{
										field : 'billcount',
										title : '派单次数',
										width : 60
									},
									{
										field : 'action',
										title : '派单进入',
										width : 100,
										formatter : function(value, row, index) {
											var str = $
													.formatString(
															'<a href="javascript:void(0);" onclick="viewRentDetail({0})" >派单 <\/a>',
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

		var xzq = $('#xzq')
				.combobox(
						{
							url : '${pageContext.request.contextPath}/jf/areaBusinessController/selectAllBigDistrict',
							editable : true,
							valueField : 'name',
							textField : 'name',
							onSelect : function(record) {

								if (record != null)
									sq
											.combobox({
												disabled : false,
												method : 'get',
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

		var industry = $('#industry')
				.combobox(
						{
							url : '${pageContext.request.contextPath}/jf/commonController/selectIndustryLevelOne',
							editable : true,
							valueField : 'name',
							textField : 'name'
						});
		$("#rentMin").blur(function() {
			$("#rent_min").val($("#rentMin").val() * 10000);
		});
		$("#rentMax").blur(function() {
			$("#rent_max").val($("#rentMax").val() * 10000);
		});

	});
	function searchFun() {
		dataGrid.datagrid('load', $.serializeObject($('#rentInfoForm')));
	}
	function cleanFun() {
		$('#rentInfoForm input').val('');
		dataGrid.datagrid('load', {});
	}

	function viewRentDetail(id) {
		var url = "${pageContext.request.contextPath}/jf/sendBillController/viewRentDetail?rentId="
				+ id;
		var title = '客户委托派单';
		window.parent.parent.addTab2(title, url);
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
			style="height: 155px">
			<form id="rentInfoForm">
				<table width="100%">
					<tr>
						<td>用户姓名</td>
						<td><input class="easyui-textbox" name="sec.name.s.like"
							data-options="prompt:'请输入用户姓名'"></td>
						<td>用户电话:</td>
						<td><input class="easyui-textbox" name="sec.phone.s.like"
							data-options="prompt:'请输入用户电话"></td>

						<td>委托编号:</td>
						<td><input class="easyui-textbox" name="sec.rent_code.s.like"
							data-options="prompt:'请输入委托编号'"></td>
					</tr>
					<tr>
						<td>目标行业:</td>
						<td><input class="easyui-textbox"
							name="sec.industry_name.s.eq" id="industry" style="width: 100px;"></td>

						<td>目标行政区：</td>
						<td><input class="easyui-combobox" id="xzq"
							style="width: 100px;" name="sec.regn.s.eq"></td>
						<td>目标商圈：</td>
						<td><input class="easyui-combobox" id="sq"
							style="width: 100px;" name="sec.target_area_name.s.eq"></td>
					</tr>
					<tr>
						<td>面积范围：</td>
						<td colspan="2"><input style="width: 100px;"
							class="easyui-textbox" id="areaMin" name="sec.area_min.i.ge"></input>&nbsp;
							~ &nbsp;<input style="width: 100px;" class="easyui-textbox"
							name="sec.area_max.i.le" id="areaMax"></input> （平米）</td>
						<td colspan="3">租金范围：<input style="width: 100px;"
							class="easyui-textbox" id="rentMin" width="1px"></input> &nbsp;~
							&nbsp;<input style="width: 100px;" class="easyui-textbox"
							id="rentMax"></input> （万元） <input type="hidden" id="rent_min"
							name="sec.rent_min.i.ge"> <input type="hidden"
							id="rent_max" name="sec.rent_max.i.le">
						</td>
					</tr>
					<tr>
						<td>委托提交日期：</td>
						<td colspan="2"><input class="easyui-datebox"
							style="width: 100px;" id="startCreateTime"
							name="sec.createtime.dt.ge"
							data-options="validType:'md[\'10/11/2012\']'"></input>&nbsp;至&nbsp;
							<input style="width: 100px;" class="easyui-datebox"
							id="endCreateTime" name="sec.createtime.dt.le"
							data-options="validType:'md[\'10/11/2012\']'"></input></td>
							
							<td>委托类型：<select  name="sec.type.s.eq"  class="easyui-combobox" style="width: 100px;" panelHeight="100">
							     <option value="">不限</option>
								<option value="0">app委托</option>
								<option value="1">微信委托</option>
								<option value="2">手工委托</option>
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
			data-options="iconCls:'brick_add',plain:true" onclick="searchFun();">查询</a><a
			href="javascript:void(0);" class="easyui-linkbutton"
			data-options="iconCls:'brick_delete',plain:true"
			onclick="cleanFun();">清空查询</a>
	</div>
</body>
</html>