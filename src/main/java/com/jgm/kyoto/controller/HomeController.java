package com.jgm.kyoto.controller;

import java.io.IOException;

import org.json.simple.JSONArray;
import org.json.simple.parser.ParseException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.jgm.kyoto.domain.PaginationVO;
import com.jgm.kyoto.service.KyotoService;
import com.jgm.kyoto.service.PaginationService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

/**
 * Handles requests for the application home page.
 */

@Slf4j
@RequiredArgsConstructor
@Controller
public class HomeController {
	
	private final KyotoService ktService;
	private final PaginationService pnService;
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(@RequestParam(required = false, defaultValue = "1", value="curPage")int curPage, Model model) throws ParseException, IOException {
		
		
		int allPostCnt =  pnService.getAllPostCnt();
		
		
		
		PaginationVO pVO = pnService.getPerfectPagination(allPostCnt, curPage);
		
		JSONArray resArray = ktService.getPageList(pVO);
		
		
		log.debug("allList:"+resArray.toString());
		
		
		model.addAttribute("curPage", pVO.getCurPage());
		model.addAttribute("startPage", pVO.getStartPage());
		model.addAttribute("endPage", pVO.getAllPageCnt());
		model.addAttribute("KYOTOLIST", resArray);
		
		
		//pagination boxが　オール用かサーチ用か判断
		model.addAttribute("PAGINATIONBAR", "ALL");
		
		
		
		
		
		
		
		return "home";
	}
	
}
