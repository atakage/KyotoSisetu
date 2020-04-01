package com.jgm.kyoto.controller;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URI;
import java.net.URISyntaxException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.json.simple.parser.ParseException;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.jgm.kyoto.domain.UserVO;
import com.jgm.kyoto.service.MemberService;

import jp.co.yahoo.yconnect.YConnectExplicit;
import jp.co.yahoo.yconnect.core.oauth2.AuthorizationException;
import jp.co.yahoo.yconnect.core.oauth2.TokenException;
import jp.co.yahoo.yconnect.core.oidc.IdTokenObject;
import jp.co.yahoo.yconnect.core.oidc.UserInfoObject;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequiredArgsConstructor
@RequestMapping(value="/member")
@Controller
public class MemberController {

	private final MemberService memberService;
	

	
	
	//dj00aiZpPXdKZzJNc1VVWmZoTSZzPWNvbnN1bWVyc2VjcmV0Jng9YjY-

	//t6TiyjaBHbadxE80BQJzTMKwmi2jIJAJpQWUrXVb
	
	
	
	
	@RequestMapping(value="/yahootoken", method=RequestMethod.GET)
	public String yahooToken( @RequestParam("state") String state, @RequestParam("code") String code,
			HttpServletRequest httpServletRequest) throws URISyntaxException, ParseException, IOException {

		
		log.debug(state+code);
		
		
		//レスポンス: access_token, token_type, refresh_token, expires_in, id_token
		JSONObject tokenJSON = memberService.getToken(state, code);
		// IDToken検証で用いるユーザー識別子を返却
		String sub  = memberService.getSub(tokenJSON);
		
		//ID TokenのSignatureを検証するためのPublic Keyのmodulusとexponentを返却
		JSONObject jwksJSON  = memberService.getJwks(tokenJSON);
		
		
		memberService.verifyIdToken(tokenJSON, jwksJSON,sub);
		
		return null;
		
	}
	
	
	
	
	
	
	
	@RequestMapping(value="/logout", method=RequestMethod.GET)
	public String logout(HttpSession httpSession) {
		
		httpSession.removeAttribute("USERSESSION");
		
		return "redirect:/";
		
	}
	
	
	@RequestMapping(value="/login", method=RequestMethod.GET)
	public String login(){
		
		return "login_page";
		
	}
	
	
	@ResponseBody
	@RequestMapping(value="/login", method=RequestMethod.POST, produces = "application/text;charset=utf8")
	public String login(UserVO userVO, HttpSession httpSession){
		
		
		UserVO storedUserVO = memberService.loginCheck(userVO);
		
		
		if(storedUserVO == null) {
			
			httpSession.removeAttribute("USERSESSION");
			return "IDかパスワードが間違っています";
		}
		
		log.debug(storedUserVO.toString());
		httpSession.setAttribute("USERSESSION", storedUserVO);
		return "ログイン成功";
		
	}
	
	
	
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
