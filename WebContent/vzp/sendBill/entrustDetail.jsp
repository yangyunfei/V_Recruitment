<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css"
	href="<%=basePath%>css/easyui.css">
<link rel="stylesheet" type="text/css" href="<%=basePath%>css/icon.css">
<link rel="stylesheet" type="text/css" href="<%=basePath%>css/demo.css">
<script type="text/javascript" src="<%=basePath%>js/jquery.min.js"></script>
<script type="text/javascript"
	src="<%=basePath%>js/jquery.easyui.min.js"></script>
<script type="text/javascript" src="<%=basePath%>js/ajaxfileupload.js"></script>
<title>客户委托详情</title>

<style type="text/css">
.titleRentStyle {
	text-align: center;
	border: 1px solid #95B8E7;
	padding: 7px 10px;
	background: #EAF2FF;
	width: 80px;
	border-radius: 25px;
	-moz-border-radius: 25px;
	position: relative;
	left: 0px;
	top: 0.5px;
}

.hr1 {
	width: 93%;
	position: relative;
	top: -7.51px;
	border-color: #E6F0FF;
}

</style>
<script type="text/javascript">
    var custValue;
    function inserSendbillInfo(){
    	$("#rentBtn").attr("disabled","disabled");
    	var storeId = $("#storeId").val(); 
	    var rtId = $("#rtId").val();
	    var userid=$("#userid").val();
	    var agentNumber = $("#agentNumber").val();
	    var agentName = $("#agentName").val();
	    var agentPhone = $("#agentPhone").val();
	    var isValid = $("#rentForm").form('validate');
		if (!isValid){
			$("#rentBtn").removeAttr("disabled");
			return isValid;
		} 
	    $.post(
		    	'${jfinalserver}v1/zypsendbill/inserSendbillInfo',{
		    		storeId : storeId,
		    		type : 0,
		    		rtId: rtId,
		    		userid:userid,
		    		agentNumber : agentNumber,
		    		agentName : agentName,
		    		agentPhone : agentPhone
		    	},
		    	function(data,state)
				{
					if (data.success) 
					{
						$.messager.alert("提示信息", "派单操作成功！");
						$('#rentBtn').linkbutton({   
							 plain:true  
					    });   
						$('#dataGrid').datagrid('load');
						$('#storeId,#agentPhone,#agentName,#agentNumber').val('');
						$('#agentPhone,#agentNumber').numberbox('clear');
						//$('#rentBtn').linkbutton('disable');//禁用按钮 
					} else {
						$.messager.alert("提示信息", data.msg);
						$('#rentBtn').linkbutton({   
							 plain:true  
					    });  
						$('#storeId,#agentPhone,#agentName,#agentNumber').val('');
						$('#agentPhone,#agentNumber').numberbox('clear');
						$("#rentBtn").removeAttr("disabled");
						//$('#rentBtn').linkbutton('disable');//禁用按钮 
					}
				  }, 'JSON'
		    )
    }
    function chooseStore(){
    	parent.$.modalDialog({
			title : '选择商铺',
			width : 600,
			height : 450,
			href : '${pageContext.request.contextPath}/zyp/sendBill/chooseStore.jsp',
				buttons : [ {
					text : '提交',
					handler : function() {
						parent.$.modalDialog.openner_dataGrid = dataGrid;
						var c = parent.$.modalDialog.handler.find("#storeDataGrid").datagrid("getChecked")[0];
						if(c){
							$("#storeId").val(c.store_id);
						}else{
							$("#storeId").val("");
						}
						parent.$.modalDialog.handler.dialog('destroy');
						parent.$.modalDialog.handler = undefined;
						
					}
					}, {
					text : '取消',
					handler : function() {
					parent.$.modalDialog.handler.dialog('destroy');
					parent.$.modalDialog.handler = undefined;
					}
					}
					]
		});
    }
    function chooseAgent(){
    	parent.$.modalDialog({
			title : '选择带看人',
			width : 600,
			height : 450,
			href : '${pageContext.request.contextPath}/zyp/sendBill/chooseAgent.jsp',
				buttons : [ {
					text : '提交',
					handler : function() {
						parent.$.modalDialog.openner_dataGrid = dataGrid;
						var c = parent.$.modalDialog.handler.find("#agentDataGrid").datagrid("getChecked")[0];
						if(c){
							$("#agentNumber").val(c.pager);
							$("#agentName").val(c.name);
							$("#agentPhone").val(c.phone);
						}else{
							$("#agentNumber").val("");
							$("#agentName").val("");
							$("#agentPhone").val("");
						}
						parent.$.modalDialog.handler.dialog('destroy');
						parent.$.modalDialog.handler = undefined;
						
					}
					}, {
					text : '取消',
					handler : function() {
					parent.$.modalDialog.handler.dialog('destroy');
					parent.$.modalDialog.handler = undefined;
					}
					}
					]
		});
    }
    function loadRentInfo() {
    	rt_id= $("#rtId").val();
	     var dataGrid = $('#dataGrid').datagrid({
			url : '${pageContext.request.contextPath}/jf/sendBillController/viewStoreDataGrid?type=0&rt_id='
								+ rt_id,
						fit : true,
						fitColumns : false,
						border : true,
						pagination : false,
						idField : 'id',
						pageSize : 10,
						singleSelect : true,
						remoteSort : false,
						pageList : [ 10, 20, 30, 40, 50 ],
						sortName : 'createdate',
						sortOrder : 'desc',
						checkOnSelect : false,
						selectOnCheck : false,
						singleSelect : true,
						nowrap : false,
						rownumbers : true,
						columns : [ [ {
							field : 'store_id',
							title : '铺源编号',
							width : 120,
							sortable : true
						}, {
							field : 'createdate',
							title : '派单日期',
							width : 100,
							sortable : true
						}, {
							field : 'agent_number',
							title : '带看人系统号',
							width : 100,
							sortable : true
						}, {
							field : 'agent_name',
							title : '带看人姓名',
							width : 100,
							sortable : true
						}, {
							field : 'agent_phone',
							title : '带看人电话',
							width : 120,
							sortable : true
						}, {
							field : 'name',
							title : '派单人',
							width : 120,
							sortable : true
						} ] ]
					})
		}
		$(function() {
			$("input",$("#agentNumber").next("span")).keyup(function(){
				   var agentId=this.value;
					if(agentId.length==8)
					{
						$("#rentBtn").attr("disabled","disabled");
					    $.post("${jfinalserver}v1/userverification/findUserinfoByPager", {
							pager : agentId,
						}, function(data) 
						{
							if (data.success) {
								$("#agentName").val(data.obj.name);
								$("#agentPhone").val(data.obj.mobile);
							} else {
								alert(" 经纪人不存在");
							}
							$("#rentBtn").removeAttr("disabled");
						});
					}
					return false;
				});
	    	
			   loadRentInfo();
		});
	</script>
</head>
<body>
	<div class="easyui-panel" title="" style="width: 1000px, border:false;">
		<div style="padding: 10px 60px 20px 60px">
			<form id="rentForm" method="post">
		      <input type="hidden" id="rtId" name="rtId" value="${rent.id}">
			     <input type="hidden" id="userid" name="userid" value="${user.id}">
				<table cellpadding="5">
					<tr>
						<td colspan="4">
							<div class="titleRentStyle">所属用户信息</div>
							<hr class="hr1" />
						</td>
					</tr>
					<tr>
						<td>用户ID:</td>
						<td><input class="easyui-textbox" type="text"
							name="customerId" value="${rent.phone}"
							data-options="editable:false"></input></td>
						<td>姓名:</td>
						<td><input class="easyui-textbox" type="text" name="name"
							value="${customers.name}" data-options="editable:false"></input></td>
					</tr>
					<tr>
						<td>性别:</td>
						<td><input class="easyui-textbox" type="text" name="sex"
							data-options="editable:false"></input></td>
						<td>注册日期:</td>
						<td><input class="easyui-datebox"
							data-options="disabled:true" value="${rent.createtime}"></input>
						</td>
					</tr>
					<tr>
						<td colspan="4">
							<div class="titleRentStyle">委托信息</div>
							<hr class="hr1" />
						</td>
					</tr>
					<tr>
						<td>委托提交日期:&nbsp;&nbsp;</td>
						<td><input class="easyui-datebox"
							data-options="disabled:true" value="${rent.createtime}"></input></td>
						<td>委托编号:</td>
						<td><input class="easyui-textbox"
							data-options="editable:false" type="text" name="rentCode"
							value="${rent.rent_code}"></input></td>
					</tr>
					<tr>
					    <td>目标行政区:</td>
						<td><input class="easyui-textbox"
							data-options="editable:false" type="text" name="regn"
							value="${rent.regn}"></input></td>
						<td>目标商圈:</td>
						<td><input class="easyui-textbox"
							data-options="editable:false" type="text" name="targetAreaName"
							value="${rent.target_area_name}"></input></td>
					</tr>
					<tr>
						<td>面积范围:</td>
						<td><input class="easyui-textbox" style="max-width: 48px;"
							data-options="editable:false" type="text" name="areaMin"
							value="${rent.area_min}"></input>平方米
							<input class="easyui-textbox"
							data-options="editable:false" style="max-width: 48px;"
							type="text" name="areaMax"
							value="${rent.area_max}"></input>平方米
					    </td>
						<td>年租金范围:</td>
						<td><input class="easyui-textbox"
							data-options="editable:false" 
							type="text" name="rentMin"
							style="max-width: 53px;"
							value="${rent.rent_min/10000}">万元</input> 
							<input class="easyui-textbox"
							data-options="editable:false" 
							type="text" name="rentMax"
							style="max-width: 53px;"
							value="${rent.rent_max/10000}">万元</input>
					    </td>
					</tr>
					<tr>
					    <td>预经营的行业:</td>
					    <td><input class="easyui-textbox"
							data-options="editable:false" type="text" name="regn"
							value="${rent.industry_name}"></input>
					    </td>
						<td>说明：</td>
						<td><textarea rows="3" cols="30"
								data-options="editable:false" name="description"
								>${rent.description}</textarea>
						</td>
					</tr>
					<tr>
						<td colspan="4">
							<div class="titleRentStyle">派单</div>
							<hr class="hr1" />
						</td>
					</tr>
					<tr>
						<td>匹配铺源: SP</td>
						<td><input id="storeId" 
						    name="storeId" 
						    type="text"
							class="easyui-validatebox" 
							data-options="prompt:'请输入铺源编号'" ></input>
							<input id="storeBtn" href="javascript:void(0)" type="button"
							onclick="chooseStore();"  value="选择商铺" ></input>
						</td>
					</tr>
					<tr>
						<td>带看人系统号:</td>
						<td>  
						   <input id="agentNumber" 
						          name="agentNumber" 
						          data-options="required:true" 
						          type="text" 
						          class="easyui-validatebox" 
						          min="0" validateType="length[0,8]" 
						          missingMessage="系统号不能为空" 
						          invalidMessage="系统号不能超过8位且为数字！"></input>
						          <input id="agentBtn" href="javascript:void(0)" type="button"
							onclick="chooseAgent();"  value="选择带看人" ></input>
						</td>
						<td>带看人姓名:</td>
						<td>
						   <input id="agentName" 
						          name="agentName" 
						          data-options="required:true" 
						          type="text" 
						          class="easyui-validatebox" 
						          validateType="length[4,20]" 
						          missingMessage="带看人姓名不能为空" 
						          invalidMessage="带看人姓名不能大于20位！"></input>
						</td>
					</tr>
					<tr>
						<td>带看人电话:</td>
						<td>
						   <input id="agentPhone" name="agentPhone" data-options="required:true" type="text" class="easyui-validatebox" min="0" validateType="length[0,11]" missingMessage="带看人电话不能为空" invalidMessage="带看人电话不能大于11位！"></input>
						</td>
						<td><input id="rentBtn" href="javascript:void(0)" type="button"
							onclick="inserSendbillInfo();"  value="派单" ></input></td>
					</tr>
					<tr>
						<td colspan="4">
							<div class="titleRentStyle">派单记录</div>
							<hr class="hr1" />
						</td>
					</tr>
					<tr>
						<table id="dataGrid"></table>
					</tr>
				</table>
			</form>
		</div>
	</div>
</body>
</html>