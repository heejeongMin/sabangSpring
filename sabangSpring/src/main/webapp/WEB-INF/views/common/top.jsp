<%@page import="com.dto.AgentDTO"%>
<%@page import="com.dto.MemberDTO"%> 
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<link rel="stylesheet" href="css/sabang.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript">
$(document).ready(function(){

	$("li.filterRgn").on("click", function(e){
		$("li.filterRgn").find("ul.sublist").each(function(idx, ele){//다른 버튼을 누르면 이미 열린애들은 닫아주기
			if(ele.clientHeight != 0) $(ele).hide(); 
		});//end ul.sublist반복
		
	$(e.target).find("ul.sublist").slideToggle();
	});//end .filterRgn onClick
	
	//sub메뉴가 열렸을 때 누르면 부모인 li.filterRgn에 이벤트 전파 방지
	$("ul.sublist").on("click", function(e){
		e.stopPropagation();
	});//end ul.sublist onClick

	$(document).mouseup(function(e){// 버튼 눌렀다가 다른데 누르면 드롭다온 사라짐. 
		if($(e.target).parents().filter("ul#filterList").length == 0){
			$("li.filterRgn").find("ul.sublist").each(function(idx, ele){//다른 버튼을 누르면 이미 열린애들은 닫아주기
				if(ele.clientHeight != 0) $(ele).hide(); 
			});//end ul.sublist반복
		};
	});//end mouseup 
	
	$("input[name='region']").on("change", function(e){
		if ($(this).val() != '신촌') {
			alert("준비중입니다.")
		}
	});
	
	$("img#logoImg").on("click", function(e){
		location.href="/sabang/";
	});
	
	
});//end ready
</script>
<a href="/sabang" id="logo"></a>
	<c:choose>
             <c:when test="${memberInfo ne null}">
             <c:set var="name" value="${memberInfo.username}" scope="request" />
				<span id="welUser"><c:out value="${name}" />님을 위한 사방팔방 곳곳의 방</span>
				<ul id="loginOnMenu">
					<li class="filterRgn">지역별 매물
						<ul class="sublist subListHide" id="rgn">
							<li class="subFilter">
								<div class="rangeWrapRgn" >
									<input type="radio" name="region" class="filterRgn" value="신촌">신촌<br>
									<input type="radio" name="region" class="filterRgn" value="홍대">홍대<br>
									<input type="radio" name="region" class="filterRgn" value="안암">안암
								</div>
							</li>
						</ul>
					</li>

					<li><a href="logout" id ="logout">로그아웃</a></li>
					<li><a href="myPage">mypage</a></li>
				</ul>
				
             </c:when>

             <c:when test="${agentInfo ne null}">
              <c:set var="name" value="${agentInfo.agntname}" scope="request" />
				<span id="welUser"><c:out value="${name}" />님을 위한 사방팔방 곳곳의 방</span>
				
				<ul id="loginOnMenu">
					<li class="filterRgn">지역별 매물
						<ul class="sublist subListHide" id="rgn">
							<li class="subFilter">
								<div class="rangeWrapRgn" >
									<input type="radio" name="region" class="filterRgn" value="신촌">신촌<br>
									<input type="radio" name="region" class="filterRgn" value="홍대">홍대<br>
									<input type="radio" name="region" class="filterRgn" value="안암">안암
								</div>
							</li>
						</ul>
					</li>
					
					<li><a href="logout">로그아웃</a></li>
					<li><a href="myPage">mypage</a></li>
				</ul>
             </c:when> 
              
              <c:otherwise>
              	<ul id="loginOffMenu">
              		<li><a href="loginUI" id="login">로그인</a></li>
              		<li><a href="signMbrUI">회원가입</a></li>
              	</ul>
              </c:otherwise>
       </c:choose>
       	</span>
<script type="text/javascript" src="js/jquery-3.3.1.js"></script>

       	
       	
       	
	
       	
