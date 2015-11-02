<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
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
<title>评价消息</title>
<link rel="stylesheet" type="text/css" href="style/style.css" />
<script src="http://code.jquery.com/jquery-1.11.0.min.js"></script>
<script type="text/javascript" src="js/job.js"></script>
<script type="text/javascript" src="js/jquery.form.js"></script>
<script type="text/javascript" src="js/loading.js"></script>
<style type="text/css">
    #leo {  
            position: absolute;  
            border: 1px solid red;  
            opacity: 0.8;  
            background: yellow;  
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
    .radioClass{
    	width:20%;
    } 
    .orderullilws{ 
    	float:left; width:110px;  color:#999;
    	line-height: 30px;}
    .orderullirws{ float:right; width:55%;line-height: 30px;padding-top: 12px;}
    .orderullirw {
    	line-height: 40px;
    }
</style>
<script type="text/javascript">
$(function(){
	
  //判断修改时是否出现评价按钮
  if('${vo.state}' == 0 || '${vo.state}' == '') {
	  $("#submitBtn").show();
  }else {
	  $("#submitBtn").hide();
	  $("input").attr("readonly","readonly"); //将输入框设置为只读
	  $("select").prop("disabled", true);
	   var input = $("#disabledDiv").find("input:radio");
	   input.attr("disabled","disabled");
	   input.each(function(){
	        $(this).attr("disabled",true);
	   });
  }
  
  //判断修改时是否出现新人系统号	
  if('${vo.resultSelect}' == 4) {
	  $(".hidSystem").show();
  }else 
  	  $(".hidSystem").hide(); //默认不显示
  $("#resultSelect").change(function(){
	  if($(this).val() == '4' || $(this).val() == 4)
		  $(".hidSystem").show();
	  else 
		  $(".hidSystem").hide();
  });
  
  
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
						window.location.href= "${basePath}assistantView.do?matchFlag=2";
				}else{
					$("#submitForm").attr("disabled",false); //按钮置为可用
				//	document.getElementById("ifr_div").style.display="none";
					closediv('ajaxform');
					alert(msg.info);
				}
					
				},
				error : function(json) {
					console.log(json);
					$("#submitForm").attr("disabled",false); //按钮置为可用1
					closediv('ajaxform');
					alert("评价出错");
					
					
				}
			};
		
		showdiv('ajaxform','表单数据提交中<br/>请稍候........ <br/> ',document.body.clientWidth,200,true);
		$("#applicantFormSub").ajaxSubmit(options);
		return false;

	});

		
		function validation() {
			//数据验证
			var hours = $("#hours24").val(); //24小时内邀约
			var facting = $("#facting").val(); //主动反馈面试进度
			var resultSelect = $("#resultSelect").val();//匹配结果
			var newOrgId = $("#newOrgId").val();//匹配结果
			/*if(hours == '' || hours == 'undefined') {
				errorshow($("#hours24"),'请选择24小时内邀约！');
				$("#hours24").focus();
				return false;
			}
			if(facting == '' || facting == 'undefined') {
				errorshow($("#facting"),'请选择主动反馈面试进度！');
				$("#facting").focus();
				return false;
			}**/
			if(resultSelect == -1 || resultSelect == 'undefined') {
				errorshow($("#resultSelect"),'请选择匹配结果！');
				$("#resultSelect").focus();
				return false;
			}else if(resultSelect == 4 || resultSelect == '4'){
				if(newOrgId == '' || newOrgId == 'undefined') {
					errorshow($("#newOrgId"),'请填写新人系统号！');
					$("#newOrgId").focus();
					return false;
				}else if(newOrgId.length != 8) {
					errorshow($("#newOrgId"),'新人系统号长度必须为8位！');
					$("#newOrgId").focus();
					return false;
				}
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
	      	//$("#leo").remove();
	      });

			
		}

		$(".iconsLeft").click(function(){
			window.location.href="${basePath}trunApplicantPage.do";	
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
            <div class="iconsLeft">&lt;&nbsp;我要推荐
			</div>
            <div class="iconNone">
                &nbsp;
            </div>
        </header>
    </div>
    <!-- head end -->
    <!-- mid start -->
    <div class="mid" id="disabledDiv">
        <form action="${basePath}saveAppraiseInfo.do" name="applicantFormSub" method="post" id="applicantFormSub">
        <input name="applicantId" type="hidden" id="applicantId" value="${vo.applicantId}">
        	<div class="orderul">
                <ul>
                 <div class="headinfo">需求方信息</div>
                 <li class="orderulli">
                        <div class="d">
                            <div class="orderullilw"><em class="red">*</em>姓名:</div>
                            <div class="orderullirw">
                            ${vo.recruitmentName}
                      		</div>
                            <div class="clear"></div>
                        </div>
                   </li>
                   <li class="orderulli">
                        <div class="d">
                            <div class="orderullilw"><em class="red">*</em>联系方式:</div>
                            <div class="orderullirw">
                            ${vo.recruitmentPhone}
                      		</div>
                            <div class="clear"></div>
                        </div>
                   </li>
                    <li class="orderulli">
                        <div class="orderullilw paddingtop"><em class="red">*</em>店面名称:</div>
                        <div class="orderullirw orderullirwwidth">
                            <textarea name="orgName" readonly="readonly" disabled="disabled" class="contral-textarea" id="orgName"  readonly="readonly">${vo.orgName}</textarea>
                        </div>
                    </li>
                <div class="headinfo">应聘者信息</div>
                  <li class="orderulli">
                        <div class="d">
                            <div class="orderullilw"><em class="red">*</em>姓名:</div>
                            <div class="orderullirw">
                            ${vo.applicantName}
                      		</div>
                            <div class="clear"></div>
                        </div>
                   </li>
                  <li class="orderulli">
                        <div class="d">
                            <div class="orderullilw"><em class="red">*</em>联系方式:</div>
                            <div class="orderullirw">
                            ${vo.applicantPhone}
                      		</div>
                            <div class="clear"></div>
                        </div>
                   </li>
                   <div class="headinfo">评价内容</div>
                   <li class="orderulli">
                        <div class="d">
                            <div class="orderullilw"><em class="red">*</em>24h内邀约:</div>
                            <div class="orderullirw">
                                	<input type="radio" <c:if test="${vo.hours24 == 0 || vo.hours24 == null}">checked="checked"</c:if> class="radioClass" name="hours24" value="0">是
                                	<input type="radio" <c:if test="${vo.hours24 == 1}">checked="checked"</c:if> class="radioClass" name="hours24" value="1">否
                      		</div>
                            <div class="clear"></div>
                        </div>
                      </li>
                    <li class="orderullis">
                        <div class="d">
                            <div class="orderullilws"><em class="red">*</em>主动反馈<br/>&nbsp;面试进展:</div>
                            <div class="orderullirws">
                                	<input type="radio" <c:if test="${vo.facting == 0 || vo.facting == null}">checked="checked"</c:if>  class="radioClass" name="facting" value="0">是
                                	<input type="radio" <c:if test="${vo.facting == 1}">checked="checked"</c:if> class="radioClass" name="facting" value="1">否
                      		</div>
                            <div class="clear"></div>
                        </div>
                      </li>
                      <li class="orderulli">
                        <div class="d">
                            <div class="orderullilw"><em class="red">*</em>匹配结果:</div>
                            <div class="orderullirw">
                                	<select class="shortselect" id="resultSelect" name="resultSelect">
                                		<option value="-1">请选择</option>
                                		<option value="0" <c:if test="${vo.resultSelect == 0}">selected</c:if>>面试未过</option>
                                		<option value="1" <c:if test="${vo.resultSelect == 1}">selected</c:if>>培训未过</option>
                                		<option value="2" <c:if test="${vo.resultSelect == 2}">selected</c:if>>未签合同</option>
                                		<option value="3" <c:if test="${vo.resultSelect == 3}">selected</c:if>>已找其他工作</option>
                                		<option value="4" <c:if test="${vo.resultSelect == 4}">selected</c:if>>已入职</option>
                                	</select>
                      		</div>
                            <div class="clear"></div>
                        </div>
                      </li>
                    <li class="hidSystem orderullih" >
                        <div class="orderullilw"><em class="red">*</em>新人系统号:</div>
                        <div class="orderullirw">
                            <input id="newOrgId" name="newOrgId" type="text" class="contarl-input" placeholder="请输入新人系统号" maxlength="8" value="${vo.newOrgId}"/>
                        </div>
                    </li>
                </ul>
                <div id="submitBtn" class="btn"><div class="loginbtn greenbtn"><input type="submit" id="submitForm" value="评价" /></div></div>
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
