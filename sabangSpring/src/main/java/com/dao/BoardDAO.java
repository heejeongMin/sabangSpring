package com.dao;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.dto.BoardDTO;
@Repository
public class BoardDAO {
	private static final Logger logger = LoggerFactory.getLogger(BoardDAO.class);
	
	@Autowired
	SqlSessionTemplate session;
	
	// 보드 리스트 가져오기
	public List<BoardDTO> boardList(String hcode){
		List<BoardDTO> list = session.selectList("BoardMapper.boardList", hcode);
		return list;
	}
	
	// 보드 삭제, pcode와 게시물 비밀번호를 받는다
	public int deleteBoard(String pcode){
		int x = session.delete("BoardMapper.deleteBoard", pcode);
		return x;
	}
	
	// 보드 수정, dto와 게시물 비밀번호를 받는다
//	public int updateBoard(HashMap<String,BoardDTO> map){
//		int x = session.update("BoardMapper.updateBoard", map);
//		return x;
//	}
	
	public int updateBoard(BoardDTO board){ //자동모델처리 테스트, BoardDTO였음
		int x = session.update("BoardMapper.updateBoard", board);
		return x;
	}
	
	//board delete 와 같이, 작업을 수행하기 전 비밀번호를 받는 작업.
	public int confUpBoard(HashMap<String,String> list) {
		return session.selectOne("BoardMapper.confUpBoard", list);
	}
	
	///////////////// Angualr 관리자 마이페이지 //////////////
	//Angular - 에이전트가 올린 모든 매물에 대한 board 리스트
	public List<HashMap<String, Object>> agentHouseBoard(String agntid){
		return session.selectList("BoardMapper.agentHouseBoard", agntid);
	}
	
}
