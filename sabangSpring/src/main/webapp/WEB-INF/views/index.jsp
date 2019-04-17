<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8">
<title>Practice</title>
<base href="/sabang/angular/">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<link href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<script	src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.0/js/bootstrap.min.js"></script>
<script	src="http://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<style type="text/css">
a#oldVersion{
	position: absolute;
    right: 0;
    background-color: orange;
    padding: 10px;
    margin: 0 10px;
    border-radius: 10px;
    color: white;
    font-weight: bold;
    text-decoration: none;
}
a#oldVersion:hover{
	background-color: greenyellow;
	color:darkblue;
}
</style>
</head>
<body>
	<a id="oldVersion" href="/sabang/houseUIController">이전 버전으로 돌아가기</a>
	<app-root></app-root>
	<script type="text/javascript" src="../js/runtime.js"></script>
	<script type="text/javascript" src="../js/es2015-polyfills.js" nomodule></script>
	<script type="text/javascript" src="../js/polyfills.js"></script>
	<script type="text/javascript" src="../js/styles.js"></script>
	<script type="text/javascript" src="../js/vendor.js"></script>
	<script type="text/javascript" src="../js/main.js"></script>
</body>
</html>