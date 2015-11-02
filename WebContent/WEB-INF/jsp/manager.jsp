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
<title>需求管理</title>
<link rel="stylesheet" type="text/css" href="style/style.css" />
<script src="http://code.jquery.com/jquery-1.11.0.min.js"></script>
<script type="text/javascript" src="js/job.js"></script>
<script type="text/javascript" src="js/loading.js"></script>

<script type="text/javascript">
       
      //格式化CST日期的字串
      function formatCSTDate(strDate,format){
        return formatDate(new Date(strDate),format);
      }
       
      //格式化日期,
      function formatDate(date,format){
        var paddNum = function(num){
          num += "";
          return num.replace(/^(\d)$/,"0$1");
        }
        //指定格式字符
        var cfg = {
           yyyy : date.getFullYear() //年 : 4位
          ,yy : date.getFullYear().toString().substring(2)//年 : 2位
          ,M  : date.getMonth() + 1  //月 : 如果1位的时候不补0
          ,MM : paddNum(date.getMonth() + 1) //月 : 如果1位的时候补0
          ,d  : date.getDate()   //日 : 如果1位的时候不补0
          ,dd : paddNum(date.getDate())//日 : 如果1位的时候补0
          ,hh : date.getHours()  //时: 如果1位的时候补0
          ,mm : paddNum(date.getMinutes()) //分: 如果1位的时候补0
          ,ss : date.getSeconds() //秒
        }
        format || (format = "yyyy-MM-dd hh:mm:ss");
        return format.replace(/([a-z])(\1)*/ig,function(m){return cfg[m];});
      } 
      

  	$(function(){
  	//跳转列表页
  		$(".iconsLeft").click(function(){
  			window.location.href="${basePath}trunMain.do";	
  		});
  	});
    </script>
<!--  
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
	//显示下一页数据 
	pageNo = Number(pageNo)+1;
		$.ajax({
			type:"post", 
			url:"${basePath}assistantViewJson.do",
			data:{"pageSize":pageSize,"pageNo":pageNo},
			success:function(page){
				page = $.parseJSON(page);
				var len = page.data.length;
				$.each(page.data,function(i,n){
					var str = '<div class="headinfo">'+n.matchingState+'</div>';
					if(n.matchingStateId == 1) {
						str += '<a href="${basePath}turnUpdateCandidates.do?applicantId='+n.applicantId+'" class="ls">';
					}
					else {
						str += '<a href="javascript:void(0)" class="ls">';
					}
					str += '<span>'+n.showInfo+'</span>'+
		                '<span>'+n.time+'</span>'+
		            '</a>';
		            $("#applicantList").append(str);
				});
				$("#pageNo").val(pageNo);
				if((pageNo-1)*pageSize+len == result) {
					$("#clickMore").hide();
				}
			} ,
			error:function(err){
				
			}
		});
	});
	
});

</script>

-->


</head>

<body>
<div class="main">
    <!-- head start -->
    <div class="head">
    	<header>
    		   <div class="iconsLeft">
    		   &lt;&nbsp;招聘推荐
			</div>
    		<div class="icon" onclick="javascript:window.location.href='${basePath}messagelist.do'">
                <div class="line"></div>
                <c:if test="${count !=0 }">
                 <div class="tag" id="tag"></div>
                </c:if>
                
            </div>
    	</header>
    </div>
    <!-- head end -->
    <!-- mid start -->
    <div class="mid">
    
    
    
        	<div class="list">
            <div class="headinfo">需求</div>
    		<a href="toUpdateDemand.do?id=${recruitInfo.id }" class="ls">
    			<span>${recruitInfo.recommendedCode}&nbsp;&nbsp;${recruitInfo.orgName}&nbsp;&nbsp;</span>
    			<span id="createTime">${recruitInfo.entryTime}</span><!-- 创建时间 -->
    		</a>

    
    	</div>
		<hr/>
    	<div class="list">
	    	<div class="headinfo">评价列表</div>
	    	<div id="appraiselist">
		 		<div id="isnotlist" style="display:none;text-align: center;padding-top: 20%;">暂无评价！</div>
	    	</div>
	    </div>
  <!--  	<div class="btn orangebtn fixedwidthbtn fixedwidthbtn120"><a href="${basePath}createCandidatesView.do">录入应聘者信息</a></div>
    	<div class="list" style="padding-top: 1%;margin-top: 1%" id="applicantList">
    	<input type="hidden" id="pageSize" name="pageSize" value="${pageSize}">
    	<input type="hidden" id="pageNo" name="pageNo" value="${pageNo}">
    	<input type="hidden" id="result" name="result" value="${result}">
            <c:if test="${list != null}">
            	<c:forEach var="app" items="${list}">
            	<div class="headinfo">${app.matchingState}</div>
            	<c:if test="${app.matchingStateId == 1}">
            		<a href="${basePath}turnUpdateCandidates.do?applicantId=${app.applicantId}" class="ls">
            		<span>${app.showInfo}</span>
	                <span>${app.time}</span>
	                </a>
            	</c:if>
            	<c:if test="${app.matchingStateId != 1}">
            		<a href="javascript:void(0)" class="ls">
            		<span>${app.showInfo}</span>
	                <span>${app.time}</span>
	                </a>
            	</c:if>
            	</c:forEach>
            </c:if>
    	</div>-->  
    </div>
   <div class="btn" id="clickMore" style="display: none;"><div class="loginbtn greenbtn"><input  id="loadMore" type="button" value="点击加载更多" /></div></div> 
    <!-- mid end -->
    <!-- foot start -->
    <div class="foot">
    </div>
    <!-- foot end -->
</div>
</body>
<script type="text/javascript">

$.ajax({
	type:"post", 
	url:"${basePath}unreadMessageCount.do",
	success:function(data){
		var count = $.parseJSON(data);
		if(count>0){

			$("#tag").show();
		}else{

			$("#tag").hide();

		}
		

	} ,
	error:function(err){
		
	}
});

var globalPage = {   
		pageSize:10,
		pageNum:1,
    };

function ajaxappraiselistJson(flag){
	showdiv('ajaxform','评价数据加载中<br/>请稍候........ <br/> ',document.body.clientWidth,200,true);
	$.ajax({
		type:"post", 
		url:"${basePath}appraiselistJson.do",
		data:{"pageSize":globalPage.pageSize,"pageNum":globalPage.pageNum},
		success:function(page){
			page = $.parseJSON(page);
			var len = page.data.length;
			var result = page.result;
			if(flag == 1 && result == 0) {
				//初始化加载数据目录
				 $("#isnotlist").show();
				 $("#clickMore").hide();
			} else {
				$.each(page.data,function(i,n){
						str = '<a href="javascript:void(0)" class="ls">';
						str += '<span stype=" float:left;">'+n.recruitmentInformation.seUser.name+' '+n.recruitmentInformation.phone+' <BR/>'+n.applicant.name+' 24h内邀约: '
						+trunFeedback(n.invite)+'<BR/>主动反馈面试进展:  '+trunFeedback(n.feedback)+'<BR/>'+trunResult(n.result)+'</span>';
					str += '<span>'+n.formatEffectiveDate+'</span>'+
		            '</a><hr/>';
		            $("#appraiselist").append(str);
				});
				if((globalPage.pageNum)*globalPage.pageSize >= result) {
					$("#clickMore").hide();
				} else {
					globalPage.pageNum = Number(globalPage.pageNum) + 1;
					$("#clickMore").show();
				}
			}
			closediv('ajaxform');
		} ,
		error:function(err){
			
		}
	});
}
function trunFeedback(obj) {
	if(Number(obj) == 1) {
		return "<font color='red'>否</font>";
	}	else {
		return "是";
	}
}
function trunResult(obj) {
 var s = "匹配结果: ";
 var i = Number(obj);
 if(i == 0) {
	 s+="面试未过";
 }else if(i == 1) {
	 s+="培训未过";
 } else if(i == 2) {
	 s+="未签合同";
 }else if(i == 3) {
	 s+="已找其他工作";
 }else if(i == 4) {
	 s+="匹配成功";
 }
 return s;
}

$(document).ready(function(){


 	ajaxappraiselistJson(1);


	$("#loadMore").click(function () {

		ajaxappraiselistJson();
	
	});
	
});
</script>
</html>
