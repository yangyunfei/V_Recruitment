<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<title>用户管理</title>
<jsp:include page="../../inc.jsp"></jsp:include>
<c:if test="${fn:contains(modules, '/jf/sourceController/accept')}">
	<script type="text/javascript">
		$.canAccept = true;
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
							queryParams: {
								"sec.handleman.l.eq": 0,
								"sec.weight.i.eq": 1
							},
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
										field : 'createtime',
										title : '创建时间',
										width : 150,
										sortable : true
									},
									{
										field : 'name',
										title : '求职者姓名',
										width : 80,
										sortable : true,
										formatter : function(value, row, index) {
											var str = $
													.formatString(
															'<a href="javascript:void(0);" onclick="xview({0},\'{1}\');">{2} <\/a>',
															row.id, value,
															value);
											return str;
										}
									}, {
										field : 'phone',
										title : '联系方式',
										width : 100,
										sortable : true
									} ] ],
							columns : [ [
									{
										field : 'degree',
										title : '学历',
										width : 80,
										formatter : function(value, row, index) {
											var str = value;
											if (0 == value) {
												str = "其他";
											} else if (1 == value) {
												str = "专科";
											} else if (2 == value) {
												str = "本科";
											} else if (3 == value) {
												str = "硕士及以上";
											} 
											return str;
										}
									},									
									{
										field : 'school_name',
										title : '学校名称',
										width : 80
										
									},
									
									{
										field : 'school_level',
										title : '学校级别',
										width : 70
									},																										
									{
										field : 'origin',
										title : '渠道来源',
										width : 120,
										formatter : function(value, row, index) {
											var str = value;
											if (0 == value) {
												str = "其他端口";
											} else if (1 == value) {
												str = "58同城";
											} else if (2 == value) {
												str = "赶集网";
											} else if (3 == value) {
												str = "前程无忧";
											} else if (4 == value) {
												str = "智联招聘";
											}else if (5 == value) {
												str = "中华英才网";
											}else if (6 == value) {
												str = "转介绍";
											}
											
											return str;
										}
									},
									{
										field : 'recordmanname',
										title : '推荐人姓名',
										width : 80,
										formatter : function(value, row, index) {
											var str = $.formatString(
													'<a href="javascript:void(0);" onclick="agentView(\'{0}\');" >'
															+ value + '</a>',
													row.recordmannum);
											return str;
										}
									},
									{
										field : 'canclename',
										title : '最后的状态',
										width : 150,
										sortable : true
									},
									{
										field : 'action',
										title : '操作',
										width : 100,
										formatter : function(value, row, index) {
											var str = '';
											if($.canAccept)
											{
												str += $
														.formatString(
																'<a href="javascript:void(0);" title="收藏" onclick="accept({0});">收藏 <\/a>',
																row.id);
											}
											if ($.canUpdate){
												str += $
														.formatString(
																'<a href="javascript:void(0);" title="查看" onclick="view({0},\'{1}\');">查看 <\/a>',
																row.id,
																row.name);
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
	function accept(id)
	{
		dataGrid.datagrid('unselectAll').datagrid('uncheckAll');
		parent.$.messager
				.confirm(
						'询问',
						'您是否确定要收藏 ？',
						function(b) {
							if (b) {
								parent.$.messager.progress({
									title : '提示',
									text : '数据处理中，请稍后....'
								});
								$
										.post(
												'${pageContext.request.contextPath}/jf/sourceController/accept/'+id,
												{
													
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
					title : '基本信息查看',
					width : 400,
					height : 400,
					onOpen : null,
					href : '${pageContext.request.contextPath}/jf/sourceController/xview?id='
							+ id,
					buttons : []
				});
	}

	function view(id, name) {
		dataGrid.datagrid('unselectAll').datagrid('uncheckAll');
		parent
				.addTab({
					url : '${pageContext.request.contextPath}/jf/sourceController/view?id='
							+ id,
					title : '查看详情-' + name,
					iconCls : 'status_online'
				});
	}
	function agentView(pager)
	{
		dataGrid.datagrid('unselectAll').datagrid('uncheckAll');
		parent.$
				.modalDialog({
					title : '推荐人信息查看',
					width : 400,
					height : 400,
					onOpen : null,
					href : '${pageContext.request.contextPath}/jf/commonController/agentView/'
							+ pager,
					buttons : []
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
		$('#searchTable input').val('');
		dataGrid.datagrid('load', {"sec.handleman.l.eq": 0,"sec.weight.i.eq": 1});
	}
</script>
</head>
<body>
	<div class="easyui-layout" data-options="fit : true,border : false">
		<div data-options="region:'north',title:'查询条件',border:false"
			style="height: 150px; width: 6900px;">
			<form id="searchForm">
				<table id="searchTable" style="display: none;">
					<tr>
						<td width="80" align="right">姓名</td>
						<td width="130"><input name="sec.name.s.eq"
							placeholder="请输入姓名" /></td>
						<td width="80" align="right">推荐人系统号</td>
						<td width="130"><input name="sec.recordman.s.eq"
							placeholder="请输入推荐人系统号" /></td>
							<!-- 
						<td width="80" align="right">行政区</td>
						<td><input class="easyui-combobox" style="width: 100px"
							name="sec.administrative_region.i.eq" id="xzq"
							data-options="
                    method:'get',
                    valueField:'id',
                    textField:'name',
                    multiple:false,
                    
            " />
						</td>
						<td width="80" align="right">商圈</td>
						<td><input style="width: 100px" class="easyui-combobox"
							style="width:100px" name="sec.business_area.i.in" id="sq"
							data-options="
            valueField:'id',
            textField:'name',
            multiple:true
            " />
						</td>
						-->
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
						<td width="80" align="right">学历</td>
						<td width="130"><select class="easyui-combobox" id="water"
							name="sec.degree.i.eq"
							data-options="
						 url: '${pageContext.request.contextPath}/jf/commonController/getTableCode/presentee-degree',
                method: 'get',
                 panelHeight:'auto',
                valueField: 'code',
                textField: 'name'"
							style="width: 100px;">
						</select></td>
						<!--
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
						  -->
						<td width="80" align="right">渠道来源</td>
						<td width="130"><select class="easyui-combobox"
							id="submit_type" name="sec.origin.i.eq"
							data-options="
						 url: '${pageContext.request.contextPath}/jf/commonController/getTableCode/presentee-origin',
                method: 'get',
                 panelHeight:'auto',
                valueField: 'code',
                textField: 'name'"
							style="width: 100px;">
						</select></td>
						<td width="80" align="right">创建时间</td>
						<td width="220"><input class="easyui-datebox"
							style="width: 90px;" id="startCreateTime"
							name="sec.createtime.dt.ge" placeholder="点击选择时间"
							data-options="validType:'md[\'10/11/2012\']'"></input>至 <input
							style="width: 90px;" class="easyui-datebox" id="endCreateTime"
							name="sec.createtime.dt.le" placeholder="点击选择时间"
							data-options="validType:'md[\'10/11/2012\']'"></td>
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
			<input name="sec.handleman.l.eq" type="hidden" value="0" />
			<input name="sec.weight.i.eq" type="hidden" value='1' />
			</form>
		</div>
		<div data-options="region:'center',border:false">
			<table id="dataGrid"></table>
		</div>
	</div>
	<div id="toolbar" style="display: none;">
	<!-- 
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
     -->
		<a href="javascript:void(0);" class="easyui-linkbutton"
			data-options="iconCls:'brick_add',plain:true" onclick="searchFun();">查&nbsp;&nbsp;询</a><a
			href="javascript:void(0);" class="easyui-linkbutton"
			data-options="iconCls:'brick_delete',plain:true"
			onclick="cleanFun();">清空查询</a>
	</div>

</body>
</html>