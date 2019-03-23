<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="css/housePanel.css"></link>
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script> <!--Load the AJAX API-->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="js/housePanel.js"></script>
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
							<th>보증금/전세가</th>
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
							<th>보증금/전세가</th>
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
							<th>보증금/전세가</th>
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
					<li>
						<h5>실적</h5>
						<div></div>
					</li>
					<li>
						<h5>매물 인기도</h5>
						<div></div>
					</li>
					<li>
						<h5>상담 진척</h5>
						<div></div>
					</li>
				</ul>
			</div>
		</li>
	  <!--Div that will hold the pie chart-->
    <div id="chart_div"></div>
	</ul>
</div>
</body>
</html>

<script type="text/javascript">

  // Load the Visualization API and the corechart package.
  google.charts.load('current', {'packages':['corechart']});

  // Set a callback to run when the Google Visualization API is loaded.
  google.charts.setOnLoadCallback(drawChart);

  // Callback that creates and populates a data table,
  // instantiates the pie chart, passes in the data and
  // draws it.
  function drawChart() {
    // Create the data table.
    var data = new google.visualization.DataTable();
    data.addColumn('string', 'Topping');
    data.addColumn('number', 'Slices');
    data.addRows([
      ['ㄴㄴㄴ', 3],
      ['Onions', 1],
      ['Olives', 1],
      ['Zucchini', 1],
      ['Pepperoni', 2]
    ]);

    // Set chart options
    var options = {'title':'매물 인기도(중개중인 매물 기준)',
                   'width':400,
                   'height':300};

    // Instantiate and draw our chart, passing in some options.
    var chart = new google.visualization.PieChart(document.getElementById('chart_div'));
    chart.draw(data, options);
  }
</script>

