<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<title>Insert title here</title>
<jsp:include page="../inc.jsp"></jsp:include>
</head>
<body>
<div id="tt" class="easyui-tabs" style="width:6900px;">
    <div title="商铺" style="padding:20px;">
       <div id="storeTable"></div>
      <input class="btn_check" style="margin-top:10px;" type="button" value="导出" onclick="downloadTable1()" />
    </div>
    <div title="客户"  style="padding:20px;">
       <div id="cusTable"></div>
         <input class="btn_check" style="margin-top:10px;" type="button" value="导出" onclick="downloadTable2()" />
    </div>
    <div title="负责人"  style="padding:20px;">
        <div id="chargerTable"></div>
         <input class="btn_check" style="margin-top:10px;" type="button" value="导出" onclick="downloadTable3()" />
    </div>
    <div title="商铺信息跟进报表"  style="padding:20px;">
        <div id="storeInfoTable"></div>
         <input class="btn_check" style="margin-top:10px;" type="button" value="导出" onclick="downloadTable4()" />
    </div>
    <div title="客户信息跟进报表"  style="padding:20px;">
        <div id="cusInfoTable"></div>
         <input class="btn_check" style="margin-top:10px;" type="button" value="导出" onclick="downloadTable5()" />
    </div>
    <div title="商铺详情表"  style="padding:20px;">
        <div id="storeDetailTable"></div>
         <input class="btn_check" style="margin-top:10px;" type="button" value="导出" onclick="downloadTable6()" />
    </div>
    <div title="客户详情表"  style="padding:20px;">
        <div id="cusDetailTable"></div>
         <input class="btn_check" style="margin-top:10px;" type="button" value="导出" onclick="downloadTable7()" />
    </div>
    
</div>
<script type="text/javascript">
	
	function downloadTable3(){
		
		window.location.href='<%=basePath%>export/table1.do?mark=3';
	}
	function downloadTable2(){
		
		window.location.href='<%=basePath%>export/table1.do?mark=2';
	}
	function downloadTable1(){
		
		window.location.href='<%=basePath%>export/table1.do?mark=1';
	}
	function downloadTable4(){
		
		window.location.href='<%=basePath%>export/table1.do?mark=4';
	}
	function downloadTable5(){
		
		window.location.href='<%=basePath%>export/table1.do?mark=5';
	}
	function downloadTable6(){
		
		window.location.href='<%=basePath%>export/table1.do?mark=6';
	}
	function downloadTable7(){
		
		window.location.href='<%=basePath%>export/table1.do?mark=7';
	}
	
	$(function(){
		
		$('#storeTable').datagrid({
		    url:'<%=basePath%>salesManageContent.do?mark=1',
		    columns:[[
		        {field:'storeId',title:'商铺编码',width:120,align:'center'},
		        {field:'storeName',title:'商铺名称',width:300,align:'center'},
		        {field:'storeSource',title:'商铺来源',width:100,align:'center'},
		        {field:'storeCreatetime',title:'商铺录入时间',width:100,align:'center'},
		        {field:'cusId',title:'客户编码',width:120,align:'center'},
		        {field:'cusName',title:'客户名称',width:100,align:'center'},
		        {field:'industry',title:'客户行业',width:100,align:'center'},
		        {field:'cusSource',title:'客户来源',width:100,align:'center'},
		        {field:'cusCreatetime',title:'客户录入时间',width:100,align:'center'},
		        {field:'submitTime',title:'匹配创建时间',width:100,align:'center'},
		        {field:'updateTime',title:'进展更新日期',width:100,align:'center'},
		        {field:'chargerName',title:'负责人',width:80,align:'center'},
		        {field:'state',title:'当前进展',width:70,align:'center'},
		        {field:'description',title:'备注',width:800,align:'left'}
		    ]],
		    pagination:true
		});
		
		$('#cusTable').datagrid({
		    url:'<%=basePath%>salesManageContent.do?mark=2',
		    columns:[[
              	{field:'cusId',title:'客户编码',width:120,align:'center'},
		        {field:'cusName',title:'客户名称',width:100,align:'center'},
		        {field:'industry',title:'客户行业',width:100,align:'center'},
		        {field:'cusSource',title:'客户来源',width:100,align:'center'},
		        {field:'storeId',title:'商铺编码',width:120,align:'center'},
		        {field:'storeName',title:'商铺名称',width:300,align:'center'},
		        {field:'storeSource',title:'商铺来源',width:100,align:'center'},
		        {field:'storeCreatetime',title:'商铺录入时间',width:100,align:'center'},
		        {field:'cusCreatetime',title:'客户录入时间',width:100,align:'center'},
		        {field:'submitTime',title:'进展更新日期',width:100,align:'center'},
		        {field:'chargerName',title:'负责人',width:80,align:'center'},
		        {field:'state',title:'当前进展',width:70,align:'center'},
		        {field:'description',title:'备注',width:800,align:'left'}
		    ]],
		    pagination:true
		});
		
		$('#chargerTable').datagrid({
		    url:'<%=basePath%>salesManageContent.do?mark=3',
		    columns:[[
				{field:'chargerName',title:'负责人',width:80,align:'center'},
                {field:'storeId',title:'商铺编码',width:120,align:'center'},
		        {field:'storeName',title:'商铺名称',width:300,align:'center'},
		        {field:'storeSource',title:'商铺来源',width:100,align:'center'},
		        {field:'storeCreatetime',title:'商铺录入时间',width:100,align:'center'},
		        {field:'cusId',title:'客户编码',width:120,align:'center'},
		        {field:'cusName',title:'客户名称',width:100,align:'center'},
		        {field:'industry',title:'客户行业',width:100,align:'center'},
		        {field:'cusSource',title:'客户来源',width:100,align:'center'},
		        {field:'cusCreatetime',title:'客户录入时间',width:100,align:'center'},
		        {field:'submitTime',title:'进展更新日期',width:100,align:'center'},
		        {field:'state',title:'当前进展',width:70,align:'center'},
		        {field:'description',title:'备注',width:800,align:'left'}
		    ]],
		    pagination:true
		});
		
		$('#storeInfoTable').datagrid({
		    url:'<%=basePath%>getStoreTableView.do',
		    columns:[[
		        {field:'storeId',title:'商铺编码',width:120,align:'center'},
		        {field:'storeName',title:'商铺名称',width:300,align:'center'},
		        {field:'dateStr1',title:'录入时间',width:200,align:'center'},
		        {field:'source',title:'当前状态',width:100,align:'center'},
		        {field:'startSpreadDateStr',title:'开始推广日期',width:200,align:'center'},
		        {field:'endSpreadDateStr',title:'关闭推广日期',width:200,align:'center'},
		        {field:'step1',title:'推荐客户数量',width:70,align:'center'},
		        {field:'step2',title:'跟进数量',width:70,align:'center'},
		        {field:'step3',title:'带看数量',width:70,align:'center'},
		        {field:'step4',title:'洽谈数量',width:70,align:'center'},
		        {field:'step5',title:'失效数量',width:70,align:'center'},
		        {field:'isSuccess',title:'成交数量',width:70,align:'center'},
		        {field:'description',title:'备注',width:800,align:'left'}
		    ]],
		    pagination:true
		});
		
		
		$('#cusInfoTable').datagrid({
		    url:'<%=basePath%>getCusTableView.do',
		    columns:[[
		        {field:'cusId',title:'客户编码',width:120,align:'center'},
		        {field:'cusName',title:'客户名称',width:200,align:'center'},
		        {field:'dateStr1',title:'录入时间',width:100,align:'center'},
		        {field:'source',title:'当前状态',width:100,align:'center'},
		        {field:'startSpreadDateStr',title:'开始推广日期',width:80,align:'center'},
		        {field:'endSpreadDateStr',title:'关闭推广日期',width:80,align:'center'},
		        {field:'step1',title:'推荐客户数量',width:70,align:'center'},
		        {field:'step2',title:'跟进数量',width:70,align:'center'},
		        {field:'step3',title:'带看数量',width:70,align:'center'},
		        {field:'step4',title:'洽谈数量',width:70,align:'center'},
		        {field:'step5',title:'失效数量',width:70,align:'center'},
		        {field:'step6',title:'成交数量',width:70,align:'center'},
		        {field:'description',title:'备注',width:800,align:'left'}
		    ]],
		    pagination:true
		});
		
		
		$('#storeDetailTable').datagrid({
		    url:'<%=basePath%>getStoreTableView.do',
		    columns:[[
		        {field:'storeId',title:'商铺编码',width:120,align:'center'},
		        {field:'storeName',title:'商铺名称',width:300,align:'center'},
		        {field:'dateStr1',title:'录入时间',width:100,align:'center'},
		        {field:'state',title:'当前状态',width:100,align:'center'},
		        {field:'source',title:'商铺来源',width:100,align:'center'},
		        {field:'startSpreadDateStr',title:'开始推广日期',width:80,align:'center'},
		        {field:'endSpreadDateStr',title:'关闭推广日期',width:80,align:'center'},
		        {field:'step1',title:'推荐客户数量',width:70,align:'center'},
		        {field:'step2',title:'跟进数量',width:70,align:'center'},
		        {field:'step3',title:'带看数量',width:70,align:'center'},
		        {field:'step4',title:'洽谈数量',width:70,align:'center'},
		        {field:'step5',title:'失效数量',width:70,align:'center'},
		        {field:'isSuccess',title:'成交数量',width:70,align:'center'},
		        {field:'description',title:'备注',width:800,align:'left'},
		        {field:'administrativeRegionStr',title:'行政区',width:200,align:'left'},
		        {field:'businessAreaStr',title:'商圈',width:200,align:'left'},
		        {field:'building',title:'楼盘',width:200,align:'left'},
		        {field:'address',title:'物业地址',width:200,align:'left'},
		        {field:'area',title:'面积',width:200,align:'left'},
		        {field:'yearRent',title:'年租金',width:200,align:'left'},
		        {field:'dayRentPerCentare',title:'每平米日租金',width:200,align:'left'},
		        {field:'tenancy',title:'租期',width:200,align:'left'},
		        {field:'transferFee',title:'转让费',width:200,align:'left'},
		        {field:'payment',title:'付款方式',width:200,align:'left'},
		        {field:'licence',title:'营业执照',width:200,align:'left'},
		        {field:'chargerName',title:'商铺负责人',width:200,align:'left'},
		        {field:'structure',title:'结构',width:200,align:'left'},
		        {field:'layout',title:'格局',width:200,align:'left'},
		        {field:'face',title:'朝向',width:200,align:'left'},
		        {field:'height',title:'层高',width:200,align:'left'},
		        {field:'width',title:'门头宽度',width:200,align:'left'},
		        {field:'preTenant',title:'原租户业态',width:200,align:'left'},
		        {field:'water',title:'上下水',width:200,align:'left'},
		        {field:'power',title:'电量',width:200,align:'left'},
		        {field:'fire',title:'明火',width:200,align:'left'},
		        {field:'wind',title:'排风',width:200,align:'left'},
		        {field:'gas',title:'燃气',width:200,align:'left'},
		        {field:'lessorType',title:'出租方',width:200,align:'left'},
		        {field:'lessorName',title:'出租方姓名',width:200,align:'left'},
		        {field:'lessorPhone',title:'出租方联系方式',width:200,align:'left'},
		        {field:'lessorCharge',title:'出租方提供佣金',width:200,align:'left'},
		        {field:'agentNumber',title:'经纪人系统号',width:200,align:'left'},
		        {field:'agentName',title:'经纪人姓名',width:200,align:'left'}
		    ]],
		    pagination:true
		});
		
		
		$('#cusDetailTable').datagrid({
		    url:'<%=basePath%>getCusTableView.do',
		    columns:[[
		        {field:'cusId',title:'客户编码',width:120,align:'center'},
		        {field:'cusName',title:'客户名称',width:200,align:'center'},
		        {field:'dateStr1',title:'录入时间',width:100,align:'center'},
		        {field:'state',title:'当前状态',width:100,align:'center'},
		        {field:'startSpreadDateStr',title:'开始推广日期',width:80,align:'center'},
		        {field:'endSpreadDateStr',title:'关闭推广日期',width:80,align:'center'},
		        {field:'step1',title:'推荐客户数量',width:70,align:'center'},
		        {field:'step2',title:'跟进数量',width:70,align:'center'},
		        {field:'step3',title:'带看数量',width:70,align:'center'},
		        {field:'step4',title:'洽谈数量',width:70,align:'center'},
		        {field:'step5',title:'失效数量',width:70,align:'center'},
		        {field:'step6',title:'成交数量',width:70,align:'center'},
		        {field:'description',title:'备注',width:200,align:'left'},
		        
		        {field:'phone',title:'客户联系方式',width:200,align:'left'},
		        {field:'industry',title:'客户行业',width:200,align:'left'},
		        {field:'rentMin',title:'年租金最小值',width:200,align:'left'},
		        {field:'rentMax',title:'年租金最大值',width:200,align:'left'},
		        {field:'areaMin',title:'面积最小值',width:200,align:'left'},
		        {field:'areaMax',title:'面积最大值',width:200,align:'left'},
		        {field:'targetAreaStr',title:'目标行政区',width:200,align:'left'},
		        {field:'label',title:'客户标签',width:200,align:'left'},
		        {field:'source',title:'客户来源',width:200,align:'left'},
		        {field:'agentNumber',title:'经纪人系统号',width:200,align:'left'},
		        {field:'agentName',title:'经纪人姓名',width:200,align:'left'}
		    ]],
		    pagination:true
		});
		
	})
</script>
</body>
</html>