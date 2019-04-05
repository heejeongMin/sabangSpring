$(document).ready(function() {
	$("#registerBtn").on("click", function(e) {// 등록버튼 클릭시
		e.preventDefault();
		location.href = "houseUIController?work=register";
	});

	$("#delBtn").on("click", function(e) {// 삭제버튼 클릭시
		var count = 0;
		$("input[name=check]").each(function(idx, ele) {// 아무것도 체크하지 않으면 alert
			if (ele.checked)
				count++;
		});
		if (count == 0) {
			e.preventDefault();
			alert("삭제할 매물을 선택해주세요");
		} else {
			e.preventDefault();
			var delList = [];
			$("input[name=check]").each(function(idx, ele) {// check 박스 체크된 애들을
															// delList에 저장
				if (ele.checked)
					delList.push($(ele).val());
			});

			$.ajax({// delList를 들고 DB에서 삭제하기
				type : 'get',
				url : 'houseManaging/DELETE/' + delList,
				dataType : 'text',
				success : function(data, status, xhr) {
					var mesg = "";
					if (data == "1") {
						$("tr").each(function(idx, ele) {
							for (var i = 0; i < delList.length; i++) {
								if ($(ele).attr("data-attr") == delList[i]) $(ele).remove();
							}//end for
						});
						mesg = "성공적으로 삭제되었습니다. 다음 매물을 기다릴게요~";
					} else {
						mesg = "삭제 실패하였습니다. 관리자에게 문의해주세요.";
					}
					alert(mesg);
				},
				error : function(xhr, status, data) { console.log(status); }
			});//end ajax
		}//end if~else
	});//end delete

	$("td.showHouse").on("click", function(e){
		location.href = "houseUIController?work=update&hcode=" + $(e.target).parent().attr("data-attr");
		$("input").each(function(idx,ele){
			$(ele).prop("readonly", true)
		});
		$("textarea").each(function(idx,ele){
			$(ele).prop("readonly", true);
		});
	}); // 매물 수정 완료 시 readonly 효과
	
	$("#accordian h3").on("click", function(e){
		$(e.target).next().slideToggle("slow");
	});// panel 메뉴 아코디언 효과
	
	
	$("h5#records").on("click", function(e){
		$(".modal-dialog-Line").toggle();
		if($(".modal-dialog-Pie").clientWidth != 0) $(".modal-dialog-Pie").hide();
	});
	$(".modal-dialog-Line .btn").on("click", function(e){
		$(".modal-dialog-Line").hide();
	})
	
	$("h5#popularity").on("click", function(e){
		$(".modal-dialog-Pie").toggle();
		if($(".modal-dialog-Line").clientWidth != 0) $(".modal-dialog-Line").hide();
	});
	$(".modal-dialog-Pie .btn").on("click", function(e){
		$(".modal-dialog-Pie").hide();
	})


});// end ready
