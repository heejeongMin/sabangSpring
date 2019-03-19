package com.controller.member;

import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.dto.MemberDTO;
import com.service.MemberService;
@Controller
public class MemberController {
	
	@Autowired
	MemberService mService;
	
	@RequestMapping("/login")
	public String login(@RequestParam Map<String, String>map, HttpSession session) { // Map<"jsp tag name", html 사용자 값>
		MemberDTO dto = mService.login(map);
		String nextPage=null;
		if(dto!=null) {
			session.setAttribute("memberInfo", dto);
			nextPage = "redirect:/";
		}else {
			nextPage = "redirect:/loginUI";
		}
		return nextPage;
	}

	@RequestMapping("/logout")
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:/";
	}
	
	
	@RequestMapping("/delMbrId") // 해당 컨트롤러로 들어오기 위한 값
	public String delMbrId(@RequestParam("passwd") String inputpw, HttpSession session, Model m) {
		MemberDTO dto = (MemberDTO) session.getAttribute("memberInfo");
		String userpw = dto.getPasswd();
		String nextPage = null;
		if (userpw.equals(inputpw)) {
			String userid = dto.getUserid();
			mService.delMbrId(userid);
			session.invalidate(); //탈퇴와 함께 로그아웃
			System.out.println(1);
			m.addAttribute("mesg", "탈퇴되었습니다");
			nextPage = "redirect:/"; //로그아웃시 main화면으로 이동하게 된다.
		}else {
			m.addAttribute("mesg", "비밀번호를 확인해주세요.");
			nextPage = "redirect:/delMbrIdConfirm";
		}
		return nextPage;
	}
	/*
	 * @RequestMapping("")
	 */
	
	
	
	
	
}
