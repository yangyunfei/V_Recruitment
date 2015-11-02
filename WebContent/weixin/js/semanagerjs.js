// JavaScript Document
$(function (){
	
	//placeholder
	var doc=document,inputs=doc.getElementsByTagName('input'),supportPlaceholder='placeholder'in doc.createElement('input'),placeholder=function(input){var text=input.getAttribute('placeholder'),defaultValue=input.defaultValue;
    if(defaultValue==''){
        input.value=text}
        input.onfocus=function(){
            if(input.value===text){this.value=''}};
            input.onblur=function(){if(input.value===''){this.value=text}}};
            if(!supportPlaceholder){
                for(var i=0,len=inputs.length;i<len;i++){var input=inputs[i],text=input.getAttribute('placeholder');
                if(input.type==='text'&&text){placeholder(input)}}}
				

	//返回按钮
	$('.goback').click(function (){
		window.history.go(-1);
	});
	
	//clientManager-- tab标签切换
	$('.tabnav ul li').click(function (){
		var objspan = '<span></span>';
		var thisindex = $(this).index();
		
		$('.tabnav ul li').removeClass('action');
		$('.tabnav ul li span').remove();
		$(this).append(objspan);
		$(this).addClass('action');
		$('.tabcontain').hide().eq(thisindex).show();
		
	});
	
	
	
	//createNews/editNews--上传图片格式判断
	$(".file").change(function (){
		if(!/.(gif|jpg|jpeg|png|GIF|JPG|JPEG|PNG)$/.test(this.value)){
			alert("图片格式不正确，支持.gif|.jpg|.jpeg|.png");
			$(this).prev().val('');
			return false;
		}else{
			$(this).prev().val(this.value);
			return true;
		}
	});



})