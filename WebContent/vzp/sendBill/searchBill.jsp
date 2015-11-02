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
							url : '${pageContext.request.contextPath}/jf/sendBillController/searchBillData',
							fit : true,
							fitColumns : true,
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
							nowrap : false,
							rownumbers : true,
							columns : [ [ {
								field : 'store_id',
								title : '铺源编号',
								width : $(this).width() * 0.15,
								sortable : true
							}, {
								field : 'createdate',
								title : '派单日期',
								width : $(this).width() * 0.2,
								sortable : true
							}, {
								field : 'phone',
								title : '所属用户ID',
								width : $(this).width() * 0.15,
								sortable : true
							}, {
								field : 'agent_number',
								title : '带看人系统号',
								width : $(this).width() * 0.15,
								sortable : true
							},

							{
								field : 'agent_name',
								title : '带看人姓名',
								width : $(this).width() * 0.1,
								sortable : true
							}, {
								field : 'agent_phone',
								title : '带看人电话',
								width : $(this).width() * 0.15,
							}, {
								field : 'name',
								title : '派单人',
								width : $(this).width() * 0.1,
								sortable : true
							}, {
								field : 'type',
								title : '派单类型',
								width : $(this).width() * 0.1,
								formatter : function(value, row, index) {
									var str = value;
									if (0 == value)
										str = "后台委托手动约看派"
									else if (1 == value)
										str = "手机端约看派单"
									else if (2 == value)
										str = "后台二次手动约看派单"
									else if (3 == value)
										str = "一带多看之派单"
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

	function searchFun() {
		console.log($.serializeObject($('#searchForm')));
		dataGrid.datagrid('load', $.serializeObject($('#searchForm')));
	}
	function cleanFun() {
		$('#searchForm input').val('');
		dataGrid.datagrid('load', {});
	}
	function exportReport() {
		var opt = dataGrid.datagrid('options');
		var sec = {
			sort : opt.sortName,
			order : opt.sortOrder
		};
		$.extend(true, sec, $.serializeObject($('#searchForm')));
		console.log(sec);
		download(
				'${pageContext.request.contextPath}/jf/exportExcelController/excel?tab=v_sendbill',
				sec, 'POST');
	}

	//构造动态form提交
	function download(url, params, method) {
		var tempForm = document.createElement("form");
		tempForm.action = url;
		tempForm.method = method;
		tempForm.style.display = "none";
		for ( var x in params) {
			var opt = document.createElement("textarea");
			opt.name = x;
			opt.value = params[x];
			tempForm.appendChild(opt);
		}
		document.body.appendChild(tempForm);
		tempForm.submit();
	}
</script>
</head>
<body>
	<div class="easyui-layout" data-options="fit : true,border : false">
		<div data-options="region:'north',title:'查询条件',border:false"
			style="height: 125px">
			<form id="searchForm">
				<table >
					<tr>
						<td>派单人:</td>
						<td><input class="easyui-combobox" id="pdr"
							name="sec.name.s.eq"
							data-options="
					url:'${pageContext.request.contextPath}/jf/sendBillController/sendUser',
                    valueField:'name',
                    textField:'name'
            "></td>
						<td>所属用户ID:</td>
						<td><input class="easyui-textbox" id="phone"
							name="sec.phone.s.eq" data-options="prompt:'请输入手机号'"></td>
						<td>约看类型：</td>
						<td><select name="sec.type.s.eq" class="easyui-combobox"
							style="width: 150px;" panelHeight="125">
								<option value="">不限</option>
								<option value="0">后台委托手动约看派</option>
								<option value="1">手机端约看派单</option>
								<option value="2">后台二次手动约看派单</option>
								<option value="3">一带多看之派单</option>
						</select></td>

					</tr>
					
					<tr>
						<td>带看人系统编号:</td>
						<td><input class="easyui-textbox" id="agentNumber"
							name="sec.agent_number.s.eq" data-options="prompt:'请输入系统编号'"></td>
						<td>带看人姓名:</td>
						<td><input class="easyui-textbox" id="agentName"
							name="sec.agent_name.s.eq" data-options="prompt:'请输入姓名'"></td>
							<td>铺源编号:</td>
						<td><input class="easyui-textbox" id="storeId"
							name="sec.store_id.s.eq" data-options="prompt:'请输入编号'"></td>
					</tr>
					<tr>
						<td>派单日期：</td>
						<td  colspan="3"><input class="easyui-datebox" id="start"
							name="sec.createdate.dt.ge"
							data-options="validType:'md[\'10/11/2012\']'"></input> -<input
							class="easyui-datebox" id="end" name="sec.createdate.dt.le"
							data-options="validType:'md[\'10/11/2012\']'"></input></td>
					</tr>
				</table>
			</form>
		</div>
		<div data-options="region:'center',border:false">
			<table id="dataGrid" style="width: 100%"></table>
		</div>
	</div>
	<div id="toolbar" style="display: none;">
		<a href="javascript:void(0);" class="easyui-linkbutton"
			data-options="iconCls:'brick_add',plain:true" onclick="searchFun();">查询</a><a
			href="javascript:void(0);" class="easyui-linkbutton"
			data-options="iconCls:'brick_delete',plain:true"
			onclick="cleanFun();">清空查询</a>
		<c:if
			test="${fn:contains(modules, '/jf/exportExcelController/v_sendbillExcel')}">
			<a href="javascript:void(0);" class="easyui-linkbutton"
				data-options="iconCls:'box',plain:true" onclick="exportReport();">导出报表</a>
		</c:if>
	</div>
</body>
</html>