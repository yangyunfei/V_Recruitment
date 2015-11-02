<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<title>消息数据</title>
<jsp:include page="../inc.jsp"></jsp:include>
<c:if test="${sessionInfo.regionType==0}">
	<script type="text/javascript">
		$.superuser = true;
	</script>
</c:if>
<script type="text/javascript">
	var dataGrid;
	$(function() {
		dataGrid = $('#dataGrid').datagrid({
			url : '${pageContext.request.contextPath}/MsgController/dataGrid',
			fit : true,
			fitColumns : false,
			border : false,
			pagination : true,
			idField : 'id',
			pageSize : 10,
			pageList : [ 10, 20, 30, 40, 50 ],
			sortName : 'createdatetime',
			sortOrder : 'desc',
			checkOnSelect : false,
			selectOnCheck : false,
		    singleSelect:true,
			nowrap : false,
			frozenColumns : [ [ {
				field : 'id',
				title : '编号',
				width : 150,
				checkbox : true
			}] ],
			columns : [ [ {
				field : 'msgBody',
				title : '内容',
				width : 500,
				sortable : true			
			},	{
				field : 'createdatetime',
				title : '时间',
				width : 120,
				sortable : true
			}, {
				field : 'sendName',
				title : '发送人',
				width : 120,
				sortable : false
			}, 
			{
				field : 'action',
				title : '操作',
				width : 100,
				formatter : function(value, row, index) {
					var str = '';
					str += '&nbsp;';
					 {
						str += $.formatString('<a href="javascript:void(0);" title="删除" onclick="deleteAction({0});" >删除</a>', row.id);
					}
				return str;
				}
			} ] ],
			//toolbar : '#toolbar',
			onLoadSuccess : function() {
				$('#searchForm table').show();
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

	
	
function deleteAction(id)
	 {
		if (id == undefined)
		 {
			var rows = dataGrid.datagrid('getSelections');
			id = rows[0].id;
		} else {
			dataGrid.datagrid('unselectAll').datagrid('uncheckAll');
		}
		parent.$.messager.confirm('询问', '您是否要删除当前数据？', function(b) {
			if (b) 
			{
				parent.$.messager.progress({
						title : '提示',
						text : '数据处理中，请稍后....'
					});
					$.post('${pageContext.request.contextPath}/MsgController/delete', {
						id : id
					}, function(result)
					 {
						if (result.success) 
						{
							parent.$.messager.alert('提示', result.msg, 'info');
							dataGrid.datagrid('reload');
						}
						else
						   parent.$.messager.alert('提示', result.msg, 'info');
						parent.$.messager.progress('close');
					  }, 'JSON');				
			 }
		    });
	}
	
</script>
</head>
<body>
	<div id="toollayout" class="easyui-layout" data-options="title:'查询条件',fit : true,border : false,collapsible:true">
			<div data-options="region:'center',border:false">
			<table id="dataGrid"></table>
		</div>
	</div>
	<div id="toolbar" style="display: none;">
		<c:if test="${1==1}">
			<a onclick="addAction();" href="javascript:void(0);" class="easyui-linkbutton" data-options="plain:true,iconCls:'pencil_add'"> 年度信息录入</a>
		</c:if>		 
	平台名称:<input name="strParam1" style="width: 120px" placeholder="可以模糊查询平台名称" />
	商务主管单位:<input name="strParam2" style="width: 100px" placeholder="可以模糊查询商务主管单位" />
	会计年度:<input name="strParam3" style="width: 120px"   class="easyui-numberbox"/>
		   状态:<select name="intParam1"  id="intParam1" class="easyui-combobox"  data-options="panelHeight:'auto'" style="width: 90px">
              <option value="-1">所有状态</option>
              <option value="0">编辑</option>
              <option value="1">已上报</option>
            </select>
            	区域:<select id="intParam2" name="intParam2"  class="easyui-combobox" data-options="panelHeight:'auto'" style="width: 100px">
              <option value="-1">所有</option>
              <option value="0">本级行政区域</option>
              <option value="1">下级行政区域</option>
            </select>
		<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'brick_add',plain:true" onclick="searchFun();">查询</a><a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'brick_delete',plain:true" onclick="cleanFun();">清空</a>
	</div>

	<div id="menu" class="easyui-menu" style="width: 120px; display: none;">
		<c:if test="${fn:contains(sessionInfo.resourceList, '/userController/addPage')}">
			<div onclick="addFun();" data-options="iconCls:'pencil_add'">增加</div>
		</c:if>
		<c:if test="${fn:contains(sessionInfo.resourceList, '/userController/delete')}">
			<div onclick="deleteFun();" data-options="iconCls:'pencil_delete'">删除</div>
		</c:if>
		<c:if test="${fn:contains(sessionInfo.resourceList, '/userController/editPage')}">
			<div onclick="editFun();" data-options="iconCls:'pencil'">编辑</div>
		</c:if>
	</div>
</body>
</html>