<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0">
<title>用户查询与绑定</title>
<link href="style/css.css" rel="stylesheet" type="text/css">
</head>
<script src="js/jquery-1.7.2.min.js"></script>
<script src="js/jquery.json-2.3.min.js"></script>
<script src='js/knockout-2.1.0.js'></script>
<script src="js/knockout.mapping-latest.js"></script>
<script src="js/knockout.validation.min.js"></script>
<script src='js/af.js'></script>

<script type="text/javascript">
	function getUrlParam(name) {
		//构造一个含有目标参数的正则表达式对象 
		var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)");
		//匹配目标参数 
		var r = window.location.search.substr(1).match(reg);
		//返回参数值 
		if (r != null)
			return unescape(r[2]);
		return null;
	}
	function f_select(id) {
		var f_userid = document.getElementById("username").value;
		var xhttp = new XMLHttpRequest();
		xhttp.onreadystatechange = function() {
			if (xhttp.readyState == 4 && xhttp.status == 200) {
				alert(xhttp.responseText);
				var object = xhttp.responseText;
				var obj = JSON.parse(object);
				var f_name = obj.f_username;
				$("#name").html(f_name);
				var f_address = obj.f_address;
				$("#address").html(f_address);
				if (!f_name == "") {
					document.getElementById("sel").style.display = 'block';
				}
			}
		};
		xhttp.open("GET", "rs/weixin/one/" + f_userid, true);
		xhttp.send();
	}
	function f_bind() {
		var openid = getUrlParam('openid');
		alert(openid);
		var f_userid = document.getElementById("username").value;
		var xhttp = new XMLHttpRequest();
		xhttp.onreadystatechange = function() {
			if (xhttp.readyState == 4 && xhttp.status == 200) {

				var object = xhttp.responseText;
				var obj = JSON.parse(object);
				alert("-----" + obj);
				var zhye = obj.zhye;
				alert("-----" + zhye);
				var money = obj.money;
				alert("-----" + money);
				var arr1 = obj.arr;
				var arr = JSON.stringify(arr1);

				alert("-----" + arr);
				document.location.href = "qf1.jsp?openid=" + openid
						+ "&showwxpaytitle=1" + "&f_zhye=" + zhye + "&money="
						+ money + "&arr=" + arr;
			}
		};
		xhttp.open("GET", "rs/weixin/one/" + f_userid + "/" + openid, true);
		xhttp.send();

	}
</script>
<body>
	<header class="findstyle">
	<ul class="list">
		<li class="userid">用户编号：</li>
		<li class="textinput"><input type="text" value="" id=username></li>
		<li class="findbtn"><input type="button" value="查询"
			onclick="f_select();"></li>
		<br>
	</ul>
	</header>

	<section class="userinfo" style="display: none;" id="sel">
	<body onload="f_select()">
		<ul class="list">
			<li><strong>用户姓名：</strong><span id="name"></span></li>
			<li><strong>用户地址：</strong><span id="address"></span></li>
			<li>请您仔细核对自己的信息，然后再绑定</li>
		</ul>
	</section>
	<div class="btn">
		<input type="submit" value="绑定" class="bdbtn" onclick="f_bind();">
	</div>
</body>
</html>