$(document).ready(function(){
	$("body").find(".goDetail").on("click", function(e){
		location.href = "houseDetailInfo?hcode="+$(e.target).attr("data-hcode");
	});//end $("body").find(".goDetail").on("click")
	
	
	//paging 버튼 ajax 처리 (search 랑 paging 두개다)
	$("body").find("a.unfocusedPage").on("click", function(e){
		var pagingBtn = $("body").find("a.unfocusedPage"); // 내가 누른 버튼
		var pagingType = pagingBtn.is(function(idx, ele){ // 내가 누른 버튼이 search로 찾아진 paging 인지 filter로 찾아진 paging인지 구별
			return $(ele).attr("class") == "unfocusedPage filterPages";
		});//end pagingType
		var url = (pagingType)? 'houseFilter':'houseList'; // pagingType에 따라 ajax가 가는 url이 다름
		$.ajax({
			type:'get',
			url:url,
			data:{ 
				curPage : this.text,
				filters : pagingData
			},
			success:function(data, status, xhr){
				$("div#section_wrap").find("div#mainWrap").remove().end().prepend($(data).find("div#mainWrap"));
			},
			error: function(xhr, status, error){console.log(xhr.status, status)}
		});//end ajax
	});//end $("body").find("a.unfocusedPage").on("click"
	
	
	 var swiper = new Swiper('.swiper-container', {
	      slidesPerView: 3,
	      spaceBetween: 30,
	      pagination: {
	        el: '.swiper-pagination',
	        clickable: true,
	        dynamicBullets: true,
	      },
	    });
});//end ready