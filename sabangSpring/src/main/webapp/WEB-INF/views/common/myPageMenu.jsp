<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<ul id="myPageMenu">
	<li><a href="myPage">내정보</a></li>
	<li><a href="#">연락한 부동산</a></li>
	<li><a href="myPageBoard">내가 쓴 리뷰</a></li>
	<li><a href="interestList">관심목록</a></li>
	<c:if test="${memberInfo.agent == 'Y'.charAt(0)}">
		<li><a href='houseUIController'>매물 관리</a></li>
	</c:if>
</ul>