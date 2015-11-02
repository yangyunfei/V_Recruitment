<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<title>资讯</title>
<jsp:include page="../../inc.jsp"></jsp:include>
<c:if test="${fn:contains(modules, '/jf/cusController/edit')}">
	<script type="text/javascript">
		$.canEdit = true;
	</script>
</c:if>
<c:if test="${fn:contains(modules, '/jf/cusController/delete')}">
	<script type="text/javascript">
		$.canDelete = true;
	</script>
</c:if>
<c:if test="${fn:contains(modules, '/jf/cusController/add')}">
	<script type="text/javascript">
		$.canAdd = true;
	</script>
</c:if>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/download.js"></script>
<script type="text/javascript">
	var dataGrid;
	$(function() {
		dataGrid = $('#dataGrid')
				.datagrid(
						{
							url : '${pageContext.request.contextPath}/jf/newsController/findAllNews',
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
							columns : [ [
									{
										field : 'id',
										title : '资讯编号',
										width : $(this).width() * 0.1,
									},
									{
										field : 'title',
										title : '资讯标题',
										width : $(this).width() * 0.1,
										sortable : true
									},
									
									{
										field : 'state',
										title : '资讯状态',
										width : $(this).width() * 0.1,
										formatter : function(value, row, index) {
											var str = value;
											if (1 == value) {
												str = "编辑";
											} else if (2== value) {
												str = "待发布";
											} else if (3 == value) {
												str = "已发布";
											} 
											return str;
										}
									},
									{
										field : 'publish',
										title : '发布方',
										width : $(this).width() * 0.2,
										formatter : function(value, row, index) {
											var str = value;
											if (0 == value) {
												str = "全部";
											} else if (1 == value) {
												str = "真有铺";
											} else if (2 == value) {
												str = "专家团队";
											} 
											return str;
										}
									},
									{
										field : 'channel',
										title : '发布渠道',
										width : $(this).width() * 0.2,
										sortable : true
									},{
										field : 'createdate',
										title : '发布时间',
										width : $(this).width() * 0.2,
										sortable : true
									},
									{
										field : 'action',
										title : '操作',
										width : $(this).width() * 0.15,
										formatter : function(value, row, index) {
											var str = '';
										/* 	str += $
													.formatString(
															'<a href="javascript:void(0);" onclick="view(\'{0}\',\'{1}\');" >编辑</a>',
															row.id,
															row.customer_code); */
											str += $
											.formatString(
													'&nbsp&nbsp<a href="javascript:void(0);" onclick="view(\'{0}\',\'{1}\');" >查看</a>',
													row.id,
													row.store_id);
											
											return str;
										}
									} ] ],
							toolbar : '#toolbar',
							onLoadSuccess : function() {
								$('#searchForm table').show();
								parent.$.messager.progress('close');

							}
						});
	});

	function editPwdFun(id) {
		dataGrid.datagrid('unselectAll').datagrid('uncheckAll');
		parent.$
				.modalDialog({
					title : '编辑用户密码',
					width : 500,
					height : 300,
					href : '${pageContext.request.contextPath}/userController/editPwdPage?id='
							+ id,
					buttons : [ {
						text : '编辑',
						handler : function() {
							parent.$.modalDialog.openner_dataGrid = dataGrid;//因为添加成功之后，需要刷新这个dataGrid，所以先预定义好
							var f = parent.$.modalDialog.handler.find('#form');
							f.submit();
						}
					} ]
				});
	}

	function deleteFun(id) {
		if (id == undefined) {//点击右键菜单才会触发这个
			var rows = dataGrid.datagrid('getSelections');
			id = rows[0].id;
		} else {//点击操作里面的删除图标会触发这个
			dataGrid.datagrid('unselectAll').datagrid('uncheckAll');
		}
		parent.$.messager
				.confirm(
						'询问',
						'您是否要删除当前客户？',
						function(b) {
							if (b) {
								parent.$.messager.progress({
									title : '提示',
									text : '数据处理中，请稍后....'
								});
								$
										.post(
												'${pageContext.request.contextPath}/jf/cusController/delete',
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

	function batchDeleteFun() {
		var rows = dataGrid.datagrid('getChecked');
		var ids = [];
		if (rows.length > 0) {
			parent.$.messager
					.confirm(
							'确认',
							'您是否要删除当前选中的项目？',
							function(r) {
								if (r) {
									parent.$.messager.progress({
										title : '提示',
										text : '数据处理中，请稍后....'
									});
									var currentUserId = '${sessionInfo.id}';/*当前登录用户的ID*/
									var flag = false;
									for (var i = 0; i < rows.length; i++) {
										if (currentUserId != rows[i].id) {
											ids.push(rows[i].id);
										} else {
											flag = true;
										}
									}
									$
											.getJSON(
													'${pageContext.request.contextPath}/userController/batchDelete',
													{
														ids : ids.join(',')
													},
													function(result) {
														if (result.success) {
															dataGrid
																	.datagrid('load');
															dataGrid
																	.datagrid(
																			'uncheckAll')
																	.datagrid(
																			'unselectAll')
																	.datagrid(
																			'clearSelections');
														}
														if (flag) {
															parent.$.messager
																	.show({
																		title : '提示',
																		msg : '不可以删除自己！'
																	});
														} else {
															parent.$.messager
																	.alert(
																			'提示',
																			result.msg,
																			'info');
														}
														parent.$.messager
																.progress('close');
													});
								}
							});
		} else {
			parent.$.messager.show({
				title : '提示',
				msg : '请勾选要删除的记录！'
			});
		}
	}

	function editFun(id) {
		parent.$
				.modalDialog({
					title : '编辑用户',
					width : 800,
					height : 400,
					href : '${pageContext.request.contextPath}/jf/cusController/editPage/'
							+ id,
					onOpen : null,
					buttons : [ {
						text : '编辑',
						handler : function() {
							parent.$.modalDialog.openner_dataGrid = dataGrid;//因为添加成功之后，需要刷新这个dataGrid，所以先预定义好
							var f = parent.$.modalDialog.handler.find('#form');
							f.submit();
						}
					} ]
				});
	}

	function addFun() {
		dataGrid.datagrid('unselectAll').datagrid('uncheckAll');
		parent.addTab({
			url : '${pageContext.request.contextPath}/jf/newsController/toAddNews',
			title : '增加资讯',
			iconCls : 'status_online'
		});
	}


	function view(id, customer_code) {
		dataGrid.datagrid('unselectAll').datagrid('uncheckAll');
		parent.addTab({
			url : '${pageContext.request.contextPath}/jf/newsController/toNewsDetail?id='+ id,
			title : '资讯详情-' + id,
			iconCls : 'status_online'
		});
	}

	function searchFun() {
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
				'${pageContext.request.contextPath}/jf/exportExcelController/excel?tab=customers_app',
				sec, 'POST');
	}
</script>
</head>
<body>
	<div class="easyui-layout" data-options="fit : true,border : false">
		<div data-options="region:'north',title:'查询条件',border:false"
			style="height: 145px;">
			<form id="searchForm">
				<table class="table table-hover table-condensed"
					style="display: none;">


					<tr>
						<th>资讯状态</th>
						<td><select name="sec.state.s.eq"
							class="form-control input-sm" style="width: 130px">
								<option  value="">全部</option>
								<option value="1">编辑</option>
								<option value="2">待发布</option>
								<option value="3">已发布</option>
						</select></td>
						<th>发布渠道</th>
						<td><select class="form-control input-sm"
							style="width: 130px" name="sec.channel.s.like">
								<option value="">全部</option>
								<option value="1">客户端</option>
								<option value="2">销售端</option>
								<option value="3">PC端</option>
						</select></td>

						<th>发布方</th>
						<td><select class="form-control input-sm"
							style="width: 130px" name="sec.publish.s.eq">
								<option value="">全部</option>
								<option value="1">真有铺</option>
								<option value="2">专家团队</option>
						</select></td>

					</tr>
					<tr>
						<th>资讯标题</th>
						<td><input name="sec.title.s.like"
							placeholder="请输入资讯标题" class="span2" /></td>
						<th>资讯编号</th>
						<td><input name="sec.id.s.eq" placeholder="请输入资讯编号"
							class="span2" /></td>
						<th>发布时间</th>
						<td colspan="2"><input class="easyui-datebox"
							style="width: 100px;" id="startCreateTime"
							name="sec.createdate.dt.ge"
							data-options="validType:'md[\'10/11/2012\']'"></input>&nbsp;至&nbsp;
							<input style="width: 100px;" class="easyui-datebox"
							id="endCreateTime" name="sec.createdate.dt.le"
							data-options="validType:'md[\'10/11/2012\']'"></input></td>
					</tr>
				</table>
			</form>
		</div>
		<div data-options="region:'center',border:false">
			<table id="dataGrid"></table>
		</div>
	</div>
	<div id="toolbar" style="display: none;">
		<c:if test="${fn:contains(modules, '/jf/cusController/add')}">
			<a onclick="addFun();" href="javascript:void(0);"
				class="easyui-linkbutton"
				data-options="plain:true,iconCls:'pencil_add'">添加</a>
		</c:if>
		<a href="javascript:void(0);" class="easyui-linkbutton"
			data-options="iconCls:'brick_add',plain:true" onclick="searchFun();">查询</a><a
			href="javascript:void(0);" class="easyui-linkbutton"
			data-options="iconCls:'brick_delete',plain:true"
			onclick="cleanFun();">清空条件</a>
	</div>
</body>

</html>