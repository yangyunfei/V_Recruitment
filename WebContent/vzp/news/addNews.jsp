<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
        "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>添加资讯</title>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<script type="text/javascript" charset="utf-8"
	src="<%=basePath%>baiduUeditor/ueditor.config.js"></script>
<script type="text/javascript" charset="utf-8"
	src="<%=basePath%>baiduUeditor/ueditor.all.min.js">
	
</script>
<!--建议手动加在语言，避免在ie下有时因为加载语言失败导致编辑器加载失败-->
<!--这里加载的语言文件会覆盖你在配置项目里添加的语言类型，比如你在配置项目里配置的是英文，这里加载的中文，那最后就是中文-->
<script type="text/javascript" charset="utf-8"
	src="<%=basePath%>baiduUeditor/lang/zh-cn/zh-cn.js"></script>
<script type="text/javascript" src="<%=basePath%>js/jquery.min.js"></script>
<script type="text/javascript" src="<%=basePath%>js/wechat/photo.js"></script>
<script type="text/javascript">
	$.imgurl = '${imgurl}';
	$.saveimg = '${saveimage_url}';
	
</script>
<style type="text/css">
div {
	width: 100%;
}
</style>
</head>
<body>
	<div  style="margin: 2%">
		<form action="<%=basePath%>jf/newsController/addNews"
			method="post">
			<table>
				<tr>
					<td>资讯标题:</td>
					<td><input type="text" name="news.title"></td>
				</tr>
				<tr>
					<td>资讯简介:</td>
					<td><textarea rows="3" cols="50" name="news.intro"></textarea></td>
				</tr>
				<tr>
					<td>资讯图片:</td>
					<td><div class="zyp_line ">
							<div style="text-align: center;">
								<div style="float: left; margin-left: 5%; width: 30%">
									<img id="img1" style="display: -none; width: 100%;"
										onclick="addPhoto2(this,'file1')"
										src="<%=basePath%>images/zyp/adddefault.jpg" />
									<div class="fileInput" style="display: none;">
										选择图片 <input type="file" id="file1" name="file" class="upfile"
											onchange="addPhoto1(this,'st.img1','img1')"
											style="width: 100%; left: 0px;" />
									</div>
								</div>
							</div>
						</div></td>
				</tr>
				<tr>
					<td>发布方:</td>
					<td><select name="news.publish">
							<option value="1">全部</option>
							<option value="2">真有铺</option>
							<option value="3">专家团队</option>
					</select></td>
				</tr>
				<tr>
					<td>发布地点:</td>
					<td><input type="checkbox" value="1" name="citys">测试1</input><input
						type="checkbox" value="2" name="citys">测试2</input></td>
				</tr>
				<tr>
					<td>发布渠道:</td>
					<td><input type="checkbox" value="1" name="channel">客户端</input><input
						type="checkbox" value="2" name="channel">销售端</input><input
						type="checkbox" value="3" name="channel">微信端</input></td>
				</tr>
				<tr>
					<td>是否置顶:</td>
					<td><input type="radio" value="0" name="news.is_up">是</input><input
						type="radio" value="1" name="news.is_up" checked="checked">否</input></td>
				</tr>
				<tr>
					<td>是否外链:</td>
					<td><input type="radio" value="">是</input><input type="radio"
						value="" checked="checked">否</input></td>
				</tr>
				<tr>
					<td></td>
					<td colspan="1"><input type="text" value=""></td>
				</tr>
			</table>
			资讯内容：
			<div>
				<script id="editor" type="text/plain"
					style="width:1024px;height:500px;" name="news.content"></script>
			</div>
			<input type="submit" value="保存">
		</form>
	</div>
	<script type="text/javascript">
		//实例化编辑器
		//建议使用工厂方法getEditor创建和引用编辑器实例，如果在某个闭包下引用该编辑器，直接调用UE.getEditor('editor')就能拿到相关的实例
		var ue = UE.getEditor('editor');
		UE.getEditor('editor').execCommand('insertHtml', '<p>听得见回电话<br/></p>')
		function isFocus(e) {
			alert(UE.getEditor('editor').isFocus());
			UE.dom.domUtils.preventDefault(e)
		}
		function setblur(e) {
			UE.getEditor('editor').blur();
			UE.dom.domUtils.preventDefault(e)
		}
		function insertHtml() {
			var value = prompt('插入html代码', '');
			UE.getEditor('editor').execCommand('insertHtml', value)
		}
		function createEditor() {
			enableBtn();
			UE.getEditor('editor');
		}
		function getAllHtml() {
			alert(UE.getEditor('editor').getAllHtml())
		}
		function getContent() {
			var arr = [];
			arr.push("使用editor.getContent()方法可以获得编辑器的内容");
			arr.push("内容为：");
			arr.push(UE.getEditor('editor').getContent());
			alert(arr.join("\n"));
		}
		function getPlainTxt() {
			var arr = [];
			arr.push("使用editor.getPlainTxt()方法可以获得编辑器的带格式的纯文本内容");
			arr.push("内容为：");
			arr.push(UE.getEditor('editor').getPlainTxt());
			alert(arr.join('\n'))
		}
		function setContent(isAppendTo) {
			var arr = [];
			arr.push("使用editor.setContent('欢迎使用ueditor')方法可以设置编辑器的内容");
			UE.getEditor('editor').setContent('欢迎使用ueditor', isAppendTo);
			alert(arr.join("\n"));
		}
		function setDisabled() {
			UE.getEditor('editor').setDisabled('fullscreen');
			disableBtn("enable");
		}

		function setEnabled() {
			UE.getEditor('editor').setEnabled();
			enableBtn();
		}

		function getText() {
			//当你点击按钮时编辑区域已经失去了焦点，如果直接用getText将不会得到内容，所以要在选回来，然后取得内容
			var range = UE.getEditor('editor').selection.getRange();
			range.select();
			var txt = UE.getEditor('editor').selection.getText();
			alert(txt)
		}

		function getContentTxt() {
			var arr = [];
			arr.push("使用editor.getContentTxt()方法可以获得编辑器的纯文本内容");
			arr.push("编辑器的纯文本内容为：");
			arr.push(UE.getEditor('editor').getContentTxt());
			alert(arr.join("\n"));
		}
		function hasContent() {
			var arr = [];
			arr.push("使用editor.hasContents()方法判断编辑器里是否有内容");
			arr.push("判断结果为：");
			arr.push(UE.getEditor('editor').hasContents());
			alert(arr.join("\n"));
		}
		function setFocus() {
			UE.getEditor('editor').focus();
		}
		function deleteEditor() {
			disableBtn();
			UE.getEditor('editor').destroy();
		}
		function disableBtn(str) {
			var div = document.getElementById('btns');
			var btns = UE.dom.domUtils.getElementsByTagName(div, "button");
			for (var i = 0, btn; btn = btns[i++];) {
				if (btn.id == str) {
					UE.dom.domUtils.removeAttributes(btn, [ "disabled" ]);
				} else {
					btn.setAttribute("disabled", "true");
				}
			}
		}
		function enableBtn() {
			var div = document.getElementById('btns');
			var btns = UE.dom.domUtils.getElementsByTagName(div, "button");
			for (var i = 0, btn; btn = btns[i++];) {
				UE.dom.domUtils.removeAttributes(btn, [ "disabled" ]);
			}
		}

		function getLocalData() {
			alert(UE.getEditor('editor').execCommand("getlocaldata"));
		}

		function clearLocalData() {
			UE.getEditor('editor').execCommand("clearlocaldata");
			alert("已清空草稿箱")
		}
	</script>
</body>
</html>