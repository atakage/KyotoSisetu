package com.jgm.kyoto.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@RequestMapping(value="/member")
@Controller
public class MemberController {

	
	
	@RequestMapping(value="/join", method=RequestMethod.GET)
	public String join(){
		
		return "join_page";
		
	}
}
