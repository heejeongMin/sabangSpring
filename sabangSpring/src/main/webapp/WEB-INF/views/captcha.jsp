<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script>
$(document).ready(function(){
	
	
	
	$("#captBtn").on("click", function(){
		$.ajax({
			type:'get',
			url:'checkResult',
			data:{
				inputVal:$("#input").val(),
				key: "${key}"
			},
			success:function(data, status, xhr){
				console.log(data);
			},
			error:function(xhr, status, error){
				console.log(xhr.status, error);
		}
		});//ajax
	});

	$("#").on("click", function(){
		$.ajax({
			url:'captcha.jsp',
			success:function(data, status, xhr){
				console.log(data);
			},
			error:function(xhr, status, error){
				console.log(xhr.status, error);
		}
		});//ajax
	});
 
	
})//end doc


</script>
</head>
<body>
<h1>Captcha</h1>
	<input type="button" value="이미지 새로고침" id="btn">
	<span class="captcha_img"><img name='captchaImage' id='chptchaimg' src='https://openapi.naver.com/v1/captcha/ncaptcha.bin?key=${key}' width='30%' height='87' alt='자동입력 방지문자'></span>
	<input type="text" id="input" name="input">
	<button id = "captBtn">제출</button>
</body>
</html>