<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script type="text/javascript">
	var dataGrid;
	var module = '${role.module}';
	var modules = module.split(',');
	$(function() {
		dataGrid = $('#dataGrid').datagrid({
			url : '${pageContext.request.contextPath}/jf/roleController/getModule',
			fit : true,
			fitColumns : true,
			border : false,
			pagination : false,
			idField : 'id',
			pageSize : 20,
			pageList : [ 10, 20, 30, 40, 50 ],
			sortName : 'id',
			sortOrder : 'asc',
			checkOnSelect : false,
			selectOnCheck : false,
			singleSelect:true,
			nowrap : false,
			columns : [ [ {
				field : 'id',
				title : '编号',
				width : 150,
				checkbox : true
			}, {
				field : 'name',
				title : '菜单说明',
				width : 80,
				sortable : true,
				formatter : function(value, row, index) {
					var str = row.name;
					if(row.fid != null)
					{
						str = "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"+ str;
					}
					return str;
				}
			}, {
				field : 'url',
				title : '路径',
				width : 200,
			},{
				field : 'type',
				title : '类别',
				width : 80,
				formatter : function(value, row, index) {
					var str = '';
					if(row.type == 0)
					{
						str = "菜单显示";
					}
					else if(row.type == 1)
					{
						str = "功能模块";
					}
					else
					{
						str = "异常情况";
					}
					var moduleid = row.id;
					var flag = false;
					for(var i=0;i<modules.length;i++)
					{
						if(modules[i] == moduleid)
						{
							flag = true;
							break;
						}
					}
					if(flag){ $('#dataGrid').datagrid('checkRow',index); }
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

		$('#form').form({
			url : '${pageContext.request.contextPath}/jf/roleController/edit',
			onSubmit : function() {
				parent.$.messager.progress({
					title : '提示',
					text : '数据处理中，请稍后....'
				});
				var isValid = $(this).form('validate');
				if (!isValid) {
					parent.$.messager.progress('close');
				}
				return isValid;
			},
			success : function(result) {
				parent.$.messager.progress('close');
				result = $.parseJSON(result);
				if (result.success) {
					parent.$.modalDialog.openner_dataGrid.datagrid('reload');//之所以能在这里调用到parent.$.modalDialog.openner_treeGrid这个对象，是因为role.jsp页面预定义好了
					parent.$.modalDialog.handler.dialog('close');
				}
			}
		});
	});
</script>
<div class="easyui-layout" data-options="fit:true,border:false">
	<div data-options="region:'center',border:false" title="" style="overflow: hidden;">
		<form id="form" method="post">
			<table class="table table-hover table-condensed">
				<tr>
					<input name="roleid" type="hidden" class="span2" value="${role.id}" readonly="readonly">
					<th>角色名称</th>
					<td><input name="name" type="text" placeholder="请输入角色名称" class="easyui-validatebox span2" data-options="required:true" value="${role.role_name}"></td>
				</tr>
				<tr>
					<table id="dataGrid"></table>
				</tr>
			</table>
		</form>
	</div>
</div>