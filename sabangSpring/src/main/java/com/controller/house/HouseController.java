package com.controller.house;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.URL;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.GregorianCalendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
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
import com.dto.HouseRcnlistDTO;
import com.dto.HouseWishlistDTO;
import com.dto.MemberDTO;
import com.localWeather.Coord;
import com.localWeather.CoordFetcher;
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
	public void houseDetailInfo(@RequestParam (value = "hcode", required = false) String hcode, 
								@ModelAttribute("list") ArrayList<String> list, HttpSession session, Model m) {
		MemberDTO memberInfo = (MemberDTO)session.getAttribute("memberInfo");
		HouseInfoDTO info = hService.houseRetrieve(hcode);
		HousePriceDTO price = hService.housePrice(hcode);
		HouseOptionDTO option = hService.houseOption(hcode);
		List<BoardDTO> board = bService.boardList(hcode);
		String agntid = info.getAgntid();
		MemberDTO agentInfo = mService.mypageMember(agntid);
		
		m.addAttribute("price", price);
		m.addAttribute("option", option);
		m.addAttribute("info", info);
		m.addAttribute("agentInfo", agentInfo);
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
		
		
		// 최근 본 방 저장하는 코드
		// session 확인 및 생성
		HashMap<Long, String> history = (HashMap)session.getAttribute("history");
		if(history==null) {
			history = new HashMap<>();
		}
					
		// 사용자가 가지고 있는 최근 본 방 정보 가져오기
		List<Long> userRcnList = new ArrayList<>();
		String userid = memberInfo.getUserid();
		List<HouseRcnlistDTO> rcnList = hService.selectRcnlist(userid);
		if(rcnList.size() != 0) {
			for(HouseRcnlistDTO rcn : rcnList) {
				history.put(rcn.getNum(), rcn.getHcode());
				userRcnList.add(rcn.getNum());
			}
			int n = hService.deleteRcnlist(userRcnList);
		}
						
						
		if(history.size()==0) {//없으면 map 새로 생성하고, 값 새로 저장
			history.put(System.currentTimeMillis(), hcode);
			session.setAttribute("history", history);
		}else if(history.size() > 0 && history.size() < 7 ){//map은 있는데 아직 6개 다 안찬경우
			Long[] keys = new Long[history.size()];
			String[] values = new String[history.size()];
			int index=0;
			for(Map.Entry<Long, String> mapEntry : history.entrySet()) {
				keys[index] = mapEntry.getKey();
				values[index] = mapEntry.getValue();
				index++;
			}
			// 동일한 hcode이면 저장하지않고 가장 늦게 본 것으로 변경하기
			for(int i=0; i<keys.length; i++) {
				if(history.get(keys[i]).equals(hcode) && System.currentTimeMillis() > keys[i]) {
					history.remove(keys[i]);
				}
			}
			history.put(System.currentTimeMillis(), hcode);
			session.setAttribute("history", history);
						
			Set<Long> keySet = history.keySet();
			if(keySet.size()>6) {
				long oldest = Long.MAX_VALUE;
				for(long key: keySet) { 
					oldest = (oldest < key)? oldest : key;
				}
				history.remove(oldest);
				history.put(System.currentTimeMillis(), hcode);
				session.setAttribute("history", history);
			}
		}
		
		
		session.setAttribute("etc", option.getEtc());
		session.setAttribute("list", list);	
	}
	
	@RequestMapping("/houseLike")
	public @ResponseBody int houseLike(@RequestParam("hcode") String hcode, HttpSession session) {
		MemberDTO member = (MemberDTO)session.getAttribute("memberInfo");
		return hService.updateCntWish(new HouseWishlistDTO(member.getUserid(), hcode));
	}
	
	@RequestMapping("/weather")
	public @ResponseBody String weather(@RequestParam HashMap<String, String> coordMap) {
		//요청 일자, 시간 만들기
		Calendar c = Calendar.getInstance();
		int month = c.get(Calendar.MONTH)+1;
		int date = c.get(Calendar.DATE);
		int hour = c.get(Calendar.HOUR_OF_DAY) ;
		String m = (month<10)? "0" + month :String.valueOf(month);
		String d = (date<10)? "0" + date : String.valueOf(date);
		
		if (hour < 11) { // 날씨 요청시간이 11 시 전일때, 
			if (date == 1) {//만약에 월의 1일이고, 
				//월 정하기
				m = ((month - 1) < 10 )? "0"+ (month - 1) : String.valueOf(month - 1); //이전 달로 갔을 때 0~9 가 나오면 앞에 0을 붙여서 두 자리 만듬.
				//일정하기
				if ((month -1) % 2  != 0) {//홀수 달이면, 날짜는 31일로 세팅 
					date = 31;
				} else {//짝수 달들 
					if ((month -1)==2) {// 짝수달이면서 만약에 2월이면
						GregorianCalendar cal = new GregorianCalendar();
						date = (cal.isLeapYear(c.getWeekYear()))? 29: 28;//true : 윤달, false: 평달
					} else {//짝수달이지만 2월이 아닌경우
						date =30;
					}//end if~else 윤달 확인
				}//end if~else 홀수 짝수 달
				
			} else {//1일이 아니면 그냥 달 사용
				m = (month<10)? "0" + month :String.valueOf(month);
				date -= 1;
			}//end if~else 일이 1일인지 아닌지 확인		
		}
		
		String base_date = String.valueOf(c.getWeekYear())+m+d;
		System.out.println(base_date);
		//요청 동네의 좌표 만들기
		String[] asLocation = new String[]{"서울특별시", "서초구", "반포1동"};  
		String x = null;
		String y = null;
		// geolocation에서 좌표를 못가져올때, 서초구 반포1동으로 자동 잡음
		if(coordMap.get("nx").equals("0") || coordMap.get("ny").equals("0")) {
			CoordFetcher cf = new CoordFetcher();
			Coord coord = cf.fetchCoord(asLocation);
			x = coord.getSx();
			y = coord.getSy();
		}

		//요청 URL 만들기
		String reqURL ;
		reqURL = "http://newsky2.kma.go.kr/service/SecndSrtpdFrcstInfoService2/ForecastSpaceData?";
		reqURL += "ServiceKey=VD5ItN1ersyBmcioWetkmK%2B4gwxiWRfmz4XKtGg%2FntXHP4CtGSLuAkL4VDjr8rPJEy1S6eYO0BdsVK8C%2FeqL0A%3D%3D";
		reqURL += "&base_date="+base_date;
		reqURL += "&base_time=1100"; //11시여야 items에 예보정보가 나옴 .... 
		if (coordMap.get("nx").equals("0") || coordMap.get("ny").equals("0")) {
			reqURL += "&nx="+x+"&ny="+y;
		} else {
			reqURL += "&nx="+coordMap.get("nx")+"&ny="+coordMap.get("ny");
		}
		reqURL += "&_type=json";
		
		//내가 만든 String을 url로 만들기
		URL url;
		BufferedReader bf; 
		String line = "";
		String result = "";
		//날씨 정보 받아오기
		try {
			url = new URL(reqURL);
			bf = new BufferedReader(new InputStreamReader(url.openStream()));
			while ((line=bf.readLine())!=null) {
				result=result.concat(line);
			}
		} catch (IOException e1) {
			e1.printStackTrace();
		}

		//읽어온 문자열 데이터를 객체화
		JSONParser parser = new JSONParser();
		HashMap<String, String> map = new HashMap<>();
		String weatherResult = "";
		try {
			JSONObject obj = (JSONObject) parser.parse(result);
			// response부분 가져오기
			JSONObject parse_response = (JSONObject) obj.get("response");
			// body 가져오기
			JSONObject parse_body = (JSONObject) parse_response.get("body");
			// items 가져오기
			JSONObject parse_items = (JSONObject) parse_body.get("items");
			// item 가져오기
			JSONArray parse_item = (JSONArray) parse_items.get("item");
			for(int i = 0; i<parse_item.size(); i++) {
				JSONObject weather = (JSONObject) parse_item.get(i);
				String category = (String) weather.get("category");
				switch (category) {
				case "POP" : 
					weatherResult = "{\"POP\":"+ weather.get("fcstValue") + ",";
					map.put("POP", String.valueOf(weather.get("fcstValue")));
					break;
				case "TMX" :
					weatherResult += "\"TMX\":"+(int)((double)weather.get("fcstValue"))+"}";
					//							map.put("TMX", String.valueOf());
				}
			}//end for
		} catch (ParseException e) {
			e.printStackTrace();
		}//end try~catch

		// 응답데이터 :  전체 데이터를 json object로 받고, 이 object 아래 body라는 object 아래 items 라는 object 아래 item이라는 array 아래 object들에 접근
		// baseDate : 발표시각의 날짜
		// baseTime : 발표시각의 시분
		// category : 데이터 종류
		// fcstDate : 예보시각의 날짜
		// fcstTime : 예보시각의 시분
		// fcstValue : 예보 값
		// nx, ny : 기상청 지역코드	
		// 항목값	항목명			단위	Missing
		// POP		강수확률		%		-1 % ----- 20%
		// T3H 		3시간 기온 		℃ 		-50 ℃  ----
		// TMN 		아침 최저기온 	℃ 		-50 ℃  ----
		// TMX 		낮 최고기온		℃ 		-50 ℃   ---- 5 도
		
		return weatherResult;
	}//end weather
	

	// houseDetailInfo.jsp에서 에이전트의 이메일 클릭 시 메일 팝업 코드 
	@RequestMapping("/houseDetailSendEmail")
	public String houseDetailBoard(@RequestParam("email") String email,
			@RequestParam("hcode") String hcode, HttpSession session, Model model) {
		MemberDTO memberInfo = (MemberDTO)session.getAttribute("memberInfo");
		model.addAttribute("hcode", hcode);
		model.addAttribute("memberInfo", memberInfo);
		model.addAttribute("email", email);
		return "houseDetailSendEmail";
	}
	
	
	// 메일전송
	@Autowired
	private JavaMailSender mailSender;
	
	@RequestMapping("/sendMail")
	public String sendMail(HttpSession session) {
		MemberDTO memberInfo = (MemberDTO)session.getAttribute("memberInfo");
		String setfrom = memberInfo.getEmail();
		String tomail = "받는사람 메일"; // 받는 사람 이메일
		String title = "title"; // 제목
		String content = "content"; // 내용
		
		try {
			System.out.println("정상요청");
			MimeMessage message = mailSender.createMimeMessage();
			MimeMessageHelper messageHelper = new MimeMessageHelper(message,
					true, "UTF-8");

			messageHelper.setFrom(setfrom); // 보내는사람 생략하면 정상작동을 안함
			messageHelper.setTo(tomail); // 받는사람 이메일
			messageHelper.setSubject(title); // 메일제목은 생략이 가능하다
			messageHelper.setText(content); // 메일 내용

			mailSender.send(message);
		} catch (Exception e) {
			System.out.println(e);
		}

		return "main";
	}
}//end HouseController
