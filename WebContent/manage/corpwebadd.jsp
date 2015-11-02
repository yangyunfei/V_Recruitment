<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script type="text/javascript">
	$(function() {
	   
		parent.$.messager.progress('close');
		$('#form').form({
			url : '${pageContext.request.contextPath}/webSiteController/add',
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
			
      <table >
        <tr> 
          <th>选择企业</th>
          <td> <select name="corpID" class="easyui-combogrid" style="width:250px"   data-options="
panelWidth: 500,
required:true,
editable:false,
idField: 'id',
textField: 'corpName',
url: 'corpController/corpdatarrid',
method: 'post',
columns: [[
{field:'corpCode',title:'组织机构代码',width:80},
{field:'corpName',title:'企业名称 ',width:120},
{field:'lawPerson',title:'法人',width:80},
{field:'addr',title:'地址',width:200}
]],
fitColumns: true
"/>
          </td>
          <th>&nbsp;</th>
          <td>&nbsp;</td>
        </tr>
        <tr> 
          <th>平台名称</th>
          <td><input name="webName" type="text" placeholder="请输入平台名称" class="easyui-validatebox span2" data-options="required:true,validType:'length[0,200]'" value=""> 
          </td>
          <th>网 址</th>
          <td><input name="webAddr" type="text" placeholder="请输入网 址" class="easyui-validatebox span2" data-options="required:true,validType:'length[0,500]'" value=""> 
          </td>
        </tr>
        <tr>
          <th>行业类别</th>
          <td><select class="easyui-combobox" name="category"  data-options="url:'commonController/LoadDataItem?itemType=3',required:true,valueField:'code',textField:'caption',editable:false, panelHeight:'auto'"/>
          </td>
          <th>网址建设运维情况</th>
          <td><select class="easyui-combobox" name="situation"  data-options="url:'commonController/LoadDataItem?itemType=1',required:true,valueField:'code',textField:'caption',editable:false, panelHeight:'auto'"/>
          </td>
        </tr>
        <tr> 
          <th>认证类型</th>
          <td><select class="easyui-combobox" name="cert" data-options="url:'commonController/LoadDataItem?itemType=2',required:true,valueField:'code',textField:'caption',editable:false, panelHeight:'auto'"/>
          </td>
          <th>网站接入方式</th>
          <td><select class="easyui-combobox" name="linkType" data-options="url:'commonController/LoadDataItem?itemType=8',required:true,valueField:'code',textField:'caption',editable:false, panelHeight:'auto'"/>
          </td>
        </tr>
        <tr> 
          <th>平台负责人</th>
          <td><input name="webMan" type="text" placeholder="请输入平台负责人" class="easyui-validatebox span2" data-options="required:true,validType:'length[0,20]'" value=""></td>
          <th>ICP备案号</th>
          <td><input name="icp" type="text" placeholder="请输入ICP备案号" class="easyui-validatebox span2" data-options="required:true,validType:'length[0,200]'" value=""></td>
        </tr>
      </table>
		</form>
	</div>
</div>