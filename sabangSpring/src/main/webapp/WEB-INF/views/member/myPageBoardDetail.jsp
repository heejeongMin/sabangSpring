<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="mesg" value="${mesg}" />
<c:if test="${!(empty mesg)}">
	<script>
		alert('${mesg}');
	</script>
</c:if>
<c:remove var="mesg" />


<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		$("#delete").on("click", function(e) {
			var ppwd = prompt("삭제하시겠습니까?", "게시물 비밀번호를 입력해주세요");
			var conf = $("h3").attr("data-ppwd")
			var pcode = $("h3").attr("data-pcode")
			if (ppwd == conf){
			location.href = "deleteBoard?pcode=" + pcode
			}else {
				alert("게시물 비밀번호를 확인해주세요")
			}
		})

		$("#edit").on("click", function(e) {
			var ppwd = prompt("수정하시겠습니까?", "게시물 비밀번호를 입력해주세요");
			var pcode = $("h3").attr("data-pcode")
			var conf = $("h3").attr("data-ppwd")
			if (ppwd == conf){
			location.href = "postBoard?pcode=" + pcode;
			}else {
				alert("게시물 비밀번호를 확인해주세요")
			}
		})
	})
</script>


<style>
th {
	text-align: left;
}
</style>



<c:forEach var="boardList" items="${boardList}" varStatus="status">
	<c:if test="${boardList.PCODE eq param.pcode }">
		<table>
			<h3 data-pcode="${boardList.PCODE}" data-ppwd ="${boardList.PPWD}">${boardList.TITLE}</h3>
			<hr>
			<tr>
				<th>작성자</th>
				<td>${boardList.USERID}</td>
			</tr>
			<tr>
				<th>게시시간</th>
				<td>${boardList.PDATE}</td>
			</tr>
			<tr>
				<th>내용</th>
				<td>${boardList.CONTENT}</td>
			</tr>
		</table>
		<br>
			<input type="button" id="edit" class="alter" value="수정">
			<input type="button" id="delete" class="alter" value="삭제">
	</c:if>
</c:forEach>


<%-- 
<c:forEach var="boardList" items="${boardList}" varStatus="status">
	<c:if test="${boardList.PCODE eq param.pcode }">
		<table>
			<h3 data-pcode="${boardList.PCODE}" data-ppwd ="${boardList.PPWD}">${boardList.TITLE}</h3>
			<hr>
			<tr>
				<th>작성자</th>
				<td>${boardList.USERID}</td>
			</tr>
			<tr>
				<th>게시시간</th>
				<td>${boardList.PDATE}</td>
			</tr>
			<tr>
				<th>내용</th>
				<td>${boardList.CONTENT}</td>
			</tr>
		</table>
		<br>
		<c:if test="${boardList.USERID eq memberInfo.userid }">
			<input type="button" id="edit" class="alter" value="수정">
			<input type="button" id="delete" class="alter" value="삭제">
		</c:if>
	</c:if>
</c:forEach>
 --%>

<c:set var="func" value="${func}" scope="session" />
<c:if test="${!(empty func)}">
	<script>
		window.close();
	</script>
</c:if>
<c:remove var="func" />


