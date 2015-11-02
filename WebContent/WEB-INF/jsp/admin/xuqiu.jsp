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
<title>我的招聘推荐-招聘需求</title>
<link href="style/semanagercss.css"  type="text/css" rel="stylesheet" />
<script type="text/javascript" src="http://code.jquery.com/jquery-1.11.0.min.js"></script>
<script src="js/semanagerjs.js"></script>
<script language="javascript" type="text/javascript" src="<%=basePath%>js/My97DatePicker/WdatePicker.js"></script>
<link rel="stylesheet" type="text/css"
	href="jquery-ui/css/smoothness/jquery-ui.min.css" />
<script src="js/semanagerjs.js"></script>
<script type="text/javascript" src="jqGrid-4.6.0/js/jquery.jqGrid.src.js"></script>
<script type="text/javascript" src="jqGrid-4.6.0/js/i18n/grid.locale-cn.js"></script>
<link rel="stylesheet" type="text/css"
	href="jqGrid-4.6.0/css/ui.jqgrid.css" />
	<script type="text/javascript">
 	$(document).ready(function() {
	
    $("#clientList").jqGrid({
        url: "${basePath}back/recruitmentNeedsBackList",
        type: "POST",
        pgbuttons:true ,
        datatype: "json",
        mtype : "POST" ,
        colNames: [
			"编号","发布编码","发布时间","发布状态","发布人姓名","系统号","店面编码",
			"店面地址关键字","详情地址","周边交通路线","其它"
		],
        colModel: [{
            name: "no",
            index: "no",
            sortable:false,
        },{
            name: "recruitmentCode",
            index: "recruitmentCode",
            sortable:false,
        },{
			name: "releaseTime",
			index: "releaseTime",
			sortable:false,
        },{
			name: "releaseCode",
			index: "releaseCode",
			sortable:false,
        },{
			name: "releaseName",
			index: "releaseName",
			sortable:false,
        },{
			name: "orgId",
			index: "orgId",
			sortable:false,
        },{
			name: "shopCode",
			index: "shopCode",
			sortable:false,
        },{
			name: "shopKey",
			index: "shopKey",
			sortable:false,
        },{
			name: "detailedAddress",
			index: "detailedAddress",
			sortable:false,
        },{
			name: "roundAddress",
			index: "roundAddress",
			sortable:false,
        },{
			name: "remarks",
			index: "remarks",
			sortable:false,
        }
        
        ],
        jsonReader: {
            root: "data",
            repeatitems: false
        },
        rowNum: 10,
        height: 350,
        width: $("#clientList").parent().innerWidth()-4,
        scrollOffset: 0,
        forceFit: true,
        pager: "#clientListPager",
        viewrecords: true,
        beforeRequest: housesQuery,
		//gridComplete:missionListGridComplete
        loadComplete: function(data) {
        	var $this = $(this);
        	var clients = data.data;
            var rows = $this.jqGrid("getDataIDs");
            for(var index in clients)
            {
                var client = clients[index];
                $this.jqGrid("setRowData", rows[index], {
					no : Number(index)+1
				});
            }
      }
    });
    
    var newQuery = false;
	$("#searchNews").click(function(){
		query();
		newQuery = true;
	});
	function query() {
		$("#clientList").trigger("reloadGrid");
	}
	
	function housesQuery() {
		var postData = $("#clientList").jqGrid("getGridParam", "postData");
			if(newQuery) {
		 		postData["page"] = 1;
			}
			postData["releaseTime"] = $("#releaseTime").val();
			postData["releaseTimeEnd"] = $("#releaseTimeEnd").val();
			postData["cityPoperId"] = $("#cityProperId").val();
			postData["addressKey"] = $("#refereeId").val();
			newQuery = false;
	}
	
	$("#xqBackExport").click(function(){
		$("#releaseTimeHid").val($("#releaseTime").val());
		$("#releaseTimeEndHid").val($("#releaseTimeEnd").val());
		$("#cityPoperIdHid").val($("#cityProperId").val());
		$("#addressKeyHid").val($("#refereeId").val());
		$("#formId").submit();
	});
    
});
</script>	
</head>
<body>
<div class="main">
    <div class="top">
        <div class="contain">
            <div class="l"><a href="#"> </a></div>
            <div class="r">
                <div class="nav">
                    <ul>
                        <li class="right">
                            <a href="#">您好：超级管理员</a>
                            <a href="${basePath}back/backlogout" class="u1">[退出]</a>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
    <div class="mid">
        <div class="contain">
        <form id="formId" method="post" action="${basePath}back/recruitmentNeedsBackListExport">
        	<input type="hidden" name="releaseTime" id="releaseTimeHid">
        	<input type="hidden" name="releaseTimeEnd" id="releaseTimeEndHid">
        	<input type="hidden" name="cityPoperId" id="cityPoperIdHid">
        	<input type="hidden" name="addressKey" id="addressKeyHid">
        </form>
            <div class="content">
                <div class="l">
                    <div class="panel">
                        <div class="topbtn">我的微招聘</div>
                        <ul>
                            <a href="${basePath}back/trunXq.do"><li class="action">招聘需求信息</li></a>
                            <a href="${basePath}back/trunTj.do"><li>招聘推荐结果</li></a>
                            <!--  <a href="${basePath}back/trunMy.do"><li style="border-bottom:#ddd 1px solid;">店长名誉列表</li></a>-->
                        </ul>
                    </div>
                </div>
                <div class="r">
                    <div class="border"></div>
                    <div class="dtable">
                        <table class="layouttable">
                            <thead>
                                <tr>
                                    <th colspan="10" class="tha">
                                        <span class="addbtn" id="xqBackExport">
                                            导出
                                        </span>
                                        <span class="a ab">发布时间：<i class="shortl100"><input type="text" id="releaseTime" name="releaseTime" class="Wdate" onClick="WdatePicker()" /></i>
                                        </span>
                                        <span class="a ab">至
                                        <i class="shortl100"><input type="text" id="releaseTimeEnd" name="releaseTimeEnd" class="Wdate" onClick="WdatePicker()" /></i>
                                        </span>
                                        <span class="a ab">所在城区：
                                         <select class="shortselect" name="cityProper" id="cityProperId">
                                           <option value="-1" selected>点击选择城区</option>
										  <c:forEach items="${cityProper}" var="area" varStatus="status">
										 	 <option value="${area.id}">${area.name}</option>
			                              </c:forEach>
										</select>
                                        </span>
                                        <span>
                                        </span>
                                    </th>
                                </tr>
                                 <tr>
                                    <th colspan="10" class="tha">
                                        <span style="padding-left:99px;">
                                        </span>
                                        <span class="a ab">所在大区：<i class="lang" style="width: 240px;"><input type="text" id="refereeId" name="refereeId" maxlength="30" placeholder="请输入大区名称" /></i>
                                        </span>
                                        <span class="cbtn" id="searchNews">
                                            搜 索
                                        </span>
                                    </th>
                                </tr>
                            </thead>
                            <tbody>
                            </tbody>
                        </table>
                     <div class="tabdiv">
							<table id="clientList"></table>
                    	    <div id="clientListPager"></div>
               		 </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="end">
        
    </div>  
</div>
</body>
</html>
