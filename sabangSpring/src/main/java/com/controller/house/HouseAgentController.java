package com.controller.house;

import javax.servlet.RequestDispatcher;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.dto.HouseInfoDTO;
import com.dto.HouseOptionDTO;
import com.dto.HousePriceDTO;
import com.service.HouseService;

@Controller
public class HouseAgentController {

	@Autowired
	HouseService service;
	
	@RequestMapping("/HouseUIControle")
	public ModelAndView houseUIControle(@RequestParam(value="work", required=false) String work, 
								  		@RequestParam(value="hcode", required=false) String hcode) {
		ModelAndView mav = new ModelAndView();
		
		if (work != null) {
			mav.setViewName("houseAgent");
			mav.addObject("work", work);
		} else if (hcode != null) {
			mav.setViewName("houseAgent");
			HouseInfoDTO infoDTO = service.houseRetrieve(hcode);
			HousePriceDTO priceDTO = service.housePrice(hcode);
			HouseOptionDTO optionDTO = service.houseOption(hcode);
			
			mav.addObject("infoDTO", infoDTO);
			mav.addObject("priceDTO", priceDTO);
			mav.addObject("optionDTO", optionDTO);
			mav.addObject("work", "update");
		}
		
		return mav;
	}
	
	
}
