package com.jgm.kyoto.controller;

import java.net.URI;
import java.net.URISyntaxException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

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
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequiredArgsConstructor
@RequestMapping(value="/member")
@Controller
public class MemberController {

	private final MemberService memberService;
	
	
	private final String yahooClientId = "dj0zaiZpPXFSRVM1WlhyWGZ2UCZzPWNvbnN1bWVyc2VjcmV0Jng9MDk-";
	private final String yahooClientSecret = "e2a9a9af53874d2ec95e194c8331365681cc045c";
	private final String redirectURI = "http://localhost:8084/kyoto/member/yahootoken";
	
	
	@RequestMapping(value="/yahootoken", method=RequestMethod.GET)
	public String yahooToken( @RequestParam("state") String state,
			HttpServletRequest httpServletRequest) throws URISyntaxException {
		
		
		
		//String state = "123";
		//String nonce = "123";
		
		
		String fullURI = httpServletRequest.getRequestURL().toString()+"?"+httpServletRequest.getQueryString();
		URI requestURI = new URI(fullURI);
	YConnectExplicit yconnect = new YConnectExplicit();
	
	
		try {
			
			
			if(yconnect.hasAuthorizationCode(requestURI)){
				log.debug("pass");
				String code = yconnect.getAuthorizationCode(state);
				yconnect.requestToken(code, yahooClientId, yahooClientSecret, redirectURI);
				String accessTokenString = yconnect.getAccessToken();
				String refreshTokent = yconnect.getRefreshToken();
				String idTokenString = yconnect.getIdToken();
				log.debug("pass2");
				
				}
		} catch (AuthorizationException e) {
			// TODO Auto-generated catch block
			log.debug("에러1");
			e.printStackTrace();
		} catch (TokenException e) {
			// TODO Auto-generated catch block
			log.debug("에러2");
			e.printStackTrace();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			log.debug("에러3");
			e.printStackTrace();
		}
//		
		log.debug("끝");
//		
		return null;
//		
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
