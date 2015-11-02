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
<title>录入应聘者信息</title>
<script src="http://code.jquery.com/jquery-1.11.0.min.js"></script>
<link rel="stylesheet" type="text/css" href="<%=basePath %>style/style.css" />
<script type="text/javascript" src="<%=basePath %>js/job.js"></script>
<script type="text/javascript" src="<%=basePath %>js/jquery.form.js"></script>
<script type="text/javascript" src="<%=basePath %>js/loading.js"></script>
<style type="text/css">
  #leo {  
            position: absolute;  
            border: 1px solid red;  
            opacity: 0.8;  
            background: yellow;  
            display: none;
    } 
     .shortselect{  
        background:#fafdfe;  
        height:35px;  
        width:100%;  
        line-height:35px;  
        border:1px solid #9bc0dd;  
        -moz-border-radius:1px;  
        -webkit-border-radius:1px;  
        border-radius:1px;  
    }  
</style>
<script type="text/javascript">

$(function() {
	
$("#applicantFormSub").submit(function() {
	$("#submitForm").attr("disabled",true); //按钮置为不可用
	if(!validation())
	{
		$("#submitForm").attr("disabled",false); //按钮置为可用
		return false;
	};
	var options = {
			dataType:"json",
			beforeSubmit:function(){
				//validation();
			},
			success : function(msg) {
				//showMessage(msg.info);
			if (msg.succ){
					alert(msg.info);
					$("#submitForm").attr("disabled",true); //按钮置为不可用
					window.location.href= "${basePath}assistantView.do?matchFlag=1";
			}else{
				$("#submitForm").attr("disabled",false); //按钮置为可用
				closediv('ajaxform');
				alert(msg.info);
				
			}
				
			},
			error : function(json) {
				$("#submitForm").attr("disabled",false); //按钮置为可用
		//		document.getElementById("ifr_div").style.display="none";
				closediv('ajaxform');
				alert("保存出错");
				
				
			}
		};
	
	showdiv('ajaxform','表单数据提交中<br/>请稍候........ <br/> ',document.body.clientWidth);
	$("#applicantFormSub").ajaxSubmit(options);
	return false;

});

	function validation() {
		//数据验证
		var department = $("#department").val().trim(); //姓名
		var remPhone = $("#remPhone").val().trim(); //姓名
		var username = $("#username").val().trim(); //姓名
		var age = Number($("#age").val().trim()); //年龄
		var phone = $("#phone").val().trim(); //手机
		var address = $("#address").val().trim(); //地址
		var schoolName = $("#schoolName").val().trim();//学校名称
		var education = $("#education").val();//学历
		var schoolLevel = $("#schoolLevel").val();//学校等级
		var remarks = $("#remarks").val().trim(); //预约数据
		var regPhone = /^0?1[3|4|5|7|8][0-9]\d{8}$/;
		if(department != null && department != 'undefind' && department != '' ) {
			if(department.length > 30) {
				errorshow($("#department"),'运营大区或部门超出长度');
				$("#department").focus();
				return false;
			}
		}
		if(!regPhone.test(remPhone)){
			errorshow($("#remPhone"),'输入合法的联系方式');
			$("#remPhone").focus();
			return false;
		}
		if(username == '' || username == 'undefind') {
			errorshow($("#username"),'请输入姓名');
			$("#username").focus();
			return false;
		}
		if(age != null && age != 'undefind' && age != '' ) {
			if(!(age >= 14 && age <= 65)) {
				errorshow($("#age"),'年龄不在范围(14~65)');
				$("#age").focus();
				return false;
			}
		}
		if(!regPhone.test(phone)){
			errorshow($("#phone"),'输入合法的联系方式');
			$("#phone").focus();
			return false;
		}
		if(education == -1 || education == 'undefined') {
			errorshow($("#education"),'请选择学历！');
			$("#education").focus();
			return false;
		}
		if(schoolLevel == -1 || schoolLevel == 'undefined') {
			errorshow($("#schoolLevel"),'请选择学校级别！');
			$("#schoolLevel").focus();
			return false;
		}
		
		if(isblank(schoolName) || schoolName.length > 80) {
			errorshow($("#schoolName"),'输入的学校名称为空或超过长度');
			$("#schoolName").focus();
			return false;
		}
		if(isblank(address) || address.length > 80) {
			errorshow($("#address"),'输入的现居地址为空或超过长度');
			$("#address").focus();
			return false;
		}
		if(isblank(remarks)) {
			errorshow($("#remarks"),'请输入备注');
			$("#remarks").focus();
			return false;
		}
		 return true;
	}
	
	$("#manager").click(function(){
		window.location.href="${basePath}loginTurnXq.do";	
	});
	
	function errorshow($input,msg){
		var x = 0;  
	    var y = 35;
		$("#leo").html(msg);
		$("#leo").css({  
		     "top" : ($input.offset().top + y) + "px",  
		     "left" : ($input.offset().left + x) + "px"  
		}).show(10).delay(3000).hide(300,function(){
		});
	}
	

	function fucCheckTEL(TEL)
	{
		var i,j,strTemp;
		strTemp="0123456789-()# ";
		for (i=0;i<strTemp.length;i++) 
		{
			j=strTemp.indexOf(TEL.charAt(i)); 
			if (j==-1)
			{
				//说明有字符不合法
				return 0;
			}
		}
		//说明合法
		return 1;
	}
	
	function isblank(str) {
		
	 	if( str != null && str != '' && str != 'undefind' && str.length > 0 ){
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
    <div class="mid">
        <form action="${basePath}createCandidatesSave.do" id="applicantFormSub" name="applicantForm" method="post" >
        	<div class="orderul">
                <ul>
                <!--  
                	<div class="headinfo">推荐人信息</div>
                	<li class="orderullih">
                        <div class="orderullilw"><em class="red"></em>所在大区:</div>
                        <div class="orderullirw">
                            <input id="department" name="department" type="text" required="required" class="contarl-input" placeholder="请输入所属运营大区或部门" value=""/>
                        </div>
                    </li>
                    <li class="orderullih">
                        <div class="orderullilw"><em class="red">*</em>联系方式:</div>
                        <div class="orderullirw">
                            <input id="remPhone" name="remPhone" type="text" required="required" class="contarl-input" placeholder="请输入联系方式(手机号)" value=""/>
                        </div>
                    </li>
                    -->
                     <div class="headinfo">应聘者信息</div>
                      <li class="orderullih">
                        <div class="orderullilw"><em class="red">*</em>姓名:</div>
                        <div class="orderullirw">
                            <input id="username" name="name"  maxlength="20" type="text" class="contarl-input" placeholder="请输入姓名" />
                        </div>
                    </li>
                   <li class="orderullih">
                        <div class="orderullilw"><em class="red">*</em>联系方式:</div>
                        <div class="orderullirw">
                            <input id="phone" name="phone" type="text" required="required" class="contarl-input" placeholder="请输入联系方式(手机号)" value=""/>
                        </div>
                    </li>
                    <li class="orderullih">
                        <div class="orderullilw"><em class="red"></em>年龄:</div>
                        <div class="orderullirw">
                            <input id="age" name="age" type="number" required="required" min="14" max="65" class="contarl-input" placeholder="请输入年龄" value=""/>
                        </div>
                    </li>
                    <!-- 
                     <li class="orderullih">
                        <div class="orderullilw"><em class="red">&nbsp;</em>QQ/微信:</div>
                        <div class="orderullirw">
                            <input id="qqOrWechat" name="qqOrWechat" required="required" type="text" class="contarl-input" placeholder="请输入QQ/微信" value=""/>
                        </div>
                    </li>
                    
                     <li class="orderullih">
                        <div class="orderullilw"><em class="red">&nbsp;</em>邮箱:</div>
                        <div class="orderullirw">
                            <input id="email" name="email" type="email" required="required" class="contarl-input" placeholder="请输入邮箱" value=""/>
                        </div>
                    </li>
                     -->
                    <div class="headinfo">学校信息</div>
                    <li class="orderullih">
                        <div class="orderullilw"><em class="red">*</em>学历:</div>
                        <div class="orderullirw">
                         <select class="shortselect" name="education" id="education">
                         	  <option value="-1">请选择学历</option>
							  <c:forEach items="${educationLevel}" var="area" varStatus="status">
								 	 <option value="${area.code}">${area.name}</option>
                               </c:forEach>
						</select>
                        </div>
                    </li>                  
                    <li class="orderullih">
                        <div class="orderullilw"><em class="red">*</em>毕业学校:</div>
                        <div class="orderullirw">
                            <input id="schoolName" name="schoolName" required="required" type="text" class="contarl-input" placeholder="填写最高学历毕业学校" value=""/>
                        </div>
                    </li>
                    <div class="headinfo">其他信息</div>
                    <li class="orderullih">
                        <div class="orderullilw"><em class="red">*</em>渠道来源:</div>
                        <div class="orderullirw">
                        <select class="shortselect" name="schoolLevel" id="schoolLevel">
                        	  <option value="-1">请选择渠道来源</option>
							  <c:forEach items="${schoolLevels}" var="level" varStatus="status">
								 	 <option value="${level.code}" >${level.name}</option>
                               </c:forEach>
						</select>
                        </div>
                    </li>
                    <li class="orderullih">
                        <div class="orderullilw"><em class="red">*</em>现居住地:</div>
                        <div class="orderullirw">
                            <input id="address" name="address" type="text" required="required" class="contarl-input" placeholder="请输入现居住地" value=""/>
                        </div>
                    </li>
                    <li class="orderullih"  style="height: 105px;">
                        <div class="orderullilw"><em class="red">*</em>备注:</div>
                        <div class="orderullih" style="height: 105px;">
                            <textarea rows="4" style="width: 100%;resize:none" required="required" id="remarks" name="remarks" class="contarl-input" placeholder="请输入预可面试时间等" ></textarea>
                        </div>
                    </li>
                </ul>
                <div class="btn"><div class="loginbtn greenbtn"><input  type="submit"  id="submitForm" value="保存" /></div></div>
            </div>
            

        </form>
    </div>
    <!-- mid end -->
    <!-- foot start -->
    <div class="foot">
    </div>
    <!-- foot end -->
</div>
</body>
</html>
