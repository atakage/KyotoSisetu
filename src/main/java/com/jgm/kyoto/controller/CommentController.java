package com.jgm.kyoto.controller;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.jgm.kyoto.domain.CommentVO;
import com.jgm.kyoto.domain.UserVO;
import com.jgm.kyoto.service.CommentService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;


@Slf4j
@RequiredArgsConstructor
@RequestMapping(value="/comment")
@Controller
public class CommentController {

	
	private final CommentService commentService;
	
	
	@ResponseBody
	@RequestMapping(value="/insert", method=RequestMethod.POST, produces = "application/text;charset=utf8")
	public String insert(CommentVO commentVO, HttpSession httpSession) {
		

		UserVO userVO = (UserVO) httpSession.getAttribute("USERSESSION");
		
		commentVO.setU_id(userVO.getU_id());
		
		int ret = commentService.insert(commentVO);
		
		if(ret > 0) {
			return "ok";
		}
		
		return "fail";
		
	}
	
	
}
