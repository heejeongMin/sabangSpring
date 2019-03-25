package com.controller.board;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.dto.BoardDTO;
import com.dto.MemberDTO;
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
	public ModelAndView postBoard(@RequestParam("pcode") String pcode) {
		ModelAndView mav = new ModelAndView();
		mav.addObject("pcode",pcode);
		mav.setViewName("board/postBoard");
		return mav;
	}
	
	
	@RequestMapping("/updateBoard")
	public String updateBoard(@RequestParam("pcode") String pcode, BoardDTO dto, HttpSession session) { //자동모델처리 테스트, BoardDTO였음. hashmap도 테스트 요망. 맵이 하나 이상이어도 자동 injection이 되는지. 
		String nextPage = null;
			dto.setPcode(pcode);
			int updBrd = bService.updateBoard(dto);
			System.out.println(dto);
			if (updBrd == 1) {
				session.setAttribute("mesg", "수정되었습니다.");
				nextPage = "redirect: houseDetailBoard?pcode="+pcode;
			}else {
				nextPage = "error.jsp";
			}
			session.setAttribute("func", "window.close()");
		return nextPage;
	}
	
	@RequestMapping("/deleteBoard")
	public String deleteBoard(@RequestParam(value = "pcode", required = false) String pcode, HttpSession session) {
		int delBrd = bService.deleteBoard(pcode);
		if( delBrd != 1 ) {
			session.setAttribute("mesg", "게시물 비밀번호를 확인해주세요");
		}else {
			session.setAttribute("mesg", "삭제되었습니다.");
		}
		session.setAttribute("func", "window.close()");
		return "board/houseDetailBoard";
	}
	
	
	@RequestMapping("/myPageBoard")
	public String myPageBoard(HttpSession session) {
		MemberDTO member = (MemberDTO)session.getAttribute("memberInfo");
		List<HashMap<String,String>> boardList = mService.myPageBoard(member.getUserid());
		session.setAttribute("boardList", boardList);
		return "myPageBoard";
	}


}