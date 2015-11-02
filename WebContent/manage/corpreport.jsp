<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<title>企业报表</title>
<jsp:include page="../inc.jsp"></jsp:include>
<script type="text/javascript">
function reports(id,webSiteID,dataYear)
{
var url="../report/prints.jsp?quarterdataid={0}&websiteid={1}&datayear={2}";
var winurl= $.formatString(url,id,webSiteID,dataYear);
window.open(encodeURI(winurl,"utf-8"));
}
function reportx(id,webSiteID,dataYear)
{
var url="../report/printx.jsp?quarterdataid={0}&websiteid={1}&datayear={2}";
var winurl= $.formatString(url,id,webSiteID,dataYear);
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
	   // $('#toollayout').layout("collapse","north");
		dataGrid = $('#dataGrid').datagrid({
			url : '${pageContext.request.contextPath}/ReportController/quarterReportGrid',
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
			//toolbar : '#toolbar',
			nowrap : false,
			frozenColumns : [ [ {
				field : 'id',
				title : '编号',
				width : 150,
				checkbox : true
			},  {
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
			columns : [ [{
				field : 'dataYear',
				title : '企业年度',
				width : 60,
				sortable : true			
			},	{
				field : 'createdatetime',
				title : '创建时间',
				width : 120,
				sortable : true
			}, {
				field : 'dataQuarter',
				title : '季度',
				width : 60,
				sortable : true,
				hidden : false,
				formatter: function (value,row,index)
				{		
                    switch(value)
                    {
                       case 0:return '第1季度'; 
                       case 1:return '第2季度';  
                       case 2:return '第3季度'; 
                       case 3:return '第4季度'; 
                   }
			    }
			},
			{
				field : 'state',
				title : '状态',
				sortable : true,
				width : 60,
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
				field : 'fullName',
				title : '商务主管单位',
				sortable : true,
				width : 120
			},
			{
				field : 'sumJe',
				title : '总额(千元)',
				sortable : true,
				width : 60
			},
			{
				field : 'action',
				title : '操作',
				width : 100,
				formatter : function(value, row, index) {
				  var str = '';
					{

						str += $.formatString('<a href="javascript:void(0);" title="上页" onclick="reports({0},{1},{2});">上页 <\/a>', row.id,row.webSiteID,row.dataYear);
					}
					str += '&nbsp;';
					    str += $.formatString('<a href="javascript:void(0);" title="下页" onclick="reportx({0},{1},{2});">下页 <\/a>', row.id,row.webSiteID,row.dataYear);
					return str;
				}
			} ] ],
			onLoadSuccess : function() 
			{
				$('#searchForm table').show();
				parent.$.messager.progress('close');
				//$(this).datagrid('tooltip');
			}
			
		});
	});
	


	function searchFun() {
		dataGrid.datagrid('load', $.serializeObject($('#searchForm')));
	}
	function cleanFun() {
		$('#searchForm input').val('');
		$('#intParam1').combobox('setValue', -1);
		dataGrid.datagrid('load', {});
	}	
</script>
</head>
<body>
	<div id="toollayout" class="easyui-layout" data-options="title:'查询条件',fit : true,border : false,collapsible:true">
		<div data-options="region:'north',title:'查询条件',border:false" style="height: 165px; overflow: hidden;">
			<form id="searchForm">
				
      <table width="810" style="display: none;">
        <tr> 
          <th width="116">行政区域</th>
          <td width="408">
          <input name="strParam4" placeholder="请输入行政区码" class="easyui-combobox" data-options="url:'${pageContext.request.contextPath}/userController/RegionList',required:true,valueField:'regionCode',textField:'regionName',formatter: formatItem,multiple:false"/></td>
          <td width="74">&nbsp;</td>
          <td width="192">&nbsp;</td>
        </tr>
        <tr> 
          <th>企业名称</th>
          <td><input name="strParam1" placeholder="可以模糊查询企业名称" /></td>
          <td>平台名称</td>
          <td><input name="strParam2" placeholder="可以模糊查询平台名称" /></td>
        </tr>
        <tr> 
          <th>企业年度</th>
          <td><input name="strParam5" style="width: 120px"   class="easyui-numberbox"/>
            至<input name="strParam6" style="width: 120px"   class="easyui-numberbox"/>
            </td>
          <td>季度</td>
          <td><select id="intParam1" name="intParam1"  class="easyui-combobox" data-options="panelHeight:'auto'" style="width: 65px">
              <option value="-1">所有</option>
              <option value="0">第1季度</option>
              <option value="1">第2季度</option>
               <option value="2">第3季度</option>
              <option value="3">第4季度</option>
            </select></td>            
        </tr>
         <tr> 
          <th></th>
          <td>        	<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'brick_add',plain:true" onclick="searchFun();" title="执行查询">查询</a>
		<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'brick_delete',plain:true" onclick="cleanFun();" title="清空查询">清空查询</a></td>
          <td></td>
          <td></td>
        </tr>
      </table>
			</form>
		</div>
		<div data-options="region:'center',border:false">
			<table id="dataGrid"></table>
		</div>
	</div>
	<div id="toolbar" style="display: none;">
		<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'brick_add',plain:true" onclick="searchFun();">查询</a>
		<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'brick_delete',plain:true" onclick="cleanFun();">清空</a>
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