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
<title>我的消息列表</title>
<link rel="stylesheet" type="text/css" href="style/style.css" />
<script src="http://code.jquery.com/jquery-1.11.0.min.js"></script>
<script type="text/javascript" src="js/job.js"></script>
<script type="text/javascript" src="js/loading.js"></script>
<script type="text/javascript">
      //function Window_Load(){
     //   var str = "Tue Jul 16 01:07:00 CST 2013";
       // alert(formatCSTDate(str,"yyyy-M-d hh:mm:ss")); //2013-7-16 16:24:58
         
       // alert(formatDate((new Date()),"yyyy-MM-dd")); //2013-07-15 
       // alert(formatDate((new Date()),"yyyy/M/d")); //2013/7/15 
    //  } 
       
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
          ,hh : date.getHours()  //时
          ,mm : date.getMinutes() //分
          ,ss : date.getSeconds() //秒
        }
        format || (format = "yyyy-MM-dd hh:mm:ss");
        return format.replace(/([a-z])(\1)*/ig,function(m){return cfg[m];});
      } 
      
      $(function (){
    	  $("#manager").click(function(){
  			window.location.href="${basePath}loginTurnXq.do";	
  		});
  		
  		
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





	

	
	$("#loadMore").click(function () {



		 var pageSize= 10;
		 var pageNum = 1;


			$.ajax({
				type:"post", 
				url:"${basePath}messagelistJson.do",
				data:{"pageSize":pageSize,"pageNum":pageNum},
				success:function(page){
					page = $.parseJSON(page);
					var len = page.data.length;
					var result = page.result;
					$.each(page.data,function(i,n){
						var str = '<div class="headinfo">'+n.title+'</div>';
						if(n.matchingStateId == 1) {
							str += '<a href="${basePath}turnUpdateCandidates.do?applicantId='+n.id+'" class="ls">';
						}
						else {
							str += '<a href="javascript:void(0)" class="ls">';
						}
						str += '<span>'+n.sender.name+' 手机：'+n.sender.phone+'</span>'+
			                '<span>'+formatCSTDate(n.createTime,"MM-dd hh:mm:ss")+'</span>'+
			                '<span>'+n.RecruitmentinformationHasApplicant.applicant.name+'</span>'+
			            '</a>';
			            $("#messagelist").append(str);
					});
					$("#pageNum").val(pageNum);
					if((pageNum)*pageSize >= result) {
						$("#clickMore").hide();
					}
				} ,
				error:function(err){
					
				}
			});
			

	});
	
});
</script>-->
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
        
        <div class="list" style="padding-top: 1%;margin-top: 1%" id="messagelist">
	    	<input type="hidden" id="pageSize" name="pageSize" value="${pageSize}">
	    	<input type="hidden" id="pageNum" name="pageNum" value="${pageNum}">
	    	<input type="hidden" id="result" name="result" value="${result}">
	 		<div id="isnotlist" style="display:none; center;padding-top: 20%;">暂无消息！</div>
    	</div>
        

    	<div class="btn" id="clickMore" style="display: none;"><div class="loginbtn greenbtn"><input  id="loadMore" type="button" value="点击加载更多" /></div></div>
    </div>
    <!-- mid end -->
    <!-- foot start -->
    <div class="foot">
    </div>
    <!-- foot end -->
</div>
</body>

<script type="text/javascript">

var globalPage = {   
		pageSize:10,
		pageNum:1,
    };

function ajaxappraiselistJson(flag){
	showdiv('ajaxform','表单数据提交中<br/>请稍候........ <br/> ',document.body.clientWidth,200,true);
	$.ajax({
		type:"post", 
		url:"${basePath}messagelistJson.do",
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
	
		            var str = '<div class="headinfo">'+n.title+'</div>';
					str += '<a href="${basePath}messageDetial.do?messageId='+n.id+'" class="ls">';
					str += '<span>'+n.content+'</span>'+
		                '<span>'+n.formatCreateTime+'</span>'+
		            '</a><hr/>';
		            $("#messagelist").append(str);
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

$(document).ready(function(){

 	ajaxappraiselistJson(1);


	$("#loadMore").click(function () {

		ajaxappraiselistJson();
	
	});
	
});
</script>
</html>
