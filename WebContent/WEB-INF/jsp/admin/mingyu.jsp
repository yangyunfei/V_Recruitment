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
<title>我的招聘推荐-店长名誉</title>
<link href="style/semanagercss.css"  type="text/css" rel="stylesheet" />
<script src="http://code.jquery.com/jquery-1.11.0.min.js"></script>
<script src="js/semanagerjs.js"></script>
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
        url: "${basePath}back/rmanagerReputationBackList",
        type: "POST",
        pgbuttons:true ,
        datatype: "json",
        mtype : "POST" ,
        colNames: [
			"系统号", "店长姓名","信誉级别","“是”/“否”次数","备注"
		],
        colModel: [{
            name: "recommendedCode",
            index: "recommendedCode",
            sortable:false,
        },{
            name: "orgName",
            index: "orgName",
            sortable:false,
        },{
			name: "honorLevel",
			index: "honorLevel",
			sortable:false,
        },{
			name: "yes",
			index: "yes",
			sortable:false,
        },{
			name: "remark",
			index: "remark",
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
                
                $this.jqGrid("setRowData", rows[index], {
					yes : client.yes +"/"+client.no
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
			postData["refereeId"] = $("#refereeId").val();
			postData["honorLevel"] = $("#honorLevel").val();
			newQuery = false;
	}
    
	
	$("#managerBackExport").click(function(){
		window.location.href="${basePath}back/managerReputationBackExport";
	});
});
</script>	
</head>
<body>
<div class="main">
    <div class="top">
        <div class="contain">
            <div class="l"><a class="logo" href="#"> </a></div>
            <div class="r">
                <div class="nav">
                    <ul>
                        <li class="right">
                            <a href="#">您好：段江航</a>
                            <a href="#" class="u1">[退出]</a>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
    <div class="mid">
        <div class="contain">
            <div class="content">
                <div class="l">
                    <div class="panel">
                        <div class="topbtn">我的招聘推荐</div>
                        <ul>
                            <a href="${basePath}back/trunXq.do"><li>招聘需求信息</li></a>
                            <a href="${basePath}back/trunTj.do"><li>招聘推荐结果</li></a>
                            <a href="${basePath}back/trunMy.do"><li class="action" style="border-bottom:#ddd 1px solid;">店长名誉列表</li></a>
                        </ul>
                    </div>
                </div>
                <div class="r">
                    <div class="border"></div>
                    <div class="dtable">
                        <table class="layouttable">
                            <thead>
                                <tr>
                                    <th colspan="8" class="tha">
                                        <span class="addbtn" id="managerBackExport">
                                            导出
                                        </span>
                                        <span class="a ab">系统号：<i class="lang"><input type="text" name="userId" id="refereeId" placeholder="请输入系统号" /></i>
                                        </span>
                                        <span class="a ab">信誉级别：<i class="lang"><input type="text" name="honorLevel" id="honorLevel" placeholder="请输入系统号" /></i>
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
                    </div>
                     <div class="tabdiv">
							<table id="clientList"></table>
                    	    <div id="clientListPager"></div>
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
