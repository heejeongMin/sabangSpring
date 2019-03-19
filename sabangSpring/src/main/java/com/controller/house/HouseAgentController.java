package com.controller.house;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.dto.HouseInfoDTO;
import com.dto.HouseOptionDTO;
import com.dto.HousePriceDTO;
import com.dto.MemberDTO;
import com.service.HouseService;

@Controller
public class HouseAgentController {

	@Autowired
	HouseService service;

	@RequestMapping("/houseManaging")
	public String houseManaging(HttpSession session, Model model) {
		MemberDTO member = (MemberDTO) session.getAttribute("memberInfo");
		model.addAttribute("houseByAgent", service.houseByAgent(member.getUserid()));
		return "houseAgent";
	}// end houseManaging


	@RequestMapping("/houseUIController/{work}")
	public String houseUIControle(@PathVariable("work") String work, 
								  		@RequestParam(value="hcode", required=false) String hcode) {
		
		System.out.println(work);
		
//		ModelAndView mav = new ModelAndView();
//		
//		if (work != null) {
//			mav.setViewName("houseAgent");
//			mav.addObject("work", work);
//		} else if (hcode != null) {
//			mav.setViewName("houseAgent");
//			HouseInfoDTO infoDTO = service.houseRetrieve(hcode);
//			HousePriceDTO priceDTO = service.housePrice(hcode);
//			HouseOptionDTO optionDTO = service.houseOption(hcode);
//			
//			mav.addObject("infoDTO", infoDTO);
//			mav.addObject("priceDTO", priceDTO);
//			mav.addObject("optionDTO", optionDTO);
//			mav.addObject("work", "update");
//		}
		
		return "";
	}

}
