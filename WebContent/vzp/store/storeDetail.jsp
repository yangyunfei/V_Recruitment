<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/easyui.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/icon.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/demo.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/main.css">

<script type="text/javascript" src="<%=basePath %>js/jquery.min.js"></script>
<script type="text/javascript" src="<%=basePath %>js/jquery.easyui.min.js"></script>


<title>店铺详情</title>
<style type="text/css">
	
	*{
		font-family:Microsoft Yahei;
	}
	
	h1{
		font-size: 16px;
	}
	
	h2{
		font-size: 15px;
		color:#1494FF;
		text-align: center;
	}
	
	hr{
		border: 1px solid #ECECEC;
		}
	
	.wrapper{
		width:420px;
		float:left;
	}
	
	
	.top, .bigImg , .center{
		width:100%;
	}
	
	.center{
		margin-top: 8px;
		height: 97px;
	}
	
	.smallImg{
		float: left; 
		width:32%;
		height:90px;
	}
	
	.smallImg + .smallImg{
		margin-left: 8px;
	}
	
	.content{
		float:left;
		padding-left: 50px;
	}
	
	.name,.cusName{
		font-size:14px;
		color:#1494FF;
		font-weight:bold;
	}
	
	.cusName{
		border-bottom: 1px solid #1494FF;
		cursor:pointer;
	}
	
	.bottom{
		width:100%;
		height:146px;
		border:1px dashed  #BCBCBC;
		margin-top: 24px;
		overflow: auto;
	}
	.table{
		clear: both;
		float: none;
		border-collapse: collapse;
        border: none;
        background:#F4F2F2;
	}
	
     td
     {
         border: solid #D8D7D7 1px;
     } 
	
	.firstTr td{
		width: 290px;
		text-align: center;
		height: 30px;
		font-size: 15px;
		font-weight: bold;
		color: #6F6F6F;
	}
	.secondTr td{
		padding-left:20px;
	}
	
	.table p+p{
	 margin-top:-10px;
	}
	
	.table2{
		border-collapse: collapse;
        border: none;
        background:#F4F2F2;
        width: 1173px;
        font-size:14px;
        text-align: center;
        margin-top: 15px;
	}
	
	.table2 tr:first-child td {
		
		height: 30px;
		font-size: 15px;
		font-weight: bold;
		color: #FFFFFF;
		background:#1394FE;
	}
	
	.tdLeft{
		text-align: left;
	}
	
	.table2 td{
		border:none;
	}
	
	.table2 tr{
		border-bottom:solid #D8D7D7 1px;
	}
	
	.content p+p{
		
		margin-top:-8px;
	}
	
	
</style>
</head>
<body>
<h1>${store.store_name }</h1>
<hr />

<div  class="ww">
	<div class="wrapper">
		<div class="top">
			<img class="bigImg" alt="" src="${imgurl}${store.img1}"/>
		</div>
		<div class="center">
			<img class="smallImg" alt="" src="${imgurl}${store.img1}" />
			<img class="smallImg" alt="" src="${imgurl}${store.img2}" />
			<img class="smallImg" alt="" src="${imgurl}${store.img3}" />
		</div>
		<div class="bottom">
			<h2>商铺描述</h2>
			<p>
			<span class="name">特色：</span>
			<span class="val">${store.characteristic }</span>
		    </p>
			<span class="name">其它描述：</span><br/>
			<p>${store.description }</p><br/>
		</div>
	</div>
	<div class="content">
		<p>
			<span class="name">商铺名称：</span>
			<span class="val">${store.store_name }</span>
		</p>
		<p>
			<span class="name">商铺编号：</span>
			<span class="val">${store.store_id }</span>
		</p>
		<p>
			<span class="name">商铺状态：</span>
			<span class="val">
				<c:if test="${store.state=='1'}">成交</c:if>
				<c:if test="${store.state=='2'}">未成交</c:if>
			</span>
		</p>
		<p>
			<span class="name">商铺来源：</span>
			<span class="val">
			<c:if test="${store.source=='1'}">当前推广</c:if>
			<c:if test="${store.source=='2'}">库存</c:if>
			<c:if test="${store.source=='3'}">经纪人推荐</c:if>
			</span>
		</p>
		<p>
			<span class="name">录入时间：</span>
			<span class="val">${store.createtime }</span>
		</p>
		<p>
			<span class="name">客户推荐数量：</span>
			<span class="val">${store.step1 }</span>
		</p>
		<p>
			<span class="name">行政区：</span>
			<span class="val">${administrativeRegion.name }</span>
		</p>
		<p>
			<span class="name">商圈：</span>
			<span class="val">${businessArea.name }</span>
		</p>
		<p>
			<span class="name">楼盘及幢号：</span>
			<span class="val">${store.building }</span>
		</p>
		<p>
			<span class="name">门牌号：</span>
			<span class="val">${store.houseNum }</span>
		</p>
		<p>
			<span class="name">物业地址：</span>
			<span class="val">${store.address }</span>
		</p>
		<p>
			<span class="name">原商户名称：</span>
			<span class="val">${store.oldName }</span>
		</p>
		
		<p>
			<span class="name">面积：</span>
			<span class="val">${store.area }（平方米）</span>
		</p>
		<p>
			<span class="name">年租金：</span>
			<span class="val">${store.year_rent }（元）</span>
		</p>
		<p>
			<span class="name">每平米日租金：</span>
			<span class="val">${store.day_rent_per_centare }（元）</span>
		</p>
		<p>
			<span class="name">租期：</span>
			<span class="val">${store.tenancy }（年）</span>
		</p>
		<p>
			<span class="name">转让费：</span>
			<span class="val">${store.transfer_fee }（元）</span>
		</p>
		<p>
			<span class="name">付款方式：</span>
			<span class="val">
			<c:if test="${store.payment=='month'}">月付</c:if>
			<c:if test="${store.payment=='3month'}">季付</c:if>
			<c:if test="${store.payment=='6month'}">半年付</c:if>
			<c:if test="${store.payment=='12month'}">年付</c:if>
			</span>
		</p>
		<p>
			<span class="name">营业执照：</span>
			<span class="val">
			<c:if test="${store.licence=='available'}">可办照</c:if>
			<c:if test="${store.licence=='unavailable'}">不可办照</c:if>
			</span>
		</p>
		<p>
			<span class="name">商铺负责人：</span>
			<span class="val">${charger.name }（${charger.phone }）</span>
		</p>
		<p>
			<span class="name">商铺维护人：</span>
			<span class="val">${maintainer.name }（${maintainer.phone }）</span>
		</p>
		<p>
			<span class="name">商铺权重：</span>
			<span class="val">${store.weight }</span>
		</p>
	</div>
</div>

<table class="table">
	<tr class="firstTr">
		<td><span>物理属性</span></td>
		<td>经营属性</td>
		<td>出租方信息</td>
		<td>经纪人信息</td>
	</tr>
	<tr class="secondTr">
		<td>
			<p style="margin-top:-12px;">
			<span class="name">结构：</span><span class="val">
			<c:if test="${fn:contains(store.structure,'1')}">一层</c:if>
			<c:if test="${fn:contains(store.structure,'2')}">二层</c:if>
			<c:if test="${fn:contains(store.structure,'3')}">三层</c:if>
			<c:if test="${fn:contains(store.structure,'4')}">四层</c:if>
			<c:if test="${fn:contains(store.structure,'-1')}">地下室</c:if>
			</span></p>
			<p><span class="name">格局：</span><span class="val">
			<c:if test="${store.layout=='1'}">格局方正</c:if>
			<c:if test="${store.layout=='2'}">承重墙多</c:if>
			</span></p>
			<p><span class="name">朝向：</span><span class="val">
			<c:if test="${store.face=='east'}">东</c:if>
			<c:if test="${store.face=='south'}">南</c:if>
			<c:if test="${store.face=='west'}">西</c:if>
			<c:if test="${store.face=='north'}">北</c:if>
			<c:if test="${store.face=='northeast'}">东北</c:if>
			<c:if test="${store.face=='southeast'}">东南</c:if>
			<c:if test="${store.face=='northwest'}">西北</c:if>
			<c:if test="${store.face=='southwest'}">西南</c:if>
			</span></p>
			<p><span class="name">层高：</span><span class="val">${store.height }（米）</span></p>
			<p><span class="name">门头宽度：</span><span class="val">${store.width }（米）</span></p>
		</td>
		<td>
			
			<p><span class="name">上下水：</span><span class="val">
			<c:if test="${store.water=='up'}">上水</c:if>
			<c:if test="${store.water=='down'}">下水</c:if>
			<c:if test="${store.water=='updown'}">上下水</c:if>
			<c:if test="${store.water=='none'}">无</c:if>
			</span></p>
			<p><span class="name">电量：</span><span class="val">
			<c:if test="${store.power=='1'}">满足高用电</c:if>
			<c:if test="${store.power=='2'}">不满足高用电</c:if>
			<c:if test="${store.power=='3'}">不满足可增容</c:if>
			</span></p>
			<p><span class="name">明火：</span><span class="val">
			<c:if test="${store.fire=='1'}">可起明火</c:if>
			<c:if test="${store.fire=='2'}">不可起明火</c:if>
			</span></p>
			<p><span class="name">排风：</span><span class="val">
			<c:if test="${store.wind=='has'}">有排风</c:if>
			<c:if test="${store.wind=='none'}">无排风</c:if>
			</span></p>
			<p><span class="name">燃气：</span><span class="val">
			<c:if test="${store.gas=='has'}">有燃气</c:if>
			<c:if test="${store.gas=='none'}">无燃气</c:if>
			</span></p>
			<p><span class="name">当前业态：</span><span class="val">${store.pre_tenant }</span></p>
			<p><span class="name">可经营业态：</span><span class="val">${store.can_tenant }</span></p>
		</td>
		<td>
			<p style="margin-top:-38px;"><span class="name">出租方:</span>
			<span class="val">
			<c:if test="${store.lessor_type=='owner'}">业主</c:if>
			<c:if test="${store.lessor_type=='agent'}">二房东</c:if>
			<c:if test="${store.lessor_type=='proxyer'}">业主代理人</c:if>
			</span></p>
			<p><span class="name">出租方姓名:</span><span class="val">${store.lessor_name }</span></p>
			<p><span class="name">出租方联系方式:</span><span class="val">${store.lessor_phone }</span></p>
			<p><span class="name">出租方提供佣金:</span><span class="val">${store.lessor_charge }（元）</span></p>
            <p><span class="name">委托获取方式：</span><span class="val">
			<c:if test="${store.info_source=='1'}">业主报盘</c:if>
			<c:if test="${store.info_source=='2'}">社区开发</c:if>
			<c:if test="${store.info_source=='3'}">网络搜索</c:if>
			<c:if test="${store.info_source=='4'}">他人推荐</c:if>
			<c:if test="${store.info_source=='5'}">其它</c:if>
			</span></p>		
		</td>
		<td>
			<p style="margin-top:-66px;"><span class="name">经纪人系统号：</span><span class="val">${store.agent_number }</span></p>
			<p><span class="name">经纪人姓名：</span><span class="val">${store.agent_name }</span></p>
			<p><span class="name">经纪人联系方式：</span><span class="val">${store.agent_phone }</span></p>
			<p><span class="name">是否愿意提供带看服务：</span><span class="val">${store.agent_will_assist }</span></p>
			
		</td>
	</tr>
</table>


<table class="table2">
	 <tr>
		<td style="width: 100px;">约看客户</td> <td style="width: 100px;">客户行业</td> <td style="width: 100px;">带看日期</td> <td style="width: 100px;">更新日期</td>
		<td style="width: 100px;">带看人</td> <td style="width: 100px;">订单状态</td> <td style="width: 17%;">备注</td>
	</tr>
	<c:forEach items="${examples }" var="em" varStatus="status">
		<tr>
			<td > <span class="cusName" cusId="${em.customer.id }" cpId="${em.customer.cus_id }">${em.customer.name }</span></td>
				<td>${em.customer.industry }</td>
				<td><fmt:formatDate value="${em.submit_time}"  type="both"/></td> <td><fmt:formatDate value="${em.update_time}"  type="both"/></td>
			<td>${charger.name }</td> 
			<td>
				<c:choose>
					<c:when test="${fn:contains(modules, 'UPDATE_PROCESS')}">
						<input  class="jindu easyui-combobox" value="${em.state }"  style="width:70px;" data-options="
						valueField: 'value',
						textField: 'label',
						data: [{
							label: '推荐',
							value: '1',
							storeId:'${em.id }'
						},{
							label: '跟进',
							value: '2',
							storeId:'${em.id }'
						},{
							label: '带看',
							value: '3',
							storeId:'${em.id }'
						},
						{
							label: '在谈',
							value: '4',
							storeId:'${em.id }'
						},
						{
							label: '成交',
							value: '5',
							storeId:'${em.id }'
						},
						{
							label: '终止',
							value: '6',
							storeId:'${em.id }'
						}],
					onSelect: function(param){
								 $.ajax({
						             type: 'GET',
						             url: '${updateExample}?id='+param.storeId+'&state='+param.value,
						             data: {
						             },
						             dataType: 'text',
						             success: function(data){
											if(data=='success'){
												alert('提交成功');
											}				                    
						             },
						             error:function(e,f){
						            	 alert('提交失败');
						             }
						         });
					}
					" />
					</c:when>
					<c:otherwise>
						<c:if test="${em.state==1 }">推荐</c:if>
					<c:if test="${em.state==2 }">跟进</c:if>
					<c:if test="${em.state==3 }">带看</c:if>
					<c:if test="${em.state==4 }">在谈</c:if>
					<c:if test="${em.state==5 }">成交</c:if>
					<c:if test="${em.state==6 }">终止</c:if>
					</c:otherwise>
					
				</c:choose>
			</td> 
			<td class="tdLeft">${em.description }</td>
		</tr>
	</c:forEach>
	
</table>
<script type="text/javascript">

	$(function(){
		
		$('.cusName').click(function(){
			var id = $(this).attr('cusId');
			var cusid = $(this).attr('cpId');
			var url='${pageContext.request.contextPath}/jf/cusController/view/'+id;
			var title = '客户详情';
			window.parent.addTab({url :'${pageContext.request.contextPath}/jf/cusController/view/'+id,
				title : '查看客户-'+cusid,
				iconCls : 'status_online'
			});
		});
		
		$('.smallImg').click(function(){
			
			var bigSrc =  $('.bigImg').attr('src');
			var smallSrc =  $(this).attr('src');
			if(bigSrc!=smallSrc){
				$('.bigImg').attr('src',smallSrc);
			}
		});
	});
</script>
</body>
</html>