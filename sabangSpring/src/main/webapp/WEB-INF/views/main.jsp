<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="cache-control" content="max-age=0">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="-1">
<meta http-equiv="expires" content="Tue, 01 Jan 1980 11:00:00 GMT">
<meta http-equiv="pragma" content="no-cache"> 
<title>Insert title here</title>
<link rel="stylesheet" href="css/main.css">
<c:set var="mesg" value="${mesg}"/>
<c:if test="${!(empty mesg)}">
	<script>
		alert('${mesg}');
	</script>
</c:if>
</head>
<body>
	<div id="wrap"></div>
	<div id="header">
		<div id="inner_header">
			<jsp:include page="common/top.jsp" flush="true" />
		</div>
	</div>
	<div id="section_wrap">
		<div id="article_main">
			<!-- <a href="houseOverview">houseOverview</a> -->
		</div>
	</div>
</body>
</html>
