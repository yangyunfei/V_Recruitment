<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<title>用户管理</title>
<jsp:include page="../../inc.jsp"></jsp:include>
<c:if test="${fn:contains(modules, '/jf/storeController/add')}">
	<script type="text/javascript">
		$.canAdd = true;
	</script>
</c:if>
<c:if test="${fn:contains(modules, '/jf/storeController/update')}">
	<script type="text/javascript">
		$.canUpdate = true;
	</script>
</c:if>
<c:if test="${fn:contains(modules, '/jf/storeController/del')}">
	<script type="text/javascript">
		$.canDel = true;
	</script>
</c:if>
<c:if test="${fn:contains(modules, '/jf/storeController/spread')}">
	<script type="text/javascript">
		$.canSpread = true;
	</script>
</c:if>
<script type="text/javascript">
	var dataGrid;
	$(function() {
		dataGrid = $('#dataGrid')
				.datagrid(
						{
							url : '${pageContext.request.contextPath}/jf/sourceController/dataGrid',
							fit : true,
							fitColumns : false,
							border : false,
							pagination : true,
							idField : 'id',
							pageSize : 20,
							pageList : [ 10, 20, 30, 40, 50 ],
							sortName : 'createtime',
							sortOrder : 'desc',
							singleSelect : true,
							checkOnSelect : false,
							selectOnCheck : false,
							nowrap : false,
							onLoadSuccess : function() {
								parent.$.messager.progress('close');
							},
							frozenColumns : [ [
									{
										field : 'id',
										title : '编号',
										width : 100,
										checkbox : true
									},
									{
										field : 'store_id',
										title : '商铺编号',
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
										width : 200,
										sortable : true
									} ] ],
							columns : [ [
									{
										field : 'source_field',
										title : '商铺来源',
										width : 70,
										sortable : true
									},
									{
										field : 'is_key_circle',
										title : '是否重点商圈',
										width : 80,
										formatter : function(value, row, index) {
											var str = value;
											if (0 == value) {
												str = "否"
											} else {
												str = "是";
											}
											return str;
										}
									},
									{
										field : 'agent_name',
										title : '经纪人',
										width : 80,
										sortable : true
									},
									{
										field : 'agent_type',
										title : '人员类型',
										width : 80,
										formatter : function(value, row, index) {
											var str = value;
											if (0 == value) {
												str = "后台用户";
											} else if (1 == value) {
												str = "普通经纪人";
											} else if (2 == value) {
												str = "注册经纪人";
											} else if (3 == value) {
												str = "真有铺经纪人";
											} else if (4 == value) {
												str = "商铺专家";
											}
											return str;
										}
									},
									{
										field : 'agent_phone',
										title : '经纪人联系方式',
										width : 100,
										sortable : true
									},
									{
										field : 'createtime',
										title : '创建时间',
										width : 120,
										sortable : true
									},
									{
										field : 'modifytime',
										title : '最后修改时间',
										width : 120,
										sortable : true
									},
									{
										field : 'action',
										title : '操作',
										width : 100,
										formatter : function(value, row, index) {
											var str = '';
											{
												str += $
														.formatString(
																'<a href="javascript:void(0);" title="查看" onclick="view({0},\'{1}\');">查看 <\/a>',
																row.id,
																row.store_id);
											}
											str += '&nbsp;';
											if ($.canUpdate) {
												str += $
														.formatString(
																'<a href="javascript:void(0);" title="修改" onclick="update({0},\'{1}\');">修改 <\/a>',
																row.id,
																row.store_id);
											}
											str += '&nbsp;';
											if ($.canDel) {
												var s = '删除';
												if (row.state == '3')
													s = '恢复';
												str += $
														.formatString(
																'<a href="javascript:void(0);" title="{1}" onclick="del({0});">{2} <\/a>',
																row.id, s, s);
											}
											str += '&nbsp;';
											if ($.canSpread) {
												var s = '推广';
												if (row.source == '1')
													s = '取消推广';
												str += $
														.formatString(
																'<a href="javascript:void(0);" title="{1}" onclick="spread({0});">{2} <\/a>',
																row.id, s, s);
											}
											return str;
										}
									} ] ],
							toolbar : '#toolbar',
							onLoadSuccess : function() {
								$('#searchForm table').show();
								parent.$.messager.progress('close');

								//$(this).datagrid('tooltip');
							}

						});
	});

	function add(id) {
		dataGrid.datagrid('unselectAll').datagrid('uncheckAll');
		parent.addTab({
			url : '${pageContext.request.contextPath}/jf/sourceController/add',
			title : '增加商铺',
			iconCls : 'status_online'
		});
	}
	function update(id, storeid) {
		dataGrid.datagrid('unselectAll').datagrid('uncheckAll');
		parent
				.addTab({
					url : '${pageContext.request.contextPath}/jf/sourceController/update/'
							+ id,
					title : '修改商铺-' + storeid,
					iconCls : 'status_online'
				});
	}
	function del(id) {
		dataGrid.datagrid('unselectAll').datagrid('uncheckAll');
		parent.$.messager
				.confirm(
						'询问',
						'您是否要进行此操作？',
						function(b) {
							if (b) {
								parent.$.messager.progress({
									title : '提示',
									text : '数据处理中，请稍后....'
								});
								$
										.post(
												'${pageContext.request.contextPath}/jf/sourceController/del',
												{
													id : id
												},
												function(result) {
													if (result.success) {
														parent.$.messager
																.alert(
																		'提示',
																		result.msg,
																		'info');
														dataGrid
																.datagrid('reload');
													}
													parent.$.messager
															.progress('close');
												}, 'JSON');
							}
						});
	}
	function spread(id) {
		dataGrid.datagrid('unselectAll').datagrid('uncheckAll');
		parent.$.messager
				.confirm(
						'询问',
						'您是否要进行此操作？',
						function(b) {
							if (b) {
								parent.$.messager.progress({
									title : '提示',
									text : '数据处理中，请稍后....'
								});
								$
										.post(
												'${pageContext.request.contextPath}/jf/sourceController/spread',
												{
													id : id
												},
												function(result) {
													if (result.success) {
														parent.$.messager
																.alert(
																		'提示',
																		result.msg,
																		'info');
														dataGrid
																.datagrid('reload');
													}
													parent.$.messager
															.progress('close');
												}, 'JSON');
							}
						});
	}
	function xview(id) {
		dataGrid.datagrid('unselectAll').datagrid('uncheckAll');
		parent.$
				.modalDialog({
					title : '商铺查看',
					width : 800,
					height : 600,
					onOpen : null,
					href : '${pageContext.request.contextPath}/jf/sourceController/view?id='
							+ id,
					buttons : []
				});
	}

	function view(id, storeid) {
		dataGrid.datagrid('unselectAll').datagrid('uncheckAll');
		parent
				.addTab({
					url : '${pageContext.request.contextPath}/jf/sourceController/view?id='
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
						'${pageContext.request.contextPath}/jf/exportExcelController/excel?tab=store',
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
			style="height: 150px; width: 6900px;">
			<form id="searchForm">
				<table style="display: none;">
					<tr>
						<td width="80" align="right">商铺编码</td>
						<td width="130"><input name="sec.store_id.s.eq"
							placeholder="请输入商铺编码" /></td>
						<td width="80" align="right">目标行政区</td>
						<td><input class="easyui-combobox" style="width: 100px"
							name="sec.administrative_region.i.eq" id="xzq"
							data-options="
                    method:'get',
                    valueField:'id',
                    textField:'name',
                    multiple:false,
                    
            " />
						</td>
						<td width="80" align="right">目标商圈</td>
						<td><input style="width: 100px" class="easyui-combobox"
							style="width:100px" name="sec.business_area.i.in" id="sq"
							data-options="
            valueField:'id',
            textField:'name',
            multiple:true
            " />
						</td>
						<!--  
						<td width="80" align="right">是否重点商圈</td>
						<td width="130"><select class="easyui-combobox" name="sec.iskey.s.is_key"
							data-options="
								valueField: 'label',
								textField: 'value',
								panelHeight : 55,
								data: [{
									label: '1',
									value: '是'
								},{
									label: '0',
									value: '否'
								}]"
								style="width: 100px;" >
							</select></td>
						<td width="80" align="right">人员类型</td>
						<td width="130"><select class="easyui-combobox" id="type"
							name="sec.type.s.agent_type"
							data-options="
						 url: '${pageContext.request.contextPath}/jf/commonController/getTableCode/user-type',
                method: 'get',
                 panelHeight:'auto',
                valueField: 'code',
                textField: 'name'"
							style="width: 100px;">
						</select></td>
						-->
					</tr>
					<tr>
						<td width="80" align="right">上下水</td>
						<td width="130"><select class="easyui-combobox" id="water"
							name="sec.water.s.eq"
							data-options="
						 url: '${pageContext.request.contextPath}/jf/commonController/getTableCode/store-water',
                method: 'get',
                 panelHeight:'auto',
                valueField: 'code',
                textField: 'name'"
							style="width: 100px;">
						</select></td>
						<td width="80" align="right">电量</td>
						<td><select class="easyui-combobox" name="sec.power.s.eq"
							id="power"
							data-options="
						 url: '${pageContext.request.contextPath}/jf/commonController/getTableCode/store-power',
                method: 'get',
                panelHeight:'auto',
                valueField: 'code',
                textField: 'name'"
							style="width: 100px;">

						</select></td>
						<td width="80" align="right">明火</td>
						<td><select class="easyui-combobox" name="sec.fire.s.eq"
							id="fire"
							data-options="
						 url: '${pageContext.request.contextPath}/jf/commonController/getTableCode/store-fire',
                method: 'get',
                panelHeight:'auto',
                valueField: 'code',
                textField: 'name'"
							style="width: 100px;">
						</select></td>

						<td width="80" align="right">排风</td>
						<td width="130"><select class="easyui-combobox"
							name="sec.wind.s.eq" id="wind"
							data-options="
						 url: '${pageContext.request.contextPath}/jf/commonController/getTableCode/store-wind',
                method: 'get',
                panelHeight:'auto',
                valueField: 'code',
                textField: 'name'"
							style="width: 100px;">
						</select></td>
						<td width="80" align="right">燃气</td>
						<td width="130"><select class="easyui-combobox"
							name="sec.gas.s.eq" id="gas"
							data-options="
						 url: '${pageContext.request.contextPath}/jf/commonController/getTableCode/store-gas',
                method: 'get',
                panelHeight:'auto',
                valueField: 'code',
                textField: 'name'"
							style="width: 100px;">
						</select></td>
					</tr>
					<tr>
						<td width="80" align="right">年租金</td>
						<td width="180"><input class="easyui-numberbox"
							style="width: 60px" name="sec.year_rent.i.ge" /> 至<input
							class="easyui-numberbox" style="width: 60px"
							name="sec.year_rent.i.le" /> 元</td>
						<td width="80" align="right">单平米日租金</td>
						<td width="180"><input class="easyui-numberbox"
							style="width: 60px" name="sec.day_rent_per_centare.i.ge" /> 至<input
							class="easyui-numberbox" style="width: 60px"
							name="sec.day_rent_per_centare.i.le" /> 元</td>
						<td width="80" align="right">面积</td>
						<td width="180"><input class="easyui-numberbox"
							style="width: 60px" name="sec.area.i.ge" /> 至<input
							class="easyui-numberbox" style="width: 60px" name="sec.area.i.le" />平米
						</td>
						<td width="80" align="right">创建时间</td>
						<td width="220"><input class="easyui-datebox"
							style="width: 90px;" id="startCreateTime"
							name="sec.createtime.dt.ge" placeholder="点击选择时间"
							data-options="validType:'md[\'10/11/2012\']'"></input>至 <input
							style="width: 90px;" class="easyui-datebox" id="endCreateTime"
							name="sec.createtime.dt.le" placeholder="点击选择时间"
							data-options="validType:'md[\'10/11/2012\']'"></td>

					</tr>
					<tr>
						<td width="80" align="right">商铺状态</td>
						<td width="130"><select class="easyui-combobox" id="state"
							name="sec.state.s.eq"
							data-options="
						 url: '${pageContext.request.contextPath}/jf/commonController/getTableCode/store-state',
                method: 'get',
                 panelHeight:'auto',
                valueField: 'code',
                textField: 'name'"
							style="width: 100px;">
						</select></td>
						<td width="80" align="right">商铺来源</td>
						<td width="130"><select class="easyui-combobox" id="source"
							name="sec.source.s.eq"
							data-options="
						 url: '${pageContext.request.contextPath}/jf/commonController/getTableCode/store-source',
                method: 'get',
                 panelHeight:'auto',
                valueField: 'code',
                textField: 'name'"
							style="width: 100px;">
						</select></td>
						<td width="80" align="right">录入方式</td>
						<td width="130"><select class="easyui-combobox"
							id="submit_type" name="sec.submit_type.i.eq"
							data-options="
						 url: '${pageContext.request.contextPath}/jf/commonController/getTableCode?tab=store&attr=submit_type',
                method: 'get',
                 panelHeight:'auto',
                valueField: 'code',
                textField: 'name'"
							style="width: 100px;">
						</select></td>
					</tr>
				</table>

				<!-- 	            :      -->
				<!-- 	            :  -->
				<!-- 						: -->
				<!-- 						<input class="span2" name="sec.area.i.ge" /> -->
				<!-- 						至<input class="span2" name="sec.area.i.le" />	（元）  -->
				<!-- 					<br>           -->
				<!-- 	          商铺状态：<select  class="easyui-combobox" name="sec.state.s.eq" id="state" style="width:130px;"> -->
				<!-- 					    <option value="">不限</option> -->
				<!-- 					    <option value="1">成交</option> -->
				<!-- 					    <option value="2">未成交</option> -->
				<!-- 					</select>商铺来源: -->
				<!-- 					   <select  class="easyui-combobox" id="gas" name="sec.source.s.eq" style="width:130px;">              -->
				<!-- 	                      </select>  	 -->
				<!-- 			:<input class="span2" name="createdatetimeStart" placeholder="点击选择时间" onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd HH:mm:ss'})" readonly="readonly" />至<input class="span2" name="createdatetimeEnd" placeholder="点击选择时间" onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd HH:mm:ss'})" readonly="readonly" /></td> -->

			</form>
		</div>
		<div data-options="region:'center',border:false">
			<table id="dataGrid"></table>
		</div>
	</div>
	<div id="toolbar" style="display: none;">
		<c:if test="${fn:contains(modules, '/jf/storeController/add')}">
			<a onclick="add();" href="javascript:void(0);"
				class="easyui-linkbutton"
				data-options="plain:true,iconCls:'pencil_add'">添加商铺</a>
		</c:if>
		<c:if
			test="${fn:contains(modules, '/jf/exportExcelController/storeExcel')}">
			<a onclick="excel();" href="javascript:void(0);"
				class="easyui-linkbutton"
				data-options="plain:true,iconCls:'cog_add'">导出商铺</a>
		</c:if>

		<a href="javascript:void(0);" class="easyui-linkbutton"
			data-options="iconCls:'brick_add',plain:true" onclick="searchFun();">查&nbsp;&nbsp;询</a><a
			href="javascript:void(0);" class="easyui-linkbutton"
			data-options="iconCls:'brick_delete',plain:true"
			onclick="cleanFun();">清空查询</a>
	</div>

</body>
</html>