package com.controller.board;

import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
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
	public ModelAndView houseDetailBoard(@RequestParam("pcode") String pcode) {
		ModelAndView mav = new ModelAndView();
		mav.addObject("pcode",pcode);
		mav.setViewName("board/houseDetailBoard");
		return mav;
	}
	

	@RequestMapping("/updateBoard")
	public String updateBoard(@RequestParam String pcode, @RequestParam String ppwd, @RequestParam String confirmPw,
			BoardDTO board, HttpSession session) {
		System.out.println(1);
		MemberDTO member = (MemberDTO) session.getAttribute("memberInfo");
		String hcode = (String) session.getAttribute("hcode");
		System.out.println(hcode);
		board.setUserid(member.getUserid());
		System.out.println(board);
		if (ppwd.equals(confirmPw)) {
			int updBrd = bService.updateBoard(board);
			if (updBrd != 1) {
				session.setAttribute("mesg", "게시물 비밀번호를 확인해주세요.");
			} else {
				session.setAttribute("mesg", "수정되었습니다.");
			}
		}
		session.setAttribute("func", "window.close()");
		return "board/houseDetailBoard";
	}
	
	@RequestMapping("/deleteBoard")
	public String deleteBoard(@RequestParam String pcode, @RequestParam String ppwd, HttpSession session) {
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