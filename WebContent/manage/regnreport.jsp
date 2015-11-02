<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<title>全省报表</title>
<jsp:include page="../inc.jsp"></jsp:include>
<script type="text/javascript">
function report(regionCode,dataYear,fullName)
{

 //regioncode=13&datayear=2013&organame=石家庄市商务局test"
var url="../report/printnb.jsp?regioncode={0}&datayear={1}&organame={2}";
var winurl= $.formatString(url,regionCode,dataYear,fullName);
window.open(encodeURI(winurl,"utf-8"));
}
 function formatItem(row)
 {
 if(row.regionType==1)
   return '&nbsp;&nbsp;&nbsp;'+row.regionName;
 else if (row.regionType==2)
    return '&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;'+row.regionName;
   else
    return row.regionName;
}
var dataGrid;
$(function() {
		dataGrid = $('#dataGrid').datagrid({
			url : '${pageContext.request.contextPath}/ReportController/yearReportdataGrid',
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
			}, {
				field : 'corpName',
				title : '企业名称',
				width : 80,
				sortable : true
			} ,
			{
				field : 'webName',
				title : '平台名称',
				width : 80,
				sortable : true
			}] ],
			columns : [ [ {
				field : 'dataYear',
				title : '企业年度',
				width : 60,
				sortable : true			
			},	{
				field : 'createdatetime',
				title : '创建时间',
				width : 120,
				sortable : true
			}, 
			 {
				field : 'fullName',
				title : '商务主管单位',
				sortable : true,
				width : 120
			},
			{
				field : 'action',
				title : '操作',
				width : 50,
				formatter : function(value, row, index) {
					var str = '';
					{

						str += $.formatString('<a href="javascript:void(0);" title="报表" onclick="report(\'{0}\',{1},\'{2}\');">报表 <\/a>', row.regionCode,row.dataYear,row.fullName);
			
					}
					return str;
				}
			} ] ],
			toolbar : '#toolbar',
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
		

	function searchFun() {
		dataGrid.datagrid('load', $.serializeObject($('#searchForm')));
	}
	function cleanFun() {
		$('#searchForm input').val('');
		dataGrid.datagrid('load', {});
	}
</script>
</head>
<body>
	<div id="toollayout" class="easyui-layout" data-options="title:'查询条件',fit : true,border : false,collapsible:true">
		<div data-options="region:'north',title:'查询条件',border:false" style="height: 120px; overflow: hidden;">
			<form id="searchForm">
				<table  style="display: none;">					
					<tr>
						<th>选择年度</th>
						<td><input name="strParam1" style="width: 120px"   class="easyui-numberbox"/></td>
					</tr>
					<tr>
						<th>行政区域</th>
						<td><input name="strParam2" placeholder="请输入行政区码" class="easyui-combobox" data-options="url:'${pageContext.request.contextPath}/userController/RegionList',required:true,valueField:'regionCode',textField:'regionName',formatter: formatItem,multiple:false"/></td>
					</tr>
					<tr>
						<th></th>
						<td>
		<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'brick_add',plain:true" onclick="searchFun();" title="执行查询">查询</a>
		<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'brick_delete',plain:true" onclick="cleanFun();" title="清空查询">清空查询</a></td>
					</tr>
				</table>
			</form>
		</div>
		<div data-options="region:'center',border:false">
			<table id="dataGrid"></table>
		</div>
	</div>
	<div id="toolbar" style="display: none;">
		<c:if test="${fn:contains(sessionInfo.resourceList, '/userController/addPage')}">
			<a onclick="addFun();" href="javascript:void(0);" class="easyui-linkbutton" data-options="plain:true,iconCls:'pencil_add'"> 年度信息录入</a>
		</c:if>		
		
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