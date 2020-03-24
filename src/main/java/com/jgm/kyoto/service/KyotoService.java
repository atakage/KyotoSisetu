package com.jgm.kyoto.service;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.stereotype.Service;

import com.fasterxml.jackson.core.JsonParser;
import com.fasterxml.jackson.databind.jsonFormatVisitors.JsonObjectFormatVisitor;
import com.google.gson.JsonElement;
import com.jgm.kyoto.domain.FacilityVO;
import com.jgm.kyoto.domain.PaginationVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class KyotoService {

	
//	private String requestURL = "https://data.city.kyoto.lg.jp/API/action/datastore/search.json?";
	
	
	
	
	
	public JSONArray getPageList(PaginationVO pVO) throws ParseException, IOException {
		// TODO Auto-generated method stub
		
		int offsetVal = pVO.getStartIndex();
		//int limitVal = pVO.getPageSize()*pVO.getCurPage();
		
		String requestURL = "https://data.city.kyoto.lg.jp/API/action/datastore/search.json?resource_id=f14b57c2-48dd-4aa7-b754-a4f4ac340f2d"
				+ "&offset="+offsetVal
				+ "&limit=10"
				+ "&fields=id,name,department,address,pic";
		
		
		
		String resString	= this.getKyotoString(requestURL);
		
		 JSONObject resObject = this.strToJson(resString);
		 JSONArray resArray = this.getInnerArray(resObject);
		 
		 
		 
		
		 return resArray;
		
	}
	
	
	
	
	// 検索用
	public JSONArray getSearchPageList(PaginationVO pVO, String searchVal) throws ParseException, IOException {
		// TODO Auto-generated method stub
		
		
		if(searchVal.trim().isEmpty()) {

			// TODO Auto-generated method stub
			
			return this.getPageList(pVO);
			
			
		}
		
		
		
		
		
		int offsetVal = pVO.getStartIndex();
		
		String requestURL = "https://data.city.kyoto.lg.jp/API/action/datastore/search.json?resource_id=f14b57c2-48dd-4aa7-b754-a4f4ac340f2d"
				+ "&offset="+offsetVal
				+ "&limit=10"
				+ "&fields=id,name,department,address,pic"
				+ "&filters[name]="+searchVal;
		
		
		
		
		String resString	= this.getKyotoString(requestURL);
		 JSONObject resObject = this.strToJson(resString);
		 JSONArray resArray = this.getInnerArray(resObject);
		 
		 
		 
		
		 return resArray;
	}
	
	
	
	
	
	/* test
	public JSONArray getList() throws ParseException {
		
		requestURL += "resource_id=f14b57c2-48dd-4aa7-b754-a4f4ac340f2d"
				+ "&limit=10"
				+ "&fields=id,name,department,address,pic";
		
		
		
	 String resString	= this.getKyotoString(requestURL);
	 JSONObject resObject = this.strToJson(resString);
	 JSONArray resArray = this.getInnerArray(resObject);
	 
	 
	 
	
	 return resArray;
	 
	 
	}
*/



	private JSONArray getInnerArray(JSONObject resObject) throws ParseException {
		// TODO Auto-generated method stub
		
		String strList = resObject.toString();
		
		
		int startIndex = strList.indexOf("\"rec");
		int endIndex = strList.length()-1;
		
		String strListMD = strList.substring(startIndex, endIndex);
		
		String strListMDied = "{"+strListMD;
		
		
		
		
		JSONParser jParser = new JSONParser();
		JSONObject resObjectFix = (JSONObject) jParser.parse(strListMDied);
		
		
		JSONArray resArray = (JSONArray) resObjectFix.get("records");
		
		
		
		
		
		
		
		
		return resArray;
	}




	public JSONObject strToJson(String resString) throws ParseException {
		// TODO Auto-generated method stub
		JSONParser jParser = new JSONParser();
		JSONObject jObject = (JSONObject) jParser.parse(resString);
		
		jObject.remove("help");
		jObject.remove("success");
		

		return jObject;
	}




	public String getKyotoString(String requestURL) throws IOException {
		// TODO Auto-generated method stub
		
		
			
			
			URL url = new URL(requestURL);
			
			log.debug("uurrll:"+url.toString());
			
			HttpURLConnection httpConn = (HttpURLConnection) url.openConnection();
			
			httpConn.setRequestMethod("GET");
			
			int resCode = httpConn.getResponseCode();
			
			
			 
			
			BufferedReader br = null;
			
			if(resCode == 200) {
				
				InputStreamReader isr = new InputStreamReader(httpConn.getInputStream());
				
				br = new BufferedReader(isr);
				
			
				
			}else {
				
				
				
				InputStreamReader isr = new InputStreamReader(httpConn.getErrorStream());
				br = new BufferedReader(isr);
				
				
			}
			
			
			StringBuffer resString = new StringBuffer();
			String reader = "";
			
			while(true) {
				
			  reader = br.readLine();
			  if(reader == null) break;
			  
			  resString.append(reader);
			 
			}
			
			
			
			
			
			
			if(resCode == 200) {
				return resString.toString();
			}else {
				
				log.debug("resCodeError:"+resString.toString());
			}
			
			
		return null;
		
	}




	public JSONArray getDetail(String id) throws IOException, ParseException {
		// TODO Auto-generated method stub
		
		String requestURL = "	https://data.city.kyoto.lg.jp/API/action/datastore/search.json?resource_id=f14b57c2-48dd-4aa7-b754-a4f4ac340f2d"
				+ "&fields=id,name,department,address,pic,note,tel,url,optime,holiday,fee,latitude,longitude"
				+ "&filters[id]="+id;
		
		String resString	= this.getKyotoString(requestURL);
		 JSONObject resObject = this.strToJson(resString);
		 JSONArray resArray = this.getInnerArray(resObject);
		 
		 log.debug("resA:"+resArray);
		
		
		return resArray;
	}





	




	
	
}
