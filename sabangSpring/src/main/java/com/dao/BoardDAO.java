package com.dao;
import java.util.HashMap;
import java.util.List;

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
	public int deleteBoard(HashMap<String,String> list){
		int x = session.delete("BoardMapper.deleteBoard", list);
		return x;
	}
	
	// 보드 수정, dto와 게시물 비밀번호를 받는다
//	public int updateBoard(HashMap<String,BoardDTO> map){
//		int x = session.update("BoardMapper.updateBoard", map);
//		return x;
//	}
	
	public int updateBoard(BoardDTO board){
		int x = session.update("BoardMapper.updateBoard", board);
		return x;
	}
	//보드 수정과 삭제를 위한 게시물 비밀번호로 보드 데이터 가져오기
/*	public List<BoardDTO> boardList(String hcode){
		List<BoardDTO> list = session.selectList("BoardMapper.boardList", hcode);
		return list;
	}*/
	
}
