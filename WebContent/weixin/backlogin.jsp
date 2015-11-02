<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html>
<html>
<head>
<base href="<%=basePath%>">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
<title>账户登录</title>
<link rel="stylesheet" type="text/css" href="style/style.css" />
<script src="http://code.jquery.com/jquery-1.11.0.min.js"></script>
<script type="text/javascript" src="js/job.js"></script>
<script type="text/javascript" src="js/jquery.form.js"></script>
<script type="text/javascript" src="js/validate.js"></script>
<script type="text/javascript">
//关闭等待窗口
function closediv() {
    //Close Div 
    document.body.removeChild(document.getElementById("bgDiv"));
    document.getElementById("msgDiv").removeChild(document.getElementById
("msgTitle"));
    document.body.removeChild(document.getElementById("msgDiv"));
}
//显示等待窗口
function showdiv(str) {
    var msgw, msgh, bordercolor;
    msgw = 400; //提示窗口的宽度 
    msgh = 100; //提示窗口的高度 
    bordercolor = "#336699"; //提示窗口的边框颜色 
    titlecolor = "#99CCFF"; //提示窗口的标题颜色 
    var sWidth, sHeight;
    sWidth = window.screen.availWidth;
    sHeight = document.body.scrollHeight;
    var bgObj = document.createElement("div");
    bgObj.setAttribute('id', 'bgDiv');
    bgObj.style.position = "absolute";
    bgObj.style.top = "0";
    bgObj.style.background = "#777";
    bgObj.style.filter = "progid:DXImageTransform.Microsoft.Alpha(style=3,opacity=25,finishOpacity=75";
    bgObj.style.opacity = "0.6";
    bgObj.style.left = "0";
    bgObj.style.width = sWidth + "px";
    bgObj.style.height = sHeight + "px";
    document.body.appendChild(bgObj);
    var msgObj = document.createElement("div")
    msgObj.setAttribute("id", "msgDiv");
    msgObj.setAttribute("align", "center");
    msgObj.style.position = "absolute";
    msgObj.style.background = "white";
    msgObj.style.font = "12px/1.6em Verdana, Geneva, Arial, Helvetica, sans-serif";
    msgObj.style.border = "1px solid " + bordercolor;
    msgObj.style.width = msgw + "px";
    msgObj.style.height = msgh + "px";
    msgObj.style.top = (document.documentElement.scrollTop + (sHeight - msgh) / 2) + "px";
    msgObj.style.left = (sWidth - msgw) / 2 + "px";
    var title = document.createElement("h4");
    title.setAttribute("id", "msgTitle");
    title.setAttribute("align", "right");
    title.style.margin = "0";
    title.style.padding = "3px";
    title.style.background = bordercolor;
    title.style.filter = "progid:DXImageTransform.Microsoft.Alpha(startX=20, startY=20, finishX=100, finishY=100,style=1,opacity=75,finishOpacity=100);";
    title.style.opacity = "0.75";
    title.style.border = "1px solid " + bordercolor;
    title.style.height = "18px";
    title.style.font = "12px Verdana, Geneva, Arial, Helvetica, sans-serif";
    title.style.color = "white";
    //title.style.cursor = "pointer";
    //title.innerHTML = "关闭";
    //title.onclick = closediv;
    document.body.appendChild(msgObj);
    document.getElementById("msgDiv").appendChild(title);
    var txt = document.createElement("p");
    txt.style.margin = "1em 0"
    txt.setAttribute("id", "msgTxt");
    txt.innerHTML = str;
    document.getElementById("msgDiv").appendChild(txt);
}
//屏蔽F5
document.onkeydown = mykeydown;
function mykeydown() {
    if (event.keyCode == 116) //屏蔽F5刷新键   
    {
        window.event.keyCode = 0;
        return false;
    }
}  
$(document).ready(function() {
	
//判断是否显示错误信息
var info = '${requestScope.errorMsg}';
info = (info == '' || info == 'undefined') ? '${param.errorCode}' : "";
if(info != '' && info != 'undefined') {
	if(info == '101') {
		alert('登陆超时,请重新登陆');
	}else
		alert(info);
}

$("#loginFrom").submit(function() {
		$("#submitForm").attr("disabled",true); //按钮置为不可用
		if(!validation())
		{
			closediv() ;
			$("#submitForm").attr("disabled",false); //按钮置为可用
			return false;
		};
		
		showdiv('登陆中<br/>请稍候........ <br/> ');
		/**var options = {
				dataType:"json",
				beforeSubmit:function(){
					//validation();
				},
				success : function(msg) {
					//showMessage(msg.info);
					if (msg.succ){
						alert(msg.info);
						if(msg.currentPositionCode) {
							//跳转店经理处理页面
							window.location.href
						} else {
							//跳转助理处理页面
						}
 					
				}else{
					$("#submitForm").attr("disabled",false); //按钮置为可用
					closediv() ;
					alert(msg.info);
					
				}
					
				},
				error : function(json) {
					$("#submitForm").attr("disabled",false); //按钮置为可用
					closediv();
					alert("登陆出错");
				}
			};
		showdiv('表单数据提交中<br/>请稍候........ <br/> ');
		$("#loginFrom").ajaxSubmit(options);
		return false; */
	
	});
	
	
	function validation() {	 
	 var username = $("#username").val().trim();
	 var password = $("#password").val().trim();
	 if(Number(username) <= 0) {
			 alert('请正确填写系统号！');
			 return false;
		 }
	 if(password.length == 0) {
			 alert('请填写系统密码！');
			 return false;
	 }
		 return true;
		
	}
});
</script>
</head>
<body>
<div class="main">
    <!-- head start -->
    <div class="head">

    </div>
    <!-- head end -->
    <!-- mid start -->
    <div class="mid" style="position:absolute;top:50%;margin:-150px 0 0 0;width:100%;height:300px;" >
    	<div class="commenul" >
        <form action="${basePath}back/backlogin.do" name="loginFrom" method="post" id="loginFrom">
        	<ul>
            	<li><div class="commenlil">系统号：</div><div class="commenlir commenlirlong"><div class="fminput"><input type="text" name="username" id="username" required="required" value="${requestScope.username}" placeholder="请输入系统号" /></div></div></li>
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
</body>
</html>
