package com.controller.house;

import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.dto.HouseInfoDTO;
import com.dto.HouseOptionDTO;
import com.dto.HousePriceDTO;
import com.dto.MemberDTO;
import com.service.HouseService;

@Controller
public class HouseAgentController {

	@Autowired
	HouseService service;

	@RequestMapping("/houseUIController")
	public String houseManaging(@RequestParam(value="work", required=false) String work, 
			  					@RequestParam(value="hcode", required=false) String hcode, HttpSession session, Model model) {
		
		//로그인한 에이전트의 이름으로 등록된 매물 리스트를 housePanel.jsp에 보여주기
		MemberDTO member = (MemberDTO) session.getAttribute("memberInfo");
		model.addAttribute("houseByAgent", service.houseByAgent(member.getUserid()));
		
		//housePanel.jsp에서 매물등록/매물수정 버튼을 눌렀을 때
		if(work!=null) {
			if (work.equals("register")) {//매물 등록
				model.addAttribute("work", "register");
			} else if (work.equals("update")) {//매물 수정
				model.addAttribute("infoDTO", service.houseRetrieve(hcode));
				model.addAttribute("priceDTO", service.housePrice(hcode));
				model.addAttribute("optionDTO", service.houseOption(hcode));
				model.addAttribute("work", "update");
			}
		}
		
		return "houseAgent";
	}// end houseManaging


	@RequestMapping("/houseUIController/{work}")
	public String houseUIControle(@PathVariable("work") String work, 
								  @RequestParam(value="hcode", required=false) String hcode) {
		
		System.out.println(work);
		
//		String htype = request.getParameter("htype");
//		
//		} else if(htype!=null) {//htype이 null이 아닐때는 register
//			String lastCode = service.getLastCode(htype);
//			PrintWriter out = response.getWriter();
//			out.print(lastCode.substring(1));
//		} else {
//		
//		
//		//>>>>>>>>>>>>>>>>>>>>>>>>>> 파일 업로드
//		// Create a factory for disk-based file items
//		DiskFileItemFactory factory = new DiskFileItemFactory();
//
//		// Configure a repository (to ensure a secure temp location is used)
//		ServletContext servletContext = this.getServletConfig().getServletContext();
//		File repository = (File) servletContext.getAttribute("javax.servlet.context.tempdir");
//		factory.setRepository(repository);
//
//		// Create a new file upload handler
//		ServletFileUpload upload = new ServletFileUpload(factory);
//		
//		// 파일 크기
//		// b ---> kb ---> mb ---> gb
//		// 1mb 가 1024 kb
//		upload.setFileSizeMax(1024 * 1024 * 3); // 개별 파일 업로드 가능한 최대 크기  지금은 2mb로 설정
//		upload.setSizeMax(1024 * 1024 * 5); // 총 파일 크기, -1을 주면 기본값으로 무제한이다. 지금은 5mb 로 설정
//	
//		HouseInfoDTO infoDTO = new HouseInfoDTO();
//		HousePriceDTO priceDTO = new HousePriceDTO();
//		HouseOptionDTO optionDTO = new HouseOptionDTO();
//		
//		FileItem item = null; 
//		String fileName = null;
//		int n = 0;
//		// Parse the request
//		try {
//			List<FileItem> items = upload.parseRequest(request);
//			// Process the uploaded items
//			Iterator<FileItem> iter = items.iterator();
//			while (iter.hasNext()) {
//			    item = iter.next();
//			    if (item.isFormField()) {// 일반 텍스트 가져오기
//			    	switch (item.getFieldName()) {
//			    	case "htype" : infoDTO.setHtype(item.getString("utf-8")); break;
//			    	case "hcode": infoDTO.setHcode(item.getString("utf-8")); 
//			    				  priceDTO.setHcode(item.getString("utf-8"));
//			    				  optionDTO.setHcode(item.getString("utf-8"));
//			    				  break;
//			    	case "rtype" : infoDTO.setRtype(item.getString("utf-8")); break;
//			    	case "hname" : infoDTO.setHname(item.getString("utf-8")); break;
//			    	case "hetc" : infoDTO.setHetc(item.getString("utf-8")); break;
//			    	case "area" : infoDTO.setArea(item.getString("utf-8")); break;
//			    	case "flr" : infoDTO.setFlr(Integer.parseInt(item.getString("utf-8"))); break;
//			    	case "whflr" : infoDTO.setWhlflr(Integer.parseInt(item.getString("utf-8"))); break;
//			    	case "room" : infoDTO.setRoom(Integer.parseInt(item.getString("utf-8"))); break;
//			    	case "batr" : infoDTO.setBatr(item.getString("utf-8")); break;
//			    	case "addr" : infoDTO.setAddr(item.getString("utf-8")); break;
//			    	case "deposit" : priceDTO.setDeposit(Integer.parseInt(item.getString("utf-8"))); break;
//			    	case "mrent" : priceDTO.setMrent(Integer.parseInt(item.getString("utf-8"))); break;
//			    	case "yrent" : priceDTO.setYrent(Integer.parseInt(item.getString("utf-8"))); break;
//			    	case "maintc" : priceDTO.setMaintc(Integer.parseInt(item.getString("utf-8"))); break;
//			    	case "parkf" : priceDTO.setParkf(Double.parseDouble(item.getString("utf-8"))); break;
//			    	case "options" :
//			    		switch (item.getString("utf-8")) {
//			    		case "BLTIN" : optionDTO.setBltin('Y'); break;
//			    		case "ELEV" : optionDTO.setElev('Y'); break;
//			    		case "PET" : optionDTO.setPet('Y'); break;
//			    		case "VRD" : optionDTO.setVrd('Y'); break;
//			    		case "LOAN" : optionDTO.setLoan('Y'); break;
//			    		case "PARK" : optionDTO.setPark('Y'); break;
//			    		case "MDATE" : optionDTO.setMdate('Y'); break;
//			    		}
//			     	case "etc" : optionDTO.setEtc(item.getString("utf-8")); break;
//			    	}
//			    } else { // System.currentTimeMills() 사용으로 DB에 gimage 데이터타입을 varchar2(20)에서 varchar2(80)으로 변경
//			    	if(item.getName().length() != 0) {
//			    		String[] fileNames = item.getName().split("\\.");
//			    		fileName = fileNames[0] + System.currentTimeMillis() + "." + fileNames[1];
//			    		infoDTO.setHimage(fileName);
//				    	File f = new File("C:\\Projects\\sabang\\masterGit\\sabang\\WebContent\\images", fileName);
////				    	File f = new File("C:\\gitTest3\\sabang\\sabang\\WebContent\\images", fileName);
//				    	item.write(f);
//			    	}
//			    }
//			}
//			//Image 업로드
//
//	    	HashMap<String, Object> registerMap = new HashMap<>();
//	    	infoDTO.setAgntid(member.getUserid());//session에 잇는 에이전트의 유저 아이디도 가져온다. 
//	    	System.out.println(infoDTO);
//	    	registerMap.put("info", infoDTO);
//	    	registerMap.put("price", priceDTO);
//	    	registerMap.put("option", optionDTO);
//	    	
//	    //	DB에 저장
//	    	n = service.houseRegister(registerMap);
//			
//		} catch (FileUploadException e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//		} catch (Exception e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//		} finally {
//			String registerMsg = (n==1)? "매물등록에 성공하였습니다. Happy Sabang~" : "매물등록에 실패하였습니다. 관리자에게 문의해주세요.";
//			session.setAttribute("registerMsg", registerMsg);
//			response.sendRedirect("HouseManagingServlet");
//		}
//		
		return "";
	}

}
