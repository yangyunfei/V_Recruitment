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
<title>需求详情</title>
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
</script>
</head>

<body>
<div class="main">
    <!-- head start -->
    <div class="head">
        <header>
             <div class="goback"><span></span>
            	<input type="button" value="返回" onclick="manager()" style="background:none;padding-top: 0;padding-bottom:0;font-size: 15px;line-height: 20px;">
            </div>
            需求详情
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
                    <li class="orderullih">
                        <div class="orderullilw">手机号码:</div>
                        <div class="orderullirw">
                        	
                            ${recruitInfo.phone}
                        </div>
                    </li>
                    <li class="orderullih">
                        <div class="orderullilw">任店经理时间:</div>
                        <div class="orderullirw">
                           ${recruitInfo.entryTime }
                        </div>
                    </li>
                    <li class="orderullih">
                        <div class="orderullilw"><em class="red">*</em>所在店面:</div>
                        <div class="orderullirw">
                            ${recruitInfo.orgName }
                        </div>
                    </li>
                    <li class="orderullih">
                        <div class="orderullilw"><em class="red">*</em>店编码:</div>
                        <div class="orderullirw">
                            <input id="orgCode" name="orgCode" type="text" class="contarl-input" placeholder="请输入店编码" value="${recruitInfo.orgCode }"/>
                        </div>
                    </li>
                    <li class="orderulli">
                      <!--   <div class="orderullilw nofloat">关键词:</div> -->
                        <div class="d">
                            <div class="orderullilw"><em class="red">*</em>城区:</div>
                            <div class="orderullirw">
                            
                            ${recruitInfo.cityProper.name }
                            
                 <!--          <select class="shortselect" name="cityProper.id">
							  <c:forEach items="${cityProper}" var="area" varStatus="status">
								  <c:if test="${recruitInfo.cityProper.id.equals(area.id) }">
								 	 <option value="${area.id }" selected>${area.name }</option>
								 </c:if>
								 <c:if test="${!recruitInfo.cityProper.id.equals(area.id) }">
								 	 <option value="${area.id }">${area.name }</option>
								 </c:if>
								
                               </c:forEach>
							</select> -->  
                            
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
                            <div class="orderullilw"><em class="red">*</em>楼盘/地标:</div>
                            <div class="orderullirw">
                               ${recruitInfo.saleOrlandmarks }
                            </div>
                            <div class="clear"></div>
                        </div>
                        <div class="d">
                            <div class="orderullilw orderullirwwidth">关键字（可填写多个，用逗号分割。）:</div>
                            <div class="orderullirw orderullirwwidth">
                                ${recruitInfo.keyword1 }
                            </div>
                            <div class="clear"></div>
                        </div>
                    </li>
                    <li class="orderulli">
                        <div class="orderullilw paddingtop"><em class="red">*</em>店面地址:</div>
                        <div class="orderullirw orderullirwwidth">
                            ${recruitInfo.address }
                        </div>
                    </li>
                    <li class="orderulli">
                        <div class="orderullilw paddingtop"><em class="red">*</em>周边交通路线:</div>
                        <div class="orderullirw orderullirwwidth">
                            ${recruitInfo.trafficRoutes }
                    </li>
                    <li class="orderulli">
                        <div class="orderullilw paddingtop">其他:</div>
                        <div class="orderullirw orderullirwwidth">
                           ${recruitInfo.other }
                        </div>
                    </li>
                </ul>
               
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
</html>
