package com.jgm.kyoto.controller;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.ParseException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.google.gson.Gson;
import com.google.gson.JsonParser;
import com.jgm.kyoto.domain.TestVO;
import com.jgm.kyoto.service.KyotoService;

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
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Model model) throws ParseException {
		
		JSONArray resArray = ktService.getList();
		
		
		model.addAttribute("KYOTOLIST", resArray);
		
		
		
		
		
		return "home";
	}
	
}
