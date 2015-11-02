<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	String str  = request.getParameter("houseStreet");
%>
<!DOCTYPE html>
<html>
<head>
<script src="http://code.jquery.com/jquery-1.11.0.min.js"></script>
<base href="<%=basePath%>">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
<title>应聘者需求匹配</title>
<link rel="stylesheet" type="text/css" href="style/style.css" />
<script type="text/javascript" src="js/job.js"></script>
<script type="text/javascript" src="js/jquery.form.js"></script>
<script type="text/javascript" src="js/loading.js"></script>
<script type="text/javascript" src="js/validate.js"></script>
<script type="text/javascript">
$(document).ready(function() {
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
				if (msg.succ){
					alert(msg.info);
					window.location.href= "${basePath}searchRecruitmentInformation.do";
			}else{
				$("#submitForm").attr("disabled",false); //按钮置为可用
			//	document.getElementById("ifr_div").style.display="none";
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
	
	showdiv('ajaxform','表单数据提交中<br/>请稍候........ <br/> ',document.body.clientWidth,200,true);
	$("#applicantFormSub").ajaxSubmit(options);
	return false;

});

	
	function validation() {
		 return true;
	}
	
	$(".iconsLeft").click(function(){
		$("#infoSubmit").submit();
	});
});
</script>
<style type="text/css">
a:link {color: blue}     / 未被访问的链接     蓝色 /
a:visited {color: blue}  / 已被访问过的链接   蓝色 /
a:hover {color: blue}    / 鼠标悬浮在上的链接 蓝色 /
a:active {color: blue}   / 鼠标点中激活链接   蓝色 /

	.orderullils, .orderullilws {
	float: left;
	width: 110px;
	color: #999;
	line-height: 70px;
	}
	.orderullihs {
	height: 70px;
	line-height: 35px;
	}
	.orderullils, .orderullilws {
	float: left;
	width: 110px;
	color: #999;
	line-height: 70px;
	}
	.orderullirws {
	float: right;
	width: 55%;
	}
}

</style>
</head>

<body>
<div class="main">
    <!-- head start -->
    <div class="head">
        <header>
           <div class="iconsLeft">
           &lt;&nbsp;店面搜索
			</div>
          <span></span>
            <div class="iconNone">
            </div>
        </header>
    </div>
    <form action="${basePath}searchRecruitmentInformation.do" id="infoSubmit" method="post">
    	<input type="hidden" value="${cityProperId}" name="cityProperId" id="cityProperId">
    	<input type="hidden" value="<%=str%>" name="houseStreet" id="houseStreet">
    </form>
    <!-- head end -->
    <!-- mid start -->
    <div class="mid">
        	<div class="orderul">
        	  <form action="${basePath}saveRecruitmentApplicant.do" id="applicantFormSub" name="applicantForm" method="post" >
                <ul>
                <div class="headinfo">店长信息</div>
                    <li class="orderullih">
                        <div class="orderullilw"><em class="red"></em>店长姓名:</div>
                        <div class="orderullirw">
                            <input id="username" name="name" required="required" maxlength="20" type="text" class="contarl-input" readonly="readonly" value="${vo.name}"/>
                        </div>
                    </li>
                    <li class="orderullih">
                        <div class="orderullilw"><em class="red"></em>店长电话:</div>
                        <div class="orderullirw">
                            <input id="age" name="age" type="text" required="required" min="14" max="65" class="contarl-input"  readonly="readonly" value="${vo.phone}"/>
                        </div>
                    </li>
                    <li class="orderullih">
                        <div class="orderullilw"><em class="red"></em>任店经理时间:</div>
                        <div class="orderullirw">
                            <input id="cardStartDate" name="entryTime" type="text" class="contarl-input" placeholder="点击选择时间" readonly="readonly" value="${vo.entryTime }"/>
                        </div>
                    </li>
                    <div class="headinfo">店面信息</div>
                     <li class="orderullih">
                        <div class="orderullilw"><em class="red"></em>所在店面：</div>
                        <div class="orderullirw">
                            <input id="orgName" name="orgName" type="text" class="contarl-input" readonly="readonly" value="${vo.orgName}"/>
                        </div>
                    </li>
                      <li class="orderullih">
                        <div class="orderullilw"><em class="red"></em>店编码:</div>
                        <div class="orderullirw">
                            <input id="orgCode" name="orgCode" readonly="readonly"  type="text" class="contarl-input" placeholder="请输入店编码" value="${vo.orgCode }"/>
                        </div>
                    </li>
                     <li class="orderullih">
                        <div class="orderullilw"><em class="red"></em>所在大区:</div>
                        <div class="orderullirw">
                            <input id="remPart" name="remPart" readonly="readonly"  type="text" class="contarl-input" value="${vo.remPart }"/>
                        </div>
                    </li>
                     <li class="orderulli">
                        <div class="orderullilw paddingtop"><em class="red"></em>店面详细地址:</div>
                        <div class="orderullirw orderullirwwidth">
                            <textarea name="address" readonly="readonly"  class="contral-textarea" id="address">${vo.orgAddress}</textarea>
                        </div>
                    </li>
                    <li class="orderulli">
                      <!--   <div class="orderullilw nofloat">关键词:</div> -->
                        <div class="d">
                            <div class="orderullilw"><em class="red"></em>所在城区:</div>
                            <div class="orderullirw">
                             <input id="cityName" name="cityName" readonly="readonly"  type="text" class="contarl-input" placeholder="请输入店编码" value="${vo.cityName }"/>
                            </div>
                            <div class="clear"></div>
                        </div>
                        <div class="d">
                            <div class="orderullilw orderullirwwidth"><em class="red"></em>楼盘/商圈:</div>
                            <div class="orderullirw orderullirwwidth">
                                <textarea name="keyword1" id="keyword1" readonly="readonly" placeholder="如崇文门，幸福家园，多个词用逗号隔开" class="contral-textarea">${vo.keyword1 }</textarea>
                            </div>
                            <div class="clear"></div>
                        </div>
                        <div class="d">
                            <div class="orderullilw orderullirwwidth"><em class="red"></em>其他:</div>
                            <div class="orderullirw orderullirwwidth">
                                <textarea name="other" id="other" readonly="readonly" placeholder="" class="contral-textarea">${vo.other}</textarea>
                            </div>
                            <div class="clear"></div>
                        </div>
                    </li>
                    <li class="orderulli">
                        <div class="orderullilw paddingtop"><em class="red"></em>周边交通路线:</div>
                        <div class="orderullirw orderullirwwidth">
                            <textarea name="trafficRoutes" class="contral-textarea">${vo.trafficRoutes }</textarea>
                        </div>
                    </li>
                    <input type="hidden" id="recruitmentId" name="recruitmentId" value="${vo.recruitmentId}">
                    <div class="headinfo">应聘者信息</div>
                    <c:if test= "${appVos!= null}">
                    	<c:forEach var="app" items="${appVos}">
                    	  <li class="orderullihs">
                        <div class="orderullilws"><em class="red"></em>应聘者:</div>
                        <div class="orderullirws">
                        	<input id="${app.applicantId}" type="hidden" value="${app.applicantId}" name="applicantIds">
                        	<span>${app.context}<br/>
                        	<c:if test="${app.status != null}">
                       		<c:if test="${app.status == 1}">待匹配</c:if>
                       		<c:if test="${app.status == 2}">匹配中</c:if>
                       		<c:if test="${app.status == 3}">匹配成功</c:if>
                       		<c:if test="${app.status == 4}">失效</c:if></c:if></span>
                        </div>
                 	   </li>
                    	</c:forEach>
                    </c:if>
                    <li class="orderullih">
                        <div class="orderullilw"><em class="red"></em>添加应聘者:</div>
                        <div class="orderullirw">
                        	<a href="${basePath}trunApplicantList.do?recruitmentId=${vo.recruitmentId}&applicantIds=${applicantIds}">添加应聘者</a>
                        </div>
                    </li>
                </ul>
                <div class="btn"><div class="loginbtn greenbtn"><input  id="submitForm" type="submit" value="匹配" /></div></div>
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
