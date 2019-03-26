$(document).ready(function() {
	
	$(".live").css("font-size", "9pt"); 
		
	$("#userid").on("keyup", function(){
		$.ajax({
			type:"post",
			url : "idCheck",
			data : {
				id : $("#userid").val().trim()
			},
			dataType : "text",
			headers: {	"Content-Type":"application/json"
			},
	        success:function(mesg){
	        	if (mesg == "N"){
	        		mesg = "이미 사용 중인 아이디입니다."
	        	}else if ($("#userid").val().length == 0){
	        		mesg = "아이디를 입력해주세요."
	        	}
	        	else{
	        		mesg = ""
	        	}
	        	$("#id").text(mesg);	
	        },
			 error : function(xhr, status, e) {  
				   console.log(e);
			 }
		})			
	})
	
	
	$("#ssn2").on("keyup", function(){
		var ssn = $("#ssn1").val()+'-'+$("#ssn2").val();
		$.ajax({
			type:"post",
			url : "ssnCheck",
			data : {
				ssn : $("#ssn1").val().trim()+'-'+$("#ssn2").val().trim()
			},
			dataType : "text",
			headers: {	"Content-Type":"application/json"
			},
			success:function(mesg){
	        	if (mesg == "N"){
	        		mesg = "이미 가입된 주민등록번호입니다."
	        			console.log("N")
	        	}else{
	        		mesg = ""
	        			console.log("Y")
	        	}
	        	$("#ssn").text(mesg);	
	        	console.log("out")
	        },
			 error : function(xhr, status, e) {  
				   console.log(e);
			 }
		})			
	})
	
	$("#phone3").on("keyup", function(){
		$.ajax({
			type:"post",
			url : "phoneCheck",
			data : {
				phone :  $("#phone1").val().trim()+$("#phone2").val().trim()+$("#phone3").val().trim() 
			},
			dataType : "text",
			headers: {	"Content-Type":"application/json"
			},
	        success:function(mesg){
	        	if (mesg == "N"){
	        		mesg = "이미 등록된 핸드폰 번호입니다."
	        	}else{
	        		mesg = ""
	        	}
	        	$("#phone").text(mesg);	
	        },
			 error : function(xhr, status, e) {  
				   console.log(e);
			 }
		})			
	})
	
		$("#cnfPasswd").on("keyup", function() {
			var passwd = $("#passwd").val();
			var mesg = null
			if (passwd != $(this).val()) {
				mesg = "비밀번호가 일치하지 않습니다.";
			}
			$("#cfpw").text(mesg);
		}); //end equal check password
	
	$("#passwd").on("keyup", function() {
		var passwd = $("#cnfPasswd").val();
		var mesg = null
		if ($("#cnfPasswd").val().length != 0){
		if (passwd != $(this).val() ) {
			mesg = "비밀번호가 일치하지 않습니다.";
		}
		}
		$("#cfpw").text(mesg);
	}); //end equal check password

	
	

	/*
	 * 
	 * 
	$("#passwd").on("keyup", function(){
		
		
		var passRule = /[^0-9]/g ;
		
		$(this).val($(this).val().replace(passRule,''));
		

		console.log($("#passwd").val())
		$.ajax({
			type:"get",
			url : "signMbrForm",
			data : {
				data : $("#passwd").val()
			},
			dataType : "text",
	        success:function(data){
	        	var mesg = "";
	        	if (passRule.test(data)){
	        		mesg = "비밀번호는 4자리 ~ 20자리 숫자만을 허용합니다."	
	        	}else{
	        		mesg = "사용 가능한 비밀번호입니다."
	        	}
	        
	        	$("#pw").text(mesg);
	        },
			 error : function(xhr, status, e) {  
				   console.log(e);
			 }
		})			
	})
	*/
		
		
		$("#signForm").on("submit", function(event){
			/* space check */
			var userid = $("#userid").val();
			var passwd = $("#passwd").val();
			var cnfPw = $("#cnfPasswd").val();
			var username = $("#username").val();
			var ssn1  = $("#ssn1").val();
			var ssn2  = $("#ssn2").val();
			var phone1 = $("#phone1").val();
			var phone2 = $("#phone2").val();
			var phone3 = $("#phone3").val();
			var addr = $("#sample4_roadAddress").val();
			var email1 =  $("#email1").val();			
			var email2 =  $("#email2").val();			
			var email3 =  $("#email3").val();	
			var mesg = null;
			/* Regular Expression */
			var idRule = /^[^ㄱ-힣!@#$^&*()<>+?/{}.-]{4,10}$/gi;
			var passRule = /^[a-z0-9]{4,20}$/;
			var nameRule = /^[가-힣]{2,4}$/;
			var ssn1Rule = /^[0-9]{6}$/;
			var ssn2Rule = /^[0-9]{7}$/;
			var pnumRule = /^[0-9]{3,4}$/;
			var emailRule = /^[^ㄱ-힣]{4,15}$/;
			var idM= "아이디를 입력해주세요.";
			var pwM = "비밀번호를 입력해주세요.";
			var unM = "이름을 입력해주세요.";
			var phM = "핸드폰 번호를 입력해주세요.";
			var emM = "이메일을 입력해주세요.";
			var snM = "주민등록번호를 입력해주세요.";
			var adM = "주소를 입력해주세요.";
			var unRM = "이름은 2자 이상 4자 이하의 한글만을 허용합니다.";
			var idRM = "아이디는 2자 이상 10자 이하의 한글과 특수문자를 제외한 문자를 허용합니다.";
			var pwRM = "비밀번호는 6자리수만을 허용합니다.";
			var snRM =  "주민등록번호 앞자리는 6자리수만을 허용합니다.";
			var snRM2 = "주민등록번호 뒷자리는 7자리수만을 허용합니다.";
			var pnRM = "핸드폰번호는 3자리수 이상 자리수 이하 숫자만을 허용합니다"
			var emRM = "이메일은 4자 이상 15자 이하 한글을 제외한 문자만을 허용합니다.";
			
			
			
			if (email2.length == 0 || (!emailRule.test(email1) ||!emailRule.test(email2)) ){
				event.preventDefault();
				if (email2.length == 0){
					$("#email").text(emM);
				}else if(!emailRule.test(email1) ||!emailRule.test(email2)  ) { 
					$("#email").text(emRM);
				}
			};
			
			if ( (phone2.length == 0 || phone3.length == 0)|| (!pnumRule.test(phone2) ||!pnumRule.test(phone3)) ){
				event.preventDefault();
				if (phone2.length == 0 || phone3.length == 0){
					$("#phone").text(phM);
				}else if(!pnumRule.test(phone2) ||!pnumRule.test(phone3)) { 
					$("#phone").text(pwRM);
				}
			} 
			if( ssn1.length == 0 || ssn2.length == 0 || !ssn1Rule.test(ssn1) || !ssn2Rule.test(ssn2) ){
				event.preventDefault();
				if(ssn1.length == 0 || ssn2.length == 0){
					$("#ssn").text(snM);
				}else if(!ssn1Rule.test(ssn1)) { 
					$("#ssn").text(snRM);
				}else if(!ssn2Rule.test(ssn2)) { 
					$("#ssn").text(snRM2);
				} 
			}

			if (username.length == 0 || !nameRule.test(username)){
				event.preventDefault();
				if (username.length == 0){
					$("#name").text(unM);
				}else if(!nameRule.test(username)) {
					$("#name").text(unRM);
				} 
			}
			
			if(passwd.length == 0 ||!passRule.test(passwd) ){
				event.preventDefault();
				if(passwd.length == 0) {
					$("#pw").text(pwM);
				}else if(!passRule.test(passwd)) { 
					$("#pw").text(pwRM);				
				}
			}		 
			
			if (userid.length == 0 || !idRule.test(userid)){
				event.preventDefault();
				if (userid.length == 0){
					$("#id").text(idM);
				}else if(!idRule.test(userid)){ 
					$("#id").text(idRM);				
				} 
			} 
			
//			if ( $("#id").text().length == 0  || $("#ssn").text().length == 0  || $("#phone").text().length == 0){
//				event.preventDefault();
//				alert("회원가입을 위해서는 중복 데이터를 수정해야합니다.");
//			}
			
		}); //end check null and multipled ID and regular expression ==> submit event
		
	
		
		$("#email3").on("click", function(){
			var email = $(this).val();
			  $("#email2").val(email);
		})// end select email
		
		$("body").on("keyup", "input[type]", function() {
				$(this).val($(this).val().replace(/(\s*)/g, ""));
		});
});
