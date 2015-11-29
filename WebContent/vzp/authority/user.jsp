<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<title>用户管理</title>
<jsp:include page="../../inc.jsp"></jsp:include>
<c:if test="${fn:contains(modules, '/jf/userController/editAcceptCountPage')}">
	<script type="text/javascript">
		$.canEditCount = true;
	</script>
</c:if>
<c:if test="${fn:contains(modules, '/jf/userController/add')}">
	<script type="text/javascript">
		$.canAdd = true;
	</script>
</c:if>
<c:if test="${fn:contains(modules, '/jf/userController/delete')}">
	<script type="text/javascript">
		$.canDelete = true;
	</script>
</c:if>
<c:if test="${fn:contains(modules, '/jf/userController/editPwdPage')}">
	<script type="text/javascript">
		$.canEditPwd = true;
	</script>
</c:if>
<script type="text/javascript">
	var dataGrid;
	$(function() {
		dataGrid = $('#dataGrid').datagrid({
			url : '${pageContext.request.contextPath}/jf/userController/dataGrid',
			//queryParams: {
			//	"sec.type.i.eq": 0,
			//},
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
			}, {
				field : 'name',
				title : '名称',
				width : 80,
				sortable : true,
				formatter : function(value, row, index) {
					var str = $
							.formatString(
									'<a href="javascript:void(0);" onclick="analysis({0},\'{1}\');">{2} <\/a>',
									row.id, value,
									value);
					return str;
				}
			} ] ],
			columns : [ [ {
				field : 'login_name',
				title : '登录名称',
				width : 60,
				sortable : true
			
			}, {
				field : 'createTime',
				title : '创建时间',
				width : 150,
				sortable : true
			}, {
				field : 'handleMaxNum',
				title : '收藏上限',
				width : 80,
				sortable : true
			}, {
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
				field : 'roleName',
				title : '角色名称',
				width : 150
			},
			{
				field : 'action',
				title : '操作',
				width : 100,
				formatter : function(value, row, index) {
					var str = '';
					if ($.canEditCount) {

						str += $.formatString('<a href="javascript:void(0);" title="修改收藏上限" onclick="editFun(\'{0}\');">修改收藏上限 <\/a>', row.id);
					}
					str += '&nbsp;';
					/* if ($.canDelete) */ {
						if(row.state == 0){		
						str += $.formatString('<a href="javascript:void(0);" title="停用" onclick="deleteFun(\'{0}\',\'{1}\');" >停用</a>', row.id,row.state);
						}else if(row.state == 1){
						str += $.formatString('<a href="javascript:void(0);" title="启用" onclick="deleteFun(\'{0}\',\'{1}\');" >启用</a>', row.id,row.state);			
						}
					}
					str += '&nbsp;';
					
					if ($.canEditPwd){
						str += $.formatString('<a  href="javascript:void(0);" title="修改密码" onclick="editPwdFun(\'{0}\');">修改密码</a>', row.id);
					}
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

	function editPwdFun(id) {
		dataGrid.datagrid('unselectAll').datagrid('uncheckAll');
		parent.$.modalDialog({
			title : '编辑用户密码',
			width : 500,
			height : 300,
			href : '${pageContext.request.contextPath}/jf/userController/editPwdPage?id=' + id,
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

	function deleteFun(id,state) {
		if (id == undefined) {//点击右键菜单才会触发这个
			var rows = dataGrid.datagrid('getSelections');
			id = rows[0].id;
		} else {//点击操作里面的删除图标会触发这个
			dataGrid.datagrid('unselectAll').datagrid('uncheckAll');
		}
		parent.$.messager.confirm('询问', '您是否要修改该用户状态？', function(b) {
			if (b) {
				var currentUserId = '${user.id}';/*当前登录用户的ID*/
				if (currentUserId != id) {
					parent.$.messager.progress({
						title : '提示',
						text : '数据处理中，请稍后....'
					});
					//alert(state);
					$.post('${pageContext.request.contextPath}/jf/userController/delete', {
						id:id,state:state
					}, function(result) {
						if (result.success) {
							parent.$.messager.alert('提示', result.msg, 'info');
							dataGrid.datagrid('reload');
						}
						parent.$.messager.progress('close');
					}, 'JSON');
				} else {
					parent.$.messager.show({
						title : '提示',
						msg : '不可以删除自己！'
					});
				}
			}
		});
	}

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
					$.getJSON('${pageContext.request.contextPath}/userController/batchDelete', {
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
			href : '${pageContext.request.contextPath}/jf/userController/editAcceptCountPage?id=' + id,
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
			href : '${pageContext.request.contextPath}/jf/userController/addPage',
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
				href : '${pageContext.request.contextPath}/userController/grantPage?ids=' + ids.join(','),
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
			href : '${pageContext.request.contextPath}/userController/grantPage?ids=' + id,
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
	
	function analysis(id ,name)
	{
		dataGrid.datagrid('unselectAll').datagrid('uncheckAll');
		parent
				.addTab({
					url : '${pageContext.request.contextPath}/jf/userController/analysis/' + id,
					title : '统计信息-' + name,
					iconCls : 'status_online'
				});
	}

	function searchFun() {
		dataGrid.datagrid('load', $.serializeObject($('#toolbar Input')));
	}
	function cleanFun() {
		$('#toolbar input').val('');
		dataGrid.datagrid('load', {});
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
	<c:if test="${fn:contains(modules, '/jf/userController/add')}">
	<a onclick="addFun();" href="javascript:void(0);" class="easyui-linkbutton" data-options="plain:true,iconCls:'pencil_add'" title="增加用户">增加用户</a>
	</c:if>
	
	
   登陆名称:<input name="sec.login_name.s.like" placeholder="可以模糊查询登录名称" />
	   角色：<input class="easyui-combobox" name="sec.roles.s.like"  data-options="url:'${pageContext.request.contextPath}/jf/userController/roleList',valueField:'id',textField:'role_name',editable:true, panelHeight:'auto'"/>
	联系电话：<input name="sec.phone.s.eq" placeholder="可以查询用户联系方式" />
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