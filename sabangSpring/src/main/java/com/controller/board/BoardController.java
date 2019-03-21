package com.controller.board;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
@Controller
public class BoardController {
	
	@RequestMapping("/houseDetailBoard")
	public ModelAndView houseDetailBoard(@RequestParam("pcode") String pcode) {
		ModelAndView mav = new ModelAndView();
		mav.addObject("pcode",pcode);
		mav.setViewName("board/houseDetailBoard");
		System.out.println(1);
		return mav;
	}
}