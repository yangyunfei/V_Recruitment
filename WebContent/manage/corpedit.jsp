<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script type="text/javascript">
	$(function() {
		parent.$.messager.progress('close');
		$('#form').form({
			url : '${pageContext.request.contextPath}/corpController/edit',
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
          <th>商务主管单位</th>
          <td><input name="corpCode2" type="text" readonly="readonly" placeholder="" class="easyui-validatebox span2" data-options="required:true,readonly:true" value="${corp.fullName}"></td>
          <th>&nbsp;</th>
          <td>&nbsp;</td>
        </tr>
        <tr> 
          <th>组织机构代码</th>
          <td> <input name="corpCode" type="text" readonly="readonly" placeholder="请输入组织机构代码" class="easyui-validatebox span2" data-options="required:true,editable:false,validType:'length[0,20]'" value="${corp.corpCode}"></td>
          <th>单位名称</th>
          <td><input name="corpName" type="text" placeholder="请输入单位名称" class="easyui-validatebox span2" data-options="required:true,validType:'length[0,200]'" value="${corp.corpName}"></td>
        </tr>
        <tr> 
          <th>企业法人</th>
          <td><input name="lawPerson" type="text" placeholder="请输入企业法人" class="easyui-validatebox span2" data-options="required:true,validType:'length[0,20]'" value="${corp.lawPerson}"></td>
          <th>企业地址</th>
          <td><input name="addr" type="text"   placeholder="请输入企业地址" class="easyui-validatebox span2" data-options="required:true,validType:'length[0,200]'" value="${corp.addr}"></td>
        </tr>
        <tr> 
          <th>邮编</th>
          <td><input name="postCode" type="text" placeholder="请输入邮编" class="easyui-validatebox span2" data-options="required:true,validType:'length[0,20]'" value="${corp.postCode}"></td>
          <th>电话</th>
          <td><input name="tel" type="text" placeholder="请输入电话" class="easyui-validatebox span2" data-options="required:true,validType:'length[0,20]'" value="${corp.tel}"></td>
        </tr>
        <tr> 
          <th>传真</th>
          <td><input name="fax" type="text" placeholder="请输入传真" class="easyui-validatebox span2" data-options="required:true,validType:'length[0,20]'" value="${corp.fax}"></td>
          <th>邮箱</th>
          <td><input name="mailBox" type="text" placeholder="请输入邮箱" class="easyui-validatebox span2" data-options="required:true,validType:'email'" value="${corp.mailBox}"></td>
        </tr>
        <tr> 
          <th>登记注册类型</th>
          <td><select name="registrationtype"  class="easyui-combobox"  id="registrationtype" data-options="
		valueField: 'label',
		editable:false,
		required:true,
		value:${corp.registrationtype},
		textField: 'value',
		data: [{
			label: 0,
			value: '内资'
		},{
			label: 1,
			value: '外商投资'
		},{
			label: 2,
			value: '港澳台商投资'
		},{
			label: 3,
			value: '中外合资'
		}]">
            </select></td>
          <th>行政代码</th>
          <td><input name="regnCode"  value="${corp.regnCode}" type="text" class="easyui-validatebox span2" id="regnCode" placeholder="请输入行政代码" data-options="required:true,validType:'length[0,20]'"/></td>
        </tr>
        <tr> 
          <th>注册资金（千元）</th>
          <td><input name="registerMoney"  type="text" placeholder="请输入注册资金（千元）" class="easyui-numberbox" data-options="required:true" value="${corp.registerMoney}"></td>
          <th>&nbsp;</th>
          <td>&nbsp;</td>
        </tr>
        <tr width="200px"> 
          <th>企业简介</th>
          <td ><textarea name="remark" style="height:60px;"  maxlength="200"  class="easyui-validatebox" data-options="required:true,validType:'length[0,200]'">${corp.remark}</textarea></td>
          <th>&nbsp;</th>
          <td>&nbsp;</td>
        </tr>
        <tr> 
          <th>&nbsp;</th>
          <td>&nbsp;</td>
          <th>&nbsp;</th>
          <td>&nbsp;</td>
        </tr>
      </table>
       <input type="hidden" name="id" value="${corp.id}" readonly="readonly">
		</form>
	</div>
</div>