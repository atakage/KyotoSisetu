package com.jgm.kyoto.controller;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.jgm.kyoto.domain.CommentVO;

import lombok.extern.slf4j.Slf4j;


@Slf4j
@RequestMapping(value="/comment")
@Controller
public class CommentController {

	
	
	@ResponseBody
	@RequestMapping(value="/insert", method=RequestMethod.POST)
	public String insert(CommentVO commentVO, HttpSession httpSession) {
		
		log.debug(commentVO.toString());
		
		return null;
		
	}
	
	
}
