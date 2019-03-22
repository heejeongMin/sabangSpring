$(document).ready(function(){
	
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
			} else if ($("input[name=himage]").val().length < 1){
				e.preventDefault();
				alert("사진을 등록하여주세요");
			} 
		});//end for onClick
		
		$("form#update").ajaxForm({
			type:'post',
			url: 'houseManaging/PUT',
			dataType: 'text',
			success:function(data, status, xhr){
				var mesg = (data==1)? "매물수정에 성공하였습니다. Sabang Continue~":"매물수정에 실패하였습니다. 관리자에게 문의해주세요.";
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