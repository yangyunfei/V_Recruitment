<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="<%=basePath %>css/login.css" />
<jsp:include page="inc.jsp"></jsp:include>
 
<title>登录</title>
</head>
<body class="login">
	<div class="login_con">
		<div class="login_logo">
			<img src="<%=basePath %>images/zyp/logo2.png" />
		</div>
		<div class="loginform">
			<h2>登录界面</h2>
			<h6>login</h6>
			<input type="text" name="name" class="logintxt" placeholder="登录用户">
			<input type="password" name="pwd" class="loginpswd"  placeholder="登录密码" onkeydown="if(event.keyCode==13){login();}">
			<div class="forgetPassword">
				<table>
					<tr>
					<td>
            			<input type="checkbox" name="rememberMe" id="rememberMe" value="true" class="rememberMe" />
            		</td>
            		<td>
            			<label for="rememberMe" class="jzmm">记住密码</label>
            		</td>
            		</tr>
            	</table>
	        </div>
			<input type="button" class="loginbtn" value="登录">	
		</div>
		<div class="bottom">
			<p>北京链家房产经纪有限公司 | 网络经营许可证 京ICP备11024601号-12</p>
			<p>©2014 Lianjia.com, all</p>
		</div>
	</div>
	<script>
function login(){
		var $loginName = $('.logintxt');
		var $password = $('.loginpswd');
		
		var loginName = $loginName.val();
		var password = $password.val();
		if(!loginName){
			alert('用户名不能为空');
			$loginName.focus();
			return false;
		}
		if(!password){
			alert('密码不能为空');
			$password.focus();
			return false;
		}
		if($('#rememberMe').attr('checked')){  
            $.cookie('rememberUser','true', { expires: 7 }); // 存储一个带7天期限的 cookie   
        	$.cookie('loginName', loginName, { expires: 7 }); // 存储一个带7天期限的 cookie   
        	$.cookie('password', password, { expires: 7 }); // 存储一个带7天期限的 cookie   
        }else{  
        	$.cookie('rememberUser','false', { expires: -1 });   
        	$.cookie('loginName', '', { expires: -1 });   
        	$.cookie('password', '', { expires: -1 });
        }  
		
		 $.ajax({
             type: "GET",
             url: '${pageContext.request.contextPath}/jf/loginController/login',
             data: {
            	 name:loginName, 
            	 pwd:password
             },
             dataType: "text",
             success: function(data){
            	 result = $.parseJSON(data);
 				if (result.success) 
 				{
 					window.location.href="<%=basePath %>index.jsp";
 				}
 				else
 					alert(result.msg);
                    
             },
             error:function(e,f){
            	 alert("提交失败");
             }
         });
	}
	
	$(function(){
		var loginName = $.cookie('loginName');
		var password = $.cookie('password');
		if(loginName){
			$('.logintxt').val(loginName);
		}
		if(password){
			$('.loginpswd').val(password);
			$('#rememberMe').attr('checked',true);
		}else{
			$('#rememberMe').attr('checked',false);
		}
		
		$('.loginbtn').click(function(){
			login();
		});
	});
	</script>
</body>
</html>