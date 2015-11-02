<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="<%=basePath %>css/easyui.css">
<link rel="stylesheet" type="text/css" href="<%=basePath %>css/icon.css">
<link rel="stylesheet" type="text/css" href="<%=basePath %>css/demo.css">
<link rel="stylesheet" type="text/css" href="<%=basePath %>css/main.css">
<script type="text/javascript" src="<%=basePath %>js/jquery.min.js"></script>
<script type="text/javascript" src="<%=basePath %>js/jquery.easyui.min.js"></script>
<title>商铺管理</title>
<style type="text/css">

	*{
		font-size:14px;
		font-family:"微软雅黑";
	}
	
	
	#searchDiv p+p{
		margin-top: -13px;
	}
	
	#searchDiv p{
		height: 27px;
	}
	
	.list{
		width: 1373px;
	}
	
	.hr{
		border-color:#008000;
	}
	
	.date+.date{
		margin-left:20px;
	} 
	
	
</style>
</head>
<body>
<!-- <div id="mask" title="单击我进行切换" class="easyui-tooltip">
	年租金与日租金二选一
</div> -->
<input id="addStore" type="button" value ="&nbsp;&nbsp;新&nbsp;增&nbsp;&nbsp;" />

<div id="searchDiv">
 <p><span class="label">区域：</span><span class="normal bold" onclick="$('#areaResult').text('');$('#areaResult').attr('value','')">不限 </span>
 	<c:forEach items="${list}" var="area">
 		<c:if test="${area.fid==0 and area.id !=1 }">
 		<span class="normal district" value="${area.id}" >${area.name }</span> 
 		</c:if>
 	</c:forEach>
 	<span id="areaResult"></span>
 </p>
<!--  <p><span class="label">年租金：</span> <span class="normal bold" onclick="$('#yearRentMin').val('');$('#yearRentMax').val('');">不限 </span>    
 	<input id="yearRentMin" style="width:50px;margin-left: 13px;" ></input>
 	 ~
 	 <input id="yearRentMax" style="width:50px;"></input>
 	 （元）</p>
 <p><span class="label">单平米日租金：</span> <span class="normal bold" onclick="$('#dayRentPerCentareMin').val('');$('#dayRentPerCentareMax').val('');">不限 </span>   
	<input id="dayRentPerCentareMin" style="width:50px;margin-left: 13px;"></input>
	 ~
	 <input id="dayRentPerCentareMax" style="width:50px;" ></input>
	 （元）</p> -->
 <p>
	<input  type="radio" name="rent" value="year" checked="checked" /> <span >年租金：</span>
	<input  type="radio" name="rent" value="day" /> <span >单平米日租金：</span>
	<input id="rentMin" style="width:50px;margin-left: 13px;"></input>
	 ~
	 <input id="rentMax" style="width:50px;" ></input>
	 （元）
 </p>
 <p><span class="label">面积：</span> <span class="normal bold" onclick="$('#areaMin').val('');$('#areaMax').val('');">不限 </span>   
 	<input id="areaMin" style="width:50px;margin-left: 13px;"></input>
	 ~
	 <input id="areaMax" style="width:50px;" ></input>（平米）
  </p>
 <p><span class="label">更多：</span> <span class="normal " >上下水 </span>
	<select  class="easyui-combobox" id="water" style="width:130px;">
	    <option value="">不限</option>
	    <option value="up">上水</option>
	    <option value="down">下水</option>
	    <option value="updown">上下水</option>
	    <option value="none">无</option>
	</select> 
    <span class="normal">电量</span>
    <select  class="easyui-combobox" id="power" style="width:130px;">
	    <option value="">不限</option>
	    <option value="1">满足高用电</option>
	    <option value="2">不满足高用电</option>
	    <option value="3">不满足可增容</option>
	</select> 
     <span class="normal">明火</span>
     <select  class="easyui-combobox" id="fire" style="width:130px;">
	    <option value="">不限</option>
	    <option value="1">可起明火</option>
	    <option value="2">不可起明火</option>
	</select>
      <span class="normal">排风</span>
      <select  class="easyui-combobox" id="wind" style="width:130px;">
	    <option value="">不限</option>
	    <option value="has">有排风</option>
	    <option value="none">无排风</option>
	</select>
       <span class="normal">燃气</span>
       <select  class="easyui-combobox" id="gas" style="width:130px;">
	    <option value="">不限</option>
	    <option value="has">有燃气</option>
	    <option value="none">无燃气</option>
	</select>
        </p>
 <p id="state"><span class="label">商铺状态：</span> <span class="normal bold" val="" >不限 </span>   <span class="normal" val="2">未成交</span> <span class="normal" val="1">成交</span>  </p>
 <p id="source"><span class="label">商铺来源：</span> <span class="normal bold" val="">不限 </span>   <span class="normal" val="1">当前推广</span> <span class="normal" val="2">库存</span> <span class="normal" val="3">经纪人推荐</span>   </p>
 <p><span class="label" style="width:112px;">商铺编码：</span> <input id="storeId" name="storeId" class="easyui-searchbox" style="width:150px"
        data-options="searcher:searchByCode,prompt:'请输入商铺编码'"></input>
    <a href="#" id="search" class="easyui-linkbutton" style="margin-left:30px;">&nbsp;&nbsp;搜&nbsp;索&nbsp;&nbsp;</a>       
 </p>
        
  
</div>

<hr class="hr" />
<div id="content" class="easyui-panel" style="height:320px;width: 1390px;overflow:hidden;"
        data-options="href:'<%=basePath %>storeManageContent.do?mark=1&pageNum=1'">
</div>

	
<div id="pagination" style="background:#efefef;border:1px solid #ccc;position: relative;
top: -15px;width:1388px;"></div>
	
<script type="text/javascript">


	$(function(){
		
		//combox 不能编辑
		$('.textbox.combo .textbox-text').attr('readonly','readonly');
	});

	/*
	* 搜索商铺编码方法
	*/
	function searchByCode(value,name){
		
		var url = '<%=basePath %>storeManageContent.do?special=1&pageNum=1&'+name+'='+value;
		$('#content').panel('refresh', url);
	}
	
	function areasClick(a){
		
		$('#areaResult').text($(a).text());
		$('#areaResult').attr('value',$(a).attr('value'));
	}

	$(function(){
		
		$('#search').click(function(){
			changeContent(1);
			//改变分页总数目放在 content 的ready方法中
		});
	});
	
	
	/*
	*改名分页totalSize的方法的方法
	*/
	function changePagination(totalSize){
		
		$('#pagination').pagination({
		    total:totalSize
		});
	}
	
	/*
	*改名列表内容的方法
	*/
	function changeContent(pageNumber){
		
		var url = '<%=basePath %>storeManageContent.do?mark=1&pageNum='+pageNumber;
    	url = urlWrapper(url);
        $('#content').panel('refresh', url);
	}

	/*
	*封装请求路径的方法
	*/
	function urlWrapper(url){
	//获取参数
		var businessArea = $('#areaResult').attr('value');
    	var yearRentMin = $('#yearRentMin').val();
    	var yearRentMax = $('#yearRentMax').val();
    	var dayRentPerCentareMin = $('#dayRentPerCentareMin').val();
    	var dayRentPerCentareMax = $('#dayRentPerCentareMax').val();
    	var areaMin = $('#areaMin').val();
    	var areaMax = $('#areaMax').val();
    	var water = $('#water').combobox('getValue');
    	var power = $('#power').combobox('getValue');
    	var fire = $('#fire').combobox('getValue');
    	var wind = $('#wind').combobox('getValue');
    	var gas = $('#gas').combobox('getValue');
    	var state = $('#state .bold').attr('val');
    	var source = $('#source .bold').attr('val');
    	var administrativeRegionStr = $('.normal.district.bold').attr('value');
    //拼参数
    if(businessArea){
    	url+='&businessArea.id='+businessArea;
    }
    if(administrativeRegionStr){
    	url+='&administrativeRegionStr='+administrativeRegionStr;
    }
    if(areaMin){
    	url+='&areaMin='+areaMin;
    }
    if(areaMax){
    	url+='&areaMax='+areaMax;
    }
    if(water){
    	url+='&water='+water;
    }
    if(power){
    	url+='&power='+power;  
    }
    if(fire){
    	url+='&fire='+fire;
    }
    if(wind){
    	url+='&wind='+wind;
    }
    if(gas){
    	url+='&gas='+gas;
    }
    if(state){
    	url+='&state='+state;
    }
    if(source){
    	url+='&source='+source;
    }
    //年租金与日租金二选一
    var rentType= $('[type="radio"][name="rent"]:checked').val();
    var rentMin = $('#rentMin').val();
    var rentMax = $('#rentMax').val();
   	if(rentType=='year'){
   		if(rentMin){
   	    	url+='&yearRentMin='+rentMin;
   	    }
   		if(rentMax){
   			url+='&yearRentMax='+rentMax;
   	    }
   	}
   	if(rentType=='day'){
   		if(rentMin){
   			url+='&dayRentPerCentareMin='+rentMin;
   	    }
   		if(rentMax){
   			url+='&dayRentPerCentareMax='+rentMax;
   	    }
   	}
	return url;
}
	
	$(function(){
		
		$('#pagination').pagination({
		    total:"${total}",
		    pageSize:10,
		    showPageList:false,
		    onSelectPage: function(pageNumber, pageSize){
		    	changeContent(pageNumber);
            }
		    
		});
	});
	

	$('#mask').click(function(){
		
		if($('#mask').css('top')=='61px'){
			$('#mask').animate({top:"89px"});
			
			$('#dayRentPerCentareMin').val('');
			$('#dayRentPerCentareMax').val('');
		}
		else{
			$('#mask').animate({top:"61px"});
			
			$('#yearRentMin').val('');
			$('#yearRentMax').val('');
		}
		
	});

	
	$(function(){
		
		/*
		*新增商铺按钮点击事件
		*/
		$('#addStore').click(function(){
			
			var title = '添加商铺';
			var url = '<%=basePath %>addStore.do';
			window.parent.addTab(title, url);
		});
		
		
		$( ".district" ).each(function(a,b){
			$(b).tooltip({
			    content: $('<div></div>'),
		        showEvent: 'click',
		        onUpdate: function(content){
		        	var id = $(this).attr('value');
		            content.panel({
		                width: '600px',
		                border: false,
		                href: '<%=basePath%>businessArea.do?id='+id+'&random='+Math.random()
		            });
		            
		        },
		        onShow: function(content){
		            var t = $(this);
		            t.tooltip('tip').unbind().bind('mouseenter', function(){
		                t.tooltip('show');
		               
		            }).bind('mouseleave', function(){
		                t.tooltip('hide');
		            });
		        }
			});
		});
		
		
		
		$( ".normal" ).click(function(){
			 if(! $( this ).hasClass('bold')){
			    	$(this).addClass('bold');
			    	$(this).siblings().removeClass('bold');
			 }
		});
	});
</script>
</body>
</html>