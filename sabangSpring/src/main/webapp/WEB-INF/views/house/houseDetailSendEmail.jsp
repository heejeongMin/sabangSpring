<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		$("#delete").on("click", function(e){
			var ppwd = prompt("비밀번호 입력","게시물 비밀번호를 입력해주세요");
			var pcode = $("h3").attr("data-pcode")
			location.href = "deleteBoard?pcode="+pcode+"&ppwd="+ppwd; 
		})
	})
</script>


<style>
th {
	text-align: center;
}
</style>

<form>
	<table>
		<tr height="1" bgcolor="#dddddd">
			<td colspan="4"></td>
		</tr>
		<tr>
			<td colspan="4">
				<h3 align="center">메일보내기</h3>
			</td>
		</tr>
		<tr height="1" bgcolor="#dddddd">
			<td colspan="4"></td>
		</tr>
		<tr>
			<th>받는 사람</th>
			<td><input type="text" value="${email}" size="50" readonly></td>
		</tr>
		<tr>
			<th>작성자</th>
			<td><input type="text" value="${memberInfo.username}" size="50" readonly></td>
		</tr>
		<tr>
			<th>내용</th>
			<td>
				<textarea style="resize: none;" name="memo" cols="50" rows="8" maxlength="200"></textarea>
			</td>
		</tr>
		<tr>
			<td>
				<input type="button" id="mesgSend" value="보내기">
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
		