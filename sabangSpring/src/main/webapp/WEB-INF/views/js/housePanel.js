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
								if ($(ele).attr("data-attr") == delList[i]) {
									console.log(1);
									$(ele).remove();
								}
								;
							}
						});
						mesg = "성공적으로 삭제되었습니다. 다음 매물을 기다릴게요~";
					} else {
						mesg = "삭제 실패하였습니다. 관리자에게 문의해주세요.";
					}
					alert(mesg);
				},
				error : function(xhr, status, data) {
					console.log(status);
				}
			});
		}
	});

	$("#updateBtn").on("click", function(e) {// 수정 버튼 클릭시
		e.preventDefault();
		var count = 0;
		var item = "";
		$("input[name=check]").each(function(idx, ele) {// 아무것도 체크하지 않으면 alert
			if (ele.checked) {
				count++;
				item = $(ele).val();
			}
		});

		if (count == 0) {
			alert("수정할 매물을 선택해주세요");
		} else if (count > 1) {
			alert("한번에 하나의 매물만 수정이 가능합니다. 매물 한개만 체크하고 수정버튼을 눌러주세요.");
		} else {
			location.href = "houseUIController?work=update&hcode=" + item;
		}
	});

});// end ready
