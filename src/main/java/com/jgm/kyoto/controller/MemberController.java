package com.jgm.kyoto.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.jgm.kyoto.domain.UserVO;
import com.jgm.kyoto.service.MemberService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequiredArgsConstructor
@RequestMapping(value="/member")
@Controller
public class MemberController {

	private final MemberService memberService;
	
	@RequestMapping(value="/join", method=RequestMethod.GET)
	public String join(){
		
		return "join_page";
		
	}
	
	
	
	
	// produces = "application/text;charset=utf8" : ajaxとサーバー間日本語文字化け防止
	@ResponseBody
	@RequestMapping(value="/mailcheck", method=RequestMethod.POST, produces = "application/text;charset=utf8")
	public String mailcheck(@RequestParam("u_id") String u_id ) {
		
		int result = memberService.mailcheck(u_id);
		
		
		String resultMSG = "使用可能なメールです";
		if(result != 0) {
			
			//resultMSG = "既に使用されているメールです";
			return "FAIL";
		}
		
		
		return resultMSG;
	}
	
	
	
	
	
	// produces = "application/text;charset=utf8" : ajaxとサーバー間日本語文字化け防止
		@ResponseBody
		@RequestMapping(value="/nickcheck", method=RequestMethod.POST, produces = "application/text;charset=utf8")
		public String nickcheck(@RequestParam("u_nickname") String u_nickname ) {
			
			int result = memberService.nickcheck(u_nickname);
			
			
			String resultMSG = "使用可能なニックネームです";
			if(result != 0) {
				
				//resultMSG = "既に使用されているニックネームです";
				return "FAIL";
			}
			
			
			return resultMSG;
		}
		
		
		
		
		@ResponseBody
		@RequestMapping(value="/insert", method=RequestMethod.POST, produces = "application/text;charset=utf8")
		public String insert(UserVO userVO) {
			
			
			userVO.setU_grade("U");
			
			int ret = memberService.insert(userVO);
			
			if(ret < 1) {
				
				return "登録失敗";
				
			}
			
			return "登録成功";
			
		}
}
