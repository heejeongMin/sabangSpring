package com.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dao.MemberDAO;
import com.dto.AgentDTO;
import com.dto.MemberDTO;
import com.dto.WdMbrDTO;

@Service
public class MemberService {
	
	@Autowired
	MemberDAO dao;
	
	/* 가입  */

	public int signMbr(MemberDTO member) {
		return dao.signMbr(member);
	}
	
	public int signAgnt(AgentDTO agent) {
		return dao.signAgnt(agent);
	}
	
	public int idCheck(String userid) {
		return dao.idCheck(userid);
	}
	
	public int ssnCheck(String ssn) {
		return dao.ssnCheck(ssn);
	}
	
	public int phoneCheck(String phone) {
		return dao.phoneCheck(phone);
	}
	
	public int agntIdCheck(String userid) {
		return dao.agntIdCheck(userid);
	}
	
	public int signedCheck(String userid) {
		return dao.signedCheck(userid);
	}// end hasSigned
	
	public WdMbrDTO wdMbrInfo (String userid) {
		return dao.wdMbrInfo(userid);
	}// end overDayCheck
	
	public String overDay(String userid) {
		return dao.overDay(userid);
	}
	
	
	/* 로그인 */

	public MemberDTO login(Map<String, String> map) {
		return dao.login(map);
	}// end member login

	
	public AgentDTO agntlogin(HashMap<String, String> map) {
		return dao.agntlogin(map);
	}// end agent login

	
/*회원 탈퇴*/
	
	public int delMbrId(String userid) {
		return  dao.delMbrId(userid);
	}// end delMbrId


	public int delAgntId(String userid) {
		return dao.delAgntId(userid);
	}// end delMbrId

	
	public int addOutMbr(String userid) {
		return dao.addOutMbr(userid);
	}
	
	public MemberDTO checkMbrPw(String passwd) {
		return dao.checkMbrPw(passwd);
	}// end checkMbrPw
	
	// 마이페이지
	public MemberDTO mypageMember(String userid) {
		return dao.mypageMember(userid);
	}
	
	
	
	public AgentDTO mypageAgent(String userid) {
		return dao.mypageAgent(userid);
	}
	
	
	public MemberDTO myPageCheckMember(HashMap<String, String> map) {
		return dao.myPageCheckMember(map);
	}
	
	
	public AgentDTO myPageCheckAgent(HashMap<String, String> map) {
		return dao.myPageCheckAgent(map);
	}
	
	
	public int memberUpdate(MemberDTO dto) {
		return dao.memberUpdate(dto);
	}
	
	public List<HashMap<String,String>> myPageBoard(String userid) {
		return dao.myPageBoard(userid);
	}
	
	
	/////////////////////Naver Login//////////////////////////
	public int naverUser(Map<String, String> naverMap) {
		return dao.naverUser(naverMap);
	} //naverUser
	
	public MemberDTO getNaverUser(String uniqId) {
		return dao.getNaverUser(uniqId);
	} //naverUser
	
}
