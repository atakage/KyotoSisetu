package com.jgm.kyoto.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
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
	
	
	
	@RequestMapping(value="/insert", method=RequestMethod.POST, produces = "application/text;charset=utf8")
	public String insert(CommentVO commentVO, HttpSession httpSession, Model model) {
		

		UserVO userVO = (UserVO) httpSession.getAttribute("USERSESSION");
		
		commentVO.setU_id(userVO.getU_id());
		commentVO.setU_nickname(userVO.getU_nickname());
		
		int ret = commentService.insert(commentVO);
		
		
		List<CommentVO> commentList = commentService.getCommentList(commentVO.getC_f_id());
		model.addAttribute("COMMENTLIST", commentList);
		
		if(ret > 0) {
			return "commentpiece";
		}
		
		return "commentpiece";
		
	}
	
	
	@ResponseBody
	@RequestMapping(value="/delete", method=RequestMethod.POST, produces = "application/text;charset=utf8")
	public String delete(@RequestParam("c_number") int c_number, HttpSession httpSession ) {
		
		
		UserVO userVO = (UserVO) httpSession.getAttribute("USERSESSION");
		
		if(userVO == null) {
			
			return "ログインしてください";
		}
		
		int ret = commentService.delete(Long.valueOf(c_number), userVO.getU_id());
		
		
		if(ret > 0) {
			
			return "削除成功";
		}
		
		
		return "作成者だけ削除できます";
	}
	
	
}
