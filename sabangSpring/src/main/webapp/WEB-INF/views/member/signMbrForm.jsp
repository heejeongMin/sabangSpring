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
<input type="text" name="post" id="sample4_postcode" placeholder="우편번호"><span class = "live" id ="post"></span>
<input type="button" onclick="sample4_execDaumPostcode()" value="우편번호 찾기"><br>
<input type="text" name="addr" id="sample4_roadAddress" placeholder="도로명주소"><span class = "live" id ="addr"></span>
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
	<!-- <span id="direct_email" style="margin-top:3px;display:none">
        <input type="text" name="email3" id="email3"  class="MS_input_txt" value="" size="15" maxlength="25"  onchange="this.form.emailcheck.value=''" />
    </span>   -->
	
<br>
<input type="submit" value="회원가입">
<input type="reset" value="취소"> 
</form>

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
</script>