package com.controller.mypage;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.dto.MemberDTO;
import com.service.MemberService;

@Controller
public class MypageController {
	
	@Autowired
	MemberService service;
	
	@RequestMapping("/myPage")
	public String myPage(HttpSession session, Model model) {
		MemberDTO loginMember = (MemberDTO)session.getAttribute("memberInfo");
		MemberDTO mDto = service.mypageMember(loginMember.getUserid());
		String email = mDto.getEmail();
		String memberPhone = mDto.getPhone();
		String [] phone = new String[3];
		phone[0] = memberPhone.substring(0, 3);
		phone[1] = memberPhone.substring(3, 7);
		phone[2] = memberPhone.substring(7);
		
		model.addAttribute("email", email);
		model.addAttribute("phone", phone);
		return "mypage";
	}
	
	
	@RequestMapping("/memberPwdCheck")
	public @ResponseBody String memberPwdCheck(HttpSession session,
			@RequestParam("passwd") String passwd ) {
		MemberDTO loginMember = (MemberDTO)session.getAttribute("memberInfo");
		
		MemberDTO mDto = service.mypageMember(loginMember.getUserid());
		String memberid = loginMember.getUserid();
		HashMap<String, String> map = new HashMap<>();
			map.put("userid", memberid);
			map.put("passwd", passwd);
			
			MemberDTO checkMember = null;
			if(mDto.getPasswd().equals(passwd)) {
				checkMember = service.myPageCheckMember(map);
			}
			
		String data = "0";
		if(checkMember != null) {
			if(checkMember.getPasswd().equals(passwd)) {
				data = "1";
			};
		}
		
		return data;
	}
	
	
	@RequestMapping("/memberUpdate")
	public String memberUpdate(HttpSession session,
			@RequestParam("pwdCheck") String passwd, 
			@RequestParam(value="phone",required=false) String[] phoneNum ) {
		MemberDTO loginMember = (MemberDTO)session.getAttribute("memberInfo");
		MemberDTO mDto = service.mypageMember(loginMember.getUserid());
		
		String userid = loginMember.getUserid();
		if(passwd.isEmpty()) {
			passwd = mDto.getPasswd();
		}
		String phone = "";
		if(phoneNum!=null) {
			phone = phoneNum[0] + phoneNum[1] + phoneNum[2];
		}else {
			phone = mDto.getPhone();
		}
		
		MemberDTO updateMDto = new MemberDTO(userid, passwd, phone);
		int num = service.memberUpdate(updateMDto);
		
		return "mypage";
	}
}
