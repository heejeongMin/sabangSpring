<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="cache-control" content="max-age=0">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="-1">
<meta http-equiv="expires" content="Tue, 01 Jan 1980 11:00:00 GMT">
<meta http-equiv="pragma" content="no-cache">
<title>Insert title here</title>
</head>
<body>
	<div id="header">
		<div id="inner_header">
			<jsp:include page="common/top.jsp" flush="true" />
		</div>
	</div>
	<div id="section_wrap">
		<div id="article_delMbrld">
			<h1>회원 탈퇴 화면입니다.</h1>
			<jsp:include page="member/delMbrId.jsp" flush="true" />
		</div>
	</div>
</body>
</html>