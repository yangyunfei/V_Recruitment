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
<title>需求更新</title>
    <style type="text/css">  
        #leo {  
            position: absolute;  
            border: 1px solid red;  
            opacity: 0.8;  
            background: yellow;  
        }  
    </style> 
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
$(function(){	
$("#applicantForm").submit(function() {
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
						closediv('ajaxform') ;
						alert(msg.info);
						$("#submitForm").attr("disabled",false); //按钮置为可用
						
						
						window.location.href="${basePath}manager.do";
					
 					
				}else{
					$("#submitForm").attr("disabled",false); //按钮置为可用
					closediv('ajaxform') ;
					alert(msg.info);
					
				}
					
				},
				error : function(json) {
					$("#submitForm").attr("disabled",false); //按钮置为可用
					closediv('ajaxform');
					alert("保存出错");
				}
			};
		showdiv('ajaxform','表单数据提交中<br/>请稍候........ <br/> ',document.body.clientWidth,200,true);
		$("#applicantForm").ajaxSubmit(options);
		return false;
	
	});
	
jQuery(window).resize(function(){

	//closediv('ajaxalert') ;
	//showdiv('ajaxalert','表单数据提交中<br/>请稍候........ <br/> ',document.body.clientWidth,200,true);
	//showdiv('ajaxlaert','表单数据提交中<br/>请稍候........ <br/> ',document.body.clientWidth);

	if(document.getElementById("ajaxform")){
		closediv('ajaxform') ;
		showdiv('ajaxform','表单数据提交中<br/>请稍候........ <br/> ',document.body.clientWidth,200,true);
		//alert("alert");
		};
	
	});

function errorshow($input,msg){


	 var x = 0;  
    var y = 35;
  $("#leo").html(msg);
  $("#leo").css({  
     "top" : ($input.offset().top + y) + "px",  
     "left" : ($input.offset().left + x) + "px"  
 }).show(10).delay(3000).hide(300,function(){
 	//$("#leo").remove();
 });

	
}


	function validation() {	 
		var remPart = $("#remPart").val().trim(); //店长手机号码
		var phone = $("#phonenumber").val().trim(); //店长手机号码
		var entryTime = $("#cardStartDate").val().trim(); //任店经理时间
		var orgName = $("#orgName").val().trim(); //店面名称
		var orgCode = $("#orgCode").val().trim(); //店编码
		var cityProperId = $("#cityProperId").val(); //所在城区
		var keyword1 = $("#keyword1").val().trim(); //关键字
		var address = $("#address").val(); //店面详细地址
		var trafficRoutes = $("#trafficRoutes").val(); //周边交通路线


		var regPhone = /^0?1[3|4|5|7|8][0-9]\d{8}$/;

		if(!regPhone.test(phone)){
			errorshow($("#phonenumber"),'输入的手机号错误！');
			$("#phonenumber").focus();
			return false;
		}
		
		if(isblank(entryTime)) {
			errorshow($("#cardStartDate"),'请选择任店经理时间！');
			$("#cardStartDate").focus();
			return false;
		}
		if(isblank(orgName)) {
			errorshow($("#orgName"),'请填写店面名称！');
			$("#orgName").focus();
			return false;
		}
		if(isblank(orgCode)) {
			errorshow($("#orgCode"),'请填写店编码！');
			$("#orgCode").focus();
			return false;
		}
		if(remPart != null && remPart != 'undefind' && remPart != '' ) {
			if(remPart.length > 30) {
				errorshow($("#remPart"),'运营大区或部门超出长度');
				$("#remPart").focus();
				return false;
			}
		}
		if(cityProperId == -1 || cityProperId == 'undefined') {
			errorshow($("#cityProperId"),'请选择所在城区！');
			$("#cityProperId").focus();
			return false;
		}
		if(isblank(keyword1)) {
			errorshow($("#keyword1"),'请填写楼盘/商圈！');
			$("#keyword1").focus();
			return false;
		}
		//if(isblank(address)) {
		//	errorshow($("#address"),'请填写店面详细地址！');
		//	$("#address").focus();
		//	return false;
	//	}

	//	if(isblank(trafficRoutes)) {
			//errorshow($("#trafficRoutes"),'请填写交通路线！');
			//$("#trafficRoutes").focus();
		//	return false;
	//	}

		 return true;
	}
});


function back()  
{  
history.go(-1); //后退1页  
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
	  	
	$("#manager").click(function(){
		window.location.href="${basePath}loginTrunZl.do";	
	});
	//跳转列表页
	$(".iconsLeft").click(function(){
		window.location.href="${basePath}trunMain.do";	
	});
	});
</script>
</head>

<body>
<div id = "leo" ></div>

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
        <form action="${basePath}updateDemand.do" name="applicantForm" method="post" id="applicantForm">
        	<div class="orderul">
        	
        	
                <ul>
                	 <div class="headinfo">个人信息</div>
                    <li class="orderullih">
                        <div class="orderullilw"><em class="red">*</em>手机号码:</div>
                        <div class="orderullirw">
                        	<input name="id" type="hidden" value="${recruitInfo.id}">
                            <input id="phonenumber" name="phone" type="text" class="contarl-input" placeholder="请输入手机号码" value="${recruitInfo.phone}"/>
                        </div>
                    </li>
                    <li class="orderullih">
                        <div class="orderullilw"><em class="red">*</em>任店经理时间:</div>
                        <div class="orderullirw">
                            <input id="cardStartDate" name="entryTime" type="text" class="contarl-input" placeholder="点击选择时间" value="${recruitInfo.entryTime }"/>
                        </div>
                    </li>
                     <div class="headinfo">店面信息</div>
                    <li class="orderullih">
                        <div class="orderullilw"><em class="red">*</em>所在店面:</div>
                        <div class="orderullirw">
                            <input id="orgName" name="orgName" type="text" class="contarl-input" placeholder="请输入店面名称" value="${recruitInfo.orgName }"/>
                        </div>
                    </li>
                    <li class="orderullih">
                        <div class="orderullilw"><em class="red">*</em>店编码:</div>
                        <div class="orderullirw">
                            <input id="orgCode" name="orgCode" type="text" class="contarl-input" placeholder="请输入店编码" value="${recruitInfo.orgCode }"/>
                        </div>
                    </li>
                    <li class="orderullih">
                        <div class="orderullilw"><em class="red">*</em>所在大区:</div>
                        <div class="orderullirw">
                            <input id="remPart" name="remPart" type="text" class="contarl-input" placeholder="请输入所属运营大区或部门" value="${recruitInfo.remPart }"/>
                        </div> 
                    </li>
                    <li class="orderulli">
                        <div class="orderullilw paddingtop"><em class="red">*</em>店面详细地址:</div>
                        <div class="orderullirw orderullirwwidth">
                            <textarea name="address" class="contral-textarea">${recruitInfo.address }</textarea>
                        </div>
                    </li>
                    <li class="orderulli">
                      <!--   <div class="orderullilw nofloat">关键词:</div> -->
                        <div class="d">
                            <div class="orderullilw"><em class="red">*</em>所在城区:</div>
                            <div class="orderullirw">
                            
                            <select class="shortselect" name="cityProper.id">
							  <c:forEach items="${cityProper}" var="area" varStatus="status">
								  <c:if test="${recruitInfo.cityProper.id.equals(area.id) }">
								 	 <option value="${area.id}" selected>${area.name }</option>
								 </c:if>
								 <c:if test="${!recruitInfo.cityProper.id.equals(area.id) }">
								 	 <option value="${area.id}">${area.name }</option>
								 </c:if>
								
                               </c:forEach>
							</select>
                            
                       <!--           <div class="select">
                                    <div class="selectname J_select" name="cityProper" value="0">请选择<span class="triangle"></span></div>
                                    <div class="selectoption" style="height: 100px;">
                                    
                                    <c:forEach items="${cityProper}" var="area" varStatus="status">
                                    <i value="${area.id }">${area.name }</i>
                                    </c:forEach>
                                    
                                <!--        <i value="0">请选择</i>
                                        <i value="1">东城</i>
                                        <i value="2">西城</i>
                                        <i value="3">朝阳</i>
                                        <i value="4">海淀</i>  -->
                            <!--          </div>
                                </div>-->
                            </div>
                            <div class="clear"></div>
                        </div>
                        <div class="d">
                            <div class="orderullilw orderullirwwidth"><em class="red">*</em>楼盘/商圈:</div>
                            <div class="orderullirw orderullirwwidth">
                                <textarea name="keyword1" id="keyword1"  placeholder="如崇文门，幸福家园，多个词用逗号隔开" class="contral-textarea">${recruitInfo.keyword1 }</textarea>
                            </div>
                            <div class="clear"></div>
                        </div>
                    </li>
                    <li class="orderulli">
                        <div class="orderullilw paddingtop"><em class="red">*</em>周边交通路线:</div>
                        <div class="orderullirw orderullirwwidth">
                            <textarea name="trafficRoutes" class="contral-textarea">${recruitInfo.trafficRoutes }</textarea>
                        </div>
                    </li>
                    <li class="orderulli">
                        <div class="orderullilw paddingtop">补充说明:</div>
                        <div class="orderullirw orderullirwwidth">
                            <textarea name="other" class="contral-textarea" placeholder="如所获荣誉、个人链家经历等">${recruitInfo.other }</textarea>
                        </div>
                    </li>
                </ul>
                <div class="btn">
                    <div class="loginbtn greenbtn"><input type="submit" value="提交" /></div>
                    <div class="clear"></div>
                </div>
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
<link href="/recruitment/style/mobiscroll.custom-2.5.0.min.css" rel="stylesheet" type="text/css" />
<script src="/recruitment/js/jquery.mobile-1.3.0.min.js" ></script>
<script data-main="scripts/main" src="/recruitment/js/mobiscroll.js" ></script>
<script>
  $(function () {

	  var cardDate=$("#cardStartDate").val();
	  
     var newjavascript={
     plugdatetime:function ($dateTxt,type) {
//     var curr = new Date().getFullYear();
       var opt = {}
       opt.time = {preset : type};
           opt.date = {preset : type};
           opt.datetime = { 
                preset : type, 
                minDate: new Date(1950,00,01), 
                maxDate: new Date(), 
                stepMinute: 1  
            };
       $dateTxt.val(cardDate).scroller('destroy').scroller(
           $.extend(opt[type], 
              	 { 
	                  preset: 'date', //日期
	                  theme: 'sense-ui', //皮肤样式
	                  display: 'modal', //显示方式 
	                  mode: 'scroller', //日期选择模式
	                  dateFormat: 'yy-mm-dd', // 日期格式
	                  setText: '确定', //确认按钮名称
	                  cancelText: '取消',//取消按钮名籍我
	                  dateOrder: 'yymmdd', //面板中日期排列格式
	                  dayText: '日', monthText: '月', yearText: '年', //面板中年月日文字
              	  }
               )
            );
      }
    }
    newjavascript.plugdatetime($("#cardStartDate"), "datetime");
});
</script>
</html>
