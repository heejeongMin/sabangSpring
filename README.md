# sabangSpring
sabang Final Project (Spring)
1. STS 실행 시 요청 URL 

	http://localhost:8090/sabang

2. Angular Project를 Build된 버전이 아닌 Cross Browisng 된 채로 실행하고 싶은 경우
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
    
	10. 실행하기 전에 현재 STS에 있는 소스는 Angular 프로젝트를 빌드하여 Deploy된 버전으로 작동하고 있기 때문에 하기 작업이 선행되어야 함
