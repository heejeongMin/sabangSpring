package com.capcha;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.Date;

import org.json.simple.JSONObject;
import org.json.simple.JSONValue;
import org.json.simple.parser.JSONParser;

public class NaverCaptcha {
		// key에 대한 정보를 인스턴스 변수 / 전역 변수로 설정
		String clientId = "QN3lv2J2hB8uD9Nm2s90";// 애플리케이션 클라이언트 아이디값";
		String clientSecret = "kow_E2M4f3";// 애플리케이션 클라이언트 시크릿값";
	
		public String getKey() {
		String key = "";
		try {
			String code = "0"; // 키 발급시 0, 캡차 이미지 비교시 1로 세팅
			String apiURL = "https://openapi.naver.com/v1/captcha/nkey?code=" + code;
			URL url = new URL(apiURL);
			HttpURLConnection con = (HttpURLConnection) url.openConnection();
			con.setRequestMethod("GET");
			con.setRequestProperty("X-Naver-Client-Id", clientId);
			con.setRequestProperty("X-Naver-Client-Secret", clientSecret);
			int responseCode = con.getResponseCode();
			BufferedReader br;
			if (responseCode == 200) { // 정상 호출
				br = new BufferedReader(new InputStreamReader(con.getInputStream()));
			} else { // 에러 발생
				br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
			}
			String inputLine;
			StringBuffer response = new StringBuffer();
			while ((inputLine = br.readLine()) != null) {
				response.append(inputLine);
			}
			br.close();
			// JSON 파싱
			// JSON으로 출력되는 key의 값만 추출하기 위해 
			JSONParser jsonParser = new JSONParser();
			JSONObject obj = new JSONObject();
			obj = (JSONObject) jsonParser.parse(response.toString());//문자열인 결과값을 JSON 오브젝트로 파싱
			key = (String) obj.get("key");  // JSONObject 메서드인 get()을 활용하여 key의 값만을 추출
		} catch (Exception e) {
			e.printStackTrace();
		}
		return key;
	}

	public void getImage(String key) {
		try {
			String apiURL = "https://openapi.naver.com/v1/captcha/ncaptcha.bin?key="+key;
			URL url = new URL(apiURL);
			HttpURLConnection con = (HttpURLConnection) url.openConnection();
			con.setRequestMethod("GET");
			con.setRequestProperty("X-Naver-Client-Id", clientId);
			con.setRequestProperty("X-Naver-Client-Secret", clientSecret);
			int responseCode = con.getResponseCode();
			BufferedReader br;
			if (responseCode == 200) { // 정상 호출

				InputStream is = con.getInputStream();
				int read = 0;
				byte[] bytes = new byte[1024];
				// 랜덤한 이름으로 파일 생성
				String tempname = Long.valueOf(new Date().getTime()).toString();
				File f = new File(tempname + ".jpg");
				f.createNewFile();
				OutputStream outputStream = new FileOutputStream(f);
				while ((read = is.read(bytes)) != -1) {
					outputStream.write(bytes, 0, read);
				}
				is.close();

			} else { // 에러 발생

				br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
				String inputLine;
				StringBuffer response = new StringBuffer();
				while ((inputLine = br.readLine()) != null) {
					response.append(inputLine);
				}
				br.close();

			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

public String checkNumber(String captKey,String userInput) {
	System.out.println(captKey);
	JSONObject object = null;
	String result = null;
    try {
        String code = "1"; // 키 발급시 0,  캡차 이미지 비교시 1로 세팅
        String key = captKey; // 캡차 키 발급시 받은 키값
        String value = userInput; // 사용자가 입력한 캡차 이미지 글자값
        String apiURL = "https://openapi.naver.com/v1/captcha/nkey?code=" + code +"&key="+ key + "&value="+ value;

        URL url = new URL(apiURL);
        HttpURLConnection con = (HttpURLConnection)url.openConnection();
        con.setRequestMethod("GET");
        con.setRequestProperty("X-Naver-Client-Id", clientId);
        con.setRequestProperty("X-Naver-Client-Secret", clientSecret);
        int responseCode = con.getResponseCode();
        BufferedReader br;
        if(responseCode==200) { // 정상 호출
            br = new BufferedReader(new InputStreamReader(con.getInputStream()));
            
        } else {  // 에러 발생
            br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
            
        }
        String inputLine;
        StringBuffer response = new StringBuffer();
        while ((inputLine = br.readLine()) != null) {
            response.append(inputLine);
        }
        br.close();
        result = response.toString();
        object = (JSONObject)JSONValue.parse(result);
    } catch (Exception e) {
        e.printStackTrace();
    }
    return object.get("result").toString();
}
}
