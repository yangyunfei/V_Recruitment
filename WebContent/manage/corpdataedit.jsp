<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
      response.setHeader("Pragma","No-Cache");
       response.setHeader("Cache-Control","No-Cache");
      response.setDateHeader("Expires", 0);
%>
<script type="text/javascript">
var dataGrid;
var editIndex = undefined;
var list;
function addYear()
{
  var date=new Date();
 var year=date.getFullYear();
 var yearlist=[];
 for(var i=0;i<3;i++)
 {
   var data=new Object();
   data.code=year-i;
   data.caption=(year-i)+"年";
   yearlist.push(data);
 }
 var monthlist=[];
  for(var i=0;i<4;i++)
 {
   var data=new Object();
   data.code=i;
   data.caption="第"+(i+1)+"季度";
   monthlist.push(data);
 }
  var month=date.getMonth()+1;
  var q=0;
  if(month>=1&&month<=3)
    q=0;
  else if(month>=4&&month<=6)
     q=1;
  else if(month>=7&&month<=9)
    q=2;
   else
     q=3;
  
 $('#dataYear').combobox({
  data:yearlist,
  valueField:'code',
  textField:'caption',
  value:${data.dataYear},
  required:true,
  editable:false
  });
$('#dataQuarter').combobox({
  data:monthlist,
  valueField:'code',
  textField:'caption',
  value:${data.dataQuarter},
  required:true,
  editable:false
  });
}

function formatWebsite(val,row)
{
   var caption='';
   switch(parseInt(val))
   {
   case 0:caption='通过自营电子商务平台进行';break;
   case 1:caption='通过第三方电子商务平台进行';break;
   case 2:caption='提供电子商务交易平台服务';break;
   }
   return caption;  
}
function formatShow(val,row)
{
 if(list==null) return;
 if (val == undefined) return;
 var c='';
 $.each(list,function(n,value) {
      if(parseInt(value.code)==parseInt(val))
     {
       c=value.caption;
       return false;
       }
  });
  return c;
}

function endEditing()
{
if (editIndex == undefined) return true;
if ($('#dg').datagrid('validateRow', editIndex))
{
	$('#dg').datagrid('endEdit', editIndex);
	editIndex = undefined;
	return true;
} 
else 
 return false;
}
function onClickRow(index)
{
	if (editIndex != index)
	{
		if (endEditing())
		{
		  $('#dg').datagrid('selectRow', index);
		  editIndex = index;
		}
		 else
		{
		  $('#dg').datagrid('selectRow', editIndex);
		
		}
	}
}
function append()
{
if (endEditing())
	{
		$('#dg').datagrid('appendRow',{id:0});
		editIndex = $('#dg').datagrid('getRows').length-1;
		$('#dg').datagrid('selectRow', editIndex).datagrid('beginEdit', editIndex);
	}
}
function removeit()
{
if (editIndex == undefined) return;
$('#dg').datagrid('cancelEdit', editIndex).datagrid('deleteRow', editIndex);
editIndex = undefined;
accept();
}
function accept()
{
if (endEditing())
  $('#dg').datagrid('acceptChanges');
}
function reject(){
$('#dg').datagrid('rejectChanges');
editIndex = undefined;
}
function getChangeJson()
{
var rows = $('#dg').datagrid('getData');
return  encodeURI(JSON.stringify(rows),"utf-8");
}
function checkgrid()
{
var rows = $('#dg').datagrid('getData');
var rel=true;
if(rows.total<=0)
{
 parent.$.messager.alert('错误', '请输入交易平台详细数据!', 'error');
 return false;
}
var changeRows=$('#dg').datagrid('getChanges');
if(changeRows.length>0)
	{
	parent.$.messager.alert('错误', '数据没有保存，请先保存输入数据!', 'error');
	 return false;
	
	}
var arr=[];
arr[0]=[];
arr[1]=[];
arr[2]=[];

$.each(rows.rows,function(i,n)
		{
		 //alert($.inArray(n.productType,arr[n.websiteType]));

	       if(arr[n.websiteType].indexOf(n.productType)>=0||arr[n.websiteType]==n.productType)
	    	   {
	    	   parent.$.messager.alert('错误', '交易平台详细数据第'+(i+1)+'条数据与前面数据类别项重复,请删除后重新输入!', 'error');
	    	   rel=false;
	    	   return false;
	    	   }
	       else
	    	   {
	    	   
	    	   arr[n.websiteType].push(n.productType); 
	    	   }
	
		}
		);
return rel;
}
$(function() {	 
 		parent.$.messager.progress('close');
		$.messager.progress('close');
		$.getJSON('${pageContext.request.contextPath}/commonController/LoadDataItem?itemType=6',function(data)
				{

				  list=data;
				
				}		
				);
		addYear();
		dataGrid = $('#dg').datagrid({
			fit : true,
			fitColumns : false,
			//url : '${pageContext.request.contextPath}/userController/dataGrid'+'?r='+Math.random(),
			border : false,
			rownumbers:true,
			singleSelect:true,
			title:'电子商务平台数据',
			data:${data.grid},
		      method: 'post',
			pagination : false,
			onClickRow: onClickRow,
			columns : [ [ 
			{
				field : 'websiteType',
				title : '交易平台',
				width : 180,
				formatter:formatWebsite,
				editor:
				{
				type:'combobox',
				options:
				{	
				url:'commonController/LoadDataItem?itemType=5',	
				valueField:'code',textField:'caption',	editable:false,	required:true,			
				onSelect: function(param)
				{
				
		          var productType = $('#dg').datagrid('getEditor', {index:editIndex,field:'productType'});
		          var serviceJe = $('#dg').datagrid('getEditor', {index:editIndex,field:'serviceJe'});
		          var saleJe = $('#dg').datagrid('getEditor', {index:editIndex,field:'saleJe'});
		          var buyJe = $('#dg').datagrid('getEditor', {index:editIndex,field:'buyJe'});
		          $(serviceJe.target).numberbox('clear');
		          $(saleJe.target).numberbox('clear');
                  $(buyJe.target).numberbox('clear');
                  $(productType.target).combobox('clear');
		          var v=parseInt(param.code);
		          if(v==2)
		          {
		             $(serviceJe.target).numberbox('disable');
		             $(saleJe.target).numberbox('disable');
                     $(buyJe.target).numberbox('disable');
                     $(productType.target).combobox('reload','commonController/LoadDataItem?itemType=7');
		          }
		          else
		          {
		             $(serviceJe.target).numberbox('disable');
		             $(saleJe.target).numberbox('disable');
                     $(buyJe.target).numberbox('disable');
                     $(productType.target).combobox('reload','commonController/LoadDataItem?itemType=6');
		          }
	            }
				}}	
	}, 
			{
				field : 'productType',
				title : '类别',
				width : 250,
				formatter:formatShow,
				editor:{
					type:'combobox',
					options:{
					valueField:'code',textField:'caption',editable:false,required:true,
					onSelect: function(param)
					{
					   var productType = $('#dg').datagrid('getEditor', {index:editIndex,field:'productType'});
			          var serviceJe = $('#dg').datagrid('getEditor', {index:editIndex,field:'serviceJe'});
			          var saleJe = $('#dg').datagrid('getEditor', {index:editIndex,field:'saleJe'});
			          var buyJe = $('#dg').datagrid('getEditor', {index:editIndex,field:'buyJe'});
			          var v=parseInt(param.code);
			          $(serviceJe.target).numberbox('clear');
			          $(saleJe.target).numberbox('clear');
	                  $(buyJe.target).numberbox('clear');
			          if(v>=1&&v<=26)
			          {
			            $(serviceJe.target).numberbox('disable');
			            $(serviceJe.target).validatebox({required: false});   
			            $(saleJe.target).numberbox('enable');
			            $(saleJe.target).validatebox({required: true});
			            $(buyJe.target).numberbox('enable');  
	                    $(buyJe.target).validatebox({required: true});              
			          }
			          else
			          {
			             $(serviceJe.target).numberbox('enable');
			             $(serviceJe.target).validatebox({required: true});     
			             $(saleJe.target).numberbox('disable');
			             $(saleJe.target).validatebox({required: false});
	                     $(buyJe.target).numberbox('disable');  
	                     $(buyJe.target).validatebox({required: false});                   
			          }
		            }
					}}				
			}, 
			{
				field : 'buyJe',
				title : '商品采购额(千元)',
				width : 150,
				formatter: function (value,row,index)
				{		
                    if(value>0)
                       return value;
			    },
				editor:{
				type:'numberbox',
				options:{				
				required:false
				}}
			}, {
				field : 'saleJe',
				title : '商品销售额(千元)',
				width : 150,
				formatter: function (value,row,index)
				{		
                    if(value>0)
                       return value;
			    },
				editor:{
				type:'numberbox',
				options:{				
				required:false
				}}	
				
			},{
				field : 'serviceJe',
				title : '服务类交易额(千元)',
				width : 150,
				formatter: function (value,row,index)
				{		
                    if(value>0)
                       return value;
			    },
				editor:{
				type:'numberbox',
				options:{				
				required:false
				}}	
			}]],
			toolbar:'#toolbar',
			
			onLoadSuccess : function()
			 {
				
				parent.$.messager.progress('close');
				$(this).datagrid('tooltip');
			}
		    
				
			});
			
	
		$('#form').form({
			url : '${pageContext.request.contextPath}/quarterDataController/edit',
			onSubmit : function(params) {
				params.grid=getChangeJson();
				parent.$.messager.progress({
					title : '提示',
					text : '数据处理中，请稍后....'
				});
				var isValid = $(this).form('validate');
				isValid= checkgrid();
				if (!isValid) {
					parent.$.messager.progress('close');
				}				
				return isValid;
			},
			success : function(result) {
				parent.$.messager.progress('close');
				result = $.parseJSON(result);
				if (result.success) {
					parent.$.modalDialog.openner_dataGrid.datagrid('reload');//之所以能在这里调用到parent.$.modalDialog.openner_dataGrid这个对象，是因为user.jsp页面预定义好了
					parent.$.modalDialog.handler.dialog('close');
				} else {
					parent.$.messager.alert('错误', result.msg, 'error');
				}
			}
		});
	});
	//class="table table-hover table-condensed"
 </script>
<div class="easyui-layout" data-options="fit:true,border:false">
	<div data-options="region:'center',border:false" title="" style="overflow: Scroll;">
		<form id="form" method="post">
			
      <table >
        <tr> 
          <th>平台</th>
          <td>
           <input name="webName" type="text"  style="width:250px"  disabled   class="easyui-validatebox span2" data-options="required:true,editable:false,disabled:true" value="${data.webName}">
<!-- <select name="webID" class="easyui-combogrid" style="width:250px"   data-options=" -->
<!-- panelWidth: 500, -->
<!-- required:true, -->
<!-- idField: 'id', -->
<!-- textField: 'webName', -->
<!-- value:${webID}, -->
<!-- url: 'webSiteController/websitedataGrid', -->
<!-- method: 'post', -->
<!-- columns: [[ -->
<!-- {field:'corpName',title:'企业名称',width:120}, -->
<!-- {field:'webName',title:'平台名称',width:120}, -->
<!-- {field:'webAddr',title:'网址 ',width:120}, -->
<!-- {field:'createdatetime',title:'创建日期',width:100} -->
<!-- ]], -->
<!-- fitColumns: true -->
<!-- "/> -->
          </td>
          <th>年度</th>
          <td><select class="easyui-combobox" name="dataYear" id="dataYear">
            
          </select>
          </td>
          <th>季度</th>
          <td><select class="easyui-combobox"  name="dataQuarter" id="dataQuarter">
              
            </select></td>
        </tr>
        <tr> 
          <th>B2B金额(千元)</th>
          <td> <input type="text" name="b2b" class="easyui-numberbox" value="${data.b2b}" data-options="required:true"/></td>
          <th>C2C金额(千元)</th>
          <td><input type="text"  name="c2c" class="easyui-numberbox" value="${data.c2c}" data-options="required:true"/></td>
          <th>B2C金额(千元)</th>
          <td><input type="text"  name="b2c" class="easyui-numberbox" value="${data.b2c}" data-options="required:true"/></td>
        </tr>
        <tr> 
          <th>网站浏览次数(日均浏览量)</th>
          <td><input type="text" name="webViews" class="easyui-numberbox" value="${data.webViews}" data-options="required:true"/></td>
          <th>月订单量(件)</th>
          <td><input type="text" name="orderCount" class="easyui-numberbox" value="${data.orderCount}" data-options="required:true"/></td>
          <th></th>
          <td></td>
        </tr>
        <tr> 
          <th>网上用户情况：个人(位)</th>
          <td><input type="text" name="personUser"  class="easyui-numberbox" value="${data.personUser}" data-options="required:true"/></td>
          <th>网上用户情况：企业(个)</th>
          <td><input type="text" name="corpUser" class="easyui-numberbox" value="${data.corpUser}" data-options="required:true"/></td>
          <th>&nbsp;</th>
          <td>&nbsp;</td>
        </tr>
        <tr> 
          <th>物流配送：自营</th>
          <td><input type="text" name="selfDelivery" class="easyui-numberbox" value="${data.selfDelivery}" data-options="required:true" /></td>
          <th>物流配送：外包</th>
          <td><input type="text" name="outDelivery" class="easyui-numberbox" value="${data.outDelivery}" data-options="required:true" /></td>
          <th></th>
          <td></td>
        </tr>
        <tr> 
          <th>从事电子商务人员人数(位)</th>
          <td><input type="text" name="ebusinessStaff" value="${data.ebusinessStaff}" class="easyui-numberbox" data-options="required:true" /></td>
          <th>信息技术人员人数(位)</th>
          <td><input type="text" name="networkStaff"  value="${data.networkStaff}" class="easyui-numberbox" data-options="required:true" /></td>
          <th>物流配送人员人数(位)</th>
          <td><input type="text" name="deliveryStaff" value="${data.deliveryStaff}" class="easyui-numberbox" data-options="required:true" /></td>
        </tr>
        <tr> 
          <th>网上支付额金额(千元)</th>
          <td><input type="text" name="netPay" value="${data.netPay}" class="easyui-numberbox" data-options="required:true" /></td>
          <th></th>
          <td></td>
          <th></th>
          <td></td>
        </tr>
        <tr> 
          <th>海外交易额：进口(千元)</th>
          <td> <input type="text" name="foreignImport"  value="${data.foreignImport}" class="easyui-numberbox" data-options="required:true" /></td>
          <th>海外交易额:出口(千元)</th>
          <td><input type="text" name="foreignExport" value="${data.foreignExport}"   class="easyui-numberbox" data-options="required:true" /></td>
          <th></th>
          <td></td>
        </tr>
        <tr> 
          <th>外省市交易额:外销(千元)</th>
          <td><input type="text" name="inlandSale" value="${data.inlandSale}" class="easyui-numberbox" data-options="required:true" ></td>
          <th>外省市交易额:采购(千元)</th>
          <td><input type="text" name="inlandBuy" value="${data.inlandBuy}" class="easyui-numberbox" data-options="required:true" ></td>
          <th>&nbsp;</th>
          <td>&nbsp;</td>
        </tr>
        <tr> 
          <th height="400" colspan="6"> 
          <table height="400" id="dg" name="items" >
            </table></th>
        </tr>
      </table>
     <input type="hidden" name="id" value="${data.id}" readonly="readonly">
      <input type="hidden" name="webID" value="${webID}" readonly="readonly">
		</form>
	</div>
	<div id="toolbar" style="display: none;">
	<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'brick_add',plain:true" onclick="append();">增加</a>
	<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'brick_delete',plain:true" onclick="removeit();">删除</a>
	<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'database_save',plain:true" onclick="accept();">保存</a>
	</div>
</div>