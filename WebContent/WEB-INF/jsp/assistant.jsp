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
<title>应聘者列表</title>
<link rel="stylesheet" type="text/css" href="<%=basePath %>style/style.css" />
<script src="http://code.jquery.com/jquery-1.11.0.min.js"></script>
<script type="text/javascript" src="<%=basePath %>js/job.js"></script>
<script type="text/javascript" src="<%=basePath %>js/loading.js"></script>
<script type="text/javascript">
$(function(){
	//判断当前页数和总页数是否相等 -- 相等则隐藏加载更多
	var result = '${result}';
	var pageSize = '${pageSize}';
	if(Number(result) <= Number(pageSize)) {
		$("#clickMore").hide();
	} else {
		$("#clickMore").show();
	}
	
	$("#loadMore").click(function () {
	var result = $("#result").val();
	var pageSize = $("#pageSize").val();
	var pageNo = $("#pageNo").val();
	var matchFlag = '${matchFlag}';
	//显示下一页数据 
	pageNo = Number(pageNo)+1;
	showdiv('ajaxform','数据加载中<br/>请稍候........ <br/> ',document.body.clientWidth,200,true);
		$.ajax({
			type:"post", 
			url:"${basePath}assistantViewJson.do",
			data:{"pageSize":pageSize,"pageNo":pageNo,"matchFlag":matchFlag},
			success:function(page){
				page = $.parseJSON(page);
				var len = page.data.length;
				$.each(page.data,function(i,n){
					var str = '<div>'+n.recommendedCode+'</div>';
					if(n.matchingStateId == 1) {
						str += '<a href="${basePath}turnUpdateCandidates.do?applicantId='+n.applicantId+'" class="ls lshight">';
					}
					else {
						str += '<a href="${basePath}appraisaldetail.do?applicantId=${app.applicantId}" class="ls lshight">';
					}
					str += '<span>'+n.showInfo+'</span>'+
		                '<span';
		                 if(n.matchingStateId == 1) {
		                	 str +=' class="divClassVid" >修改</span>';
		                 }
		                 if(n.matchingStateId == 2) {
		                	 str +=' class="divClassSucc" >评价</span> ';
		                 }
						 if(n.matchingStateId == 3) {
							 str +=' class="divClassSucc" >评价</span>';
			             }
						 if(n.matchingStateId == 4) {
							 str+= ' class="divClassSucc" >评价</span>';
			             }
		            str+='</a> <hr/>';
		            $("#applicantList").append(str);
				});
				$("#pageNo").val(pageNo);
				if((pageNo-1)*pageSize+len == result) {
					$("#clickMore").hide();
				}
				closediv('ajaxform');
			} ,
			error:function(err){
				
			}
		});
	});
	
	$("#managerBtn").click(function() {
		window.location.href="${basePath}searchRecruitmentInformation.do";
	});
	
	$("#manager").click(function(){
		window.location.href="${basePath}loginTurnXq.do";	
	});
	
	$(".iconsLeft").click(function(){
		//window.location.href="${basePath}trunApplicantPage.do";	
		window.location.href="${pageContext.request.contextPath}/weixin/api/toadd"
	});
	
});
</script>

<style type="text/css">
	.divClassSucc {
		background-size:cover;
		height: 100%;
		border: #75ac95 1px solid;
		border-radius: 3px 3px 3px 3px;
		padding: 3px 10px;	
		color: #75ac95;
	}
	
	.divClassing {
		background-size:cover;
		height: 100%;
		border: #e9b339 1px solid;
		border-radius: 3px 3px 3px 3px;
		padding: 3px 10px;	
		color: #e9b339;
	}
	
	.divClassVid {
		background-size:cover;
		height: 100%;
		border: #239a62 1px solid;
		border-radius: 3px 3px 3px 3px;
		padding: 3px 10px;	
		color: #239a62;
	}
	
	.divClassFail {
		background-size:cover;
		height: 100%;
		border: #e24b52 1px solid;
		border-radius: 3px 3px 3px 3px;
		padding: 3px 10px;	
		color: #e24b52;
	}
	
</style>
</head>

<body>
<div class="main">
    <!-- head start -->
    <div class="head">
    	<header>
    		<div class="iconsLeft">&lt;&nbsp;我要推荐
			</div><span id="insertInfo">
    		</span>
    		<div class="icons">
            </div>
    	</header>
    </div>
    <!-- head end -->
    <!-- mid start -->
    <div class="mid">
    	<div class="list" style="padding-top: 1%;margin-top: 1%" id="applicantList">
    	<input type="hidden" id="pageSize" name="pageSize" value="${pageSize}">
    	<input type="hidden" id="pageNo" name="pageNo" value="${pageNo}">
    	<input type="hidden" id="result" name="result" value="${result}">
            <c:if test="${list != null}">
            	<c:forEach var="app" items="${list}">
            	<div>${app.name}</div>
            	<div>${app.phone}</div>
            	<c:if test="${app.matchingStateId == 1}">
            		<a href="${basePath}turnUpdateCandidates.do?applicantId=${app.applicantId}" class="ls lshight">
            		<span>${app.showInfo}</span>
	                <span class="divClassVid">修改</span>
	                </a>
	                <hr/>
            	</c:if>
            	<c:if test="${app.matchingStateId != 1}">
            		<a href="${basePath}appraisaldetail.do?applicantId=${app.applicantId}" class="ls lshight">
            		<span >${app.showInfo}</span>
	                <span <c:if test="${app.matchingStateId == 2}">class="divClassing"</c:if> <c:if test="${app.matchingStateId == 3}">class="divClassSucc"</c:if>
	                <c:if test="${app.matchingStateId == 4}">class="divClassSucc"</c:if>><c:if test="${app.matchingStateId == 2}">评价</c:if> <c:if test="${app.matchingStateId == 3}">评价</c:if>
	                <c:if test="${app.matchingStateId == 4}">评价</c:if></span>
	                </a>
	                <hr/>
            	</c:if>
            	</c:forEach>
            </c:if>
            <c:if test="${list == null}">
            	<div id="isnotlist" style="text-align:center;padding-top: 20%;">暂无该状态应聘者，请录入后查看！</div>
            </c:if>
    	</div>
    </div>
    <div class="btn" id="clickMore"><div class="loginbtn greenbtn"><input  id="loadMore" type="button" value="点击加载更多" /></div></div>
    <!-- mid end -->
    <!-- foot start -->
    <div class="foot">
    </div>
    <!-- foot end -->
</div>
</body>
</html>
