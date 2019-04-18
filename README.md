# sabangSpring
sabang Final Project (Spring)
### 1. STS 실행 시 요청 URL 

	http://localhost:8090/sabang

### 2. Angular Project를 Build된 버전이 아닌 Cross Browisng 된 채로 실행하고 싶은 경우
	*******************************************************
	Angular버전 관리자 페이지 src 사용 방법
	*******************************************************
	1. 새 폴더를 만든다. 
	2. Visual Studio Code에서 새로 만든 폴더를 열고 New Folder 아이콘을 클릭해 하위 폴더를 만든다.
	3. 만들어진 하위 폴더에서 마우스 오른쪽 클릭 -> Open In Terminal
	4. Terminal 에서 다음 명령어를 실행해 angular node module을 다운 받는다.	
		
		npm install -g @angular/cli

	5. Terminal에서 다음 명령어를 실행하여 프로젝트를 만든다. 
		
		npm new sabang-angular 
	
	   *  Would you like to add Angular routing? (y/N) 
		 --> Y 선택	
	   *  Which stylesheet format would you like to use? (Use arrow keys)
      ```  
        > CSS
        SCSS   [ http://sass-lang.com/documentation/file.SASS_REFERENCE.html#syntax ]
 	    Sass   [ http://sass-lang.com/documentation/file.INDENTED_SYNTAX.html       ]
        Less   [ http://lesscss.org                                                 ]
        Stylus [ http://stylus-lang.com                                             ]  
      ```
		--> CSS 선택

	6. 프로젝트 생성이 완료되면 자동으로 만들어진 src 폴더는 삭제
	7. 제공된 src.zip의 압축을 풀어 src 폴더를 새로 생성
	8. 생성한 프로젝트까지 접근 

		cd sabang-angular
	
	9. 실행에 필요한 다음 module을 다운받는다. 
    ```$npm install @angular/cdk
		$npm install angular-google-charts
		$npm install ngx-textarea-autosize
		$npm install ngx-swiper-wrapper
		$npm install ng2-daum-address
		$npm install angular-file-uploader
    ```
    
	10. 실행하기 전에 현재 STS에 있는 소스는 Angular 프로젝트를 빌드하여 Deploy된 버전으로 작동하고 있기 때문에 하기 작업이 선행되어야한다. 
  	    - Session처리를 하지 않고 구현하였기 때문에 로그인한 중개인의 아이디를 가져오는 부분에서 NullPointerException이 나기 때문에, 
     	        중개인중 회원으로 존재하는 "agent"를 하드코딩하여 실행 필요

		```a) STS 에서 HouseAgentController.java에서 Session에서 로그인한 유저의 아이디를 가져오는 부분을 "agent"로 수정
			1) 경로: sabangSpring -> src/main/java -> com.controller.house -> HouseAgentController.java
			2) 47라인: return service.houseByAgent(member.getUserid()) 를 return service.houseByAgent("agent")로 수정
			3) 53라인: return service.houseSoldByAgent(member.getUserid())를 return service.houseSoldByAgent("agent")로 수정
			4) 65라인: return service.houseByRegisterDate(member.getUserid())를 return service.houseByRegisterDate("agent")로 수정
			5) 72라인: return service.houseSoldByAgentCount(member.getUserid())를 return service.houseSoldByAgentCount("agent")로 수정
			6) 79라인: return service.houseLikeByAgent(member.getUserid())를 return service.houseLikeByAgent("agent")로 수정
			7) 86라인: return service.houseLikeByAgent(member.getUserid())를 return service.houseLikeByAgent("agent")로 수정
			8) 173라인: infoDTO.setAgntid(member.getUserid())를 infoDTO.setAgntid("agent")로 수정

		b) STS에서 serve-context.xml에서 로그인 후 session 유지 여부를 묻는 interceptor에 걸리지 않게 exclude-mapping에 path 추가
			1) 경로: sabangSpring -> src -> main -> webapp -> WEB-INF -> spring -> appServlet -> servlet-context.xml
			2) 44라인: <mvc:exclude-mapping path="/angular**"/> 의 주석을 푼다. 

	
		c) STS에서 서버 실행 (http://localhost:8090/sabang)
		b) Visual Studio Code에서 Angular 프로젝트 실행 (http://localhost:4200)
    
    	: 테스트 후, 모두 원복해 놓아야 포트 8090으로 요청하여 실행되는 angular페이지가 로그인한 유저의 정보로 정상 작동한다.  ```


11. STS 서버 실행 

	Run As > Run on Server
	
12. Angular 프로젝트 실행

	ng serve --open
