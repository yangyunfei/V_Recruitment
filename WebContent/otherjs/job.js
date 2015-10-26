$(function (){

	//去除引用JQM自动添加的input的样式
	 $("input").attr('data-role','none');  
	 $("select").attr('data-role','none');

	 //点击页面其他地方，下拉菜单消失
	 $(document).click(function (){ 
	 	$(".selectoption").hide();
	 });

	 //各页面的返回按钮
	 $('.goback').click(function (){
	 	window.history.go(-1);
	 });
	 
	//login.html--记住密码按钮
	$("#loginckb").click(function (){
		if($(this).attr('checked')){
			$(this).removeAttr('checked');
			$(".checkboxout .loginckb").css({
				"background":"url(../images/ckbnochecked.png) no-repeat 0px 0px",
				"background-size":"17px 17px"
			});
		}else{
			$(this).attr('checked','checked');
			$(".checkboxout .loginckb").css({
				"background":"url(../images/ckbchecked.png) no-repeat 0px 0px",
				"background-size":"17px 17px"
			});
		}
	});

	//createDemand.html--下拉菜单
	$(".J_select").click(function (event){
		event.stopPropagation();
		var windowHeight = $('html').height();    //页面高度
		var offset = $(this).offset();
		var offsetHeight = offset.top;  //下拉菜单的偏移
		var selectoptionheight = $(".selectoption").height();  //下拉菜单的高度

		if(windowHeight - offsetHeight - selectoptionheight - 30 < 0 && (offsetHeight - selectoptionheight) > 0){
			$(".selectoption").css({
				'top' : -(selectoptionheight)
			})
		}
		$(".selectoption").toggle();
	});
	$(".selectoption i").click(function (){
		var pname = $(this).text();
		var node = '<span class="triangle"></span>';

		$(".selectname").html(pname + node);
		
		$(this).parent().hide();
		
	});
	//createDemand.html--下拉菜单  end


});








