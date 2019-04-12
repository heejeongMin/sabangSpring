package com.dao;

import java.util.Calendar;
import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.dto.HouseInfoDTO;
import com.dto.HouseOptionDTO;
import com.dto.HousePriceDTO;
import com.dto.HouseRcnlistDTO;
import com.dto.HouseWishlistDTO;

@Repository
public class HouseDAO {

	@Autowired
	SqlSessionTemplate session;

	/*
	 * 페이징 처리 
	 * 1. curPage : 현재 페이지 
	 * 2. perPage : 한번에 보여줄 페이지 개수 
	 * 3. totalPage : 전체 목록개수 
	 * 4. list : db에서 가져온 애들
	 */

	// 검색에 의한 결과 리스트 페이징 처리
	public HashMap<String, Object> searchList(String search, int curPage) {
		HashMap<String, Object> pagingMap = new HashMap<>();
		pagingMap.put("curPage", curPage);
		pagingMap.put("perPage", 3);
		pagingMap.put("totalPage", totalListBySearch(search));

		int offset = (curPage - 1) * (int) pagingMap.get("perPage");
		List<HashMap<String, Object>> list = session.selectList("HouseMapper.searchList", search, new RowBounds(offset, (int) pagingMap.get("perPage")));
		pagingMap.put("list", list);

		return pagingMap;
	}// searchList

	// searchList에서만 사용해서 private처리
	private int totalListBySearch(String search) {
		return session.selectOne("HouseMapper.totalListBySearch", search);
	}// totalListbySearch

	// 전체매물 리스트
	public List<HashMap<String, Object>> retrieveAllItems() {
		return session.selectList("HouseMapper.retrieveAllItems");
	}// end retrieveAllItems

	// 신매물 리스트
	public List<HashMap<String, Object>> retrieveNewItems() {
		String maxSeven = session.selectOne("HouseMapper.newItemCount");
		if (maxSeven == null) {
			Calendar today = Calendar.getInstance();
			String year = String.valueOf(today.get(Calendar.YEAR));
			String month = (today.get(Calendar.MONTH) < 10)? "0"+(today.get(Calendar.MONTH)+1) : String.valueOf(today.get(Calendar.MONTH)+1);
			String date = (today.get(Calendar.DATE) <10)? "0"+today.get(Calendar.DATE) : String.valueOf(today.get(Calendar.DATE));
			
			maxSeven = year+month+date;
		}	
		return session.selectList("HouseMapper.retrieveNewItems", maxSeven);
	}// end retrieveNewItems

	// 핫매물 리스트
	public List<HashMap<String, Object>> retrieveHotItems() {
		return session.selectList("HouseMapper.retrieveHotItems");
	}// end retrieveHotItems

	// 필터에 의한 리스트
	public HashMap<String, Object> listByFilter(HashMap<String, List<String>> queryMap, int curPage) {
		HashMap<String, Object> pagingMap = new HashMap<>();
		pagingMap.put("curPage", curPage);
		pagingMap.put("perPage", 3);
		pagingMap.put("totalPage", totalListByFilter(queryMap));

		int offset = (curPage - 1) * (int) pagingMap.get("perPage");
		List<HashMap<String, Object>> list = session.selectList("HouseMapper.listByFilter", queryMap,
				new RowBounds(offset, (int) pagingMap.get("perPage")));
		pagingMap.put("list", list);

		return pagingMap;
	}// listByFilter

	// listByFilter에서만 사용해서 private 처리
	private int totalListByFilter(HashMap<String, List<String>> queryMap) {
		return session.selectOne("HouseMapper.totalListByFilter", queryMap);
	}// totalListByFilter

	// panel에 매물리스트
	public List<HashMap<String, Object>> houseByAgent(String agntid) {
		return session.selectList("HouseMapper.houseByAgent", agntid);
	}// houseByAgent

	// panel에 매물리스트 (거래완료)
	public List<HashMap<String, Object>> houseSoldByAgent(String agntid) {
		return session.selectList("HouseMapper.houseSoldByAgent", agntid);
	}// houseByAgent

	// 에이전트별 매물 좋아요 많은 순
	public List<HashMap<String, Object>> houseLikeByAgent(String agntid) {
		return session.selectList("HouseMapper.houseLikeByAgent", agntid);
	}// houseLikeByAgent

	// group by 등록일자 매물 수
	public List<HashMap<String, Object>> houseByRegisterDate(String agntid) {
		return session.selectList("HouseMapper.houseByRegisterDate", agntid);
	}// houseLikeByAgent
	
	// group by 등록일자 , 거래 완료 매물 수
		public List<HashMap<String, Object>> houseSoldByAgentCount(String agntid) {
			return session.selectList("HouseMapper.houseSoldByAgentCount", agntid);
		}// houseLikeByAgent

	// 가장 최근에 등록된 매물코드가져오기
	public String getLastCode(String htype) {
		return session.selectOne("HouseMapper.getLastCode", htype);
	}// end getLastCode

	// 매물 올리기- info - info&price&option 트랜잭션 처리
	@Transactional
	public int houseRegister_info(HouseInfoDTO infoDTO) {
		return session.insert("HouseMapper.houseRegister_info", infoDTO);
	}// end houseRegister_info

	// 매물 올리기- price - info&price&option 트랜잭션 처리
	@Transactional
	public int houseRegister_price(HousePriceDTO priceDTO) {
		return session.insert("HouseMapper.houseRegister_price", priceDTO);
	}// end houseRegister_price

	// 매물 올리기- option - info&price&option 트랜잭션 처리
	@Transactional
	public int houseRegister_option(HouseOptionDTO optionDTO) {
		return session.insert("HouseMapper.houseRegister_option", optionDTO);
	}// end houseRegister_option

	// 매물 수정- info - info&price&option 트랜잭션 처리
	@Transactional
	public int houseUpdate_info(HouseInfoDTO infoDTO) {
		return session.update("HouseMapper.houseUpdate_info", infoDTO);
	}// end houseRegister_info

	// 매물 수정- price - info&price&option 트랜잭션 처리
	@Transactional
	public int houseUpdate_price(HousePriceDTO priceDTO) {
		return session.update("HouseMapper.houseUpdate_price", priceDTO);
	}// end houseRegister_price

	// 매물 수정- option - info&price&option 트랜잭션 처리
	@Transactional
	public int houseUpdate_option(HouseOptionDTO optionDTO) {
		return session.update("HouseMapper.houseUpdate_option", optionDTO);
	}// end houseUpdate_option

	// 매물 삭제
	public int houseDel(List<String> list) {
		return session.delete("HouseMapper.houseDel_info", list);
	}// end houseDel

	// 매물 cntwish 값 업데이트
	@Transactional
	public int updateCntWish(String hcode) {
		int n = getCntWish(hcode);

		HashMap<String, Object> map = new HashMap<>();
		map.put("hcode", hcode);
		map.put("cntwish", n);

		n = session.update("HouseMapper.updateCntWish", map);
		return n;
	}// updateCntWish

	// 매물 cntwish 값 가져오기
	private int getCntWish(String hcode) {
		return session.selectOne("HouseMapper.getCntWish", hcode);
	}// getCntWish

	// 유저가 찜한 매물 저장하기
	@Transactional
	public int addWish(HouseWishlistDTO dto) {
		int n = getNoOfWishes(dto); // 유저의 찜 개수 가지고 오기
		int result = 0;
		int dupleCheck = 0;

		// result 0: 찜 개수 다 찼음
		// result 1: 찜 성공
		// result 2 : 찜 대상 매물 중복

		if (n >= 6) {// 이미 찜한개수가 6개가 다 찼을때 result 는 0
			result = 0;
		} else {// 찜은 할 수 있는 블럭
			if (n == 0) {// 찜을 단 한번도 하지 않은 상태니까 그냥 insert 해주고,
				result = session.insert("HouseMapper.addWish", dto);
				result = updateCntWish(dto.getHcode());
			} else {// 찜을 한번이라도 한 이력이 있으니까, 중복매물인지 확인
				dupleCheck = duplicateHouseCheck(dto);
				if (dupleCheck == 0) {// 중복매물이 아니면 insert진행
					result = session.insert("HouseMapper.addWish", dto);
					result = updateCntWish(dto.getHcode());
				} else {// 중복매물이면 2 리턴
					result = 2;
				}
			} // if~else
		}
		return result;
	}// updateCntWish

	// 한 유저당 찜 한 개수 가지고 오기
	private int getNoOfWishes(HouseWishlistDTO dto) {
		return session.selectOne("HouseMapper.getNoOfWishes", dto.getUserid());
	}// getCntWish

	//유저가 동일 매물 이미 찜했는지 않했는지 체크
	private int duplicateHouseCheck(HouseWishlistDTO dto) {
		return session.selectOne("HouseMapper.duplicateHouseCheck", dto);
	};
	
	//매물 중개중/중개완료 여부 저장
	public int houseChange(List<List<String>> list) {
		int n =0 ;
		if (!(list.get(0).isEmpty())) n = session.update("HouseMapper.houseOnSale", list.get(0));
		if (!(list.get(1).isEmpty())) n = session.update("HouseMapper.houseSold", list.get(1));			
		return n;
	}

	///////////////////////////////////////////////////////////
	// Basic: House 자세히보기
	public HouseInfoDTO houseRetrieve(String hcode) {
		HouseInfoDTO dto = session.selectOne("HouseMapper.houseRetrieve", hcode);
		return dto;
	}

	// Basic: House 가격
	public HousePriceDTO housePrice(String hcode) {
		HousePriceDTO dto = session.selectOne("HouseMapper.housePrice", hcode);
		return dto;
	}

	// Basic: House 옵션
	public HouseOptionDTO houseOption(String hcode) {
		HouseOptionDTO dto = session.selectOne("HouseMapper.houseOption", hcode);
		return dto;
	}

	///////////////////////////////////////////////////////////
	// 최근 본 House 테이블 보기
	public List<HouseRcnlistDTO> selectRcnlist(String userid) {
		List<HouseRcnlistDTO> list = session.selectList("HouseMapper.rcnList", userid);
		return list;
	}

	// 최근 본 House DB 데이터 저장
	public int rcnListAllDone(List<HouseRcnlistDTO> rList) {
		int n = session.insert("HouseMapper.rcnInsertAll", rList);
		return n;
	}

	// 최근 본 House DB 데이터 삭제
	public int deleteRcnlist(List<Long> userRcnList) {
		int n = session.delete("HouseMapper.rcnDelete", userRcnList);
		return n;
	}

	// 최근 본 / 찜한 House 리스트 보기
	public List<HashMap<String, Object>> rcnHouseInfo(List<String> hCodeList) {
		List<HashMap<String, Object>> list = session.selectList("HouseMapper.rcnHouseList", hCodeList);
		return list;
	}

	// 찜한 House 테이블 보기
	public List<HouseWishlistDTO> selectWishlist(String userid) {
		List<HouseWishlistDTO> list = session.selectList("HouseMapper.wishList", userid);
		return list;
	}
}
