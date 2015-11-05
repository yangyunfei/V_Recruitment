<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<title>用户管理</title>
<jsp:include page="../../inc.jsp"></jsp:include>
<c:if test="${fn:contains(modules, '/jf/agentController/edit')}">
	<script type="text/javascript">
		$.canEdit = true;
	</script>
</c:if>
<c:if test="${fn:contains(modules, '/jf/agentController/add')}">
	<script type="text/javascript">
		$.canAdd = true;
	</script>
</c:if>
<script type="text/javascript">
	var dataGrid;
	$(function() {
		dataGrid = $('#dataGrid').datagrid({
			url : '${pageContext.request.contextPath}/jf/agentController/dataGrid',
			queryParams: {
				"sec.type.i.noteq": 0,
			},
			fit : true,
			fitColumns : true,
			border : false,
			pagination : true,
			idField : 'id',
			pageSize : 20,
			pageList : [ 10, 20, 30, 40, 50 ],
			sortName : 'name',
			sortOrder : 'asc',
			checkOnSelect : false,
			selectOnCheck : false,
			singleSelect:true,
			nowrap : false,
			frozenColumns : [ [ {
				field : 'id',
				title : '编号',
				width : 150,
				checkbox : true
			} ] ],
			columns : [ [  {
				field : 'pager',
				title : '系统号',
				width : 150,
				sortable : true,
				formatter : function(value, row, index) {
					if(value!=null){
						var str = $.formatString(
								'<a href="javascript:void(0);" onclick="viewAgentDetail({0},{1})" ">{2} <\/a>',value,row.id,value);
				         return str;
					}
				
				}
			},{
				field : 'realname',
				title : '姓名',
				width : 150				
			},
			/* {
				field : 'openid',
				title : '微信openid',
				width : 150,
				sortable : true
			}, */
			{
				field : 'phone',
				title : '电话',
				width : 150,
				sortable : true
			}, 
			{
				field : 'state',
				title : '状态',
				width : 150,
				sortable : true,
				formatter: function (value,row,index)
				{		
                    switch(value)
                    {
                       case 0:return '正常'; 
                       case 1:return '停用';          
                   }
			    }
			},
			{
				field : 'type',
				title : '用户类型',
				width : 150,
				formatter:function(value,row,index)
				{
					switch(value)
					{
						case 0 : return "后台用户";
					}
				}
			},
			/* {
				field : 'createtime',
				title : '创建时间',
				width : 150,
				sortable : true
			},{
				field : 'lastupdatetime',
				title : '最后更新时间',
				width : 150,
				sortable : true
			}, */
			{
				field : 'action',
				title : '操作',
				width : 100,
				formatter : function(value, row, index) {
					var str = '';
					if ($.canEdit) {

						str += $.formatString('<a href="javascript:void(0);" title="编辑" onclick="editFun(\'{0}\');">编辑 <\/a>', row.id);
					}
					str += '&nbsp;';
					
					return str;
				}
			} ] ],
			toolbar : '#toolbar',
			onLoadSuccess : function() {
				//$('#searchForm table').show();
				parent.$.messager.progress('close');

				//$(this).datagrid('tooltip');
			},
			onRowContextMenu : function(e, rowIndex, rowData) {
				e.preventDefault();
				$(this).datagrid('unselectAll').datagrid('uncheckAll');
				$(this).datagrid('selectRow', rowIndex);
				$('#menu').menu('show', {
					left : e.pageX,
					top : e.pageY
				});
			}
		});
	});


	function batchDeleteFun() {
		var rows = dataGrid.datagrid('getChecked');
		var ids = [];
		if (rows.length > 0) {
			parent.$.messager.confirm('确认', '您是否要删除当前选中的项目？', function(r) {
				if (r) {
					parent.$.messager.progress({
						title : '提示',
						text : '数据处理中，请稍后....'
					});
					var currentUserId = '${sessionInfo.id}';/*当前登录用户的ID*/
					var flag = false;
					for ( var i = 0; i < rows.length; i++) {
						if (currentUserId != rows[i].id) {
							ids.push(rows[i].id);
						} else {
							flag = true;
						}
					}
					$.getJSON('${pageContext.request.contextPath}/agentController/batchDelete', {
						ids : ids.join(',')
					}, function(result) {
						if (result.success) {
							dataGrid.datagrid('load');
							dataGrid.datagrid('uncheckAll').datagrid('unselectAll').datagrid('clearSelections');
						}
						if (flag) {
							parent.$.messager.show({
								title : '提示',
								msg : '不可以删除自己！'
							});
						} else {
							parent.$.messager.alert('提示', result.msg, 'info');
						}
						parent.$.messager.progress('close');
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
		if (id == undefined) {
			var rows = dataGrid.datagrid('getSelections');
			id = rows[0].id;
		} else {
			dataGrid.datagrid('unselectAll').datagrid('uncheckAll');
		}
		parent.$.modalDialog({
			title : '编辑用户',
			width : 500,
			height : 300,
			href : '${pageContext.request.contextPath}/jf/agentController/editPage?id=' + id,
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
		parent.$.modalDialog({
			title : '添加用户',
			width : 600,
			height : 450,
			href : '${pageContext.request.contextPath}/jf/agentController/addPage',
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
			for ( var i = 0; i < rows.length; i++) {
				ids.push(rows[i].id);
			}
			parent.$.modalDialog({
				title : '用户授权',
				width : 500,
				height : 300,
				href : '${pageContext.request.contextPath}/agentController/grantPage?ids=' + ids.join(','),
				buttons : [ {
					text : '授权',
					handler : function() {
						parent.$.modalDialog.openner_dataGrid = dataGrid;//因为授权成功之后，需要刷新这个dataGrid，所以先预定义好
						var f = parent.$.modalDialog.handler.find('#form');
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

	function grantFun(id) {
		dataGrid.datagrid('unselectAll').datagrid('uncheckAll');
		parent.$.modalDialog({
			title : '用户授权',
			width : 500,
			height : 300,
			href : '${pageContext.request.contextPath}/agentController/grantPage?ids=' + id,
			buttons : [ {
				text : '授权',
				handler : function() {
					parent.$.modalDialog.openner_dataGrid = dataGrid;//因为授权成功之后，需要刷新这个dataGrid，所以先预定义好
					var f = parent.$.modalDialog.handler.find('#form');
					f.submit();
				}
			} ]
		});
	}

	function searchFun() {
		dataGrid.datagrid('load', $.serializeObject($('#searchForm')));
	}
	function cleanFun() {
		$('#toolbar input').val('');
		dataGrid.datagrid('load', {});
	}
	
	function viewAgentDetail(agentNum,id){
		dataGrid.datagrid('unselectAll').datagrid('uncheckAll');
		parent.addTab({url :'${pageContext.request.contextPath}/jf/agentController/getAgentDetailByID?id='+id,
				title : '经纪人-'+agentNum,
				iconCls : 'status_online'
		}
		);
		
	}
</script>
</head>
<body>
	<div class="easyui-layout" data-options="fit : true,border : false">
		<div data-options="region:'center',border:false">
			<table id="dataGrid"></table>
		</div>
	</div>
	<div id="toolbar" style="display: none;">
	<c:if test="${fn:contains(modules, '/jf/agentController/add')}">
	<a onclick="addFun();" href="javascript:void(0);" class="easyui-linkbutton" data-options="plain:true,iconCls:'pencil_add'" title="增加用户">增加用户</a>
	</c:if>
	
	<form id="searchForm">
	 系统号：<input  name="sec.pager.s.like" placeholder="可以模糊查询系统号"/>
	联系电话：<input name="sec.phone.s.eq" placeholder="可以查询用户联系方式" />
	经纪人类型:<select  name="sec.type.i.eq">
								<option value="">不限</option>
								<option value="1">普通经纪人</option>
								<option value="2">注册经纪人</option>
								<option value="3">真有铺经纪人</option>
								<option value="4">商铺专家</option>
						</select>
	
	<input name="sec.type.i.noteq" type="hidden" value="0" />
	</form>
	<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'brick_add',plain:true" onclick="searchFun();" title="执行查询">查询</a>
	   <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'brick_delete',plain:true" onclick="cleanFun();" title="清空查询">清空查询</a>

	</div>

	<div id="menu" class="easyui-menu" style="width: 120px; display: none;">
		<c:if test="${fn:contains(modules, '/userController/addPage')}">
			<div onclick="addFun();" data-options="iconCls:'pencil_add'">增加</div>
		</c:if>
		<c:if test="${fn:contains(modules, '/userController/delete')}">
			<div onclick="deleteFun();" data-options="iconCls:'pencil_delete'">删除</div>
		</c:if>
		<c:if test="${fn:contains(modules, '/userController/editPage')}">
			<div onclick="editFun();" data-options="iconCls:'pencil'">编辑</div>
		</c:if>
	</div>
</body>
</html>