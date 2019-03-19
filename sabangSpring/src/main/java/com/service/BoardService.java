package com.service;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
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
	// 보드 수정
/*	 public int updateBoard(HashMap<String,BoardDTO> map) {
			SqlSession session = MySqlSessionFactory.getSession();
			int updateBoard = 0;
			try {
				BoardDAO dao = new BoardDAO();
				updateBoard = dao.updateBoard(map);
				session.commit();
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				session.close();
			}
			return updateBoard;
		}*/
	 
	 
	 public int updateBoard(BoardDTO board) {
			return  dao.updateBoard(board);
		}
}
