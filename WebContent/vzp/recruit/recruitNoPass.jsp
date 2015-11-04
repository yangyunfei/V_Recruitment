<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script type="text/javascript">
	
	function clearForm(){
		var title = '添加面试时间';
		window.parent.closeTab(title);
	}
	
	
	function submitForm(){	
		$('#cusInfo').submit();
	}
	
	$(function(){
		parent.$.messager.progress('close');
		$('#form').form({
			url : '${pageContext.request.contextPath}/jf/recruitController/nopass',
			onSubmit : function() {
				//parent.$.messager.progress({
				//	title : '提示',
			//		text : '数据处理中，请稍后....'
			//	});
				var isValid = $(this).form('validate');
				//if (!isValid) {
				//	parent.$.messager.progress('close');
				//}
				return isValid;
			},
			success : function(result) {
				//parent.$.messager.progress('close');
				result = $.parseJSON(result);
				if (result.success) {
					parent.$.modalDialog.openner_dataGrid.datagrid('reload');//之所以能在这里调用到parent.$.modalDialog.openner_treeGrid这个对象，是因为role.jsp页面预定义好了
					parent.$.modalDialog.handler.dialog('close');
				}else{
					alert(result.msg);
				}
			}
		});
		
	});
</script>
	<div style="padding:10px 60px 20px 60px">
     <form id="form" method="post">
     	 <input type="hidden" name="rt_id" value="${recruit.id }"></input>   
     				 请选择不参加初试的原因
     	
		<br>
		<select class="easyui-combobox" id="water"
							name="cancle"
							data-options="
						 url: '${pageContext.request.contextPath}/jf/commonController/getTableCode/presentee-cancle2',
                method: 'get',
                 panelHeight:'auto',
                valueField: 'code',
                textField: 'name'"
							style="width: 200px;">
		</select>
			
    
     </form>
     <!-- 
     <div style="text-align:center;padding:5px">
         <a id="btn_submit" href="javascript:void(0)" class="easyui-linkbutton" onclick="submitForm()">提交</a>
         <a href="javascript:void(0)" class="easyui-linkbutton" onclick="clearForm()">取消</a>
     </div>
     -->
     </div>