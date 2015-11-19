<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<title>用户管理</title>
<jsp:include page="../../inc.jsp"></jsp:include>
<c:if test="${fn:contains(modules, '/jf/cusController/edit')}">
	<script type="text/javascript">
		$.canEdit = true;
	</script>
</c:if>
<script type="text/javascript">
	var dataGrid;
	var state = '${state}';
	$(function() {
		dataGrid = $('#dataGrid')
				.datagrid(
						{
							url : '${pageContext.request.contextPath}/jf/recruitController/dataGrid',
							queryParams: {"sec.state.i.eq": 2 ,"sec.handleman.l.eq": '${user.id}'}, 
							fit : true,
							fitColumns : false,
							border : false,
							pagination : true,
							idField : 'id',
							pageSize : 10,
							pageList : [ 10, 20, 30, 40, 50 ],
							sortName : 'interviewtime',
							sortOrder : 'asc',
							checkOnSelect : false,
							selectOnCheck : false,
							nowrap : false,
							onLoadSuccess : function() {
								$(this).datagrid('freezeRow', 0).datagrid(
										'freezeRow', 1);
							},
							frozenColumns : [ [
									{
										field : 'id',
										title : '编号',
										width : 150,
										checkbox : true
									},
									/**
									
									{
										field : 'lastUpdateTime',
										title : '更新时间',
										width : 150,
										sortable : true
									},
									*/
									{
										field : 'interviewtime',
										title : '面试时间',
										width : 150,
										sortable : true
									},
									{
										field : 'name',
										title : '求职者姓名',
										width : 70,
										sortable : true,
										formatter : function(value, row, index) {
											var str = $.formatString(
													'<a href="javascript:void(0);" onclick="xview(\'{0}\');" >'
															+ value + '</a>',
													row.presentee_id);
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
										width : 70,
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
										width : 100,
										sortable : true
									},
									{
										field : 'school_level',
										title : '学校级别',
										width : 70,
										sortable : true
									},
									{
										field : 'origin',
										title : '渠道来源',
										width : 70,
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
										field : 'state',
										title : '注释',
										//colspan: 4,
										width : 80,
										formatter : function(value, row, index) {
											var str = value;
											  if (2 == value)
												str = "待面试"
											else if (1 == value)
												str = "待处理"
													else if (3 == value)
														str = "初试通过"
											return str;
										}
									}

									,
									{
										field : 'action',
										title : '操作',
										width : 300,
										formatter : function(value, row, index) {
											var str = '';											
											if(row.state == 2)
											{
												str += $
												.formatString(
														'<a href="javascript:void(0);" onclick="pass(\'{0}\',\'{1}\');" >通过</a>',
														row.id,row.idcard);
												str += "&nbsp;&nbsp;";
												str += $
												.formatString(
														'<a href="javascript:void(0);" onclick="nopass(\'{0}\');" >未通过</a>',
														row.id);
												str += "&nbsp;&nbsp;";
												str += $
												.formatString(
														'<a href="javascript:void(0);" onclick="EditInterview(\'{0}\');" >修改面试时间</a>',
														row.id);
												str += "&nbsp;&nbsp;";
												str += $
												.formatString(
														'<a href="javascript:void(0);" onclick="noComeInterview(\'{0}\');" >未参加面试</a>',
														row.id);
												str += "&nbsp;&nbsp;";
												str += $
												.formatString(
														'<a href="javascript:void(0);" onclick="addProperty(\'{0}\',\'{1}\');" >完善信息</a>',
														row.id,row.name);
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
						/* 表单右击菜单
						onRowContextMenu : function(e, rowIndex, rowData) {
							e.preventDefault();
							$(this).datagrid('unselectAll').datagrid('uncheckAll');
							$(this).datagrid('selectRow', rowIndex);
							$('#menu').menu('show', {
								left : e.pageX,
								top : e.pageY
							});
						}
						 */
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
		/* if (id == undefined) {
			var rows = dataGrid.datagrid('getSelections');
			id = rows[0].id;
		} else {
			dataGrid.datagrid('unselectAll').datagrid('uncheckAll');
		} */
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
		parent.$
				.modalDialog({
					title : '添加客户',
					width : 800,
					height : 400,
					onOpen : null,
					href : '${pageContext.request.contextPath}/jf/cusController/addPage',
					buttons : [ {
						text : '添加',
						handler : function() {
							parent.$.modalDialog.openner_dataGrid = dataGrid;//因为添加成功之后，需要刷新这个dataGrid，所以先预定义好
							var f = parent.$.modalDialog.handler.find('#form');
							f.submit();
						}
					} ]
				});
	}

	function batchGrantFun() {
		var rows = dataGrid.datagrid('getChecked');
		var ids = [];
		if (rows.length > 0) {
			for (var i = 0; i < rows.length; i++) {
				ids.push(rows[i].id);
			}
			parent.$
					.modalDialog({
						title : '用户授权',
						width : 500,
						height : 300,
						href : '${pageContext.request.contextPath}/userController/grantPage?ids='
								+ ids.join(','),
						buttons : [ {
							text : '授权',
							handler : function() {
								parent.$.modalDialog.openner_dataGrid = dataGrid;//因为授权成功之后，需要刷新这个dataGrid，所以先预定义好
								var f = parent.$.modalDialog.handler
										.find('#form');
								f.submit();
							}
						} ]
					});
		} else {
			parent.$.messager.show({
				title : '提示',
				msg : '请勾选要授权的记录！'
			});
		}
	}

	function view(id, customer_code) {
		dataGrid.datagrid('unselectAll').datagrid('uncheckAll');
		parent.addTab({
			url : '${pageContext.request.contextPath}/jf/cusController/view/'
					+ id,
			title : '客户详情-' + customer_code,
			iconCls : 'status_online'
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
	function cleanFun() {
		$('#searchTable input').val('');
		dataGrid.datagrid('load', {"sec.state.i.eq": 2 ,"sec.handleman.l.eq": '${user.id}'});
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

	function pass(id,idcard)
	{
		/*
		if("" == idcard || "null" == idcard)
		{
			alert("请先完善信息！");
			return;
		}
		*/
		dataGrid.datagrid('unselectAll').datagrid('uncheckAll');
		parent.$.messager
				.confirm(
						'询问',
						'您确定已通过初试 ？',
						function(b) {
							if (b) {
								parent.$.messager.progress({
									title : '提示',
									text : '数据处理中，请稍后....'
								});
								$
										.post(
												'${pageContext.request.contextPath}/jf/recruitController/pass/'+id,
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
	};
	
	function nopass(id)
	{
		dataGrid.datagrid('unselectAll').datagrid('uncheckAll');
		parent.$.messager
				.confirm(
						'询问',
						'您确定未通过 ？',
						function(b) {
							if (b) {
								parent.$.messager.progress({
									title : '提示',
									text : '数据处理中，请稍后....'
								});
								$
										.post(
												'${pageContext.request.contextPath}/jf/recruitController/nopass/'+id,
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
	
	
	function EditInterview(id){
		parent.$.modalDialog({
			title : '面试时间',
			width : 400,
			height : 200,
			href : '${pageContext.request.contextPath}/jf/recruitController/toEditInterview/'+id,
			buttons : [ {
				text : '提交',
				handler : function() {
					parent.$.modalDialog.openner_dataGrid = dataGrid;//因为添加成功之后，需要刷新这个dataGrid，所以先预定义好
					var f = parent.$.modalDialog.handler.find('#form');
					f.submit();
				}
			} ]
		});
	};
	
	
	function noComeInterview(id)
	{
		dataGrid.datagrid('unselectAll').datagrid('uncheckAll');
		parent.$.messager
				.confirm(
						'询问',
						'您确定未参加面试 ？',
						function(b) {
							if (b) {
								parent.$.messager.progress({
									title : '提示',
									text : '数据处理中，请稍后....'
								});
								$
										.post(
												'${pageContext.request.contextPath}/jf/recruitController/noComeInterview/'+id,
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
	};
	
	function addProperty(id,name)
	{
		/*
		parent.$.modalDialog({
			title : '完善信息',
			width : 800,
			height : 600,
			href : '${pageContext.request.contextPath}/jf/recruitController/toaddProperty/'+id,
			buttons : [ {
				text : '提交',
				handler : function() {
					parent.$.modalDialog.openner_dataGrid = dataGrid;//因为添加成功之后，需要刷新这个dataGrid，所以先预定义好
					var f = parent.$.modalDialog.handler.find('#form');
					f.submit();
				}
			} ]
		});
		*/
		dataGrid.datagrid('unselectAll').datagrid('uncheckAll');
		parent
				.addTab({
					url : '${pageContext.request.contextPath}/jf/recruitController/toaddProperty/' + id,
					title : '完善信息-' + name,
					iconCls : 'status_online'
				});
	}
</script>
</head>
<body>
	<div class="easyui-layout" data-options="fit : true,border : false">
		<div data-options="region:'north',title:'查询条件',border:false"
			style="height: 100px;">
			<form id="searchForm">
				<table id="searchTable" class="table table-hover table-condensed"
					style="display: none;">
					<tr>
						<th>求职者姓名</th>
						<td><input name="sec.name.s.like" placeholder="请输入求职者姓名"
							class="span2" /></td>						
						<th>求职者电话</th>
						<td><input name="sec.phone.s.eq" placeholder="请输入电话号码"
							class="span2" /></td>
						<th>推荐人</th>
						<td><input name="sec.recordmanname.s.eq" placeholder="请输入推荐人姓名"
							class="span2" /></td>
					</tr>					
				</table>
				<input name="sec.state.i.eq" type="hidden" value="2" />
				<input name="sec.handleman.l.eq" type="hidden" value="${user.id}" />	
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
		<c:if
			test="${fn:contains(modules, '/jf/exportExcelController/customerExcel')}">
			<a href="javascript:void(0);" class="easyui-linkbutton"
				data-options="iconCls:'box',plain:true" onclick="exportReport();">导出报表</a>
		</c:if>
	</div>

	<div id="menu" class="easyui-menu" style="width: 120px; display: none;">
		<c:if
			test="${fn:contains(sessionInfo.resourceList, '/userController/addPage')}">
			<div onclick="addFun();" data-options="iconCls:'pencil_add'">增加</div>
		</c:if>
		<c:if
			test="${fn:contains(sessionInfo.resourceList, '/userController/delete')}">
			<div onclick="deleteFun();" data-options="iconCls:'pencil_delete'">删除</div>
		</c:if>
		<c:if
			test="${fn:contains(sessionInfo.resourceList, '/userController/editPage')}">
			<div onclick="editFun();" data-options="iconCls:'pencil'">编辑</div>
		</c:if>
	</div>
</body>
<!--  
<script type="text/javascript">
	$(function() {
		var xzq = $('#xzq')
				.combobox(
						{
							url : '${pageContext.request.contextPath}/jf/areaBusinessController/selectAllBigDistrict',
							editable : false,
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

<script type="text/javascript">
	$(function() {
		//$('#cushy').combotree('loadData', [{ id: 1, text: 'Languages', children: [{ id: 11, text: 'Java' },{ id: 12, text: 'C++' }] }]); 
		// $('#cushy').combo('setValue', 'text');
		$('#cushy')
				.combotree(
						{
							url : '${pageContext.request.contextPath}/jf/industryController/findIndustry',
							textField : 'text',
							valueField : '餐馆',

							editable : false,
							onlyLeafCheck : true,
							cascaseCheck : true,
							method : 'get',
							onLoadSuccess : function(node, data) {
								$('#cushy').val(data.text);
							}
						});

	});
</script>
-->
</html>