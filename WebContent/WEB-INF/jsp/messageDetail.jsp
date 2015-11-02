<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<base href="<%=basePath%>">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
<title>我的消息详情</title>
<style type="text/css">
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
<link rel="stylesheet" type="text/css" href="style/style.css" />
<script src="http://code.jquery.com/jquery-1.11.0.min.js"></script>
<script type="text/javascript" src="js/loading.js"></script>
<script type="text/javascript" src="js/job.js"></script>
<script type="text/javascript" src="js/jquery.form.js"></script>
<script type="text/javascript" src="js/validate.js"></script>


<script type="text/javascript">
function manager()  
{  
	history.go(-1);  
}  
function forward()  
{  
history.go(+1); //前进1页  
}  
function refresh()  
{  
history.go(-0) //刷新  
} 
$(function(){
	//跳转列表页
	$("select").prop("disabled", true);
	$(".iconsLeft").click(function(){
		window.location.href="${basePath}trunMain.do";	
	});
});
</script>
</head>

<body>
<div class="main">
    <!-- head start -->
    <div class="head">
        <header>
             <div class="iconsLeft">
             &lt;&nbsp;招聘推荐
			</div>
            <div class="iconNone">
                &nbsp;
            </div>
        </header>
    </div>
    <!-- head end -->
    <!-- mid start -->
    <div class="mid">
        	<div class="orderul">
                <ul>
                 <div class="headinfo">推荐人信息</div>
                    <li class="orderullih">
                        <div class="orderullilw">姓名:</div>
                        <div class="orderullirw">
                            ${message.sender.name}
                        </div>
                    </li>
                    <li class="orderullih">
                        <div class="orderullilw">联系方式:</div>
                        <div class="orderullirw">
                            ${message.recruitmentinformationHasApplicant.applicant.remPhone}
                        </div>
                    </li>
                    <div class="headinfo">应聘者信息</div>
                    <li class="orderullih">
                        <div class="orderullilw"><em class="red"></em>姓名:</div>
                        <div class="orderullirw">
                            ${message.recruitmentinformationHasApplicant.applicant.name}
                        </div>
                    </li>
                    <li class="orderullih">
                        <div class="orderullilw"><em class="red"></em>联系方式:</div>
                        <div class="orderullirw">
                            ${message.recruitmentinformationHasApplicant.applicant.phone}
                        </div>
                    </li>
                        <li class="orderullih">
                        <div class="orderullilw"><em class="red"></em>年龄:</div>
                        <div class="orderullirw">
                            <input id="age" name="age" readonly="readonly" type="number" required="required" min="14" max="65" value="${message.recruitmentinformationHasApplicant.applicant.age}" class="contarl-input" value=""/>
                        </div>
                    </li>
                     <li class="orderullih">
                        <div class="orderullilw"><em class="red">&nbsp;</em>QQ/微信:</div>
                        <div class="orderullirw">
                            <input id="qqOrWechat" readonly="readonly" name="qqOrWechat" required="required" type="text" value="${message.recruitmentinformationHasApplicant.applicant.qqOrWechat}" class="contarl-input" value=""/>
                        </div>
                    </li>
                     <li class="orderullih">
                        <div class="orderullilw"><em class="red">&nbsp;</em>邮箱:</div>
                        <div class="orderullirw">
                            <input id="email" readonly="readonly" name="email" type="email" required="required" class="contarl-input" value="${message.recruitmentinformationHasApplicant.applicant.email}"/>
                        </div>
                    </li>
                    <div class="headinfo">学校信息</div>
                    <li class="orderullih">
                        <div class="orderullilw"><em class="red"></em>学历:</div>
                        <div class="orderullirw">
                         <select class="shortselect" name="education" id="education">
							  <c:forEach items="${educationLevel}" var="area" varStatus="status">
								 	 <option value="${area.code}" <c:if test="${message.recruitmentinformationHasApplicant.applicant.education == area.code}">selected</c:if>>${area.name}</option>
                               </c:forEach>
						</select>
                        </div>
                    </li>
                    <li class="orderullih">
                        <div class="orderullilw"><em class="red"></em>学校级别:</div>
                        <div class="orderullirw">
                        <select class="shortselect" name="schoolLevel" id="schoolLevel">
							  <c:forEach items="${schoolLevels}" var="level" varStatus="status">
								 	 <option value="${level.code}" <c:if test="${message.recruitmentinformationHasApplicant.applicant.schoolLevel == level.code}">selected</c:if>>${level.name}</option>
                               </c:forEach>
						</select>
                        </div>
                    </li>
                    <li class="orderullih" style="height: 105px;">
                        <div class="orderullilw" ><em class="red"></em>毕业学校:</div>
                        <div class="orderullih" style="height: 105px;">
                            <textarea rows="4" style="width: 100%;resize:none" required="required" readonly="readonly" class="contarl-input">${message.recruitmentinformationHasApplicant.applicant.schoolName}</textarea>
                        </div>
                    </li>
                    <div class="headinfo">其他信息</div>
                    <li class="orderullih" style="height: 105px;">
                        <div class="orderullilw"><em class="red"></em>现居住地:</div>
                        <div class="orderullih" style="height: 105px;">
                            <textarea rows="4" style="width: 100%;resize:none" required="required" readonly="readonly" class="contarl-input">${message.recruitmentinformationHasApplicant.applicant.address}</textarea>
                        </div>
                    </li>
                    <li class="orderullih"  style="height: 105px;">
                        <div class="orderullilw"><em class="red"></em>备注:</div>
                        <div class="orderullih" style="height: 105px;">
                            <textarea rows="4" style="width: 100%;resize:none" required="required" id="remarks" readonly="readonly" name="remarks" class="contarl-input" placeholder="请输入预可面试时间等" >${message.recruitmentinformationHasApplicant.applicant.remarks}</textarea>
                        </div>
                    </li>
                </ul>
               
            </div>
    </div>
    <!-- mid end -->
    <!-- foot start -->
    <div class="foot">
    </div>
    <!-- foot end -->
</div>
</body>
<link href="/recruitment/style/mobiscroll.custom-2.5.0.min.css" rel="stylesheet" type="text/css" />
<script src="/recruitment/js/jquery.mobile-1.3.0.min.js" ></script>
<script data-main="scripts/main" src="/recruitment/js/mobiscroll.js" ></script>
</html>
