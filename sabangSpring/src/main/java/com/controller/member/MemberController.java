package com.controller.member;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpSession;

import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.capcha.NaverCaptcha;
import com.dto.HouseRcnlistDTO;
import com.dto.MemberDTO;
import com.service.HouseService;
import com.service.MemberService;

@Controller
public class MemberController {

	@Autowired
	MemberService mService;

	@Autowired
	HouseService hService;

	@RequestMapping("/login")
	public String login(@RequestParam Map<String, String> map, HttpSession session, RedirectAttributes flash) { // Map<"jsp
																												// tag
																												// name",
																												// html
																												// 사용자
																												// 값>
		MemberDTO dto = mService.login(map);
		String nextPage = null;
		if (dto != null) {
			session.setAttribute("memberInfo", dto);
			nextPage = "redirect:/";
			flash.addFlashAttribute("mesg", dto.getUserid() + "님이" + " 정상적으로 로그인 되었습니다.");
		} else {
			nextPage = "redirect:/loginUI";
			flash.addFlashAttribute("mesg", "아이디 또는 비밀번호를 잘못입력하셨습니다.");
		}
		return nextPage;
	}

	@RequestMapping("/logout")
	public String logout(HttpSession session) {
		MemberDTO dto = (MemberDTO) session.getAttribute("memberInfo");
		HashMap<Long, String> history = (HashMap<Long, String>) session.getAttribute("history");
		if (history != null) {
			Set<Long> keys = history.keySet(); // time
			List<HouseRcnlistDTO> rList = new ArrayList<>();
			for (long key : keys) {
				HouseRcnlistDTO rDto = new HouseRcnlistDTO();
				rDto.setNum(key);
				rDto.setHcode(history.get(key));
				rDto.setUserid(dto.getUserid());
				rList.add(rDto);
			}

			int n = hService.rcnListAllDone(rList);
		}

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
			mService.addOutMbr(userid);
			session.invalidate(); // 탈퇴와 함께 로그아웃된다
			flash.addFlashAttribute("mesg", "탈퇴되었습니다"); // request와 session의 중간급 scope로서, 한번의 요청에만 살아있다. 해당 메세지는 일회용으로서,
			nextPage = "redirect:/";
			// model 자체는 request scope
		} else {
			flash.addFlashAttribute("mesg", "비밀번호를 확인해주세요");
			nextPage = "redirect:/delMbrIdConfirm";
		}
		return nextPage;
	}

	// naver 로그인 기능
	@RequestMapping("/naverSignin")
	public @ResponseBody MemberDTO naverSignin(@RequestParam HashMap<String, String> naverMap, HttpSession session) {
		MemberDTO memberInfo = new MemberDTO();
		int n = mService.naverUser(naverMap);
		memberInfo = mService.getNaverUser(naverMap.get("uniqId"));
		session.setAttribute("memberInfo", memberInfo);
		return memberInfo;
	}

	
	
	
	@RequestMapping("/signMbr")
	public String signMbr(RedirectAttributes flash, MemberDTO dto, String cnfPasswd, String ssn1, String ssn2,
			String addr, String phone1, String phone2, String phone3, String email1, String email2, String email3
			) {
		// 1. id 중복체크
		int hasUserId = mService.idCheck(dto.getUserid());
		// 2. 가입 이력 검사
		int hasSigned = mService.signedCheck(dto.getUserid());
		String nextPage = null;
		if (hasUserId == 0 && hasSigned == 0) {
			dto.setSsn(ssn1 + '-' + ssn2);
			dto.setEmail(email1 + '@' + email2);
			dto.setPhone(phone1 + phone2 + phone3);
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

	

	@RequestMapping(value = "/idCheck", method = RequestMethod.POST)
	public @ResponseBody String idCheck(@RequestBody String id) {
		String mesg = null;
		int idCheck = mService.idCheck(id.substring(3));
		System.out.println(id);
		if (idCheck == 1) {
			mesg = "N";
		} else {
			mesg = "Y";
		}
		System.out.println(mesg);
		return mesg;
	}

	@RequestMapping(value = "/ssnCheck", method = RequestMethod.POST)
	public @ResponseBody String ssnCheck(@RequestBody String ssn) {
		String mesg = null;
		int ssnCheck = mService.ssnCheck(ssn.substring(4));
		System.out.println(ssn);
		if (ssnCheck == 1) {
			mesg = "N";
		} else {
			mesg = "Y";
		}
		System.out.println(mesg);
		return mesg;
	}

	@RequestMapping(value = "/phoneCheck", method = RequestMethod.POST)
	public @ResponseBody String phoneCheck(@RequestBody String phone) {
		String mesg = null;
		int phoneCheck = mService.phoneCheck(phone.substring(6));
		System.out.println(phone);
		if (phoneCheck == 1) {
			mesg = "N";
		} else {
			mesg = "Y";
		}
		System.out.println(mesg);
		return mesg;
	}

	
	@RequestMapping("/signMbrUI")
	public String getImage(HttpSession session, Model m) throws ParseException {
		NaverCaptcha key = new NaverCaptcha();
		System.out.println("1>" + key);
		String mykey = key.getKey();
		m.addAttribute("key", mykey);
		key.getImage();
		System.out.println("2>" + mykey);
		return "signMbrForm";
	}
	
	
	@RequestMapping("/checkResult")
	public @ResponseBody String checkResult(@RequestParam("inputVal") String input, @RequestParam("key") String key) {
		NaverCaptcha ct = new NaverCaptcha();
		String res = ct.checkNumber(key, input);
		System.out.println(key);
		return res;
	}

}
