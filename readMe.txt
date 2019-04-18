1. STS ���� �� ��û URL 

	http://localhost:8090/sabang

2. Angular Project�� Build�� ������ �ƴ� Cross Browisng �� ä�� �����ϰ� ���� ���
	*******************************************************
	Angular���� ������ ������ src ��� ���
	*******************************************************
	1. �� ������ �����. 

	2. Visual Studio Code���� ���� ���� ������ ���� New Folder �������� Ŭ���� ���� ������ �����.
 
	3. ������� ���� �������� ���콺 ������ Ŭ�� -> Open In Terminal

	4. Terminal ���� ���� ��ɾ ������ angular node module�� �ٿ� �޴´�.
	
		npm install -g @angular/cli

	5. Terminal���� ���� ��ɾ �����Ͽ� ������Ʈ�� �����. 

		npm new sabang-angular 
	
	   *  Would you like to add Angular routing? (y/N) 
	
		 --> Y ����	

	   *  Which stylesheet format would you like to use? (Use arrow keys)
 	     > CSS
               SCSS   [ http://sass-lang.com/documentation/file.SASS_REFERENCE.html#syntax ]
 	       Sass   [ http://sass-lang.com/documentation/file.INDENTED_SYNTAX.html       ]
               Less   [ http://lesscss.org                                                 ]
               Stylus [ http://stylus-lang.com                                             ]

		--> CSS ����

	6. ������Ʈ ������ �Ϸ�Ǹ� �ڵ����� ������� src ������ ����
	7. ������ src.zip�� ������ Ǯ�� src ������ ���� ����
	8. ������ ������Ʈ���� ���� 

		cd sabang-angular
	
	9. ���࿡ �ʿ��� ���� module�� �ٿ�޴´�. 
	
		npm install @angular/cdk
		npm install angular-google-charts
		npm install ngx-textarea-autosize
		npm install ngx-swiper-wrapper
		npm install ng2-daum-address
		npm install angular-file-uploader

	10. �����ϱ� ���� ���� STS�� �ִ� �ҽ��� Angular ������Ʈ�� �����Ͽ� Deploy�� �������� �۵��ϰ� �ֱ� ������ �ϱ� �۾��� ����Ǿ�� ��

  		Angular Project�� Cross Browisng �� ä�� �����ϰ� ���� ���
  		 : Sessionó���� ���� �ʰ� �����Ͽ��� ������ �α����� �߰����� ���̵� �������� �κп��� NullPointerException�� ���� ������, 
     		   �߰����� ȸ������ �����ϴ� "agent"�� �ϵ��ڵ��Ͽ� ���� �ʿ�

			a) STS ���� HouseAgentController.java���� Session���� �α����� ������ ���̵� �������� �κ��� "agent"�� ����
				1) ���: sabangSpring -> src/main/java -> com.controller.house -> HouseAgentController.java
				2) 47����: return service.houseByAgent(member.getUserid()) �� return service.houseByAgent("agent")�� ����
				3) 53����: return service.houseSoldByAgent(member.getUserid())�� return service.houseSoldByAgent("agent")�� ����
				4) 65����: return service.houseByRegisterDate(member.getUserid())�� return service.houseByRegisterDate("agent")�� ����
				5) 72����: return service.houseSoldByAgentCount(member.getUserid())�� return service.houseSoldByAgentCount("agent")�� ����
				6) 79����: return service.houseLikeByAgent(member.getUserid())�� return service.houseLikeByAgent("agent")�� ����
				7) 86����: return service.houseLikeByAgent(member.getUserid())�� return service.houseLikeByAgent("agent")�� ����
				8) 173����: infoDTO.setAgntid(member.getUserid())�� infoDTO.setAgntid("agent")�� ����

			b) STS���� serve-context.xml���� �α��� �� session ���� ���θ� ���� interceptor�� �ɸ��� �ʰ� exclude-mapping�� path �߰�
				1) ���: sabangSpring -> src -> main -> webapp -> WEB-INF -> spring -> appServlet -> servlet-context.xml
				2) 44����: <mvc:exclude-mapping path="/angular**"/> �� �ּ��� Ǭ��. 

	
			c) STS���� ���� ���� (http://localhost:8090/sabang)
			b) Visual Studio Code���� Angular ������Ʈ ���� (http://localhost:4200)
    
    		: �׽�Ʈ ��, ��� ������ ���ƾ� ��Ʈ 8090���� ��û�Ͽ� ����Ǵ� angular�������� �α����� ������ ������ ���� �۵��Ѵ�.  

	11. STS ���� ���� 

		Run As > Run on Server
		
	12. Angular ������Ʈ ����

		ng serve --open


	*******************************************************
	Angular���� ������ ���������� �����ϴ� ��� 
	*******************************************************
	- �߰��κ� �߰����θŹ�/�߰��Ϸ�Ź��� ���� �����Ʈ
	- �߰��κ� �α�Ź��� ���� �����Ʈ
	- �߰��κ� ��� �Ź��� ���� ���ǻ��� ��ȸ
	- �߰��κ� �Ź� ��ü ��ȸ
	- �߰��κ� �Ź��� ���� ���� (�߰��� <> �߰��Ϸ�)
	- �Ź� ��� (���� ��� ����)
	- �Ź� ����

	*******************************************************
	Angular���� ������ ���������� �������� �ʴ� ���
	*******************************************************
	- �߰��κ� ��� �Ź��� ���� ���ǻ��׿� ���� ����ۼ�
	- �Ź� ��Ͻ� ���� ���
	- �Ź� ����


3. React Project�� Cross Browisng �� ä�� �����ϰ� ���� ���
	*******************************************************
	React���� ������ ������ src ��� ���
	*******************************************************
	1. �� ������ �����. 

	2. Visual Studio Code���� ���� ���� ������ ���� New Folder �������� Ŭ���� ���� ������ �����.

	3. ������� ���� �������� ���콺 ������ Ŭ�� -> Open In Terminal

	4. Terminal ���� ���� ��ɾ ������ ������Ʈ�� �����Ѵ�. (�뷫 5�� �̳��� �ð��� �ҿ�ȴ�.)
	
		npx create-react-app my-app
	
	5. ������Ʈ ������ �Ϸ�Ǹ� �ڵ����� ������� src ������ ����

	6. ������ src.zip�� ������ Ǯ�� src ������ ���� ����

	7. �͹̳η� ������ ������Ʈ�� ���丮�� ���� 

		cd my-app

	8. ���� ������ �ʿ��� ���̺귯���� �ٿ�޴´�.

		npm install --save axios


	9. STS���� ���� ���� (http://localhost:8090/sabang)
	
	10. Visual Studio Code���� React ������Ʈ ���� (http://localhost:3000)