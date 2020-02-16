package com.jgm.kyoto.service;

import java.io.UnsupportedEncodingException;
import java.net.URI;
import java.net.URISyntaxException;
import java.net.URL;
import java.net.URLEncoder;

import org.json.simple.JSONObject;
import org.json.simple.parser.ParseException;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import com.jgm.kyoto.domain.PaginationVO;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequiredArgsConstructor
@Service
public class PaginationService {
	
	private final KyotoService ktService;
	
	
	PaginationVO pVO = new PaginationVO();
	
	
	private String requestURL = "https://data.city.kyoto.lg.jp/API/action/datastore/search.json?";
	

	public int getAllPostCnt() throws ParseException {
		
		
		requestURL += "resource_id=f14b57c2-48dd-4aa7-b754-a4f4ac340f2d&fields=name";
		
	
		String resString = ktService.getKyotoString(requestURL);
		JSONObject resObjectFix = ktService.strToJson(resString);
		
		// JSONObjectのなかlistの数だけを取り出し
		int allPostCnt = this.getInnerList(resObjectFix);
		
		// TODO Auto-generated method stub
		return allPostCnt;
	}


	private int getInnerList(JSONObject resObjectFix) {
		// TODO Auto-generated method stub
		
		
		String strList = resObjectFix.toString();
		
		
		
		int startIndex = strList.indexOf("\"tot");
		int endIndex = strList.indexOf("\"rec");
		
		String allPostCntStr = strList.substring(startIndex+9, endIndex-2);
		
		
		
		return Integer.valueOf(allPostCntStr);
	}


	public PaginationVO getPerfectPagination(int allPostCnt, int curPage) {
		// TODO Auto-generated method stub
		
		
		//PaginationVO pVO = new PaginationVO();
		
		pVO.setCurPage(curPage);
		pVO.setAllPostCnt(allPostCnt);
		
		pVO.setAllPageCnt(this.getPageCnt(allPostCnt));
		pVO.setAllRangeCnt(this.getRangeCnt(pVO.getAllPageCnt()));
		
		//現在ブロック
		this.rangeSetting(curPage);
		
		// for SQLquery
		this.startIndexSetting(curPage);
		
		return pVO;
	}


	private void startIndexSetting(int curPage) {
		// TODO Auto-generated method stub
		
		pVO.setStartIndex((curPage-1) * pVO.getPageSize());
		
	}


	private void rangeSetting(int curPage) {
		// TODO Auto-generated method stub
		//PaginationVO pVO = new PaginationVO();
		
		// curPage=1 -> curRange=1, curPage=11 -> curRange=2
		pVO.setCurRange((int)((curPage-1)/pVO.getRangeSize())+1);
		
		
		// ２ブロックのスタートページは１１
		pVO.setStartPage((pVO.getCurRange()-1) * pVO.getRangeSize() + 1);
		// 2ブロックのエンドページは２０
		pVO.setEndPage((pVO.getStartPage() + pVO.getRangeSize() - 1));
		
		if(pVO.getEndPage() > pVO.getAllPageCnt()) {
			
			pVO.setEndPage(pVO.getAllPageCnt());
		}
		
		
		pVO.setPrevPage(pVO.getCurPage()-1);
		pVO.setNextPage(pVO.getCurPage()+1);
		
		
	}


	private int getRangeCnt(int allPageCnt) {
		// TODO Auto-generated method stub
		
		//pVO = new PaginationVO();
		
		// ceil : 小数点以下切り上げ？？
		return (int)Math.ceil(allPageCnt*1.0/pVO.getRangeSize());
	}


	private int getPageCnt(int allPostCnt) {
		// TODO Auto-generated method stub
		
		//pVO = new PaginationVO();
		
		// ceil : 小数点以下切り上げ？？
		return (int)Math.ceil(allPostCnt*1.0/pVO.getPageSize());
	}


	public int getAllSearchPostCnt(String searchVal) throws UnsupportedEncodingException, ParseException{
		// TODO Auto-generated method stub
		
		
		//検索valueに何も入力されなかった場合は全体結果return
		if(searchVal.trim().isEmpty()) {

			// TODO Auto-generated method stub
			
			return this.getAllPostCnt();
			
			
		}
		
		String searchValEn = URLEncoder.encode(searchVal, "UTF-8");
		
		
		requestURL += "resource_id=f14b57c2-48dd-4aa7-b754-a4f4ac340f2d&fields=name&filters[name]="+searchValEn;
		
		
		
		String resString = ktService.getKyotoString(requestURL);
		JSONObject resObjectFix = ktService.strToJson(resString);
		
		// JSONObjectのなかlistの数だけを取り出し
		int allSearchPostCnt = this.getInnerList(resObjectFix);
		
		
		
		
		// TODO Auto-generated method stub
		return allSearchPostCnt;
		
	}


	

}
