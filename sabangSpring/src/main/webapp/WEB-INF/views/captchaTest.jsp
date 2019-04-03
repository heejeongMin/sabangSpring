<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<h1>Captcha</h1>
	<input type="button" value="이미지 새로고침" id="captImg">
	<div id="captcha_img_container">
		<span class="captcha_img"><img name='captchaImage'
			id='chptchaimg'
			src='https://openapi.naver.com/v1/captcha/ncaptcha.bin?key=${key}'
			width='30%' height='87' alt='자동입력 방지문자'></span>
	</div>
	<input type="text" id="input" name="input">
	<button id="captSub">제출</button>

</body>
</html>