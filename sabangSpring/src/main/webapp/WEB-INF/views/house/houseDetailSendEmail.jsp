<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
	})
</script>

<div id="pageTitle"><h2>메일 보내기</h2></div>
<form action="sendMail">
	<table id="wholeTable">
		<tr height="1" bgcolor="#dddddd"></tr>
		<tr>
			<th>받는 사람</th>
			<td>${email}</td>
		</tr>
		<tr>
			<th>작성자</th>
			<td>${memberInfo.username}</td>
		</tr>
		<tr>
			<th>매물코드</th>
			<td>${hcode}</td>
		</tr>
		<tr>
			<th>내용</th>
			<td>
				<textarea style="resize: none;" name="memo" cols="50" rows="8" maxlength="200"></textarea>
			</td>
		</tr>
		<tr>
			<td>
				<input type="submit" id="mesgSend" value="보내기">
	 		</td>
			<td>
				<input type="reset" value="다시쓰기">
			</td>
		</tr>
	</table>
	 
</form>
<c:set var="func" value="${func}" scope="session" />
<c:if test="${!(empty func)}">
	<script>
		window.close();
	</script>
</c:if>
<c:remove var="func" />		
		