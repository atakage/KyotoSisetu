package com.jgm.kyoto.controller;

import java.io.IOException;
import java.util.List;

import org.json.simple.JSONArray;
import org.json.simple.parser.ParseException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.jgm.kyoto.domain.CommentVO;
import com.jgm.kyoto.domain.PaginationVO;
import com.jgm.kyoto.service.CommentService;
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
	private final CommentService commentService;
	
	
	
	@RequestMapping(value="/search", method=RequestMethod.GET)
	public String search(@RequestParam("searchVal") String searchVal,
			@RequestParam(required = false, defaultValue = "1", value="curPage")int curPage, Model model) throws ParseException, IOException {
		
		int allSearchPostCnt = pnService.getAllSearchPostCnt(searchVal);
		
		
		PaginationVO pVO = pnService.getSearchPerfectPagination(allSearchPostCnt, curPage, searchVal);
		
		JSONArray resArray = ktService.getSearchPageList(pVO, searchVal);
		
		
		
		model.addAttribute("curPage", pVO.getCurPage());
		model.addAttribute("startPage", pVO.getStartPage());
		model.addAttribute("endPage", pVO.getEndPage());
		model.addAttribute("allEndPage", pVO.getAllPageCnt());
		model.addAttribute("prevPage", pVO.getPrevPage());
		model.addAttribute("nextPage", pVO.getNextPage());
		model.addAttribute("KYOTOLIST", resArray);
		model.addAttribute("searchVal", searchVal);
		

		
		return "home";
	}
	
	
	
	@RequestMapping(value="/view", method=RequestMethod.GET)
	public String view(@RequestParam("id") String id, Model model) throws IOException, ParseException {
		
		JSONArray resArray = ktService.getDetail(id);
		
		List<CommentVO> commentList = commentService.getCommentList(id);
		
		
		
	
		model.addAttribute("FACILITY", resArray);
		model.addAttribute("COMMENTLIST", commentList);
		
		return "view_page";
	}

}
