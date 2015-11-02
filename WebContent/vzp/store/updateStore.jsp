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
<link rel="stylesheet" href="<%=basePath %>css/chosen.css">
<script type="text/javascript" src="<%=basePath %>js/jquery.min.js"></script>
<script type="text/javascript" src="<%=basePath %>js/jquery.easyui.min.js"></script>
<script type="text/javascript" src="<%=basePath %>js/ajaxfileupload.js"></script>
<script type="text/javascript" src="<%=basePath %>js/wechat/chosen.jquery.js"></script>
		<script type="text/javascript" src="<c:url value='/js/wechat/photo.js'></c:url>" ></script>
<title>更新商铺</title>


<style type="text/css">
    .mask {       
		            position: fixed; top: 0px; filter: alpha(opacity=60); background-color: #777;     
		            z-index: 1002; left: 0px;     
		            opacity:0.5; -moz-opacity:0.5;  
		            display: none;   
		        } 
		     .load{position:fixed;}
		     
	.td_title{
		width:15%;
	}
	.td_content{
	width:45%;
	}
	
	.title1{
		text-align: center;
		border: 1px solid #95B8E7;
		padding: 7px 10px;
		background: #EAF2FF;
		width: 61px;
		border-radius: 25px;
		-moz-border-radius: 25px;
		position: relative;
		left: -50px;
		top: 0.5px;
	}
	
	.hr1{
		width: 93%;
		position: relative;
		top: -7.51px;
		border-color: #E6F0FF;
	}
	
	.img_error{
		color:red;
	}
	
	.uploadOk{
		color: green;
		margin-left: 20px;
	}
	
	.uploadError{
		color: red;
		margin-left: 20px;
	}
</style>


<script type="text/javascript">

$.imgurl = '${imgurl}';
$.saveimg = '${saveimage_url}';

function getImagePath(img)
{
   return $.imgurl+img;
}

	 /*    $('#addr').bind('click', function(){    
	        alert('easyui');    
	    });  */
	    $(function(){
	    	var canTenant='${st.can_tenant}';
	    	var canTenantArray=canTenant.split(",");
	    	for (var i = 0; i < canTenantArray.length; i++) {
				$("#canTenant option[value='"+canTenantArray[i]+"']").attr("selected","selected");
			}
	    	var characteristicArray='${st.characteristic}';
	    	var characteristicArray=characteristicArray.split(",");
	    	for (var i = 0; i < characteristicArray.length; i++) {
				$("#characteristic option[value='"+characteristicArray[i]+"']").attr("selected","selected");
			}
	    	var structureArray='${st.structure}';
	    	var structureArray=structureArray.split(",");
	    	for (var i = 0; i < structureArray.length; i++) {
				$("#structure option[value='"+structureArray[i]+"']").attr("selected","selected");
			}
	    	$("#lp").textbox({onChange:function(a,b)
	    		{
	    		    getaddr();
	    		}
	    	});
	    	$("#mp").textbox({onChange:function(a,b)
	    		{
	    		    getaddr();
	    		}
	    	});
	    	
	    });
 
	    function getaddr()
	    {
	    	//var sq = document.getElementById("businessArea").value.replace(/[ ]/g,"");
        	var xzq = $("#xzq").textbox('getText');
        	var sq = $("#sq").textbox('getText');
			//sq.replace(/[ ]/g,"");
			var lp = $("#lp").textbox('getText');
			var mp = $("#mp").textbox('getText');
			if(lp&&mp&&xzq&&sq)
				{
						var addrval =xzq+sq+lp+mp;
						 $("#addr").textbox("setText",addrval);
	         }
	    }
$(function(){
	  
    /* $(".dept-select").html('<option>部门6</option>');
    $(".dept-select").trigger("liszt:updated");  */
    $('.dept_select').chosen();
}); 


</script>

</head>
<body>
<div class="easyui-panel" title="店铺信息填写" style="width:800px">
	<div style="padding:10px 60px 20px 60px">
     <form id="storeInfo" method="post">
         <table cellpadding="5" >
         	<tr>
         		<td colspan="4">
         			<div class="title1">物理属性</div>
         			<hr class="hr1" />
         		</td>
         	</tr>
             <tr>
                 <td style="width:15%;">行政区:</td>
                 <td style="width:35%;">
                    <input class="easyui-combobox"  style="width:100px" name="st.administrative_region" id="xzq"  data-options="
                    method:'get',
                    valueField:'id',
                    textField:'name',
                    multiple:false,
                    required:true
                    
            "   missingMessage="请选择行政区"/>
                 </td>
                 <td style="width:15%;">商圈:</td>
                 <td style="width:35%;">
                   <input style="width:100px" class="easyui-combobox" style="width:100px" name="st.business_area"
            id="sq" missingMessage="请选择商圈"   
            data-options="
            valueField:'id',
            required:true,
            textField:'name'
            "/>    </td>
             </tr>
             <tr>
                 <td>楼盘及幢号:</td>
                 <td><input class="easyui-textbox" id="lp" type="text"  value="${st.building}"  name="st.building" data-options="required:true" missingMessage="不能为空"></input></td>
            	 <td>门牌号:</td>
                 <td><input class="easyui-textbox" type="text" id="mp"   value="${st.houseNum}"  name="st.houseNum" data-options="required:true" missingMessage="不能为空"></input></td>
             </tr>
             <tr>
            	 <td>物业地址:</td>
                 <td><input id="addr" class="easyui-textbox"  type="text"   value="${st.address}"    name="st.address" data-options="required:true" missingMessage="不能为空"></input>
    			</td>
                 <td>原商户名称:</td>
                 <td><input class="easyui-textbox" type="text" name="st.oldName"   value="${st.oldName}"   data-options="required:true" missingMessage="不能为空"></input></td>
             </tr>
             <tr>
                 <td>面积:</td>
                 <td>
                 	<input class="easyui-numberbox" id="area" name="st.area"  value="${st.area}"  min="0" max="10000"  required="true" missingMessage="必须填写0~10000之间的数字"></input>
                 	（平方米）
                 </td>
            	 <td>门头宽度:</td>
                 <td>
                 	<input class="easyui-numberbox" name="st.width"  value="${st.width}"  min="0" max="30" precision="2" required="true" missingMessage="必须填写0~30之间的数字"></input>
                 	（米）
                 </td>
             </tr>
             <tr>
                 <td>朝向:</td>
                 <td>
					<select  id="face"  class="easyui-combobox" name="st.face" style="width:130px;" >      
					    <option value="east">东</option>
					    <option value="south">南</option>
					    <option value="west">西</option>
					    <option value="north">北</option>
					    <option value="northeast">东北</option>
					    <option value="southeast">东南</option>
					    <option value="northwest">西北</option>
					    <option value="southwest">西南</option>
					</select>  
				 </td>   
            	 <td>层高:</td>
                 <td>
					<input class="easyui-numberbox"   value="${st.height }" name="st.height" min="0" max="10" precision="2" required="true" missingMessage="必须填写0~10之间的数字" ></input>
                 	（米）
				</td>
             </tr>
             <tr>
                 <td>格局:</td>
                 <td>
                 	<select  id="layout"  class="easyui-combobox" name="st.layout" style="width:130px;">
					    <option value="1">格局方正</option>
					    <option value="2">承重墙多</option>
					</select>  
                 </td>
                
             </tr>
             <tr>
             	 <td>结构</td>
                 <td colspan="3">
                      <select  data-placeholder="--选择商铺结构--"  name="structure" style="width: 80%;" id="structure" multiple class="dept_select chosen-select  easyui-validatebox"  data-options="required:true"> 
			    <option value="-1"></option>
			    <option value="1">一层</option>		   
			    <option value="2">二层</option>		
			    	    <option value="3">三层</option>		   
			    <option value="4">四层</option>		
			    	    <option value="-1">地下室</option>		   
			    </select>
                 </td>
             </tr>
             <tr>
         		<td colspan="4">
         			<div class="title1">经济属性</div>
         			<hr class="hr1" />
         		</td>
         	</tr>
             <tr>
                 <td>年租金:</td>
                 <td>
                 	<input class="easyui-numberbox" id="yearRent" name="st.year_rent"  value="${st.year_rent}"   min="0" max="20000000" precision="2" required="true" missingMessage="必须填写0~2000万之间的数字" ></input>
                	（元）
                 </td>
            	 <td>每平米日租金:</td>
                 <td>
                 	<input class="easyui-numberbox" id="dayRentPerCentare"   value="${st.day_rent_per_centare}"  name="st.day_rent_per_centare" editable="false" min="0" max="50" precision="2" required="true" missingMessage="必须填写0~50之间的数字"></input>
                 	（元）
                 </td>
             </tr>
             <tr>
                 <td>租期:</td>
                 <td>
                 	<input class="easyui-numberbox" id="tenancy"    value="${st.tenancy}"   name="st.tenancy" min="0" max="20" precision="1" required="true" missingMessage="必须填写0~20之间的数字"></input>
                 	（年）
                 </td>
            	 <td>转让费:</td>
                 <td>
                 	<input class="easyui-numberbox" name="st.transfer_fee"   value="${st.transfer_fee}"  min="0" max="5000000" precision="2" required="true" missingMessage="必须填写0~500万之间的数字"></input>
                 	（元）
                 </td>
             </tr>
             <tr>
                 <td>付款方式:</td>
                 <td>
                 	<select  id="payment"  class="easyui-combobox" name="st.payment" style="width:130px;">
					    <option value="month">月付</option>
					    <option value="3month">季付</option>
					    <option value="6month">半年付</option>
					    <option value="12month">年付</option>
					</select>  
                 </td>
            	 <td>营业执照:</td>
                 <td>
					<select id="licence"  class="easyui-combobox" name="st.licence" style="width:130px;">
					    <option value="available">可办照</option>
					    <option value="unavailable">不可办照</option>
					</select>                   
				</td>
             </tr>
             <tr>
         		<td colspan="4">
         			<div class="title1">经营属性</div>
         			<hr class="hr1" />
         		</td>
         	 </tr>
             <tr>
                 <td>上下水:</td>
                 <td>
                 	<select id="water"  class="easyui-combobox" name="st.water" style="width:130px;">
					    <option value="up">上水</option>
					    <option value="down">下水</option>
					    <option value="updown">上下水</option>
					    <option value="none">无</option>
					</select>  
                 </td>
            	 <td>电量:</td>
                 <td>
                 	<select id="power"  class="easyui-combobox" name="st.power" style="width:130px;">
					    <option value="1">满足高用电</option>
					    <option value="2">不满足高用电</option>
					    <option value="3">不满足可增容</option>
					</select> 
				</td>
             </tr>
             <tr>
                 <td>明火:</td>
                 <td>
                 	<select  id="fire"  class="easyui-combobox" name="st.fire" style="width:130px;">
					    <option value="1">可起明火</option>
					    <option value="2">不可起明火</option>
					</select>
				</td>
            	 <td>排风:</td>
                 <td>
                 	<select id="wind"  class="easyui-combobox" name="st.wind" style="width:130px;">
					    <option value="has">有排风</option>
					    <option value="none">无排风</option>
					</select>
				</td>
             </tr>
             <tr>
                 <td>燃气:</td>
                 <td>
                 	<select  id="gas"  class="easyui-combobox" name="st.gas" style="width:130px;" >
					    <option value="has">有燃气</option>
					    <option value="none">无燃气</option>
					</select>
				</td>
            	 <td>当前业态:</td>
                 <td>
                 	<input id="preTenant"   value="${st.pre_tenant }"  name="st.pre_tenant" editable="false" class="easyui-textbox" type="text"  data-options="required:true" missingMessage="不能为空"></input>
                 	<a href="javascript:void(0)" id="mb" class="easyui-menubutton" 
				    style="background:#EAF2FF;position: relative;left: -47px;height: 18px;"> </a>
                 </td>
             </tr>
             <tr>
                 <td >可经营业态：</td>
                 <td colspan="3">
               <select  data-placeholder="--选择可经营业态--"  name="can_tenant" style="width: 80%;" id="canTenant" multiple class="dept_select chosen-select  easyui-validatebox"  data-options="required:true"> 
			    <option value="-1"></option>
			    <option value="酒楼餐饮">酒楼餐饮</option>		   
			    <option value="美容美发">美容美发</option>		   
			    <option value="服饰鞋包">服饰鞋包</option>		   
			    <option value="休闲娱乐">休闲娱乐</option>		   
			    <option value="百货超市">百货超市</option>		   
			    <option value="生活服务">生活服务</option>		   
			    <option value="电子通讯">电子通讯</option>		   
			    <option value="汽修美容">汽修美容</option>		   
			    <option value="医药保健">医药保健</option>		   
			    <option value="家居建材">家居建材</option>		   
			    <option value="教育培训">教育培训</option>		   
			    <option value="旅馆宾馆">旅馆宾馆</option>		   
			</select>
				</td>
            	
             </tr>
             <tr>
         		<td colspan="4">
         			<div class="title1">出租方信息</div>
         			<hr class="hr1" />
         	 	</td>
         	 </tr>
             <tr>
                 <td>出租方:</td>
                 <td>
                 	<select  id="lessorType" class="easyui-combobox" name="st.lessor_type" style="width:130px;">
					    <option value="owner">业主</option>
					    <option value="agent">二房东</option>
					    <option value="proxyer">业主代理人</option>
					</select>
                 </td>
            	 <td>出租方姓名:</td>
                 <td><input class="easyui-textbox" type="text" name="st.lessor_name"  value="${st.lessor_name}"  data-options="required:true" missingMessage="不能为空"></input></td>
             </tr>
             <tr>
                 <td>出租方联系方式:</td>
                 <td><input class="easyui-numberbox" type="text" name="st.lessor_phone"  value="${st.lessor_phone}"  data-options="required:true" missingMessage="不能为空"></input></td>
            	 <td>出租方提供佣金:</td>
                 <td>
                 	<input class="easyui-numberbox" name="st.lessor_charge"  value="${st.lessor_charge}"  min="0" max="2000000" precision="2" required="true" missingMessage="必须填写0~200万之间的数字"></input>
                 	（元）
                 </td>
             </tr>
             <tr>
             	<td>委托获取方式:</td>
             	<td><select  id="info_source"  class="easyui-combobox" name="st.info_source" style="width:130px;">
             	    <option value="1">业主报盘</option>
					    <option value="2">社区开发</option>
					    <option value="3">网络搜索</option>
					    <option value="4">他人推荐</option>
					    <option value="5">其它</option>
					    </select>
             	</td>
             	<td>负责人:</td>
             	<td><input id="sales" name="st.user_id" style="width:130px;" /> </td>
             </tr>
             <tr>
         		<td colspan="4">
         			<div class="title1">商铺描述</div>
         			<hr class="hr1" />
         		</td>
         	 </tr>
             <tr>
                 <td>特色:</td>
                 <td colspan="3">
                <select  data-placeholder="--选择商铺特色--"  name="characteristic" style="width: 89%;" id="characteristic" multiple class="dept_select chosen-select" > 
			    <option value="-1"></option>
			    <option value="临街">临街</option>		   
			    <option value="近地铁">近地铁</option>		   
			    <option value="学校周边">学校周边</option>		   
			    <option value="邻社区">邻社区</option>		   
			    <option value="商业街">商业街</option>		   
			    <option value="独家">独家</option>
			    <option value="有钥匙">有钥匙</option>		   
			      <option value="独栋">独栋</option>		   
			</select></td>
             </tr>
             <tr>
                 <td>其它描述:</td>
                 <td colspan="3"><input class="easyui-textbox" name="st.description"  value="${st.description}" 
                  data-options="multiline:true" style="height:60px;width:500px;"></input></td>
             </tr>
                <tr>
         		<td colspan="4">
         			<div class="title1">经纪人信息</div>
         			<hr class="hr1" />
         		</td>
         	 </tr>
         	  <tr>
                 <td>经纪人系统号:</td>
                 <td>
                 <input class="easyui-textbox" type="text"  value="${st.agent_number}"  name="st.agent_number" data-options="required:true" missingMessage="不能为空"></input>
                 </td>
            	 <td>经纪人姓名:</td>
                 <td><input class="easyui-textbox" type="text"   value="${st.agent_name}"  name="st.agent_name" data-options="required:true" missingMessage="不能为空"></input></td>
             </tr>
               <tr>
                 <td>经纪人电话:</td>
                 <td>
                 <input class="easyui-textbox" type="text" name="st.agent_phone"  value="${st.agent_phone}"   data-options="required:true" missingMessage="不能为空"></input>
                 </td>
            	 <td>是否愿意带看:</td>
                 <td><select id="agent_will_assist"  class="easyui-combobox" name="st.agent_will_assist" style="width:130px;">
             	    <option value="是">愿意</option>
					    <option value="否">不愿意</option>

					    </select></td>
             </tr>
             <tr>
                 <td>商铺权重:</td>
                 <td>
                 	<input class="easyui-numberbox" id="storeWeight" value="${st.weight }" name="st.weight" min="0" max="255" required="true" missingMessage="必须填写0~255之间的数字" />
                 </td>
             </tr>
             <tr>
       			<td>
       				<div class="title1">上传图片</div>
       				<hr class="hr1" />
       			</td>
       		</tr>
         </table>

     <input  name="str1" type="hidden" />
     <input  name="str2" type="hidden" />
     
     <input type="text"  value="${st.img1}"  name="st.img1" style="display:none;"></input>
     <input type="text"   value="${st.img2}"  name="st.img2" style="display:none;"></input>
     <input type="text"   value="${st.img3}"  name="st.img3" style="display:none;"></input>
      <input  name="st.id" type="hidden"  value="${st.id}"/>
      </form>
    <div class="mask"><div class="load"><img alt="load..." src="<c:url value='/images/zyp/mask.gif'></c:url>"></div></div>
		<div class="zyp_line ">
			<div style="text-align: center;">
				<div style="float:left;margin-left:5%;width: 30%">
					<img id="img1"  style="display: -none;width:100%;" onclick="addPhoto2(this,'file1')"  src="${imgurl}${st.img1 }"/>
					<div class="fileInput" style="display: none;">
						选择图片
		        		<input type="file" id="file1" name="file" class="upfile" onchange="addPhoto1(this,'st.img1','img1')"  style="width: 100%;left: 0px;"/>
		       		</div>
				</div>
				<div  style="float: left;width: 30%">
					<img id="img2"  style="display: -none;width:100%;"  onclick="addPhoto2(this,'file2')" src="${imgurl}${st.img2}"/>
					<div class="fileInput" style="display: none;">
					选择图片
		        	<input type="file" id="file2" name="file" class="upfile" onchange="addPhoto1(this,'st.img2','img2')"  style="width: 100%;left: 0px;"/>
		        </div>
				</div>
				<div  style="float: right; margin-right: 5%;width:30% ">
					<img id="img3"  style="display: -none;width:100%;" onclick="addPhoto2(this,'file3')" src="${imgurl}${st.img3}"/>
					<div class="fileInput" style="display: none;">
					选择图片
		        	<input type="file" id="file3" name="file" class="upfile" onchange="addPhoto1(this,'st.img3','img3')"  style="width: 100%;left: 0px;"/>
		       		</div>
				</div>
				<div style="clear: both;"></div>
	        </div>
	        
		</div>

    
     <div style="text-align:center;padding:5px">
         <a id="btn_submit" href="javascript:void(0)" class="easyui-linkbutton" onclick="submitForm()">提交</a>
         <a href="javascript:void(0)" class="easyui-linkbutton" onclick="clearForm()">取消</a>
     </div>
     </div>
</div>
<div id="mm" style="width: 150px;">
	<c:forEach items="${industryList}" var="industry" >
		
		<c:if test="${industry.fid==null}">
			<div>${industry.name}
				<div class="easyui-menu" style="width: 120px;"></div>
				<div>
					<c:forEach items="${industryList}" var="newindustry" >
						<c:if test="${newindustry.fid==industry.id}">
							<div> ${newindustry.name} </div>
						</c:if>
					</c:forEach>
				</div>
			</div>
		</c:if>
	</c:forEach>
</div>

<script type="text/javascript">

	function clearForm(){
		var title = '添加商铺';
		window.parent.closeTab(title);
	}

	
	var flag=0;
	$(function(){
		 var xzq = $('#xzq').combobox({
		        url: '${pageContext.request.contextPath}/jf/areaBusinessController/selectAllBigDistrict',
		        editable: true,
		        valueField: 'id',
		        textField: 'name',
		        onLoadSuccess:function(){
		        	$('#xzq').combobox('select', '${st.administrative_region}');
	           
			    },
		        onSelect: function (record) {
		        	flag=flag+1;
		        	getaddr();
		        	if(record!=null)
		            sq.combobox({
		                disabled: false,
		                method:'get',
		                url:'${pageContext.request.contextPath}/jf/areaBusinessController/selectBusinessArea?id=' + record.id,
		                valueField: 'id',
		                textField: 'name',
		                onSelect:function(record)
		                {
		                	getaddr();
		                	if(flag<=1)
		                	$("#addr").textbox("setText",'${st.address}');
		                },
		                onLoadSuccess:function(){
		                	if(flag<=1)
				        	$('#sq').combobox('select', '${st.business_area}');
			           
					    }
		            });
		        }
		    });
		    var sq = $('#sq').combobox({
		        disabled: true,
		        valueField: 'id',
		        textField: 'name'
		    });
	/* 	$('#dayRentPerCentare').siblings('span').find('.textbox-text').blur(function(){
			var day = $('#dayRentPerCentare').numberbox('getValue');
			var year = $('#yearRent').numberbox('getValue');
			var area = $('#area').numberbox('getValue');
			if(!area){
				alert('请先选择面积');
				return;
			}
			year = day*365*area;
			$('#yearRent').numberbox('setValue',year);
		}); */
		$('#yearRent').siblings('span').find('.textbox-text').blur(function(){
			var day = $('#dayRentPerCentare').numberbox('getValue');
			var year = $('#yearRent').numberbox('getValue');
			var area = $('#area').numberbox('getValue');
			if(!area){
				alert('请先选择面积');
				return;
			}
			day = year/365/area;
			$('#dayRentPerCentare').numberbox('setValue',day);
		});
	});

	function submitForm(){
		$('#storeInfo').submit();
	}
 
	$(function(){
		
		//描述字符限制
		$('textarea').keyup(function(){
			
			var content = $(this).val();
			var len =  $(this).val().length;
			if(len>150){
				$(this).val(content.substr(0,150));
			}
		});
		
		//combox 不能编辑
		$('.textbox.combo .textbox-text').attr('readonly','readonly');
		
		$('#storeInfo').form({
            url: '${update_url}',
            onSubmit: function () {
                //表单验证
                var allOk = $("#storeInfo").form('validate');
                if(!allOk){
               	 alert('请正确填写表单内容后再提交');
                }
               if(allOk)
                 {
               	  var structure = $('#storeInfo [name="structure"]').val();
            	  if(!structure)
            		  {
            		  $('#storeInfo [name="structure"]').focus();
            		  alert('请选择商铺结构');
            		  return false;
            		  }
            	  var can_tenant = $('#storeInfo [name="can_tenant"]').val();
            	  if(!can_tenant)
            		  {
            		  $('#storeInfo [name="can_tenant"]').focus();
            		  alert('请选择可经营业态');
            		  return false;
            		  }
                	  var characteristic = $('#storeInfo [name="characteristic"]').val();
                	  if(!characteristic)
                		  {
                		  $('#storeInfo [name="characteristic"]').focus();
                		  alert('请选择商铺特色');
                		  return false;
                		  }
                	   var ok = false;
                       var imgName1 = $('#storeInfo [name="st.img1"]').val();
                       var imgName2 = $('#storeInfo [name="st.img2"]').val();
                       var imgName3 = $('#storeInfo [name="st.img3"]').val();
                       if(imgName1&&imgName2&&imgName3){
                       	ok = true;
                       }
                       else{
                       	alert('请上传图片');
                       	return false;
                       }
                	$('#btn_submit').linkbutton('disable');
                }
               return allOk;
            },
            success: function (data) {
            	result = $.parseJSON(data);
                alert(result.msg);
            }
		});
		
		
		
		//年租金和每平米日租金二选一
		
		//上传图片判断类型和大小
		$('[type="file"]').change(function(a,b,c){
			
			
			
			var types=['jpg','jpeg','png','JPG','IPEG','PNG'];
			var arr = $(this).attr('id').split('_');
			var index = arr[arr.length-1];
			arr = $(this)[0].files[0].name.split('.');
			var size = ($(this)[0].files[0].size)/1024;
			var type = arr[1];
			var name = arr[0];
			if(size>2048){
				$('#upload'+index).append('<span class="img_error">图片大小超过2M，不能上传</span');
			}
			
			var typeIsWrong = true;
			for(var i=0;i<types.length;i++){
				
				if(types[i]==type){
					typeIsWrong = false;
					break;
				}
			}
			
			if(typeIsWrong){
				$('#upload'+index).after('<span class="img_error">图片类型错误，不能上传</span');
			}
			
			
		});
		
		
		//照片上传
	 	$('.btn_upload').click(function(){
			
	 		var srcEle = this;
			var btnId = $(this).attr('id');
			var index = btnId.charAt(btnId.length-1);
			var fileId='filebox_file_id_'+index;
			var upFileId = 'img'+index;
			if($('#'+fileId)[0].files[0]==undefined){
				alert('请选择文件');
				return false;
			} 
			//前台判断类型
			var fileName = $('#'+fileId)[0].files[0].name;
	
 	       $.ajaxFileUpload({  
 	  	    fileElementId: fileId,  
 	  	    url: '${saveimage_url}',  
 	  	    dataType: 'json',  
 	  	    data: { id: upFileId },  
 	  	    beforeSend: function (XMLHttpRequest) {  
 	  	      //("loading");  
 	  	    },  
 	  	    success: function (data, textStatus) {
 	
 	  	    	//插件原因，data后台传不过来
 	  	    	$(srcEle).parent().find('.uploadOk').remove();
 	  	    	$(srcEle).parent().find('.uploadError').remove();
 	  	    	$(srcEle).after('<span class="uploadOk">图片上传成功！</span>');
 	  	    	
 	  	    	//表单图片名字必填
 	  	    	$('#storeInfo').find('[name="'+upFileId+'"]').val(fileName);
 	  	    },  
 	  	    error: function (XMLHttpRequest, textStatus, errorThrown) {  
 	  	     alert( "图片上传失败！");  
 	  	 	$(srcEle).parent().find('.uploadOk').remove();
 	    	$(srcEle).parent().find('.uploadError').remove();
 	    	$(srcEle).after('<span class="uploadOk">图片上传失败！</span>');
 	  	    },  
 	  	    complete: function (XMLHttpRequest, textStatus) {  
 	  	      //("loaded");  
 	  	     //	 alert( "图片上传完成！");
 	  	    }  
 	  	  }); 
		}); 
		
		
		//原租户业态二级菜单点击事件
		
		var ddlMenu = $('#mb').menubutton({ menu: '#mm' });
		$(ddlMenu.menubutton('options').menu).menu({
            onClick: function (item) {
                //item 的相关属性参见API中的menu
                if($(item.target).attr('class')=='menu-item'){
                	$('#preTenant').textbox('setValue', item.text);
                }
            }
		}); 
		
	});
	
	$(function(){
		
		//初始化销售列表
		$('#sales').combobox({
		    url:'${pageContext.request.contextPath}/jf/userController/getSales',
		    valueField:'id',
		    textField:'name',
		    onLoadSuccess:function(){
		    	var data = $('#sales').combobox('getData');
		        if (data.length > 0) {
		            $('#sales').combobox('select', '${st.user_id}');
		        }
		        
		        //combox 不能编辑
		        $('.textbox.combo .textbox-text').attr('readonly','readonly');
		    },
		    onLoadError:function(){
		    	alert('销售列表加载失败');
		    }
		});

	});
	
	$(function(){
		$('#face').combobox('select','${st.face}');
		$('#layout').combobox('select','${st.layout}');
		$('#payment').combobox('select','${st.payment}');
		$('#licence').combobox('select','${st.licence}');
		$('#water').combobox('select','${st.water}');
		$('#power').combobox('select','${st.power}');
		$('#wind').combobox('select','${st.wind}');
		$('#gas').combobox('select','${st.gas}');
		$('#fire').combobox('select','${st.fire}');
		$('#lessorType').combobox('select','${st.lessor_type}');
		$('#info_source').combobox('select','${st.info_source}');
		$('#agent_will_assist').combobox('select','${st.agent_will_assist}');

	

		
		//描述字符限制
		$('textarea').keyup(function(){
			
			var content = $(this).val();
			var len =  $(this).val().length;
			if(len>150){
				$(this).val(content.substr(0,150));
			}
		});
	});
</script>
</body>
</html>