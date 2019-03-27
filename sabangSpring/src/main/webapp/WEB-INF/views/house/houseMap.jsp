<%@page import="java.util.HashMap"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script> 
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=af8573930680705c377bb41b984d5c1a"></script>
<link rel="stylesheet" href="css/mainmap.css">
</head>
<body>
<div id="container">
    <div id="mapWrapper">
        <div id="map" style="width:100%;height:100%"></div> <!-- 지도를 표시할 div 입니다 -->
    	
    	 <!-- 지도 위에 표시될 마커 카테고리 -->
		 <div class="category">
	        <ul>
	            <li id="coffeeMenu" onclick="changeMarker('coffee')">
	                <span class="ico_comm ico_coffee"></span>
	                	카페
	            </li>
	            <li id="storeMenu" onclick="changeMarker('store')">
	                <span class="ico_comm ico_store"></span>
	                	편의점
	            </li>
	            <li id="carparkMenu" onclick="changeMarker('carpark')">
	                <span class="ico_comm ico_carpark"></span>
	                	도서관
	            </li>
	        </ul>
	    </div>
	    
	    <!-- 지도 위에 표시될 하우스 카테고리  -->
	    <div class="houseCategory">
	    	<ul>
	            <li id="totalListMenu" onclick="changeMarker('total')">
	                <span class="ico_comm ico_total"></span>
	                	전체보기
	            </li>
	            <li id="newListMenu" onclick="changeMarker('new')">
	                <span class="ico_comm ico_new"></span>
	                	신매물
	            </li>
	            <li id="hotListMenu" onclick="changeMarker('hot')">
	                <span class="ico_comm ico_hot"></span>
	                	핫매물
	            </li>
	        </ul>
	    </div>
    </div>
</div>


<!-- 전체매물 테이블 좌표저장 -->
<c:if test="${!(empty allList)}">
	<script>
		var allListCoord = [];
	</script>
	<c:forEach var="item" items="${allList}">
		<c:set var="x" value="${item.COORDX}"/>
		<c:set var="y" value="${item.COORDY}"/>
		<script>
		var allListArray = [];
			allListArray.push("${x}");
			allListArray.push("${y}");
		allListCoord.push(allListArray);
		</script>
	</c:forEach>
</c:if>



<!-- 신매물 테이블 좌표저장 -->
<c:if test="${!(empty newList)}">
	<script>
		var newListCoord = [];
	</script>
	<c:forEach var="item" items="${newList}">
		<c:set var="x" value="${item.COORDX}"/>
		<c:set var="y" value="${item.COORDY}"/>
		<script>
		var newListArray = [];
			newListArray.push("${x}");
			newListArray.push("${y}");
		newListCoord.push(newListArray);
		</script>
	</c:forEach>
</c:if>

<!-- 핫매물 테이블 좌표저장 -->
<c:if test="${!(empty hotList)}">
	<script>
		var hotListCoord = [];
	</script>
	<c:forEach var="item" items="${hotList}">
		<c:set var="x" value="${item.COORDX}"/>
		<c:set var="y" value="${item.COORDY}"/>
		<script>
		var hotListArray = [];
			hotListArray.push("${x}");
			hotListArray.push("${y}");
		hotListCoord.push(hotListArray);
		</script>
	</c:forEach>
</c:if>

<script type="text/javascript">
		// 함수 호출
		var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
	    mapOption = { 
	        center: new daum.maps.LatLng(37.565778, 126.938528), // 지도의 중심좌표
	        level: 6 // 지도의 확대 레벨
	    };
	
		// 지도를 표시할 div와  지도 옵션으로  지도를 생성합니다
		var map = new daum.maps.Map(mapContainer, mapOption);
		// 지도의 최대레벨
		map.setMaxLevel(6);
		// 지도의 최소레벨
		map.setMinLevel(3);
		// 지도 이동 금지
		map.setDraggable(false);
		
		
		
		// 마우스 휠 이벤트
		// 지도 확대 후 이동 가능 및 축소 후 원래 좌표로 돌아오기 
		daum.maps.event.addListener(map, 'idle', function() {
			if(map.getLevel()<6){
				map.setDraggable(true);
			}else if(map.getLevel()==6){
				map.setDraggable(false);
				map.setCenter(new daum.maps.LatLng(37.565778, 126.938528));
			}
		});
		
		
		
		// 카페 마커가 표시될 좌표 배열입니다
		var coffeePositions = [ 
		    new daum.maps.LatLng(37.569406672142456, 126.93173920685587),
		    new daum.maps.LatLng(37.56351392364315, 126.9253926114588),
		    new daum.maps.LatLng(37.56186042771902, 126.92656230924486),
		    new daum.maps.LatLng(37.5584391131211, 126.9370866812841),
		    new daum.maps.LatLng(37.558244042277146, 126.94330255758469),
		    new daum.maps.LatLng(37.56205766207434, 126.92499565832408),
		    new daum.maps.LatLng(37.55413739144038, 126.92706331544218),               
		    new daum.maps.LatLng(37.55774083206093, 126.93878492052923),               
		    new daum.maps.LatLng(37.5570612945145, 126.93506425671245),                
		    new daum.maps.LatLng(37.56255993608386, 126.94745540735512),                
		    new daum.maps.LatLng(37.56331504061321, 126.94369712684679)                
		];

		// 편의점 마커가 표시될 좌표 배열입니다
		var storePositions = [
		    new daum.maps.LatLng(37.56470049815986, 126.9394990975759),
		    new daum.maps.LatLng(37.55904754883219, 126.93590005603934),
		    new daum.maps.LatLng(37.55880216671275, 126.94228352892168),
		    new daum.maps.LatLng(37.55893473356894, 126.94070798030427),
		    new daum.maps.LatLng(37.55873266769416, 126.94782931992488),
		    new daum.maps.LatLng(37.55720425065452, 126.94709700502537),
		    new daum.maps.LatLng(37.56540832218574, 126.95031480987691),
		    new daum.maps.LatLng(37.56255993608386, 126.94745540735512),
		    new daum.maps.LatLng(37.56510662917557, 126.95285494806376),
		    new daum.maps.LatLng(37.564634392107806, 126.93069771150611),
		    new daum.maps.LatLng(37.5653020379637, 126.93226361831663),
		    new daum.maps.LatLng(37.563182507210136, 126.93159095453868),
		    new daum.maps.LatLng(37.5590258340482, 126.92942172294279),
		    new daum.maps.LatLng(37.55867069691373, 126.93225151323217),
		    new daum.maps.LatLng(37.56291887235145, 126.93065855417491),
		    new daum.maps.LatLng(37.56876210571136, 126.93269062032132)
		];

		// 도서관 마커가 표시될 좌표 배열입니다
		var carparkPositions = [
			{
				content:'<div>도서관1</div>',
				latlng:new daum.maps.LatLng(37.55585045214628, 126.94218621244649)
			},
			{
				content: '<div>도서관2</div>',
				latlng:new daum.maps.LatLng(37.55859026760159, 126.93668816730333)
			},
			{
				content: '<div>도서관3</div>',
				latlng:new daum.maps.LatLng(37.55688729590438, 126.93325812644618)
			},
			{
				content: '<div>도서관4</div>',
				latlng:new daum.maps.LatLng(37.563876754527094, 126.95061463835172)
			},
			{
				content: '<div>도서관5</div>',
				latlng: new daum.maps.LatLng(37.56255993608386, 126.94745540735512)
			},
			{
				content: '<div>도서관6</div>',
				latlng: new daum.maps.LatLng(37.56470049815986, 126.9394990975759)
			},
			{
				content: '<div>도서관7</div>',
				latlng: new daum.maps.LatLng(37.56437248231042, 126.93273984469688)
			}
		    
		];
		
		
		// 전체매물 좌표 저장
        var	allListPositions = [];
        for(var i = 0; i< allListCoord.length; i++){
			allListPositions.push(new daum.maps.LatLng(allListCoord[i][0], allListCoord[i][1]));
		}
		// 신매물 좌표 저장
        var newListPositions = [];
        for(var i = 0; i< newListCoord.length; i++){
			newListPositions.push(new daum.maps.LatLng(newListCoord[i][0], newListCoord[i][1]));
		}
    	// 핫매물 좌표 저장
        var hotListPositions = [];
        for(var i = 0; i< hotListCoord.length; i++){
			hotListPositions.push(new daum.maps.LatLng(hotListCoord[i][0], hotListCoord[i][1]));
		}
        
        allListMarkers = [];	// 전체매물 마커 객체를 가지고 있을 배열입니다
		newListMarkers = [];	// 신매물 마커 객체를 가지고 있을 배열입니다
		hotListMarkers = [];	// 핫매물 마커 객체를 가지고 있을 배열입니다
		
		function createAllListMarkers() {
			for (var i = 0; i < (allListPositions.length); i ++) { 
				// 마커 이미지의 이미지 크기 입니다
				var imageSrc = "images/marker/markerYellow.png"
			    var imageSize = new daum.maps.Size(24, 35); 
			    // 마커 이미지를 생성합니다    
			    var markerImage = new daum.maps.MarkerImage(imageSrc, imageSize);
		           
		        // 마커이미지와 마커를 생성합니다
		        var marker = createMarker(allListPositions[i], markerImage);  
		        // 생성된 마커를 신매물 마커 배열에 추가합니다
		        allListMarkers.push(marker);
		    }  
		}
		
		function createNewListMarkers() {
			for (var i = 0; i < (newListPositions.length); i ++) { 
				var imageSrc = "images/marker/markerBlue.png"
			    var imageSize = new daum.maps.Size(24, 35); 
			    var markerImage = new daum.maps.MarkerImage(imageSrc, imageSize);
		           
		        var marker = createMarker(newListPositions[i], markerImage);  
		        newListMarkers.push(marker);
		    }  
		}
		function createHotListMarkers() {
			for (var i = 0; i < (hotListPositions.length); i ++) { 
				var imageSrc = "images/marker/markerRed.png"
			    var imageSize = new daum.maps.Size(24, 35); 
			    var markerImage = new daum.maps.MarkerImage(imageSrc, imageSize);
		           
		        var marker = createMarker(hotListPositions[i], markerImage);  
		        hotListMarkers.push(marker);
		    }  
		}
		
		
		// 마커 객체 저장하기
		createAllListMarkers();
		createNewListMarkers();
		createHotListMarkers();
		
		
		// 전체매물 마커들의 지도 표시 여부를 설정하는 함수입니다
		function setAllListMarkers(map) {
		    for (var i = 0; i < allListMarkers.length; i++) {  
		    	allListMarkers[i].setMap(map);
		    }        
		}
		
		// 신매물 마커들의 지도 표시 여부를 설정하는 함수입니다
		function setNewListMarkers(map) {
		    for (var i = 0; i < newListMarkers.length; i++) {  
		    	newListMarkers[i].setMap(map);
		    }        
		}
		
		// 핫매물 마커들의 지도 표시 여부를 설정하는 함수입니다
		function setHotListMarkers(map) {
		    for (var i = 0; i < hotListMarkers.length; i++) {  
		    	hotListMarkers[i].setMap(map);
		    }        
		}
		
		
		
		
		var markerImageSrc = 'images/marker/category.png';  // 마커이미지의 주소입니다. 스프라이트 이미지 입니다
	    coffeeMarkers = [], // 커피숍 마커 객체를 가지고 있을 배열입니다
	    storeMarkers = [], // 편의점 마커 객체를 가지고 있을 배열입니다
	    carparkMarkers = []; // 도서관 마커 객체를 가지고 있을 배열입니다
	    
	    carparkInfoWindow = []; // 도서관 인포윈도우 객체를 가지고 있을 배열입니다
	    
		createCoffeeMarkers(); // 커피숍 마커를 생성하고 커피숍 마커 배열에 추가합니다
		createStoreMarkers(); // 편의점 마커를 생성하고 편의점 마커 배열에 추가합니다
		createCarparkMarkers(); // 도서관 마커를 생성하고 도서관 마커 배열에 추가합니다
	
	
	
		// 마커이미지의 주소와, 크기, 옵션으로 마커 이미지를 생성하여 리턴하는 함수입니다
		function createMarkerImage(src, size, options) {
		    var markerImage = new daum.maps.MarkerImage(src, size, options);
		    return markerImage;            
		}
	
		// 좌표와 마커이미지를 받아 마커를 생성하여 리턴하는 함수입니다
		function createMarker(position, image) {
		    var marker = new daum.maps.Marker({
		        position: position,
		        image: image
		    });
		    
		    return marker;  
		}   
		   
		// 커피숍 마커를 생성하고 커피숍 마커 배열에 추가하는 함수입니다
		function createCoffeeMarkers() {
		    
		    for (var i = 0; i < coffeePositions.length; i++) {  
		        
		        var imageSize = new daum.maps.Size(22, 26),
		            imageOptions = {  
		                spriteOrigin: new daum.maps.Point(10, 0),    
		                spriteSize: new daum.maps.Size(36, 98)  
		            };     
		        
		        // 마커이미지와 마커를 생성합니다
		        var markerImage = createMarkerImage(markerImageSrc, imageSize, imageOptions),    
		            marker = createMarker(coffeePositions[i], markerImage);  
		        
		        // 생성된 마커를 커피숍 마커 배열에 추가합니다
		        coffeeMarkers.push(marker);
		    }     
		}
	
		// 커피숍 마커들의 지도 표시 여부를 설정하는 함수입니다
		function setCoffeeMarkers(map) {        
		    for (var i = 0; i < coffeeMarkers.length; i++) {  
		        coffeeMarkers[i].setMap(map);
		    }        
		}
	
		// 편의점 마커를 생성하고 편의점 마커 배열에 추가하는 함수입니다
		function createStoreMarkers() {
		    for (var i = 0; i < storePositions.length; i++) {
		        
		        var imageSize = new daum.maps.Size(22, 26),
		            imageOptions = {   
		                spriteOrigin: new daum.maps.Point(10, 36),    
		                spriteSize: new daum.maps.Size(36, 98)  
		            };       
		     
		        // 마커이미지와 마커를 생성합니다
		        var markerImage = createMarkerImage(markerImageSrc, imageSize, imageOptions),    
		            marker = createMarker(storePositions[i], markerImage);  
	
		        // 생성된 마커를 편의점 마커 배열에 추가합니다
		        storeMarkers.push(marker);    
		    }        
		}
	
		// 편의점 마커들의 지도 표시 여부를 설정하는 함수입니다
		function setStoreMarkers(map) {        
		    for (var i = 0; i < storeMarkers.length; i++) {  
		        storeMarkers[i].setMap(map);
		    }        
		}
	
		// 도서관 마커를 생성하고 도서관 마커 배열에 추가하는 함수입니다
		function createCarparkMarkers() {
		    for (var i = 0; i < carparkPositions.length; i++) {
		        
		        var imageSize = new daum.maps.Size(22, 26),
		            imageOptions = {   
		                spriteOrigin: new daum.maps.Point(10, 72),    
		                spriteSize: new daum.maps.Size(36, 98)  
		            };       
		     
		        // 마커이미지와 마커를 생성합니다
		        var markerImage = createMarkerImage(markerImageSrc, imageSize, imageOptions),    
		            marker = createMarker(carparkPositions[i].latlng, markerImage);  
				
		     	// 생성된 마커를 도서관 마커 배열에 추가합니다
		        carparkMarkers.push(marker); 
		        
		        
		     	
		     	// 마커에 표시할 인포윈도우를 생성합니다 
		        var infowindow = new daum.maps.InfoWindow({
		            content: carparkPositions[i].content // 인포윈도우에 표시할 내용
		        });
		        
		        carparkInfoWindow.push(infowindow);
		     	
		     	
		    	// 마커에 mouseover 이벤트와 mouseout 이벤트를 등록합니다
		        // 이벤트 리스너로는 클로저를 만들어 등록합니다 
		        // for문에서 클로저를 만들어 주지 않으면 마지막 마커에만 이벤트가 등록됩니다
		        daum.maps.event.addListener(marker, 'mouseover', makeOverListener(map, marker, infowindow));
		        daum.maps.event.addListener(marker, 'mouseout', makeOutListener(infowindow));
		    }
		}
		
		// 인포윈도우를 표시하는 클로저를 만드는 함수입니다 
        function makeOverListener(map, marker, infowindow) {
            return function() {
                infowindow.open(map, marker);
            };
        }

        // 인포윈도우를 닫는 클로저를 만드는 함수입니다 
        function makeOutListener(infowindow) {
            return function() {
                infowindow.close();
            };
        }
		
		
		
		// 도서관 마커들의 지도 표시 여부를 설정하는 함수입니다
		function setCarparkMarkers(map) {
		    for (var i = 0; i < carparkMarkers.length; i++) {  
		        carparkMarkers[i].setMap(map);
		    }        
		}
	
		// 카테고리를 클릭했을 때 type에 따라 카테고리의 스타일과 지도에 표시되는 마커를 변경합니다
		function changeMarker(type){
		    
		    var coffeeMenu = document.getElementById('coffeeMenu');
		    var storeMenu = document.getElementById('storeMenu');
		    var carparkMenu = document.getElementById('carparkMenu');
		    var totalListMenu = document.getElementById('totalListMenu');
		    var newListMenu = document.getElementById('newListMenu');
		    var hotListMenu = document.getElementById('hotListMenu');
		    
		    
		    // 커피숍 카테고리가 클릭됐을 때
		    if (type === 'coffee') {
		    
		        // 커피숍 카테고리를 선택된 스타일로 변경하고
		        coffeeMenu.className = 'menu_selected';
		        
		        // 편의점과 도서관 카테고리는 선택되지 않은 스타일로 바꿉니다
		        storeMenu.className = '';
		        carparkMenu.className = '';
		        totalListMenu.className = '';
		        newListMenu.className = '';
		        hotListMenu.className = '';
		        
		        
		        // 커피숍 마커들만 지도에 표시하도록 설정합니다
		        setCoffeeMarkers(map);
		        setStoreMarkers(null);
		        setCarparkMarkers(null);
		        setAllListMarkers(null);
		        setNewListMarkers(null);
				setHotListMarkers(null);
		        
		    } else if (type === 'store') { // 편의점 카테고리가 클릭됐을 때
		    
		        // 편의점 카테고리를 선택된 스타일로 변경하고
		        coffeeMenu.className = '';
		        storeMenu.className = 'menu_selected';
		        carparkMenu.className = '';
		        totalListMenu.className = '';
		        newListMenu.className = '';
		        hotListMenu.className = '';
		        
		        // 편의점 마커들만 지도에 표시하도록 설정합니다
		        setCoffeeMarkers(null);
		        setStoreMarkers(map);
		        setCarparkMarkers(null);
		        setAllListMarkers(null);
		        setNewListMarkers(null);
				setHotListMarkers(null);
		        
		    } else if (type === 'carpark') { // 도서관 카테고리가 클릭됐을 때
		     
		        // 도서관 카테고리를 선택된 스타일로 변경하고
		        coffeeMenu.className = '';
		        storeMenu.className = '';
		        carparkMenu.className = 'menu_selected';
		        totalListMenu.className = '';
		        newListMenu.className = '';
		        hotListMenu.className = '';
		        
		        // 도서관 마커들만 지도에 표시하도록 설정합니다
		        setCoffeeMarkers(null);
		        setStoreMarkers(null);
		        setCarparkMarkers(map);
		        setAllListMarkers(null);
		        setNewListMarkers(null);
				setHotListMarkers(null);
		        
		    // 신매물 / 핫매물
		    }else if (type === 'new'){
		    	coffeeMenu.className = '';
		        storeMenu.className = '';
		        carparkMenu.className = '';
		        totalListMenu.className = '';
		        newListMenu.className = 'menu_selected';
		        hotListMenu.className = '';
		        
		        setCoffeeMarkers(null);
		        setStoreMarkers(null);
		        setCarparkMarkers(null);
		        setAllListMarkers(null);
				setNewListMarkers(map);
				setHotListMarkers(null);
		    	
		    }else if(type === 'hot'){
			    coffeeMenu.className = '';
				storeMenu.className = '';
				carparkMenu.className = '';
				totalListMenu.className = '';
				newListMenu.className = '';
				hotListMenu.className = 'menu_selected';
				        
				setCoffeeMarkers(null);
				setStoreMarkers(null);
				setCarparkMarkers(null);
				setAllListMarkers(null);
				setNewListMarkers(null);
				setHotListMarkers(map);
				
		    } else if (type === 'total'){
		    	coffeeMenu.className = '';
		        storeMenu.className = '';
		        carparkMenu.className = '';
		        totalListMenu.className = 'menu_selected';
		        newListMenu.className = '';
		        hotListMenu.className = '';
		        
		        setCoffeeMarkers(null);
				setStoreMarkers(null);
				setCarparkMarkers(null);
				setAllListMarkers(map);
				setNewListMarkers(null);
				setHotListMarkers(null);
		    }
		}
</script>
</body>
</html>