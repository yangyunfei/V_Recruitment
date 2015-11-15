<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/IdCardCheck.js?v=20151116" charset="utf-8"></script>
<script type="text/javascript">	
	function submitForm(){
		if(checkidCard())
		{
			$('#cusInfo').submit();
		}	
	}
	
	$(function(){				
		$('#form').form({
			url : '${pageContext.request.contextPath}/jf/recruitController/addProperty',
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
     <!--  <input type="hidden" name="ct.id" value="${cus.id}"></input>-->
     <input name="rt_id" type="hidden" value="${rt_id}" readonly="readonly">    
         <table cellpadding="5" >
             <tr>
                 <td style="width:15%;">推荐者姓名:</td>
                 <td style="width:35%;">
					${presentee.name } 
                </td>
                <td>客户联系方式:</td>
                 <td>
                 	${presentee.phone }
                 </td>
             </tr>      
             <tr>
                 <td>身份证号码:</td>
            	 <input class="easyui-textbox" type="text" id="idcard"  name="idcard" data-options="required:true" missingMessage="不能为空" value="${presentee.idcard }"></input>
             </tr>   
             <tr>
                 <td style="width:15%;">学校名称:</td>
                 <td style="width:35%;">
					<input class="easyui-textbox" type="text" name="school_name" data-options="required:true" missingMessage="不能为空" value="${presentee.name }"></input> 
                </td>
                <td>学校级别:</td>
                 <td>
                 	<input class="easyui-textbox" type="text" name="school_level" data-options="required:true" missingMessage="不能为空" value="${presentee.phone }"></input>
                 </td>
             </tr>   
             <tr>
                 <td>地址:</td>
            	 <input class="easyui-textbox" type="text" name="address" data-options="required:true" missingMessage="不能为空" value="${presentee.phone }"></input>
             </tr>                 
             <tr>
                 <td>描述:</td>
                 <td colspan="3"><input class="easyui-textbox" name="remarks" data-options="multiline:true" missingMessage="不能为空" style="height:60px;width:500px;" value="${presentee.remarks }"></input></td>
             </tr>
         </table>
     </form>
     <div style="text-align:center;padding:5px">
         <a id="btn_submit" href="javascript:void(0)" class="easyui-linkbutton" onclick="submitForm()">提交</a>       
     </div>
     </div>