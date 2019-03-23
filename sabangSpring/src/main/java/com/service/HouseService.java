package com.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.dao.HouseDAO;
import com.dto.HouseInfoDTO;
import com.dto.HouseOptionDTO;
import com.dto.HousePriceDTO;
import com.dto.HouseRcnlistDTO;
import com.dto.HouseWishlistDTO;

@Service
public class HouseService {

	@Autowired
	HouseDAO dao;

	public HashMap<String, Object> searchList(String search, int curPage) {// 검색에 의한 결과 리스트 페이징 처리
		return dao.searchList(search, curPage);
	}// searchList
	
	public List<HashMap<String, Object>> retrieveAllItems() {// 전체매물 리스트
		return dao.retrieveAllItems();
	}// retrieveAllItems
	
	public List<HashMap<String, Object>> retrieveNewItems() {// 신매물 리스트
		return dao.retrieveNewItems();
	}// retrieveNewItems

	public List<HashMap<String, Object>> retrieveHotItems() {// 핫매물 리스트
		return dao.retrieveHotItems();
	}// retrieveHotItems

	public HashMap<String, Object> listByFilter(HashMap<String, List<String>> queryMap, int curPage) {// 필터에 의한 리스트
		return dao.listByFilter(queryMap, curPage);
	}// retrieveHotItems

	public List<HashMap<String, Object>> houseByAgent(String agntid) {// 거래중인 매물
		return dao.houseByAgent(agntid);
	}// houseByAgent
	
	public List<HashMap<String, Object>> houseSoldByAgent(String agntid) {// 거래완료 매물
		return dao.houseSoldByAgent(agntid);
	}// houseSoldByAgent
	
	public List<HashMap<String, Object>> houseLikeByAgent(String agntid) {// 에이전트가 등록한 매물 좋아요받은 순
		return dao.houseLikeByAgent(agntid);
	}// houseLikeByAgent

	public String getLastCode(String htype) {// 마지막으로 등록된 코드 가져오기
		return dao.getLastCode(htype);
	}// end getLastCode

	@Transactional
	public int houseRegister(HashMap<String, Object> registerMap) {// 매물등록
		int n = dao.houseRegister_info((HouseInfoDTO) registerMap.get("info"));
			n = dao.houseRegister_price((HousePriceDTO) registerMap.get("price"));
			n = dao.houseRegister_option((HouseOptionDTO) registerMap.get("option"));
		return n;
	}// end houseRegister

	@Transactional
	public int houseUpdate(HashMap<String, Object> registerMap) {// 매물 수정
		int n = dao.houseUpdate_info((HouseInfoDTO) registerMap.get("info"));
			n = dao.houseUpdate_price((HousePriceDTO) registerMap.get("price"));
			n = dao.houseUpdate_option((HouseOptionDTO) registerMap.get("option"));
		return n;
	}// end houseUpdate

	public int houseDel(List<String> list) {// 매물삭제
		return dao.houseDel(list);
	}// end houseDel

	@Transactional
	public int updateCntWish(HouseWishlistDTO dto) {// 매물 cnthwish 업데이트
		int n = dao.addWish(dto);
//			n = dao.updateCntWish(session, dto.getHcode());
		return n;
	}// end updateCntWish
	

	///////////////////////////////////////////////////////////
	// Basic : House 자세히보기
	public HouseInfoDTO houseRetrieve(String hcode) {
		return dao.houseRetrieve(hcode);
	}

	// Basic : house 가격
	public HousePriceDTO housePrice(String hcode) {
		return dao.housePrice(hcode);
	}

	// Basic : house 옵션
	public HouseOptionDTO houseOption(String hcode) {
		return dao.houseOption(hcode);
	}

	///////////////////////////////////////////////////////////
	// 최근 본 House 테이블 보기
	public List<HouseRcnlistDTO> selectRcnlist(String userid) {
		return dao.selectRcnlist(userid);
	}

	// 최근 본 House DB 데이터 저장
	public int rcnListAllDone(List<HouseRcnlistDTO> rList) {
		return dao.rcnListAllDone(rList);
	}

	// 최근 본 House DB 데이터 삭제
	public int deleteRcnlist(List<Long> userRcnList) {
		return dao.deleteRcnlist(userRcnList);
	}

	// 최근 본 / 찜한 House 리스트 보기
	public List<HashMap<String, Object>> rcnHouseInfo(List<String> hCodeList) {
		return dao.rcnHouseInfo(hCodeList);
	}

	// 찜한 House 리스트 보기
	public List<HouseWishlistDTO> selectWishlist(String userid) {
		return dao.selectWishlist(userid);
	}
}
