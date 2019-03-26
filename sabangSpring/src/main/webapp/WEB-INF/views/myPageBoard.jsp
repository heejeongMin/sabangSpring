<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="css/mypageBoard.css">
</head>
<body>
<div id="header">
	<div id="inner_header">
		<jsp:include page="common/top.jsp" flush="true"/>
	</div>
</div>
<div id="section_mypage_menu">
	<div id="inner_menu">
		<jsp:include page="common/myPageMenu.jsp" flush="true"/>
	</div>
</div>
<div id="section_wrap">
	<div id="article_mypageBoard">
		<jsp:include page="member/myPageBoard.jsp" flush="true"/>
	</div>
</div>
</body>
</html>