package com.jgm.kyoto.controller;

import java.io.IOException;
import java.io.UnsupportedEncodingException;

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

@Slf4j
@RequiredArgsConstructor
@RequestMapping(value="/kyoto")
@Controller
public class KyotoController {
	
	private final KyotoService ktService;
	private final PaginationService pnService;
	
	@RequestMapping(value="/search", method=RequestMethod.GET)
	public String search(@RequestParam("searchVal") String searchVal,
			@RequestParam(required = false, defaultValue = "1", value="curPage")int curPage, Model model) throws ParseException, IOException {
		
		int allSearchPostCnt = pnService.getAllSearchPostCnt(searchVal);
		
		
		PaginationVO pVO = pnService.getSearchPerfectPagination(allSearchPostCnt, curPage, searchVal);
		
		JSONArray resArray = ktService.getSearchPageList(pVO, searchVal);
		
		
		
		model.addAttribute("curPage", pVO.getCurPage());
		model.addAttribute("startPage", pVO.getStartPage());
		model.addAttribute("endPage", pVO.getAllPageCnt());
		model.addAttribute("KYOTOLIST", resArray);
		model.addAttribute("searchVal", searchVal);
		

		
		return "home";
	}

}
