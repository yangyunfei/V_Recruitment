<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script type="text/javascript">
	$(function() {
		parent.$.messager.progress('close');
		$('#form').form({
			url : '${pageContext.request.contextPath}/jf/userController/add',
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

<script type="text/javascript">
 //自定义验证
  $.extend($.fn.validatebox.defaults.rules, {
  phoneRex: {
    validator: function(value){
    var rex=/^1[3-8]+\d{9}$/;
    //var rex=/^(([0\+]\d{2,3}-)?(0\d{2,3})-)(\d{7,8})(-(\d{3,}))?$/;
    //区号：前面一个0，后面跟2-3位数字 ： 0\d{2,3}
    //电话号码：7-8位数字： \d{7,8
    //分机号：一般都是3位数字： \d{3,}
     //这样连接起来就是验证电话的正则表达式了：/^((0\d{2,3})-)(\d{7,8})(-(\d{3,}))?$/		 
    var rex2=/^((0\d{2,3})-)(\d{7,8})(-(\d{3,}))?$/;
    if(rex.test(value)||rex2.test(value))
    {
      // alert('t'+value);
      return true;
    }else
    {
     //alert('false '+value);
       return false;
    }
      
    },
    message: '请输入正确电话或手机格式'
  }
});

</script>

<div class="easyui-layout" data-options="fit:true,border:false">
	<div data-options="region:'center',border:false" title="" style="overflow: hidden;">
		<form id="form" method="post">
			<table class="table table-hover table-condensed">
				<tr>
					<%-- <th>编号</th>
					<td><input name="id" type="text" class="span2" value="${user.id}" readonly="readonly"></td> --%>
					<th>登录名称</th>
					<td><input name="user.login_name" type="text" placeholder="请输入登录名称" class="easyui-validatebox span2" data-options="required:true" value=""></td>
					<th>密码</th>
					<td><input name="user.password" type="password" validType="length[6,20]" placeholder="请输入密码" class="easyui-validatebox span2" data-options="required:true"></td>
				</tr>
				<tr>
					<th>真实姓名</th>
					<td><input name="user.name" type="text" placeholder="请输入用户真实姓名" class="easyui-validatebox span2" data-options="required:true"></td> 
					<th>联系电话</th>
					<td><input name="user.phone" type="text" placeholder="请输入用户联系电话" class="easyui-validatebox span2" data-options="required:true,validType:'phoneRex'"></td> 
				</tr>
					<tr>
			    <th>&nbsp;&nbsp;用户角色&nbsp;&nbsp;</th> 
	    <td>
	    <select class="easyui-combogrid" name="user.roles" style="width:150px" data-options="
            panelWidth: 150,
            panelHeight: 100,   
            required:true,
            multiple: true,
            idField: 'id',
            editable:false ,
            textField: 'role_name',
            url: '${pageContext.request.contextPath}/jf/userController/roleList',
            method: 'get',
            columns: [[
                {field:'id',checkbox:true},
                {field:'role_name',title:'用户角色',width:150},
               
            ]],
            fitColumns: true
        "></select>
    </td>
        </tr>
			</table>	      
		</form>
	</div>
</div>
