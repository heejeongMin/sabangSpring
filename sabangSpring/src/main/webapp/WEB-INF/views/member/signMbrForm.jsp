<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="js/signEvents.js"></script><br>    

<h4 style="text-align:center">회원 가입 </h4>


<form action = "signMbr" id = "signForm" method = "get">

<input type = "radio" id = "selectMbr" name = "agent" value = 'N' checked = "checked" > 일반 회원
<input type = "radio" id = "selectAgnt" name = "agent" value = 'Y'> 공인중개사 <span class = "live" id ="type"></span>
<br>
 <input type="text" name="userid" id="userid" placeholder = "아이디"><span class = "live" id = "id"></span>
<br> 
<input type="password" name="passwd" id="passwd" placeholder="비밀번호" ><span class = "live" id ="pw"></span><br>
<input type="password" name="cnfPasswd" id="cnfPasswd" placeholder="비밀번호 확인" ><span class = "live" id ="cfpw"></span>
<br> 
<input type="text" name="username" id ="username" placeholder = "이름"><span class = "live" id = "name"></span><br> 
<input type = "text" name = "ssn1" id = "ssn1" placeholder = "주민등록번호 앞자리"> - <input type = "password" id = "ssn2" name = "ssn2" placeholder = "주민등록번호 뒷자리"><span class = "live" id = "ssn"></span> <br> 
<input type="text" name="post" id="sample4_postcode" placeholder="우편번호"></span>
<input type="button" onclick="sample4_execDaumPostcode()" value="우편번호 찾기"><br>
<input type="text" name="addr" id="sample4_roadAddress" placeholder="도로명주소"></span>
<input type="text" name="addr2" id="sample4_jibunAddress" placeholder="지번주소" style="display: none;">
<span id="guide"></span>
<br>
<select name="phone1" id = "phone1">
  <option value="010">010</option>
  <option value="011">011</option>
</select>-
<input type="text" name="phone2" id = "phone2">-<input type="text" name="phone3" id = "phone3"><span class = "live" id = "phone"></span>
<br>
<input type="text" name="email1" id="email1" placeholder = "이메일">@
<input type="text" name = "email2" id="email2" placeholder = "직접 입력">
	<select id="email3"><span class = "live" id ="email"></span>
		<option value="">직접 입력</option>
		<option value="naver.com">naver.com</option>
		<option value="hanmail.net">hanmail.net</option>
		<option value="yahoo.co.kr">yahoo.co.kr</option>
		<option value="paran.com">paran.com</option>
		<option value="nate.com">nate.com</option>
		<option value="empal.com">empal.com</option>
		<option value="dreamwiz.com">dreamwiz.com</option>
		<option value="hanafos.com">hanafos.com</option>
		<option value="korea.com">korea.com</option>
		<option value="chol.com">chol.com</option>
		<option value="gmail.com">gmail.com</option>
		<option value="lycos.co.kr">lycos.co.kr</option>
		<option value="netian.com">netian.com</option>
		<option value="hanmir.com">hanmir.com</option>
		<option value="sayclub.com">sayclub.com</option>
	</select> 
	<br><br>
	<c:set var = "key" item = "${key}" scope = "session"/>
	<div id = "capt" class = "live" data-fail ="" ></div>
	<div id = "captcha_space">
	<div id ="captcha_img_container">
	<span class="captcha_img"><img name='captchaImage' id='chptchaimg' src='https://openapi.naver.com/v1/captcha/ncaptcha.bin?key=${key}' width='30%' height='87' alt='자동입력 방지문자'></span>
	</div>
	<br><input type="button" value="이미지 새로고침" id="captImg"><br>
	<input type="text" id="input" name="input">
	<input type = "button" id = "captSub" value = "제출">
	</div>
	
<br>
<input type="submit" value="회원가입">
<input type="reset" value="취소"> 

</form>

<br>

<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script>
    //본 예제에서는 도로명 주소 표기 방식에 대한 법령에 따라, 내려오는 데이터를 조합하여 올바른 주소를 구성하는 방법을 설명합니다.
    function sample4_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 도로명 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var fullRoadAddr = data.roadAddress; // 도로명 주소 변수
                var extraRoadAddr = ''; // 도로명 조합형 주소 변수

                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraRoadAddr += data.bname;
                }
                // 건물명이 있고, 공동주택일 경우 추가한다.
                if(data.buildingName !== '' && data.apartment === 'Y'){
                   extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 도로명, 지번 조합형 주소가 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                if(extraRoadAddr !== ''){
                    extraRoadAddr = ' (' + extraRoadAddr + ')';
                }
                // 도로명, 지번 주소의 유무에 따라 해당 조합형 주소를 추가한다.
                if(fullRoadAddr !== ''){
                    fullRoadAddr += extraRoadAddr;
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('sample4_postcode').value = data.zonecode; //5자리 새우편번호 사용
                document.getElementById('sample4_roadAddress').value = fullRoadAddr;
                document.getElementById('sample4_jibunAddress').value = data.jibunAddress;

                // 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.
                if(data.autoRoadAddress) {
                    //예상되는 도로명 주소에 조합형 주소를 추가한다.
                    var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
                    document.getElementById('guide').innerHTML = '(예상 도로명 주소 : ' + expRoadAddr + ')';

                } else if(data.autoJibunAddress) {
                    var expJibunAddr = data.autoJibunAddress;
                    document.getElementById('guide').innerHTML = '(예상 지번 주소 : ' + expJibunAddr + ')';

                } else {
                    document.getElementById('guide').innerHTML = '';
                }
            }
        }).open();
    }
    
    
    
    /////CAPTCHA
		
    //제출
    	$("#captSub").on("click", function(){ //버튼 선택시
    		$.ajax({
			type:'get',
			url:'checkResult',
			data:{ // checkResult 컨트롤러에 해당 데이터 전송
				inputVal:$("#input").val(), 
				key: "${key}",
				isFailed : $("#capt").attr('data-fail').trim()
			},
			success:function(data, status, xhr){
				if (data == 'false'){ //0. 컨트롤러 다녀온 상황, 값이 일치하지 않음.
					$("#capt").text('문자열이 일치하지 않습니다, 다시 시도해주세요.')
					$("#capt").attr('data-fail','fail')
					$.ajax({
						url:'captcha', // 1. 컨트롤러 다녀옴, 키 새로 받아옴
						success:function(mykey, status, xhr){
							$(".captcha_img").remove();
							$("#captcha_img_container").html('<span class="captcha_img"><img name="captchaImage" data-key="'+mykey+'"id="chptchaimg" src="https://openapi.naver.com/v1/captcha/ncaptcha.bin?key='+ mykey +'" width="30%" height="87" alt="자동입력 방지문자?????"></span>')
							var newKey = mykey
							$.ajax({
								url : 'newKey',
								data : {
									newKey : mykey
								},
								success:function(newkey, status, xhr){
									console.log("newKey????: ", newKey)
								},
								error : function (xhr,status,error){
									console.log(error)
								}
							
							})
						
					
						}
						,
						error:function(xhr, status, error){
						console.log(xhr.status, error);
						}
					});//end inner ajax
				}else{
					$("#captcha_space").hide();
					$("#capt").text('인증되었습니다.')
				}
				console.log("data-innerKey, outer", $("#capt").attr('data-innerKey'))
			},
			error:function(xhr, status, error){
				console.log(xhr.status, error);
		}
		});//ajax
    	});
	
     //이미지 새로고침
	$("#captImg").on("click", function(){
		$.ajax({
			url:'captcha',
			success:function(mykey, status, xhr){
				console.log(mykey)
				$(".captcha_img").remove();
				$("#captcha_img_container").html('<span class="captcha_img"><img name="captchaImage" data-key="'+mykey+'"id="chptchaimg" src="https://openapi.naver.com/v1/captcha/ncaptcha.bin?key='+ mykey +'" width="30%" height="87" alt="자동입력 방지문자!!!"></span>')
			}
			
		});//ajax
	});
	 
	
	
    </script>
   
