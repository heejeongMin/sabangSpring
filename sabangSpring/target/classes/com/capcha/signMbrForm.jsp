<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script>
$(document).ready(function(){
	("#btn")on("click",function(){
		$.ajax({
			url : "https://openapi.naver.com/v1/captcha/nkey",
			dataType: 'json',
			
			
			
		})
		
		
	})
	
	
	
	
	
	
	
})
	


</script>
</head>
<body>
<button id = "btn"></button>

</body>
</html>