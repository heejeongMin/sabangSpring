package com.controller.house;

import java.io.File;
import java.io.IOException;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Set;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import com.dto.HouseInfoDTO;
import com.dto.HouseOptionDTO;
import com.dto.HousePriceDTO;
import com.dto.MemberDTO;
import com.service.HouseService;

@Controller
public class HouseAgentController {

	@Autowired
	HouseService service;

	@RequestMapping("/houseUIController") // houseAgent.jsp에 include되는 jsp 화면 3개 결정
	public String houseUIController(@RequestParam(value = "work", required = false) String work,
			@RequestParam(value = "hcode", required = false) String hcode, HttpSession session, Model model) {

		// 로그인한 에이전트의 이름으로 등록된 매물 리스트를 housePanel.jsp에 보여주기
		MemberDTO member = (MemberDTO) session.getAttribute("memberInfo");
		model.addAttribute("houseByAgent", service.houseByAgent(member.getUserid()));
		model.addAttribute("houseSoldByAgent", service.houseSoldByAgent(member.getUserid()));
		model.addAttribute("houseLikeByAgent", service.houseLikeByAgent(member.getUserid()));
		model.addAttribute("houseByRegisterDate", service.houseByRegisterDate(member.getUserid()));
		model.addAttribute("houseSoldByAgentCount", service.houseSoldByAgentCount(member.getUserid()));

		// housePanel.jsp에서 매물등록/매물수정 버튼을 눌렀을 때
		if (work != null) {
			if (work.equals("register")) {// 매물 등록
				model.addAttribute("work", "register");
			} else if (work.equals("update")) {// 매물 수정
				model.addAttribute("infoDTO", service.houseRetrieve(hcode));
				model.addAttribute("priceDTO", service.housePrice(hcode));
				model.addAttribute("optionDTO", service.houseOption(hcode));
				model.addAttribute("work", "update");
			}
		}
		return "houseAgent";
	}// end houseUIController

	@RequestMapping("/houseManaging/GET/{htype}")
	public @ResponseBody String houseRegisterGET(@PathVariable("htype") String htype) {
		return service.getLastCode(htype).substring(1);
	}

	//매물등록, 매물수정 둘다 처리
	@RequestMapping("/houseManaging/{workType}")
	@ResponseBody
	public int houseRegisterPOST(@PathVariable("workType") String workType,
								 @RequestParam(value="himage", required=false) CommonsMultipartFile himage, 
								 @RequestParam HashMap<String, Object> house, HttpSession session ) {
		MemberDTO member = (MemberDTO) session.getAttribute("memberInfo");
		HouseInfoDTO infoDTO = new HouseInfoDTO();
		HousePriceDTO priceDTO = new HousePriceDTO();
		HouseOptionDTO optionDTO = new HouseOptionDTO();
		HashMap<String, Object> registerMap = new HashMap<>(); //DB로 가는 최종 MAP
		Set<String> keys = house.keySet();
		for(String key : keys) {//클라이언트에서 가져온 값을 돌면서 키를 체크, 형변환해서 각각 DTO에 넣는다. 			
			if(!(house.get(key).equals(""))) {
				switch (key) {
		    	case "htype" : infoDTO.setHtype((String)house.get(key)); break;
		    	case "hcode": infoDTO.setHcode((String)house.get(key)); 
		    				  priceDTO.setHcode((String)house.get(key));
		    				  optionDTO.setHcode((String)house.get(key)); break;
		    	case "rtype" : infoDTO.setRtype((String)house.get(key)); break;
		    	case "hname" : infoDTO.setHname((String)house.get(key)); break;
		    	case "hetc" : infoDTO.setHetc((String)house.get(key)); break;
		    	case "area" : infoDTO.setArea((String)house.get(key)); break;
		    	case "flr" : infoDTO.setFlr(Integer.parseInt((String)house.get(key))); break;
		    	case "whflr" : infoDTO.setWhlflr(Integer.parseInt((String)house.get(key))); break;
		    	case "room" : infoDTO.setRoom(Integer.parseInt((String)house.get(key))); break;
		    	case "batr" : infoDTO.setBatr((String)house.get(key)); break;
		    	case "addr" : infoDTO.setAddr((String)house.get(key)); break;
		    	case "deposit" : priceDTO.setDeposit(Integer.parseInt((String)house.get(key))); break;
		    	case "mrent" : priceDTO.setMrent(Integer.parseInt((String)house.get(key))); break;
		    	case "yrent" : priceDTO.setYrent(Integer.parseInt((String)house.get(key))); break;
		    	case "maintc" : priceDTO.setMaintc(Integer.parseInt((String)house.get(key))); break;
		    	case "parkf" : priceDTO.setParkf(Double.parseDouble((String)house.get(key))); break;
		    	case "etc" : optionDTO.setEtc((String)house.get(key)); break;
		    	case "options" :
		    		switch ((String)house.get(key)) {
		    		case "BLTIN" : optionDTO.setBltin('Y'); break;
		    		case "ELEV" : optionDTO.setElev('Y'); break;
		    		case "PET" : optionDTO.setPet('Y'); break;
		    		case "VRD" : optionDTO.setVrd('Y'); break;
		    		case "LOAN" : optionDTO.setLoan('Y'); break;
		    		case "PARK" : optionDTO.setPark('Y'); break;
		    		case "MDATE" : optionDTO.setMdate('Y'); break;
		    		}
		    	}
			}
		}
		
		String fileName = null;
		if(himage!=null) {
			String[] fileNames = himage.getOriginalFilename().split("\\.");
			fileName = fileNames[0] + "_" + System.currentTimeMillis() + "." + fileNames[1];
			infoDTO.setHimage(fileName);
		}
		
    	infoDTO.setAgntid(member.getUserid());//session에 잇는 에이전트의 유저 아이디도 가져온다. 
    	registerMap.put("info", infoDTO);
    	registerMap.put("price", priceDTO);
    	registerMap.put("option", optionDTO);
    	
    	//POST면 매물등록, 아니면 PUT으로 매물 수정으로 감 
    	int n = (workType.equals("POST"))? service.houseRegister(registerMap):service.houseUpdate(registerMap);
    	if (n==1 && himage!=null) {//성공하면 FILE업로드 진행 및 성공 메세지 담기
    		File f = new File("c:\\upload", fileName);
    		try {
    			himage.transferTo(f);
    		} catch (IllegalStateException | IOException e) {
    			e.printStackTrace();
    		}
    	} 
		
		return n;
	}
	
	//매물삭제
	@RequestMapping("/houseManaging/DELETE/{delList}")
	public @ResponseBody String houseRegisterDELETE(@PathVariable("delList") String[] delList) {
		List<String> list = Arrays.asList(delList);
		int n = service.houseDel(list);
		return (n>0)? "1":"0";
	}
	
	
}
