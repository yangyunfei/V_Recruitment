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
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
<title>店面搜索</title>
<link rel="stylesheet" type="text/css" href="style/style.css" />
<script src="http://code.jquery.com/jquery-1.11.0.min.js"></script>
<script type="text/javascript" src="js/job.js"></script>
<script type="text/javascript" src="js/loading.js"></script>
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
		var houseStreet = $("#housesStreet").val(); //街道查询
		var cityProperId =  $("#cityProperId").val();
		var pageNo = $("#pageNo").val();
		//显示下一页数据 
		pageNo = Number(pageNo)+1;
		showdiv('ajaxform','数据加载中<br/>请稍候........ <br/> ',document.body.clientWidth,200,true);
			$.ajax({
				type:"post", 
				url:"${basePath}searchRecruitmentInformationJson.do",
				data:{"pageSize":pageSize,"pageNo":pageNo,"houseStreet":houseStreet,"cityProperId":cityProperId},
				success:function(page){
					page = $.parseJSON(page);
					var len = page.data.length;
					$.each(page.data,function(i,n){
						str = '<a href="${basePath}matchAssistant.do?id='+n.id+'&houseStreet='+houseStreet+'&cityProperId='+cityProperId+'" class="ls">'+
						'<span>'+n.code+'&nbsp;&nbsp;'+n.name+'<br/>任店经理时间：'+n.time+'<br/>'+n.remPart+'&nbsp;&nbsp;'+n.orgName+'</span><span></span></a><hr/>';
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
	
	$("#searchbtnSea").click(function () {
		var result = '${result}';
		var pageSize = 10;
		var houseStreet = $("#housesStreet").val(); //街道查询
		var cityProperId = $("#cityProperId").val();
		var pageNo = 1;
		$("#applicantList").html('');
		//显示下一页数据 
		showdiv('ajaxform','数据加载中<br/>请稍候........ <br/> ',document.body.clientWidth,200,true);
			$.ajax({
				type:"post", 
				url:"${basePath}searchRecruitmentInformationJson.do",
				data:{"pageSize":pageSize,"pageNo":pageNo,"houseStreet":houseStreet,"cityProperId":cityProperId},
				success:function(page){
					page = $.parseJSON(page);
					var len = page.data.length;
					if(len == 0 || len == '0') {
						 $("#applicantList").append('<div id="isnotlist" style="text-align:center;padding-top: 20%;">抱歉，未搜到匹配的数据，请更改楼盘/商圈关键词!</div>');
					} else {
						$("#result").val(page.result);
							$.each(page.data,function(i,n){
									str = '<a href="${basePath}matchAssistant.do?id='+n.id+'&houseStreet='+houseStreet+'&cityProperId='+cityProperId+'" class="ls">'+
								'<span>'+n.code+'&nbsp;&nbsp;'+n.name+'<br/>任店经理时间：'+n.time+'<br/>'+n.remPart+'&nbsp;&nbsp;'+n.orgName+'</span><span></span></a><hr/>';
					            $("#applicantList").append(str);
							});
						}
						$("#pageNo").val(Number(pageNo));
						if((pageNo-1)*pageSize+len >= page.result) {
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
		window.location.href="${basePath}trunApplicantPage.do";	
	});
});
</script>
<style type="text/css">
 .shortselect{  
        background:#fafdfe;  
        height:35px;  
        width:100%;  
        line-height:35px;  
        font-size:13px;
        border:1px solid #9bc0dd;  
        -moz-border-radius:1px;  
        -webkit-border-radius:1px;  
        border-radius:1px;  
  }  
  .contarl-input {
    width : 70%;
  	height: 20px;
  	font-size:16px;
  }
</style>
</head>
<body>
<div class="main">
    <!-- head start -->
    <div class="head">
    	<header>
    		<div class="iconsLeft">
    		&lt;&nbsp;我要推荐
			</div>
    		<div class="iconNone">
                &nbsp;
            </div>
    	</header>
    </div>
    <!-- head end -->
    <!-- mid start -->
    <div class="mid">
    	<div class="search">
            <div class="select left">
               <select class="shortselect" id="cityProperId" name="cityProperId">
               	<option value="-1">点击选择城区</option>
                <c:forEach var="city" items="${cityProper}">
                	<option id="${city.id}" value="${city.id}" <c:if test="${city.id == vo.cityProperId}">selected</c:if>>${city.name}</option>
            	</c:forEach>         		
               </select>
            </div>
            <span>
                <input type="text" id="housesStreet" placeholder="输入楼盘/商圈" value="${vo.houseStreet}" class="contarl-input" />
                <em class="searchbtn" id="searchbtnSea"><div class="icons"></div></em>
            </span>
        </div>
        <input type="hidden" id="pageSize" name="pageSize" value="${pageSize}">
    	<input type="hidden" id="pageNo" name="pageNo" value="${pageNo}">
    	<input type="hidden" id="result" name="result" value="${result}">
    	<div class="list" id="applicantList">
    		 <c:if test="${list != null}">
            	<c:forEach var="app" items="${list}">
            		<a href="${basePath}matchAssistant.do?id=${app.id}&houseStreet=${vo.houseStreet}&cityProperId=${vo.cityProperId}" class="ls">
            		<span>${app.code}&nbsp;&nbsp;${app.name}<br/>任店经理时间：${app.time}<br/>${app.remPart}&nbsp;&nbsp;${app.orgName}</span>
            		<span></span>
	                </a><hr/>
            	</c:forEach>
            </c:if>
            <c:if test="${list == null}">
            <div style="text-align:center;padding-top: 20%;">抱歉，未搜到匹配的数据，请更改楼盘/商圈关键词</div>
    		</c:if>
    	</div>
    	<div class="btn" id="clickMore"><div class="loginbtn greenbtn"><input  id="loadMore" type="button" value="点击加载更多" /></div></div>
    </div>
    <!-- mid end -->
    <!-- foot start -->
    <div class="foot">
    </div>
    <!-- foot end -->
</div>
</body>
</html>
