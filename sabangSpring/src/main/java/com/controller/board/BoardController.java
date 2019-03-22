package com.controller.board;

import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.service.BoardService;
import com.service.MemberService;
@Controller
public class BoardController {
	
	@Autowired
	MemberService mService;
	@Autowired
	BoardService bService;
	
	@RequestMapping("/houseDetailBoard")
	public ModelAndView houseDetailBoard(@RequestParam("pcode") String pcode) {
		ModelAndView mav = new ModelAndView();
		mav.addObject("pcode",pcode);
		mav.setViewName("board/houseDetailBoard");
		return mav;
	}
	
	/*
	 * @RequestMapping("/editBoard")
	 * 
	 * @ModelAttribute("pcode") public void editBoard(@RequestParam("pcode")String
	 * pcode) {
	 * 
	 * }
	 */

	
	@RequestMapping("/deleteBoard")
	public String deleteBoard(@RequestParam String pcode, @RequestParam String ppwd, HttpSession session) {
		System.out.println(1);
		HashMap<String,String> list = new HashMap<>();
		list.put("pcode",pcode);
		list.put("ppwd",ppwd);
		System.out.println(ppwd);
		int delBrd = bService.deleteBoard(list);
		if( delBrd != 1 ) {
			session.setAttribute("mesg", "게시물 비밀번호를 확인해주세요");
			System.out.println("확인");
		}else {
			session.setAttribute("mesg", "삭제되었습니다.");
		}
		session.setAttribute("func", "window.close()");
		System.out.println("func");
		return "board/houseDetailBoard";
	}
	


}