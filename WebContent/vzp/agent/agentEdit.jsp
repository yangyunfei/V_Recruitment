<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script type="text/javascript">
	$(function() {
		parent.$.messager.progress('close');
		$('#form').form({
			url : '${pageContext.request.contextPath}/jf/agentController/edit',
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
		
		//初始化行政区列表
		 $('#type').combobox({
		        url: '${pageContext.request.contextPath}/jf/agentController/getAgentTypes',
		        editable: false,
		        valueField: 'code',
		        textField: 'name'	
		    });
		 $('#type').combobox('setValue','${user.type }');
		 $('#businessAreas').combotree({
			    url: '${pageContext.request.contextPath}/jf/agentController/getBusinessAreaTree',
			    multiple: true,
			    onlyLeafCheck:true
			});
		 var areas = '${user.businessAreas }';
		 $('#businessAreas').combotree('setValues', areas.split(","));
	});
</script>

<div class="easyui-layout" data-options="fit:true,border:false">
	<div data-options="region:'center',border:false" title=""
		style="overflow: hidden;">
		<form id="form" method="post">
			<input name="id" type="hidden" value="${user.id}" readonly="readonly">
			<table class="table table-hover table-condensed">
				<tr>
					<%-- <th>编号</th>
					<td><input name="id" type="text" class="span2" value="${user.id}" readonly="readonly"></td> --%>
					<th>系统号</th>
					<td>${user.pager }</td>
				</tr>
				<tr>
					<th>手机号码&nbsp;&nbsp;</th>
					<td>
					<input type="text" name="phone" value="${user.phone }">
					</td>
				</tr>
				<tr>
					<th>用户类型&nbsp;&nbsp;</th>
					<td>
					<select id="type"  name="type">
						
					</select>
					</td>
				</tr>
				<tr>
					<th>用户商圈&nbsp;&nbsp;</th>
					<td>
					<select id="businessAreas"  name="businessAreas">
						
					</select>
					</td>
				</tr>
			</table>
		</form>
	</div>
</div>
