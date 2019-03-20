package com.controller.house;

import java.util.Arrays;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

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

	@RequestMapping("/houseManaging/POST")
	public @ResponseBody String houseRegisterPOST(@PathVariable("htype") String htype) {
		return "";
	}
	
	@RequestMapping("/houseManaging/DELETE/{delList}")
	public @ResponseBody String houseRegisterDELETE(@PathVariable("delList") String delList) {
		List<String> list = Arrays.asList(delList);
		int n = service.houseDel(list);
		String deleteMsg = (n>0)? "1":"0";
//		response.sendRedirect("HouseManagingServlet");
		return deleteMsg;
	}
}
