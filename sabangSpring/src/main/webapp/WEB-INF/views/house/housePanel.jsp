<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css"> -->
<link rel="stylesheet" href="css/housePanel.css"></link>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script> <!--Load the AJAX API-->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script><!-- for modal -->
<script src="js/housePanel.js"></script>
<style>
	div#drawChartRecords div[dir="ltr"] {top:110px;}
	div#drawChartRecords div[dir="ltr"] svg {width:700px;}
</style>
</head>
<body>
<div id="accordian">
	<ul>
		<li>
			<h3>중개 중인 매물</h3>
			<form action="#" method="get" id="panel" class="accordianBox">
					<table id="panel">
						<div id="btnBox">
							<button id="delBtn">매물 삭제</button>
							<button id="registerBtn">매물 등록</button>
							<!-- 	<button id="updateBtn">매물 수정</button> -->
						</div>
						<tr>
							<th></th>
							<th>코드</th>
							<th>주소</th>
							<th>보증금</th>
							<th>월세</th>
						</tr>
						<c:forEach var="house" items="${houseByAgent}">
							<tr data-attr="${house.HCODE}" class="tooltip">
								<td><input type="checkbox" name="check" value="${house.HCODE}"></td>
								<td>${house.HCODE}</td>
								<c:set var="addr" value="${fn:split(house.ADDR, ' ')}" />
								<td class="showHouse">${addr[2]}</td>
								<td>${house.DEPOSIT}</td>
								<td>${house.MRENT} <span class="tooltiptext"> 
									<img alt="${house.HCODE}" src="images/house/${house.HIMAGE}.jpg">
								</span>
								</td>
							</tr>
						</c:forEach>
					</table>
				</form>
			</li>
		<li>
			<h3>거래완료 매물</h3>
			<div class="accordianBox">
				<table id="panel">
						<tr>
							<th>코드</th>
							<th>주소</th>
							<th>보증금</th>
							<th>월세</th>
							<th>완료일</th>
						</tr>
						<c:forEach var="houseSold" items="${houseSoldByAgent}">
							<tr data-attr="${houseSold.HCODE}" class="tooltip">
								<td>${houseSold.HCODE}</td>
								<c:set var="addr" value="${fn:split(houseSold.ADDR, ' ')}" />
								<td class="showHouse">${addr[2]}</td>
								<td>${houseSold.DEPOSIT}</td>
								<td>${houseSold.MRENT} <span class="tooltiptext"> 
									<img alt="${houseSold.HCODE}" src="images/house/${houseSold.HIMAGE}.jpg">
								</span>
								</td>
								<td>${houseSold.CLOSEDDATE}</td>
							</tr>
						</c:forEach>
					</table>
				</div>
			</li>
		<li>
			<h3>내 인기 매물</h3>
			<div class="accordianBox">
				<table id="panel">
						<tr>
							<th>코드</th>
							<th>주소</th>
							<th>보증금</th>
							<th>월세</th>
							<th>좋아요</th>
						</tr>
						<c:forEach var="houselike" items="${houseLikeByAgent}">
							<tr data-attr="${houselike.HCODE}" class="tooltip">
								<td>${houselike.HCODE}</td>
								<c:set var="addr" value="${fn:split(houselike.ADDR, ' ')}" />
								<td class="showHouse">${addr[2]}</td>
								<td>${houselike.DEPOSIT}</td>
								<td>${houselike.MRENT} <span class="tooltiptext"> 
									<img alt="${houselike.HCODE}" src="images/house/${houselike.HIMAGE}.jpg">
								</span>
								</td>
								<td>${houselike.CNTWISH}</td>
							</tr>
						</c:forEach>
				</table>
			</div>
		</li>
		<li>
			<h3>실적 한눈에 보기</h3>
			<div class="accordianBox">
				<ul>
					<li class="chartMenu">
						<h5 id="records">실적</h5>
						<!-- Modal -->
								<div class="modal-dialog-Line" style="display:none;">
									<!-- Modal content-->
									<div class="modal-content" style="overflow:hidden; left: 130%; z-index: 3; top: 0; box-shadow: 1px 0px 5px 3px lightgrey; border-radius: 20px; background: white; position: absolute; padding: 0 20px; ">
										<div class="modal-header">
											<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
										</div>
										<div class="modal-body">
											 <div id="drawChartRecords" style="width:800px; height:450px;"></div>
										</div>
									</div>
								</div>
					</li>
					<li class="chartMenu">
						<h5 id="popularity">인기 매물</h5>
						 <!-- Modal -->
								<div class="modal-dialog-Pie" style="display:none;">
									<!-- Modal content-->
									<div class="modal-content" style="overflow:hidden; left: 130%; z-index: 3; top: 0; box-shadow: 1px 0px 5px 3px lightgrey; border-radius: 20px; background: white; position: absolute; padding: 0 20px; ">
										<div class="modal-header">
											<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
										</div>
										<div class="modal-body">
											<div id="drawChartPopularHouse"></div>  <!--Div that will hold the pie chart-->
										</div>
									</div>
								</div>
						</li>
				</ul>
				
			</div>
		</li>
	</ul>
</div>
</body>
</html>
<script type="text/javascript">
var rows = []; //data.addrows에 2차원배열로 값을 넣어야 해서 houseLikeByAgent를 for문을 돌면서 만들어준다. 
"<c:forEach var='houseLike' items='${houseLikeByAgent}' varStatus='status'>"
	rows["${status.index}"] = ["${houseLike.HCODE}", Number.parseInt("${houseLike.CNTWISH}")];
"</c:forEach>"

var openItems = new Array();
"<c:forEach var='i' begin='1' end='12'>"
	var month = ("${i}".length < 2)? "0${i}":"${i}";
	openItems["${i-1}"] = [Number.parseInt("${i}")],
	"<c:forEach var='house' items='${houseByRegisterDate}' varStatus='stauts'>"
		if(month == "${house.REGISTERDATE}"){
			openItems["${i-1}"].push(Number.parseInt("${house.COUNT}"));
		}
	"</c:forEach>"
	"<c:forEach var='soldHouse' items='${houseSoldByAgentCount}' varStatus='stauts'>"
		if(month == "${soldHouse.CLOSEDDATE}" && openItems["${i-1}"].length != 3){
			openItems["${i-1}"].push(Number.parseInt("${soldHouse.COUNT}"));
		}
	"</c:forEach>"
"</c:forEach>"

for(i in openItems){
	if(openItems[i].length == 1){
		openItems[i].push(null, null);
	} else if (openItems[i].length < 3){
		openItems[i].push(null);
	}
}
console.log(openItems);
console.log("${houseSoldByAgentCount}");

  // Load the Visualization API and the corechart package.
  google.charts.load('current', {'packages':['corechart', 'line']});

  // Set a callback to run when the Google Visualization API is loaded.
  google.charts.setOnLoadCallback(drawChartRecords); //실적 눌르면 나오는애
  google.charts.setOnLoadCallback(drawChartPopularHouse); //인기매물 눌르면 나오는애

  // Callback that creates and populates a data table,
  // instantiates the pie chart, passes in the data and
  // draws it.
  function drawChartRecords(){//실적 눌르면 나오는애
	        var data = new google.visualization.DataTable();
	        data.addColumn('number', 'month');
	        data.addColumn('number', '중개중인매물');
	        data.addColumn('number', '중개완료매물');
	        data.addRows(openItems.slice());

	        var options = {
	          hAxis: {
	            title: '월',
	            ticks: [1,2,3,4,5,6,7,8,9,10,11,12]
	          },
	          vAxis: {
	            title: '매물수',
	          },
	          colors: ['#AB0D06', '#007329'],
	          width:600,
	          height:200,
	        };

	        var chart = new google.visualization.LineChart(document.getElementById('drawChartRecords'));
	        chart.draw(data, google.charts.Line.convertOptions(options));
  }
  
  
  function drawChartPopularHouse() {// 인기매물 파이 차트
    // Create the data table.
    var data = new google.visualization.DataTable();
    data.addColumn('string', 'HCODE');
    data.addColumn('number', 'CNTWISH');
    data.addRows(rows.slice()); //값이 0인애는 안나옴.

    // Set chart options
    var options = {'title':'매물 인기도(중개중인 매물 기준)',
                   'width': 600,
                   'height':500};

    // Instantiate and draw our chart, passing in some options.
    var chart = new google.visualization.PieChart(document.getElementById('drawChartPopularHouse'));
    chart.draw(data, options);
  }
</script>

