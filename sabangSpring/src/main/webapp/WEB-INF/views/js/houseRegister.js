$(document).ready(function(){
		$("select[name=htype]").on("change", function(e){ //상품 코드 값 정하기
			$.ajax({
				type:'get',
				url:'houseManaging/GET/'+ $(e.target).val(),
				dataType:'text',
				success:function(data, status, xhr){
					var newCode = Number.parseInt(data)+1;
					switch($(e.target).val()){
					case "o": 
						if(newCode < 10){
							$("#hcode>input").val("O00"+newCode);
						} else if (newCode < 100){
							$("#hcode>input").val("O0"+newCode);
						} else {
							$("#hcode>input").val("O"+newCode);
						}
						 break;
					case "t": 
						if(newCode < 10 ){
							$("#hcode>input").val("T00"+newCode); 
						} else if (newCode < 100){
							$("#hcode>input").val("T0"+newCode);
						} else {
							$("#hcode>input").val("T"+newCode);
						}
						break;
					case "f": 
						if(newCode < 10){
							$("#hcode>input").val("F00"+newCode);
						} else if (newCode < 100){
							$("#hcode>input").val("F0"+newCode);
						} else {
							$("#hcode>input").val("F"+newCode);
						}
						 break;
					case "p":
						if(newCode < 10){
							$("#hcode>input").val("P00"+newCode);
						} else if (newCode < 100){
							$("#hcode>input").val("P0"+newCode);
						} else {
							$("#hcode>input").val("P"+newCode);
						}
						break;
					}
				},
				error:function(xhr, status, data){ console.log(status); }
			});//end ajax
		});//end select gcategory change
		
		$("input[type=submit]").on("click", function(e){//submit전 유효성체크
			if($("select[name=gcategory]").val()==""){
				e.preventDefault();
				alert("상품 카테고리를 선택하여주세요");
			}  else if(Number.isNaN(Number.parseInt($("input[name=area]").val()))){
				e.preventDefault();
				alert("평수는 숫자로만 입력해주세요.");
			} else if (Number.isNaN(Number.parseInt($("input[name=flr]").val()))){
				e.preventDefault();
				alert("매물층수는 숫자로만 입력해주세요.");
			} else if (Number.isNaN(Number.parseInt($("input[name=whflr]").val()))){
				e.preventDefault();
				alert("건물층수는 숫자로만 입력해주세요.");
			} 
		});//end for onClick
		
			$("form#register").ajaxForm({
				type:'post',
				url: 'houseManaging/POST',
				dataType: 'text',
				success:function(data, status, xhr){
					var mesg = (data==1)? "매물등록에 성공하였습니다. Happy Sabang~":"매물등록에 실패하였습니다. 관리자에게 문의해주세요.";
					alert(mesg);
					$("input").each(function(idx,ele){
						$(ele).prop("readonly", true);
					});
					$("textarea").each(function(idx,ele){
						$(ele).prop("readonly", true);
					});
		 		},
		 		error: function(xhr, status, error){console.log(xhr.status, status)}
			});
		
		$("textarea").on("keyup", function(e){//상품설명 글자수 세기
			$("p#textLength>span").text($(e.target).val().length);
		});//end textarea onKeyup
		
		$(".arrows").on("click", function(e){
			if($("div#lastPage").attr("class") == "swiper-slide swiper-slide-active"){
				$("div#registerDiv").css("visibility", "visible");
			} else {
				$("div#registerDiv").css("visibility", "hidden");
			}
			
		});
		
		
	});//end ready