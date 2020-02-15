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

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class KyotoService {

	
	private String requestURL = "https://data.city.kyoto.lg.jp/API/action/datastore/search.json?";
	
	
	
	
	public JSONArray getList() throws ParseException {
		
		requestURL += "resource_id=f14b57c2-48dd-4aa7-b754-a4f4ac340f2d"
				+ "&limit=10"
				+ "&fields=id,name,department,address,pic";
		
		
		
	 String resString	= this.getKyotoString(requestURL);
	 JSONObject resObject = this.strToJson(resString);
	 JSONArray resArray = this.getInnerArray(resObject);
	 
	 
	 
	
	 return resArray;
	 
	 
	}




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




	public String getKyotoString(String requestURL) {
		// TODO Auto-generated method stub
		
		try {
			
			
			URL url = new URL(requestURL);
			
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
			
			
			
			
			return resString.toString();
			
		} catch (MalformedURLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return null;
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return null;
		}
		
		
		
	}
	
}
