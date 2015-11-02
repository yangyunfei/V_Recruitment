<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<title>综合查询</title>
<jsp:include page="../inc.jsp"></jsp:include>
<script type="text/javascript">
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
			url : '${pageContext.request.contextPath}/ReportController/complexReportdataGrid',
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
			showFooter: true,
			frozenColumns : [ [ {
				field : 'id',
				title : '编号',
				width : 80,
				checkbox : true
			}, {
				field : 'corpName',
				title : '企业名称',
				width : 120,
				sortable : true
			} ,
			{
				field : 'webName',
				title : '平台名称',
				width : 120,
				sortable : true
			}] ],
			columns : [ [ {
				field : 'websiteType',
				title : '平台类型',
				width : 150,
				sortable : true,
				formatter: function (value,row,index)
				{		
                    switch(value)
                    {
                       case 0:return '通过自营电子商务平台进行'; 
                       case 1:return '通过第三方电子商务平台进行'; 
                       case 2:return '提供电子商务交易平台服务';             
                   }
			    }		
			},	{
				field : 'je',
				title : '交易额(千元)',
				width : 80,
				sortable : true
			}, 
			 {
				field : 'fullName',
				title : '商务主管单位',
				width : 120
			},
			{
				field : 'action',
				title : '操作',
				width : 100,
				hiden:true,
				formatter : function(value, row, index) {
					var str = '';
					if ($.superuser||row.state==0) {

						str += $.formatString('<a href="javascript:void(0);" title="报表" onclick="editAction({0});">报表 <\/a>', row.id);
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
	function exportExcel() {
	    var str='${pageContext.request.contextPath}/ReportController/complexReportdataGridExcel?'+$.serializeObject($('#searchForm'));
	   // alert(str);
	    window.open(encodeURI(str,"utf-8"));
	}
	function cleanFun() {
		$('#searchForm input').val('');
		dataGrid.datagrid('load', {});
	}
</script>
</head>
<body>
	<div id="toollayout" class="easyui-layout" data-options="title:'查询条件',fit : true,border : false,collapsible:true">
		<div data-options="region:'north',title:'查询条件',border:false" style="height: 160px; overflow: hidden;">
			<form id="searchForm">
				
      <table  style="display: none;">
        <tr> 
          <th width="85">起止年季度</th>
          <td width="200"><input name="strParam1" style="width: 60px"   class="easyui-numberbox"/>
            至 <input name="strParam2" style="width: 60px"   class="easyui-numberbox"/></td>
          <td width="101">交易模式</td>
          <td width="170"><input class="easyui-combobox" name="strParam3" data-options="required:false,multiple:true,valueField:'value',textField:'label',editable:false, panelHeight:'auto',data: [{
			label: 'B2C',
			value: 0
		},{
			label: 'B2B',
			value: 1
		},{
			label: 'C2C',
			value: 2
		}]"/></td>
        </tr>
        <tr> 
          <th>行政区域</th>
          <td><input name="strParam4" placeholder="请输入行政区码" class="easyui-combobox" data-options="url:'${pageContext.request.contextPath}/userController/RegionList',required:true,valueField:'regionCode',textField:'regionName',formatter: formatItem,multiple:false"/></td>
          <td>平台类型</td>
          <td><input name="strParam5" placeholder="请输入平台类型" class="easyui-combobox" data-options="required:false,multiple:true,valueField:'value',textField:'label',editable:false, panelHeight:'auto',data: [{
			label: '通过自营电子商务平台进行',
			value: '0'
		},{
			label: '通过第三方电子商务平台进行',
			value: '1'
		},{
			label: '提供电子商务交易平台服务',
			value: '2'
		}]"/></td>
        </tr>
        <tr> 
          <th>交易额</th>
          <td>
            <input name="strParam6" style="width: 60px"   class="easyui-numberbox"/>
            至 
            <input name="strParam7" style="width: 60px"   class="easyui-numberbox"/></td>
          <td>平台名称</td>
          <td><input name="strParam8" placeholder="请输入平台名称" /></td>
        </tr>
        <tr> 
          <th></th>
          <td>
            <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'brick_add',plain:true" onClick="searchFun();" title="执行查询">查询</a>
            <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'brick_delete',plain:true" onClick="cleanFun();" title="清空查询">清空查询</a>
             <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'database_link',plain:true" onClick="exportExcel();" title="导出Excel文件">导出</a>
           </td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
        </tr>
      </table>
			</form>
		</div>
		<div data-options="region:'center',border:false">
			<table id="dataGrid"></table>
		</div>
	</div>
	<div id="toolbar" style="display: none;">

		
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