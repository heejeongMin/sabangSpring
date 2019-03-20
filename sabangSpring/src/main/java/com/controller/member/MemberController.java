package com.controller.member;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.dto.MemberDTO;
import com.service.MemberService;

@Controller
public class MemberController {

	@Autowired
	MemberService mService;

	@RequestMapping("/login")
	public String login(@RequestParam Map<String, String> map, HttpSession session) { // Map<"jsp tag name", html 사용자 값>
		MemberDTO dto = mService.login(map);
		String nextPage = null;
		if (dto != null) {
			session.setAttribute("memberInfo", dto);
			nextPage = "redirect:/";
		} else {
			nextPage = "redirect:/loginUI";
		}
		return nextPage;
	}

	@RequestMapping("/logout")
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:/";
	}

	@RequestMapping("/delMbrId")
	public String delMbrId(@RequestParam("passwd") String inputpw, HttpSession session, RedirectAttributes flash) {
		MemberDTO dto = (MemberDTO) session.getAttribute("memberInfo");
		String userpw = dto.getPasswd();
		String nextPage = null;
		if (userpw.equals(inputpw)) {
			String userid = dto.getUserid();
			mService.delMbrId(userid);
			session.invalidate(); // 탈퇴와 함께 로그아웃된다
			flash.addFlashAttribute("mesg", "탈퇴되었습니다"); // request와 session의 중간급 scope로서, 한번의 요청에만 살아있다. 해당 메세지는 일회용으로서,
														// flash scope에 저장하였음.
			nextPage = "redirect:/";
			// model 자체는 request scope
		} else {
			flash.addFlashAttribute("mesg", "비밀번호를 확인해주세요");
			nextPage = "redirect:/delMbrIdConfirm";
		}
		return nextPage;
	}

	@RequestMapping("/signMbr")
	public String signMbr(RedirectAttributes flash, MemberDTO dto, String cnfPasswd, String ssn1, String ssn2,
			String addr,String phone1, String phone2, String phone3, String email1, String email2,
			String email3) {
		System.out.println("!!!!!!!!!!!!!!!!!!!!!!!!!Systest: dto" + dto);
		// 1. id 중복체크
		int hasUserId = mService.idCheck(dto.getUserid());
		// 2. 가입 이력 검사
		int hasSigned = mService.signedCheck(dto.getUserid());
		String nextPage = null;
		if (hasUserId == 0 && hasSigned == 0) {
			dto.setSsn(ssn1+'-'+ssn2);
			dto.setEmail(email1+'@'+email2);
			dto.setPhone(phone1+phone2+phone3);
			mService.signMbr(dto);
			flash.addFlashAttribute("mesg", "사방팔방 곳곳의 방에 오신 것을 환영합니다");
			nextPage = "redirect:/";
		} else if (hasSigned == 1) { // 가입 이력이 있다면
			// 탈퇴 + 24시간 출력, sql상에서 날짜포맷 변환을 위한 TO_CHAR 작업으로 mapper에서 parameterType을
			// String으로 주었으므로 형변환 작업이 수반된다
			int outDate = Integer.parseInt(mService.overDay(dto.getUserid()));
			// 현재시간을 구하기 위한 Date 객체
			Date date = new Date();
			// 시간 포맷 지정하는 SimpleDateFormat 객체
			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHH");
			// 현재 시간을 simpledateformat으로 구한 시간 포맷으로 변환, integer형으로 형변환한다.
			int curDate = Integer.parseInt(sdf.format(date));
			System.out.println(outDate);
			System.out.println(curDate);
			if (curDate > outDate) {
				mService.signMbr(dto);
				flash.addFlashAttribute("mesg", "다시 돌아와 주었군요! 재가입을 환영합니다.");
				nextPage = "redirect:/";
			} else {
				flash.addFlashAttribute("mesg", "탈퇴한 회원은 24시간 이내에 재가입 할 수 없습니다. 시간 경과후 다시 시도해 주시길 바랍니다.");
				nextPage = "redirect:/loginUI";
			}
		}
		return nextPage;
	}

}
