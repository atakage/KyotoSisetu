package com.jgm.kyoto.controller;

import java.io.UnsupportedEncodingException;

import org.json.simple.parser.ParseException;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.jgm.kyoto.service.PaginationService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequiredArgsConstructor
@RequestMapping(value="/kyoto")
@Controller
public class KyotoController {
	
	
	private final PaginationService pnService;
	
	@RequestMapping(value="/search", method=RequestMethod.GET)
	public String search(@RequestParam("searchVal") String searchVal) throws UnsupportedEncodingException, ParseException {
		
		int allSearchPostCnt = pnService.getAllSearchPostCnt(searchVal);
		
		
		
		return "home";
	}

}
