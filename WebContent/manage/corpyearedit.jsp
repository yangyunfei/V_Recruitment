<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script type="text/javascript">
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
   
 $('#dataYear').combobox({
  data:yearlist,
  valueField:'code',
  textField:'caption',
  value:${data.dataYear},
  required:true,
  editable:false,
  panelHeight:'auto'
  });
}

	$(function() {
		parent.$.messager.progress('close');
		addYear();
		$('#form').form({
			url : '${pageContext.request.contextPath}/yearDataController/edit',
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
					parent.$.modalDialog.openner_dataGrid.datagrid('reload');//之所以能在这里调用到parent.$.modalDialog.openner_dataGrid这个对象，是因为user.jsp页面预定义好了
					parent.$.modalDialog.handler.dialog('close');
				} else {
					parent.$.messager.alert('错误', result.msg, 'error');
				}
			}
		});
	});
</script>
<div class="easyui-layout" data-options="fit:true,border:false">
	<div data-options="region:'center',border:false" title="" style="overflow: hidden;">
		<form id="form" method="post">
			
      <table class="table">
        <tr> 
          <th>平台</th>
          <td> 
          <input name="webName" type="text"  style="width:250px"  disabled   class="easyui-validatebox span2" data-options="required:true,editable:false,disabled:true" value="${data.webName}">
<!--            <select name="webID" class="easyui-combogrid" style="width:250px"   data-options=" -->
<!-- panelWidth: 500, -->
<!-- required:true, -->
<!-- editable:false, -->
<!-- disabled:true, -->
<!-- idField: 'id', -->
<!-- value:${webID}, -->
<!-- textField: 'webName', -->
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
          <th>会计年度</th>
          <td><select class="easyui-combobox" name="dataYear" id="dataYear">
            
          </select>
          </td>
        </tr>
        <tr> 
          <th>全年营业收入(千元)</th>
          <td><input name="income" type="text" placeholder="请输入平台名称" class="easyui-numberbox" data-options="required:true" value="${data.income}"></td>
          <th>主营业务收入(千元)</th>
          <td><input name="mainIncome" type="text" placeholder="请输入平台名称" class="easyui-numberbox" data-options="required:true" value="${data.mainIncome}"></td>
        </tr>
        <tr> 
          <th>年末资金总计(千元)</th>
          <td><input name="surplus" type="text" placeholder="请输入平台名称" class="easyui-numberbox" data-options="required:true" value="${data.surplus}"></td>
          <th>全年营业利润(千元)</th>
          <td><input name="profit" type="text" placeholder="请输入平台名称" class="easyui-numberbox" data-options="required:true" value="${data.profit}"></td>
        </tr>
        <tr> 
          <th>全年企业成本(千元)</th>
          <td><input name="cost" type="text" placeholder="请输入平台名称" class="easyui-numberbox" data-options="required:true" value="${data.cost}"></td>
          <th>全年纳税金额(千元)</th>
          <td><input name="tax" type="text" placeholder="请输入平台名称" class="easyui-numberbox" data-options="required:true" value="${data.tax}"></td>
        </tr>
      </table>
       <input type="hidden" name="id" value="${data.id}" readonly="readonly">
        <input type="hidden" name="webID" value="${webID}" readonly="readonly">
		</form>
	</div>
</div>