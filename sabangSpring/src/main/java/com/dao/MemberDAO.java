package com.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.dto.AgentDTO;
import com.dto.MemberDTO;
import com.dto.WdMbrDTO;
@Repository
public class MemberDAO {
	
	@Autowired
	SqlSessionTemplate session;
	
	/* 가입 */
	
	public int signMbr( MemberDTO member) {
		int n = session.insert("MemberMapper.signMbr", member);
		return n;
	}
	
	public int signAgnt( AgentDTO agent) {
		int n = session.insert("MemberMapper.signAgnt", agent);
		return n;
	}
	
	public int idCheck( String userid) {
		int count = session.selectOne("MemberMapper.idCheck", userid);
		return count;
	}
	
	public int ssnCheck( String ssn) {
		int count = session.selectOne("MemberMapper.ssnCheck", ssn);
		return count;
	}
	
	public int phoneCheck( String phone) {
		int count = session.selectOne("MemberMapper.phoneCheck", phone);
		return count;
	}
	
	public int agntIdCheck( String userid) {
		int count = session.selectOne("MemberMapper.agntIdCheck", userid);
		return count;
	}

	public int signedCheck( String userid) {
		return session.selectOne("MemberMapper.signedCheck", userid);
	}
	
	public WdMbrDTO wdMbrInfo( String userid) {
		return session.selectOne("MemberMapper.wdMbrInfo", userid);
	}
	
	public String overDay(String userid) {
		return session.selectOne("MemberMapper.overDay", userid);
	}
	
	public int addOutMbr(String userid) {
		return session.insert("MemberMapper.addOutMbr", userid);
	}
	
	
	/* 로그인 */
	
	public MemberDTO login(Map<String, String> map) {
		MemberDTO member = session.selectOne("MemberMapper.login", map);
		return member;
	}
	
	public AgentDTO agntlogin( HashMap<String, String> map) {
		AgentDTO agent = session.selectOne("MemberMapper.agntlogin", map);
		return agent;
	}
	
	
	/* 탈퇴 */
	
	public int delMbrId( String userid) {
		int delMbr = session.delete("MemberMapper.delMbrId", userid);
		return delMbr;
	}
	
	public int delAgntId( String userid) {
		int delAgntId = session.delete("MemberMapper.delAgntId", userid);
		return delAgntId;
	}


	public MemberDTO checkMbrPw( String passwd) {
		MemberDTO checkMbrPw = session.selectOne("MemberMapper.checkMbrPw", passwd);
		return checkMbrPw;
	}





	
	
	//////////////////////////////////////////////////////////////////
	// 마이페이지
	public MemberDTO mypageMember(String userid) {
		MemberDTO n = session.selectOne("MemberMapper.mypageMember",userid);
		return n;
	}
	
	public AgentDTO mypageAgent(String userid) {
		AgentDTO n = session.selectOne("MemberMapper.mypageAgent",userid);
		return n;
	}
	
	public MemberDTO myPageCheckMember( HashMap<String, String> map) {
		MemberDTO mDto = session.selectOne("MemberMapper.myPageCheckMember", map);
		return mDto;
	}
	
	public AgentDTO myPageCheckAgent( HashMap<String, String> map) {
		AgentDTO aDto = session.selectOne("MemberMapper.myPageCheckAgent", map);
		return aDto;
	}
	
	
	public int memberUpdate( MemberDTO dto) {
		int n = session.update("MemberMapper.memberUpdate",dto);
		return n;
	}

	
	
	public List<HashMap<String, String>> myPageBoard(String userid) {
		return session.selectList("MemberMapper.myPageBoard",userid);
	}
	
	
	
	
	/////////////////////Naver Login//////////////////////////
	public int naverUser(Map<String, String> naverMap) {
		String uniqId = naverMap.get("uniqId");
		int n = session.selectOne("MemberMapper.naverUser", naverMap);
		if (n==0) naverSignUp(naverMap);
		return n;
	}//end naverIdCheck
	
	private int naverSignUp(Map<String, String> naverMap) {
		return session.insert("MemberMapper.naverSignUp", naverMap);
	}//end naverSignUp
	
	public MemberDTO getNaverUser( String uniqId) {
		return session.selectOne("MemberMapper.getNaverUser", uniqId);
	}//end naverSignUp
}
