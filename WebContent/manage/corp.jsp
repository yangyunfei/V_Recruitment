<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<title>平台管理</title>
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
			url : '${pageContext.request.contextPath}/corpController/dataGrid',
			fit : true,
			fitColumns : false,
			border : false,
			pagination : true,
			idField : 'id',
			pageSize : 10,
			singleSelect:true,
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
			}, {
				field : 'corpCode',
				title : '组织机构代码',
				width : 80,
				sortable : true
			} ,
			{
				field : 'corpName',
				title : '企业名称',
				width : 80,
				sortable : true
			}] ],
			columns : [ [ 
			{
				field : 'createdatetime',
				title : '创建时间',
				width : 120,
				sortable : true
			}, {
				field : 'modifydatetime',
				title : '最后修改时间',
				width : 120,
				sortable : true
			},
			{
				field : 'lawPerson',
				title : '法人',
				width : 60,
				sortable : true		
			}, {
				field : 'addr',
				title : '地址',
				width : 150,
				sortable : true
			}, {
				field : 'postCode',
				title : '邮编',
				width : 150,
				sortable : true,
				hidden:true
			}, {
				field : 'tel',
				title : '电话',
				width : 150,
				hidden : true
			}, {
				field : 'fax',
				title : '传真',
				width : 150,
				hidden:true
			}, 
			{
				field : 'mailBox',
				title : '邮箱',
				width : 150,
				sortable : true,
				hidden:true
			},
			{
				field : 'state',
				title : '状态',
				width : 60,
				sortable : true,
				formatter: function (value,row,index)
				{		
                    switch(value)
                    {
                       case 0:return '编辑'; 
                       case 1:return '已上报';          
                   }
			    }
			},
			{
				field : 'registrationtype',
				title : '注册类型 ',
				width : 80,
				sortable : true,
				formatter: function (value,row,index)
				{		
                    switch(value)
                    {
                       case 0:return '内资'; 
                       case 1:return '外商投资'; 
                       case 2:return '港澳台商投资'; 
                       case 3:return '中外合资'; 
                   }
			    }
			 },
			
			{
				field : 'registerMoney',
				title : '注册资金(千元) ',
				width : 85,
				sortable : true
			},
		
			{
				field : 'fullName',
				title : '商务主管单位 ',
				width : 150,
				sortable : true
			},
			{
				field : 'action',
				title : '操作',
				width : 132,
				formatter : function(value, row, index) {
					var str = '';
					if ($.superuser||row.state==0) {

						str += $.formatString('<a href="javascript:void(0);" title="编辑" onclick="editAction({0});">编辑 <\/a>', row.id);
					}
					str += '&nbsp;';
					if ($.superuser||row.state==0) {
						str += $.formatString('<a href="javascript:void(0);" title="删除" onclick="deleteAction({0});" >删除</a>', row.id);
					}
					
					str += '&nbsp;';
					if (row.state==0) {
						str += $.formatString('<a href="javascript:void(0);" title="上报" onclick="reportAction({0});" >上报</a>', row.id);
					}
					
					str += '&nbsp;';
					{
						str += $.formatString('<a  href="javascript:void(0);" title="查看" onclick="viewAction(\'{0}\');">查看</a>', row.id);
					}
					return str;
				}
			} ] ],
			toolbar : '#toolbar',
			onLoadSuccess : function() {
				
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
		parent.$.messager.confirm('询问', '您是否要删除当前企业？', function(b) {
			if (b) 
			{
				parent.$.messager.progress({
						title : '提示',
						text : '数据处理中，请稍后....'
					});
					$.post('${pageContext.request.contextPath}/corpController/delete', {
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

	function reportAction(id)
	 {
		if (id == undefined)
		 {
			var rows = dataGrid.datagrid('getSelections');
			id = rows[0].id;
		} else {
			dataGrid.datagrid('unselectAll').datagrid('uncheckAll');
		}
		parent.$.messager.confirm('询问', '您是否要上报当前企业数据?', function(b) {
			if (b) 
			{
				parent.$.messager.progress({
						title : '提示',
						text : '数据处理中，请稍后....'
					});
					$.post('${pageContext.request.contextPath}/corpController/report', {
						id : id
					}, function(result)
					 {
						if (result.success) 
						{
							parent.$.messager.alert('提示', result.msg, 'info');
							dataGrid.datagrid('reload');
						}
						parent.$.messager.progress('close');
					  }, 'JSON');				
			 }
		    });
	}


	function editAction(id) {
		if (id == undefined) {
			var rows = dataGrid.datagrid('getSelections');
			id = rows[0].id;
		} else {
			dataGrid.datagrid('unselectAll').datagrid('uncheckAll');
		}
		parent.$.modalDialog({
			title : '编辑企业',
			width : 800,
			height : 500,
			href : '${pageContext.request.contextPath}/corpController/editPage?id=' + id,
			buttons : [ {
				text : '保存',
				handler : function() {
					parent.$.modalDialog.openner_dataGrid = dataGrid;//因为添加成功之后，需要刷新这个dataGrid，所以先预定义好
					var f = parent.$.modalDialog.handler.find('#form');
					f.submit();
				}
			} ]
		});
	}
	
	function viewAction(id) {
		if (id == undefined) {
			var rows = dataGrid.datagrid('getSelections');
			id = rows[0].id;
		} else {
			dataGrid.datagrid('unselectAll').datagrid('uncheckAll');
		}
		parent.$.modalDialog({
			title : '浏览企业',
			width : 800,
			height : 500,
			href : '${pageContext.request.contextPath}/corpController/editPage?id=' + id,
			buttons : []
		});
	}

	function addAction() {
		parent.$.modalDialog({
			title : '增加企业',
			width : 800,
			height : 400,
			href : '${pageContext.request.contextPath}/corpController/addPage',
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

	

	function searchAction() {
		dataGrid.datagrid('load', $.serializeObject($('#toolbar Input')));
	}
	function cleanAction() {
		$('#toolbar input').val('');
		$('#intParam2').combobox('setValue', -1);
		$('#intParam1').combobox('setValue', -1);
		dataGrid.datagrid('load', {});
	}
</script>
</head>
<body>
<div id="toollayout" class="easyui-layout" data-options="fit : true,border : false">
		<div data-options="region:'center',border:false">
			<table id="dataGrid"></table>
		</div>
	</div>
	<div id="toolbar" style="display: none;float: left;">
		<c:if test="${sessionInfo.regionType!=4}">
			<a onclick="addAction();" href="javascript:void(0);" class="easyui-linkbutton"  title="打开增加企业窗口" data-options="plain:true,iconCls:'pencil_add'">增加企业</a>
		</c:if>	
		 组织机构代码:<input name="strParam1" style="width: 120px" placeholder="可以模糊查询组织机构代码" />
	企业名称:<input name="strParam2" style="width: 120px" placeholder="可以模糊查询企业名称" />
	商务主管单位:<input name="strParam3" style="width: 100px" placeholder="可以模糊查询商务主管单位" />
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
	   <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'brick_add',plain:true" onclick="searchAction();" title="执行查询">查询</a>
	   <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'brick_delete',plain:true" onclick="cleanAction();" title="清空查询">清空查询</a>
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