package com.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dao.BoardDAO;
import com.dto.BoardDTO;
@Service
public class BoardService {

@Autowired
BoardDAO dao;
	
	// 보드 리스트 가져오기
	 public List<BoardDTO> boardList(String hcode) {
			return dao.boardList(hcode);
		}//end boardList
	 
	 
	// 보드 삭제
	 public int deleteBoard(HashMap<String,String> list) {
			return dao.deleteBoard(list);
		}
	 
	//보드 수정 
	 public int updateBoard(BoardDTO board) {
			return  dao.updateBoard(board);
	}
	 
	// 보드 삭제와 같이 수정 전 비밀번호 확인 작업을 받기 위한 쿼리문
	 public int confUpBoard(HashMap<String,String> list) {
		 return dao.confUpBoard(list);
	 }
}
