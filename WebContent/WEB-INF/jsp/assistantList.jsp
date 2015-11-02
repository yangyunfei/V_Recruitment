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
<title>应聘者人员列表</title>
<link rel="stylesheet" type="text/css" href="style/style.css" />
<script src="http://code.jquery.com/jquery-1.11.0.min.js"></script>
<script type="text/javascript" src="js/job.js"></script>
<script type="text/javascript" src="js/jquery.form.js"></script>
<script type="text/javascript" src="js/loading.js"></script>
<script type="text/javascript">
$(function(){
	var globalPage = {   
			pageSize:10,
			pageNum:1,
			result:0
	};
	
	$("#manager").click(function(){
		window.location.href="${basePath}loginTurnXq.do";	
	});
	
	//判断当前页数和总页数是否相等 -- 相等则隐藏加载更多
	globalPage.result = '${result}';
	globalPage.pageSize = '${pageSize}';
	globalPage.pageNum = '${pageNo}';
	if(Number(globalPage.result) <= Number(globalPage.pageSize)) {
		$("#clickMore").hide();
	} else {
		$("#clickMore").show();
	}
	
	$("#loadMore").click(function () {
	
	//显示下一页数据 
	var pageNo = Number(globalPage.pageNum)+1;
	showdiv('ajaxform','数据加载中<br/>请稍候........ <br/> ',document.body.clientWidth,200,true);
		$.ajax({
			type:"post", 
			url:"${basePath}assistantViewJson.do",
			data:{"pageSize":globalPage.pageSize,"pageNo":pageNo,"matchFlag":"1","applicantIds":'${param.applicantIds}'},
			success:function(page){
				page = $.parseJSON(page);
				var len = page.data.length;
				$.each(page.data,function(i,n){
					str = '<a class="ls">'
	            		+'<span><input class="checkApplicant" name="checkApplicant" style="width: 3%" type="checkbox" id="'+n.applicantId+'" value="'+n.applicantId+'">'+n.recommendedCode+n.showInfo+'</span>'
		                +'<span>'+n.time+'</span>'
		                +'</a><hr/>';
					
		            $("#applicantList").append(str);
				});
				globalPage.pageNum = pageNo;
				if((pageNo-1)*globalPage.pageSize+len >= globalPage.result) {
					$("#clickMore").hide();
				}
				closediv('ajaxform');
			} ,
			error:function(err){
				
			}
		});
	});
	
	
	$("#checkFrom").submit(function() {
		$("#checkSub").attr("disabled",true); //按钮置为不可用
		if(!validation())
		{
			$("#checkSub").attr("disabled",false); //按钮置为可用
			return false;
		};
		//处理表单数据
		var ids = '';
		$("input[name='checkApplicant']:checked").each(function(){
			ids += $(this).val()+',';	
		});
		$("#checkApplicantIds").val($("#checkApplicantIds").val()+ids);

	});

		
		function validation() {
			 if($("input[name='checkApplicant']:checked").length < 1 ) {
				 alert('请选择一条信息');
				 return false;
			 }
			 return true;
		}
		
		$(".iconsLeft").click(function(){
			window.location.href="${basePath}trunApplicantPage.do";	
		});
});

</script>
<style type="text/css">
	.buttonClass{
		height: 32px;
		width: 105%;
	}
</style>
</head>

<body>
<div class="main">
    <!-- head start -->
    <div class="head">
    	<header>
    		<div class="iconsLeft">
    		&lt;&nbsp;我的推荐
			</div>
    			
    		<div class="icons">
    			<form method="post" action="${basePath}bindRecruitmentApplicant.do" id="checkFrom" name="checkFrom">
			    	<input type="hidden" id="recruitmentId" name="recruitmentId" value="${recruitmentId}">
			    	<input type="hidden" id="checkApplicantIds" name="checkApplicantIds" value="${applicantIds}">
			    	<input type="submit" id="managerBtn" class="buttonClass" value="确认">
			    </form>	
            </div>
    	</header>
    </div>
    <!-- head end -->
    <!-- mid start -->
    <div class="mid">
    	<div class="list" style="padding-top: 1%;margin-top: 1%" id="applicantList">
            <c:if test="${list != null}">
            	<c:forEach var="app" items="${list}">
            		<a class="ls">
            		<span><input class="checkApplicant" name="checkApplicant" style="width: 3%" type="checkbox" id="${app.applicantId}" value="${app.applicantId}">${app.recommendedCode}&nbsp;${app.showInfo}</span>
	                <span>${app.time}</span>
	                </a>
	                <hr/>
            	</c:forEach>
            </c:if>
            <c:if test="${list == null}">
            <div style="text-align:center;padding-top: 20%;">暂无应聘人员，请录入后推荐！</div>
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
