package com.controller.board;

import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.dto.BoardDTO;
import com.service.BoardService;
import com.service.MemberService;
@Controller
public class BoardController {
	
	@Autowired
	MemberService mService;
	@Autowired
	BoardService bService;
	
	@RequestMapping("/houseDetailBoard")
	public ModelAndView houseDetailBoard(@RequestParam(value = "pcode", required = false) String pcode) {
		ModelAndView mav = new ModelAndView();
		mav.addObject("pcode",pcode);
		mav.setViewName("board/houseDetailBoard");
		return mav;
	}
	
	@RequestMapping("/postBoard")
	@ModelAttribute("pcode")
	public ModelAndView postBoard(@RequestParam(value = "pcode", required = false) String pcode) {
		ModelAndView mav = new ModelAndView();
		mav.addObject("pcode",pcode);
		mav.setViewName("board/postBoard");
		return mav;
	}
	
	
	@RequestMapping("/updateBoard")
	public String updateBoard(@RequestParam(value = "pcode", required = false) String pcode, @RequestParam String ppwd, HashMap<String,String> list
			, BoardDTO dto, HttpSession session) { //자동모델처리 테스트, BoardDTO였음. hashmap도 테스트 요망. 맵이 하나 이상이어도 자동 injection이 되는지. 
		list.put("pcode",pcode);
		list.put("ppwd",ppwd);
		int confUpBoard = bService.confUpBoard(list);
		String nextPage = null;
		if (confUpBoard == 1) {
			int updBrd = bService.updateBoard(dto);
			if (updBrd == 1) {
				session.setAttribute("mesg", "수정되었습니다.");
				nextPage = "board/houseDetailBoard";
			}else {
				nextPage = "error.jsp";
			}
		} else {
			session.setAttribute("mesg", "게시물 비밀번호를 확인해주세요.");
		}
		session.setAttribute("func", "window.close()");
		return nextPage;
	}
	
	@RequestMapping("/deleteBoard")
	public String deleteBoard(@RequestParam(value = "pcode", required = false) String pcode, @RequestParam String ppwd, HttpSession session) {
		HashMap<String,String> list = new HashMap<>();
		list.put("pcode",pcode);
		list.put("ppwd",ppwd);
		int delBrd = bService.deleteBoard(list);
		if( delBrd != 1 ) {
			session.setAttribute("mesg", "게시물 비밀번호를 확인해주세요");
		}else {
			session.setAttribute("mesg", "삭제되었습니다.");
		}
		session.setAttribute("func", "window.close()");
		return "board/houseDetailBoard";
	}
	


}