<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script type="text/javascript">
	
	function clearForm(){
		var title = '添加客户';
		window.parent.closeTab(title);
	}
	
	var hasError1 = false;
	var hasError2 = false;
	
	function maxMin()
	{
		
		 hasError1 = false;
		 hasError2 = false;
		
		var val1 =  $('[type="hidden"][name="rent_min"]').val();
		var val2 =  $('[type="hidden"][name="rent_max"]').val();
		var val3 =  $('[type="hidden"][name="area_min"]').val();
		var val4 =  $('[type="hidden"][name="area_max"]').val();
		
		if(val1==''||val2==''||val3==''||val4==''){
			return;
		}
		
		val1=parseFloat(val1);
		val2=parseFloat(val2);
		val3=parseFloat(val3);
		val4=parseFloat(val4);
		
		if(val2<=val1){
			hasError1 = true;
		}
		
	    if(val4<=val3){
			hasError2 = true;
		}
	}
	
	function submitForm(){
		maxMin();
		if(hasError1||hasError2){
			alert('最大值不能小于最小值');
			return false;
		}
		$('#cusInfo').submit();
	}
	
	$(function(){
		//描述字符限制
		$('textarea').keyup(function(){
			
			var content = $(this).val();
			var len =  $(this).val().length;
			if(len>150){
				$(this).val(content.substr(0,150));
			}
		});
		
		$('#form').form({
			//url : '${pageContext.request.contextPath}/jf/cusController/update',
			url : '${edit_url}',
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
		
		//初始化客户行业列表
		$('#cushy').combotree
        ({
            url: '${pageContext.request.contextPath}/jf/industryController/findIndustry',
            textField: 'name',
            valueField: 'id',
            
            editable: false,
            onlyLeafCheck: true,
            cascaseCheck:true,
            method:'get',
			onLoadSuccess: function (node, data) {
				$('#cushy').val(data.id);
			}
            
        });
		 //初始化行政区列表
		 $('#xzq').combobox({
		        url: '${pageContext.request.contextPath}/jf/areaBusinessController/selectAllBigDistrict',
		        editable: false,
		        valueField: 'code',
		        textField: 'name'	
		        
		    });
		 $('#xzq').combobox('setValue','${ctRent.target_area_name }');
		 $('#cushy').combotree('setValue','${ctRent.industry_name }');
		 $('#label').val('${ctApp.label }');
		 
		 
		
	});
		
</script>
	<div style="padding:10px 60px 20px 60px">
     <form id="form" method="post">
     <!--  <input type="hidden" name="ct.id" value="${cus.id}"></input>-->
     <input name="ct_app.id" type="hidden" value="${ctApp.id}" readonly="readonly">
     <input name="ct_rent.rent_code" type="hidden" value="${ctRent.rent_code}" readonly="readonly">
     <input type="hidden" name="ct_app.user_id" value="${user.id }"></input>
         <table cellpadding="5" >
             <tr>
                 <td style="width:15%;">客户姓名:</td>
                 <td style="width:35%;">
					<input class="easyui-textbox" type="text" name="ct_app.name" data-options="required:true" missingMessage="不能为空" value="${ctApp.name }"></input> 
                </td>
                <td>客户联系方式:</td>
                 <td>
                 	<input class="easyui-textbox" type="text" name="ct_app.phone" data-options="required:true" missingMessage="不能为空" value="${ctApp.phone }"></input>
                 </td>
             </tr>
             <tr>
                <!--  <td>客户来源:</td>
                 <td>
                 	<select  class="easyui-combobox" name="from" style="width:130px;">
					    <option value="east">不限</option>
					    <option value="south">当前推广</option>
					    <option value="west">库存</option>
					    <option value="north">经纪人推荐</option>
					</select>  
                 </td> -->
                 <td>客户状态:</td>
                 <td>             
                 	<select  class="easyui-combobox" name="ct_app.state" style="width:130px;">
                 		<c:if test="${ctApp.state=='1'}">
                 			<option value="1" selected="selected">正常客户</option>
					    	<option value="2">失效客户</option>
                 		</c:if>
                 		<c:if test="${ctApp.state=='2'}">
                 			<option value="1">正常客户</option>
					    	<option value="2" selected="selected">失效客户</option>
                 		</c:if>
					    
					</select>  
                 </td>
                    <td>客户行业：</td>
					  <td> <input  id="cushy" name="ct_rent.industry_code"
					              data-options="
					                            method:'get',
					                            valueField:'id',
		                    					textField:'name'" ></td>
            	 
             </tr>
             <tr>
                 <td>年租金范围:</td>
                 <td>
					<input id="rentMin" style="width:55px;" name="ct_rent.rent_min" class="easyui-numberbox" min="0" min="50000" max="20000000" precision="2" required="true" missingMessage="必须填写5~2000万之间的数字" value="${ctRent.rent_min }"></input>
                 	--
                 	<input id="rentMax" style="width:55px;" name="ct_rent.rent_max" class="easyui-numberbox" min="0" min="50000" max="20000000" precision="2" required="true" missingMessage="必须填写5~2000万之间的数字" value="${ctRent.rent_max }"></input>
                 	（元）
				 </td> 
                 <td>面积范围:</td>
                 <td>
                 	<input id="areaMin" style="width:55px;" name="ct_rent.area_min" class="easyui-numberbox" min="0" max="2000" precision="2" required="true" missingMessage="必须填写0~2000之间的数字" value="${ctRent.area_min }"></input>
                 	--
                 	<input id="areaMax" style="width:55px;" name="ct_rent.area_max" class="easyui-numberbox" min="0" max="2000" precision="2" required="true" missingMessage="必须填写0~2000之间的数字" value="${ctRent.area_max }"></input>
                 	（平方米）
                 </td>
             </tr>
             
             <tr>
             	 <td> 目标行政区：</td> 
				 <td>  
				 <input  name="ct_rent.target_area_code" id="xzq"  data-options="
		                    method:'get',
		                    valueField:'code',
		                    textField:'name',
		                    multiple:false,
		                    
		            ">  
		            </td>
				 <!-- <td>目标行政区:</td>
                 <td>
 					<input class="textbox.combo .textbox-text" id="bigDistrict" name="targetArea.id" style="width:130px;" /> 
                 </td>   -->
            	 <td>客户标签:</td>
                 <td>
                 	<select id="label"  class="easyui-combobox" name="ct_app.label" style="width:130px;">
                 		<c:choose>
                 			<c:when test="${ctApp.label=='0'}">
                 				<option value="0" selected="selected">无</option>
					    		<option value="1">品牌客户</option>
					    		<option value="2">长期客户</option>
					    		<option value="3">急需客户</option>
                 			</c:when>
                 			<c:when test="${ctApp.label=='1'}">
                 				<option value="1" selected="selected">品牌客户</option>
					    		<option value="0">无</option>
					    		<option value="2">长期客户</option>
					    		<option value="3">急需客户</option>
                 			</c:when>
                 			<c:when test="${ctApp.label=='2'}">
                 				<option value="2" selected="selected">长期客户</option>
                 				<option value="0">无</option>
					    		<option value="1">品牌客户</option>
					    		<option value="3">急需客户</option>
                 			</c:when>
                 			<c:when test="${ctApp.label=='3'}">
                 				<option value="3" selected="selected">急需客户</option>
                 				<option value="0">无</option>
					    		<option value="1">品牌客户</option>
					    		<option value="2">长期客户</option>
                 			</c:when>
                 			<c:otherwise>
                 				<option value="0">无</option>
					    		<option value="1">品牌客户</option>
					    		<option value="2">长期客户</option>
					    		<option value="3">急需客户</option>
                 			</c:otherwise>
                 		</c:choose>
					</select>  
				</td>
             </tr>
             <tr>
                 <td>客户描述:</td>
                 <td colspan="3"><input class="easyui-textbox" name="ct_rent.description" data-options="multiline:true" style="height:60px;width:500px;" value="${ctRent.description }"></input></td>
             </tr>
         </table>
     </form>
     <!-- 
     <div style="text-align:center;padding:5px">
         <a id="btn_submit" href="javascript:void(0)" class="easyui-linkbutton" onclick="submitForm()">提交</a>
         <a href="javascript:void(0)" class="easyui-linkbutton" onclick="clearForm()">取消</a>
     </div>
     -->
     </div>