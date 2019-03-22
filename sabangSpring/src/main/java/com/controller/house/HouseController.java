package com.controller.house;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import com.dto.BoardDTO;
import com.dto.HouseInfoDTO;
import com.dto.HouseOptionDTO;
import com.dto.HousePriceDTO;
import com.dto.MemberDTO;
import com.service.BoardService;
import com.service.HouseService;
import com.service.MemberService;

@Controller
public class HouseController {

	@Autowired
	HouseService hService;
	@Autowired
	MemberService mService;
	@Autowired
	BoardService bService;
	
	@RequestMapping("/houseOverview")// 메인.jsp에서 신촌으로 바로 들어올 때
	public void houseOverview(Model model) {
		model.addAttribute("allList", hService.retrieveAllItems());
		model.addAttribute("newList", hService.retrieveNewItems());
		model.addAttribute("hotList", hService.retrieveHotItems());
	}// end houseOverview

	@RequestMapping("/houseList")// 검색어를 입력하고 검색버튼을 눌렀을 때
	public String houseList(@RequestParam(value = "filters", required = false) String search, @RequestParam(value = "curPage", required = false, defaultValue = "1") int curPage, Model model) {
		System.out.println(search);
		model.addAttribute("search", search);
		model.addAttribute("pagingMap", hService.searchList(search, curPage));
		model.addAttribute("allList", hService.retrieveAllItems());
		model.addAttribute("newList", hService.retrieveNewItems());
		model.addAttribute("hotList", hService.retrieveHotItems());
		return "houseList";
	}//end houseList
	
	@RequestMapping("/houseFilter")// 필터 조건들을 선택했을 때 ajax
	public String houseFilter(@RequestParam(value = "filters", required = false) String filters, @RequestParam(value = "curPage", required = false, defaultValue = "1") int curPage, Model model) {
		System.out.println(filters);
		HashMap<String, Object> pagingMap;//service-dao 갔다 온 결과를 담는 pagingMap
		List<String> list = new ArrayList<>(); //db 가기전에 htype, rtype, maintc, mrent, yrent 리스트와 비교해서 사용할 list 
	
		HashMap<String, List<String>> queryMap = new HashMap<>(); //htype과 rtype을 따로 담아서 보내기. 
		List<String> htype = new ArrayList<>();
		List<String> rtype = new ArrayList<>();
		List<String> maintc = new ArrayList<>();
		List<String> mrent = new ArrayList<>();
		List<String> yrent = new ArrayList<>();
		
		String[] filterArray = filters.split(","); //클라이언트에서 넘어온 값
		String[] inOperator = {"o", "t", "f", "p", "월세", "전세"}; //db로 보낼 양식인데 비교하면서 for 문에서 비교하면서 각 5개의 list를 만드는데 사용
		
		for(int i = 0; i < filterArray.length; i++) {//1. 사용자가 체크한 값을 받아서 그 길이만큼 돈다.
			for(int n = 0; n<inOperator.length; n++) {//2. in 연산자 값에 들어갈 수 있는 가능 값 수 만큼 돈다.
				if(filterArray[i].startsWith("yrent")) {//보증금/전세가 범위
					if(yrent.size() == 0) {
						yrent.add(filterArray[i].substring(5));
					} else {
						continue;
					}// end if~else yrent.size
				} else if(filterArray[i].startsWith("mrent")) {// 월세 범위
					if(mrent.size() == 0) {
						String[] mRange = filterArray[i].substring(5).split("~");
						mrent.add(mRange[0]);
						mrent.add(mRange[1]);
					} else {
						continue;
					}//end if~else mrent.size
				} else if (filterArray[i].startsWith("maintc")) {//filterArray[i]가 maintc로 시작하면 따로 리스트에 저장
					if(!(filterArray[i].substring(6).equals("0")) && maintc.size()==0) {
						maintc.add(filterArray[i].substring(6));
					}//end if~else maintc 숫자 가져오기
				} else if(!(filterArray[i].equals(inOperator[n]))) {// 사용자 값이랑 inOperator에 있는 값이랑 같지않으면
					if(list.size() == n) {//list사이즈와 현재 n이 동일하면 추가
						list.add(n, "na");
					} else {//list가 더 작으면 그 안에 이미 값이 있으니까 set으로 수정해준다. 
						if(list.get(n).equals("na")) list.set(n, "na");
					}//end if~else
				} else {// 사용자 값이랑 inOperator에 있는 값이랑 일치하면
					list.add(n, filterArray[i]);
					break;
				}//end if~else
			}//end inOperator for
		}// end for
		
		if(list.size() < inOperator.length) { // in 연산자에서 쓰기위해서 모자라는 값은 null을 넣어서 길이를 고정
			for(int i = list.size(); i < inOperator.length; i++) {
				list.add(i, "na");
			}
		}//end if
		
		for(int i = 0; i < list.size(); i++) {
			if (i<4) {
				if(list.get(i) != "na") htype.add(list.get(i));
			} else {
				if(list.get(i) != "na")	rtype.add(list.get(i));
			}
		}//end for
		
		queryMap.put("htype", htype);
		queryMap.put("rtype", rtype);
		queryMap.put("maintc", maintc);
		queryMap.put("mrent", mrent);
		queryMap.put("yrent", yrent);
		
		pagingMap = hService.listByFilter(queryMap, curPage);
		model.addAttribute("filters", filters);
		model.addAttribute("pagingMap", pagingMap);
		
		return "houseList";
	}//end houseFilter

	
	@RequestMapping("/houseDetailInfo")
	public void houseDetailInfo(@RequestParam (value = "hcode", required = false) String hcode, @ModelAttribute("list") ArrayList<String> list,  HttpSession session) {
		MemberDTO memberInfo = (MemberDTO)session.getAttribute("memberInfo");
		HouseInfoDTO info = hService.houseRetrieve(hcode);
		HousePriceDTO price = hService.housePrice(hcode);
		HouseOptionDTO option = hService.houseOption(hcode);
		List<BoardDTO> board = bService.boardList(hcode);
		String agntid = info.getAgntid();
		MemberDTO agentInfo = mService.mypageMember(agntid);
		
		session.setAttribute("price", price);
		session.setAttribute("option", option);
		session.setAttribute("info", info);
		session.setAttribute("agentInfo", agentInfo);
		session.setAttribute("board", board);
		if (option.getBltin() == 'Y') {
			list.add("bltin");
		}
		if (option.getElev() == 'Y') {
			list.add("elev");
		}
		if (option.getPet() == 'Y') {
			list.add("pet");
		}
		if (option.getLoan() == 'Y') {
			list.add("loan");
		}
		if (option.getPark() == 'Y') {
			list.add("park");
		}
		if (option.getMdate() == 'Y') {
			list.add("mdate");
		}
		session.setAttribute("etc", option.getEtc());
		session.setAttribute("list", list);	
	}
	
	

}//end HouseController
