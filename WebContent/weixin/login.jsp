<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	basePath = basePath + "weixin" + "/";
%>

<!DOCTYPE html>
<html>
<head>
<base href="<%=basePath%>">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
<title>账户登录</title>
<link rel="stylesheet" type="text/css" href="<%=basePath %>style/style.css" />
<script src="http://code.jquery.com/jquery-1.11.0.min.js"></script>
<script type="text/javascript" src="<%=basePath %>js/job.js"></script>
<script type="text/javascript" src="<%=basePath %>js/validate.js"></script>
<script type="text/javascript" src="<%=basePath %>js/loading.js"></script>
<style type="text/css">
  #leo {  
            position: absolute;  
            border: 1px solid red;  
            opacity: 0.8;  
            background: yellow;  
             display: none;
    } 
</style>
<script type="text/javascript">
$(document).ready(function() {
//判断是否显示错误信息
var infoE = '${requestScope.errorMsg}';
var info = (infoE == '' || infoE == 'undefined') ? '${param.errorCode}' : infoE;
if(info != '' && info != 'undefined') {
	if(info == '101') {
		alert('登录超时,请重新登录');
	}else if(info == '102') {
		alert('当前用户已在其他地点登录！');
	}else
		alert(info);
}
	//自动登陆
	if('${cookie.userId.value}'!=null && '${cookie.userId.value}' != '' && '${param.errorCode}' != '101' && '${param.errorCode}' != '102') {
		showdiv('ajaxform','自动登录中<br/>请稍候........ <br/> ',document.body.clientWidth,200,true);
		$.ajax({
			type:"post", 
			url:"${basePath}loginJson.do",
			data:{},
			success:function(msg){
				var msg = $.parseJSON(msg);
				if (msg.succ){
					alert(msg.info);
					window.location.href = "${basePath}trunMain.do";
				}else{
					alert(msg.info);
					closediv('ajaxform');
				}
			} ,
			error:function(err){
				
			}
		});
	}

function errorshow($input,msg){

	 var x = 0;  
    var y = 35;
  //var otitle = $("#phonenumber").attr('title'); 
//  alert(otitle); 
	//var ndiv = "<div id='leo'>" + otitle + "</div>";  
// $("body").append(ndiv);
  
  $("#leo").html(msg);
  
 $("#leo").css({  
     "top" : ($input.offset().top + y) + "px",  
     "left" : ($input.offset().left + x) + "px"  
 }).show(10).delay(3000).hide(300,function(){
 	//$("#leo").remove();
 });

}

$("#loginFrom").submit(function() {
		$("#submitForm").attr("disabled",true); //按钮置为不可用
		if(!validation())
		{
			closediv('ajaxform');
			$("#submitForm").attr("disabled",false); //按钮置为可用
			return false;
		};
		showdiv('ajaxform','登录中<br/>请稍候........ <br/> ',document.body.clientWidth,200,true);
		return true;
	});
	
	
	function validation() {	 
	 var username = $("#username").val().trim();
	 var password = $("#password").val().trim();
	 if(isblank(username)) {
			 errorshow($("#username"),'请填写系统号！');
			 return false;
		 }
	 if(isblank(password)) {
			 errorshow($("#password"),'请填写系统密码！');
			 return false;
	 }
		 return true;
		
	}
});
</script>
</head>
<body>
<div id = "leo" ></div>

<div class="main">
    <!-- head start -->
    <div class="head">

    </div>
    <!-- head end -->
    <!-- mid start -->
    <div class="mid" style="position:absolute;top:75%;margin:-150px 0 0 0;width:100%;height:300px;" >
    	<div class="commenul" >
        <form action="${pageContext.request.contextPath}/jf/loginController/wechatlogin" name="loginFrom" method="post" id="loginFrom">
        	<ul>
            	<li><div class="commenlil">系统号：</div><div class="commenlir commenlirlong"><div class="fminput"><input type="number" name="username" id="username" autofocus value="${requestScope.username}" placeholder="请输入系统号" /></div></div></li>
                <li><div class="commenlil"><span class="shortpadding">密</span>码：</div><div class="commenlir commenlirlong"><div class="fminput"><input required="required" type="password" id="password" name="password" placeholder="请输入密码"/></div></div></li>
            </ul>
      <!--      <div class="checkboxout"><div class="loginckb"><input type="checkbox" class="checkbox" id="loginckb" checked="checked" /></div>保持登录</div> --> 
            <div class="btn"><div class="loginbtn greenbtn"><input type="submit" id="submitForm" value="登录" /></div></div>
        </form>
        </div>
    </div>
    <!-- mid end -->
    <!-- foot start -->
    <div class="foot">
    </div>
    <!-- foot end -->
</div>
<script type="text/javascript">
	document.getElementById("username").focus();
</script>
</body>
</html>
