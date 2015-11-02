<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <base href="<%=basePath%>">
    <meta content="IE=EmulateIE7" http-equiv="X-Ua-Compatible">
<title>真有铺后台管理系统</title>
<jsp:include page="inc.jsp"></jsp:include>
 <link href="stylesheets/base.css" rel="stylesheet" type="text/css" />
<link href="stylesheets/index.css" rel="stylesheet" type="text/css" />   
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

  </head>
    <script type="text/javascript">
	$(function() {
 	/*      $('#loginuser').click(function()
 	     {
 	         $('#form').submit();
     }
	     ); */
	    /*  $('#kaptchaImage').click(function () {//生成验证码  
                 $(this).hide().attr('src', '${pageContext.request.contextPath}/captcha/captcha-image?' + Math.floor(Math.random()*100) ).fadeIn();     
                      });   */ 
		$('#form').form({
			//url : '${pageContext.request.contextPath}/userController/login',
			url : '${pageContext.request.contextPath}/jf/loginController/login',
			onSubmit : function() {
				 parent.$.messager.progress({
					title : '提示',
					text : '数据处理中，请稍后....'
				}); 
				var isValid = $(this).form('validate');	
				if(!isValid)
				  parent.$.messager.progress('close');  
				return isValid; 
			},
			success : function(result)
			 {
				parent.$.messager.progress('close');
				result = $.parseJSON(result);
			    alert(result.success); 
				if (result.success) 
				{
					window.location.href="index.jsp";
				}/*  else 
				 {
				  //$('#kaptchaImage').click();
				    alert("aaa");
				    //$.messager.alert('Warning','The warning message');
				} */
			}
			});
		});
</script>
 <body>
<div id="container">
   <form id="form" method="post">
	<div id="login">
		<div class="neik">
			<div class="yonghum clearfix">
				<p>用户名</p>
				<input name="name" type="text" maxlength="20" placeholder="请输入登录名" class="easyui-validatebox " style="width:180px; padding-bottom: 0px; padding-top: 0px;" data-options="required:true,validType:'length[0,20]',missingMessage:'请输入登陆名'" value=""/>
			</div>
			<div class="mima clearfix">
				<p>密&nbsp;&nbsp;码</p>
				<input name="pwd" type="password" maxlength="20" placeholder="请输入密码" class="easyui-validatebox " style="width:180px; padding-bottom: 0px; padding-top: 0px;" data-options="required:true,validType:'length[0,20]',missingMessage:'请输入密码'" value=""/>
				
			</div>
			<div class="yanzhengm clearfix">
				<!-- <div class="yanzh">
					<p>验证码</p>
					<input name="kaptcha"  type="text" id="kaptcha" maxlength="4" style="novalidate:true;width:80px; padding-bottom: 0px; padding-top: 0px;"  placeholder="请输入验证码" class="duan" data-options="required:true,validType:'length[4,4]',missingMessage:'请输入验证码'" value=""/>
				</div> -->
				<%--  <img src="${pageContext.request.contextPath}/captcha/captcha-image" id="kaptchaImage"  style="margin:0px 0px 0px 10px"/> --%>
			</div>
			<div class="denglu">
				<input type="image"  id="loginuser" class="denglu" src="images/ico_denglu.gif" alt=""/>
			</div>
		</div>
	</div>
	</form>
	<div id="bottom">
		<p>主办单位：北京链家房地产经纪有限公司&nbsp;&nbsp;&nbsp;&nbsp;版权所有</p>
		<p>咨询电话：4006-066-055&nbsp;&nbsp;&nbsp;&nbsp;技术咨询电话：4006-066-055</p>
	</div>
</div>

</body>
</html>
