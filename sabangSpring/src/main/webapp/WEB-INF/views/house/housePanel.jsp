<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="css/housePanel.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="js/housePanel.js"></script>
</head>
<body>
<form action="#" method="get" id="panel">
<table id="panel">
	<tr>
		<th></th>
		<th>코드</th>
		<th>주소</th>
		<th>보증금/전세가</th>
		<th>월세</th>
	</tr>
	<c:forEach var="house" items="${houseByAgent}">
		<tr data-attr="${house.HCODE}">
			<td><input type="checkbox" name="check" value="${house.HCODE}"></td>
			<td>${house.HCODE}</td>
			<c:set var="addr" value="${fn:split(house.ADDR, ' ')}"/>
			<td>${addr[2]}</td>
			<td>${house.DEPOSIT}</td>
			<td>${house.MRENT}</td>
		</tr>
	</c:forEach>
</table>
<div id="btnBox">
	<button id="delBtn">매물 삭제</button>
	<button id="registerBtn">매물 등록</button>
	<button id="updateBtn">매물 수정</button>
</div>
</form>
</body>
</html>

