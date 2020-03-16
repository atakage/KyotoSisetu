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
	
	
	
	
	
	
	@RequestMapping(value="/hensinList",method=RequestMethod.POST)
	public String hensinList(@RequestParam("c_p_number") int c_p_number, Model model) {
		
		
		List<CommentVO> commentList2 = commentService.getHensinList(c_p_number);
		
		model.addAttribute("COMMENTLIST2", commentList2);
		
		// 返信ぺーじで使用するための
		model.addAttribute("c_p_number", c_p_number);
		
		return "commentpiece2";
	}
	
	
	
	
	
	
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
	
	
	
	@RequestMapping(value="/hensininsert", method=RequestMethod.POST)
	public String hensinInsert(CommentVO commentVO, HttpSession httpSession, Model model) {
		
		
		UserVO userVO = (UserVO) httpSession.getAttribute("USERSESSION");
		
		commentVO.setU_id(userVO.getU_id());
		commentVO.setU_nickname(userVO.getU_nickname());
		
		log.debug("hensininsert go");
		int ret = commentService.hensinInsert(commentVO);
		
		
		List<CommentVO> commentList = commentService.getCommentList(commentVO.getC_f_id());
		model.addAttribute("COMMENTLIST", commentList);
		List<CommentVO> commentList2 = commentService.getHensinList(commentVO.getC_p_number());
		model.addAttribute("COMMENTLIST2", commentList2);
		
		model.addAttribute("c_p_number", commentVO.getC_p_number());
		
		
		return "commentpiece2";
	}
	
	
	@ResponseBody
	@RequestMapping(value="/delete", method=RequestMethod.POST, produces = "application/text;charset=utf8")
	public String delete(@RequestParam("c_number") int c_number, HttpSession httpSession, Model model ) {
		
		
		UserVO userVO = (UserVO) httpSession.getAttribute("USERSESSION");
		
		if(userVO == null) {
			
			return "ログインしてください";
		}
		
		int ret = commentService.delete(Long.valueOf(c_number), userVO.getU_id());
		
		
		
		if(ret == 999999999) {
			
			return "削除成功";
		}
		

		
		
		if(ret > 0) {
			
			return "削除成功";
		}
		
		
		
		return "作成者だけ削除できます";
	}
	
	
	
	
	
	
	@ResponseBody
	@RequestMapping(value="/deletehensin", method=RequestMethod.POST, produces = "application/text;charset=utf8")
	public String deleteHensin(@RequestParam("c_number") int c_number, HttpSession httpSession, Model model ) {
		
		
		UserVO userVO = (UserVO) httpSession.getAttribute("USERSESSION");
		
		if(userVO == null) {
			
			return "ログインしてください";
		}
		
		int ret = commentService.deleteHensin(Long.valueOf(c_number), userVO.getU_id());
		
		
		if(ret > 0) {
			
			return "削除成功";
		}
		
		
		return "削除できません";
	}
	
	
	@RequestMapping(value="/removecomment", method=RequestMethod.POST)
	public String removeComment() {
		
		return "commentpiece2";
	}
	
}
