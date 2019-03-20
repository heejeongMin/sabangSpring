$(document).ready(function(){
		
		$("form").on("submit", function(e){//submit전 유효성체크
			console.log(Number.isNaN(Number.parseInt($("input[name=whlflr]").val())));
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
			} else if ($("input[name=gimage]").val().length < 1){
				e.preventDefault();
				alert("사진을 등록하여주세요");
			}
		});//end for onSubmit
		
		
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