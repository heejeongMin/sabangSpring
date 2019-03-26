<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="css/houseDetailInfo.css">
</head>
<body>
	<div id="header">
		<div id="inner_header">
			<jsp:include page="common/top.jsp" flush="true"/>
		</div>
	</div>
	<div id="section_wrap">
		<jsp:include page="house/houseDetailInfo.jsp" flush="true"/>
	</div>
</body>
</html>