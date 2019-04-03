$(document).ready(function() {

	//-- 메뉴 드롭다운 슬라이드 효과
	$("li.filterOpt").on("click", function(e) {
		$("li.filterOpt").find("ul.sublist").each(function(idx, ele) {// 다른 버튼을 누르면 이미 열린애들은 닫아주기
			if (ele.clientHeight != 0) $(ele).hide();
		});// end ul.sublist반복
		$(e.target).find("ul.sublist").slideToggle();
	});// end .filterOpt onClick

	//-- sub메뉴가 열렸을 때 누르면 부모인 li.filterOpt에 이벤트 전파 방지
	$("ul.sublist").on("click", function(e) {
		e.stopPropagation();
	});// end ul.sublist onClick

	//-- 버튼 눌렀다가 다른데 바탕화면 등등 누르면 드롭다온 사라짐.
	$(document).mouseup(function(e) {
		if ($(e.target).parents().filter("ul#filterList").length == 0) {
			$("li.filterOpt").find("ul.sublist").each(function(idx, ele) {
				if (ele.clientHeight != 0) $(ele).hide();
			});// end ul.sublist반복
		}//end if
	});// end mouseup

	//-- 가격대 버튼 드롭다운 range 바
	$("input[type=range]").on("change", function(e) {
		var result = $(e.target).val();
		if ($(e.target).val().length > 4) {
			var million = $(e.target).val().charAt(0);
			var hundred = $(e.target).val().substring(1);
			result = million + "억" + hundred;
		}
		$(".searchRange").text(result + "만원~무제한");
	});// end input[type=range] onChagne

	//-- 검색어 없이 search 버튼 눌렀을 때 유효성 체크
	$("button#searchBtn").on("click", function(e) {
		if ($("input[name=search]").val().trim().length == 0) {
			e.preventDefault();
			alert("검색어를 입력하여주세요");
		}
	});// end searchBtn onClick

	var yrent; // 가격대 조절 바 값을 저장
	//-- yrent의 값 저장은 바를 조절 했을 때만
	$("input[type=range]").on("change", function(e) {
		setTimeout(function(e) {
			yrent = $("input[type=range]").val();
			$("input.filter, select.filter").trigger("change");
		});
	});// end input[type=range] onChange

	//-- 필터버튼을 눌러 조건들을 선택했을 때 모아서 컨트롤러로 보냄
	$("input.filter, select.filter").on("change", function() {
		var filters = []; //사용자가 선택한 값을 배열에 저장해서 컨트롤러로 보냄
		
		//1. 체크박스에 있는 애들은 선택된 만큼 돌면서 배열에 저장
		$("input.filter").each(function(idx, ele) {
			if (ele.checked) filters.push($(ele).val());
		});// end each

		//2. dropdown에 있는 애는 선택해주세요가 아니고 실제 값을 선택했을 때 filters 배열에 저장
		if ($("select.filter").val() != "선택해주세요") filters.push($(this).val());
		
		//3. yrent 값이 저장되어 있을 때만 filters 배열에 저장
		if (yrent != undefined) filters.push("yrent" + yrent);

		//4. 클라이언트에서 선택된 값을 filters에 저장한 후에 ajax 시작//////////////////////
		$.ajax({
			type : 'get',
			url : 'houseFilter',
			data : { filters : filters.toString() },
			success : function(data, status, xhr) {
				$("div#section_wrap").find("div#mainWrap").remove().end().prepend($(data).find("div#mainWrap"));
			},
			error : function(xhr, status, error) { console.log(xhr.status, status) }
		});// end ajax

	}); // end input[name=rtype] onChange

	//-- 필터 초기화 버튼 클릭 시 ajax로 신매물/핫매물 보이는 화면으로 이동
	$("li#filterInitializer").on("click", function(e) {
		$.ajax({
			type : 'get',
			url : 'houseOverview',
			success : function(data, status, xhr) {
				//1. 체크박스에 체크된 애들 체크 해제
				$("input.filter").each(function(idx, ele) {
					if (ele.checked) ele.checked = false;
				});// end each
				//2. dropdown에 있는 애는 선택해주세요로 초기화
				$("select.filter").find("option[value='선택해주세요']").prop("selected", true);
				//3. range 값 초기화
				$("input[type=range]").prop("value", 10000);
				$("div#section_wrap").find("div#mainWrap").remove().end().prepend($(data).find("div#mainWrap"));
				
			},
			error : function(xhr, status, error) { console.log(xhr.status, status) }
		});// end ajax
	});//end "li#filterInitializer" onClick
	

});// end ready
