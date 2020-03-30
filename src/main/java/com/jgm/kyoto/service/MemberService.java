package com.jgm.kyoto.service;

import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.ProtocolException;
import java.net.URL;
import java.util.Base64;
import java.util.Base64.Encoder;

import javax.net.ssl.HttpsURLConnection;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.google.gson.JsonArray;
import com.google.gson.JsonParser;
import com.jgm.kyoto.domain.UserVO;
import com.jgm.kyoto.persistence.MemberDao;
import com.nimbusds.jose.JWEHeader;

import jp.co.yahoo.yconnect.core.oidc.JWTVerification;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequiredArgsConstructor
@Service
public class MemberService {
	
	
	private final MemberDao memberDao;

	public int mailcheck(String u_id) {
		// TODO Auto-generated method stub
		
		
		
		
		return memberDao.selectById(u_id);
	}

	public int nickcheck(String u_nickname) {
		// TODO Auto-generated method stub
		return memberDao.selectByNick(u_nickname);
	}

	public int insert(UserVO userVO) {
		// TODO Auto-generated method stub
		BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
		String encodedPass = passwordEncoder.encode(userVO.getU_password());
		
		userVO.setU_password(encodedPass);
		
		return memberDao.insert(userVO);
	}

	public UserVO loginCheck(UserVO userVO) {
		// TODO Auto-generated method stub
		
		
		UserVO storedUserVO = memberDao.selectByIdForVO(userVO.getU_id());
		
		
		
		
		if(storedUserVO == null) {
			
			return null;
		}else {
			
			BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
			
			
			if(passwordEncoder.matches(userVO.getU_password(), storedUserVO.getU_password())) {
				
				
				return storedUserVO; // 成功
				
			}
			
			return null;
			
		}
		
		
	}

	public JSONObject getToken(String state, String code) throws UnsupportedEncodingException, ParseException {
		// TODO Auto-generated method stub
		
	
		Encoder encoder  = Base64.getEncoder();
		String idsec = "dj00aiZpPXdKZzJNc1VVWmZoTSZzPWNvbnN1bWVyc2VjcmV0Jng9YjY-:t6TiyjaBHbadxE80BQJzTMKwmi2jIJAJpQWUrXVb";
		byte[] target;


		target = idsec.getBytes("UTF-8");
	
			
		String authVal = encoder.encodeToString(target);

		
		try {
			URL url = new URL("https://auth.login.yahoo.co.jp/yconnect/v2/token");
			HttpsURLConnection httpsCon = (HttpsURLConnection) url.openConnection();
			
			httpsCon.setRequestMethod("POST");
			httpsCon.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");
			httpsCon.setRequestProperty("Authorization", "Basic "+authVal);
			httpsCon.setDoOutput(true);
			
			
			
			
			
			
			DataOutputStream dos = new DataOutputStream(httpsCon.getOutputStream());
			String parameter = "grant_type=authorization_code" +
					//+ "&client_id=dj00aiZpPXdKZzJNc1VVWmZoTSZzPWNvbnN1bWVyc2VjcmV0Jng9YjY-" + 
					//"&client_secret=t6TiyjaBHbadxE80BQJzTMKwmi2jIJAJpQWUrXVb" + 
					"&code=" + code +
					"&redirect_uri=http://localhost:8084/kyoto/member/yahootoken";
			dos.writeBytes(parameter);
			dos.flush();
			
			
			int responseCode = httpsCon.getResponseCode();
			

			log.debug(httpsCon.getContentType().toString());
			log.debug(httpsCon.getResponseMessage().toString());
			log.debug(httpsCon.getHeaderFields().toString());
			log.debug(httpsCon.getContent().toString());
			
			log.debug(httpsCon.getURL().toString());
			
			
			log.debug("getinputsstream:"+httpsCon.getInputStream().toString());
			
			BufferedReader br = new BufferedReader(new InputStreamReader(httpsCon.getInputStream()));
			
			
			
			String inputSTR;
			StringBuffer response = new StringBuffer();
			
			while((inputSTR = br.readLine()) != null) {
			
				log.debug(inputSTR);
				response.append(inputSTR);
			}
			
			br.close();
			dos.close();
			
			log.debug("responsecode" + responseCode+"");
			log.debug("httpbody:" + response.toString());
			
			
			
			
		JSONParser jsonParser = new JSONParser();
		JSONObject tokenJSON = (JSONObject) jsonParser.parse(response.toString());
			
	
		return tokenJSON;
			
			
		} catch (MalformedURLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		return null;
	}

	public JSONObject getJwks(JSONObject tokenJSON) throws ParseException {
		// TODO Auto-generated method stub
		
		log.debug("verifytoken start");
		
		try {
			URL url = new URL("https://auth.login.yahoo.co.jp/yconnect/v2/jwks");
			HttpURLConnection httpsCon = (HttpURLConnection) url.openConnection();
			
			httpsCon.setRequestMethod("GET");
			int responseCode = httpsCon.getResponseCode();
			BufferedReader br = new BufferedReader(new InputStreamReader(httpsCon.getInputStream()));
			
			String inputSTR;
			StringBuffer response = new StringBuffer();
			
			while((inputSTR = br.readLine()) != null) {
				
				response.append(inputSTR);
			}
			br.close();
			
			log.debug("responsecode:" + responseCode);
			log.debug("httpbody:" + response.toString());
			
			
			
			JSONParser jsonParser = new JSONParser();
			JSONObject jwksJSON = (JSONObject) jsonParser.parse(response.toString());
				
		
			return jwksJSON;
			
			
			
		} catch (MalformedURLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (ProtocolException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		return null;
	}

	public void verifyIdToken(JSONObject tokenJSON, JSONObject jwksJSON, String sub) {
		// TODO Auto-generated method stub
		
		
		
		
	
	}

	public String getSub(JSONObject tokenJSON) {
		// TODO Auto-generated method stub
		
		log.debug("start getsub");
		//log.debug(tokenJSON.get("access_token").toString());
		try {
			URL url = new URL(" https://userinfo.yahooapis.jp/yconnect/v2/attribute");
			HttpsURLConnection httpsCon = (HttpsURLConnection) url.openConnection();
			
			httpsCon.setRequestMethod("GET");
			httpsCon.setRequestProperty("Authorization", "Bearer "+tokenJSON.get("access_token").toString());
			httpsCon.setDoOutput(true);
			
			
			int responseCode = httpsCon.getResponseCode();
			log.debug("responsecode" + responseCode+"");
			
			BufferedReader br = new BufferedReader(new InputStreamReader(httpsCon.getInputStream()));
			
			
			
			String inputSTR;
			StringBuffer response = new StringBuffer();
			
			while((inputSTR = br.readLine()) != null) {
			
				log.debug(inputSTR);
				response.append(inputSTR);
			}
			
			br.close();
			
			
			
			log.debug("httpbody:" + response.toString());
			
			
			JSONParser jsonParser = new JSONParser();
			JSONObject userInfoJSON = (JSONObject) jsonParser.parse(response.toString());
			
			String sub = userInfoJSON.get("sub").toString();
			
			log.debug("sub:" + sub);
			
			return sub;
			
		} catch (MalformedURLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (ProtocolException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		
		
		
		return null;
	}
	
	

}
