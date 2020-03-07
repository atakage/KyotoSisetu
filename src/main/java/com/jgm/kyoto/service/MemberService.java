package com.jgm.kyoto.service;

import org.apache.jena.atlas.logging.Log;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.jgm.kyoto.domain.UserVO;
import com.jgm.kyoto.persistence.MemberDao;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequiredArgsConstructor
@Service
public class MemberService {
	
	
	private final MemberDao memberDao;

	public int mailcheck(String u_id) {
		// TODO Auto-generated method stub
		
		
		
		
		return memberDao.selectById(u_id);
	}

	public int nickcheck(String u_nickname) {
		// TODO Auto-generated method stub
		return memberDao.selectByNick(u_nickname);
	}

	public int insert(UserVO userVO) {
		// TODO Auto-generated method stub
		BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
		String encodedPass = passwordEncoder.encode(userVO.getU_password());
		
		userVO.setU_password(encodedPass);
		
		return memberDao.insert(userVO);
	}

	public UserVO loginCheck(UserVO userVO) {
		// TODO Auto-generated method stub
		
		
		UserVO storedUserVO = memberDao.selectByIdForVO(userVO.getU_id());
		
		
		
		
		if(storedUserVO == null) {
			
			return null;
		}else {
			
			BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
			
			
			if(passwordEncoder.matches(userVO.getU_password(), storedUserVO.getU_password())) {
				
				
				return storedUserVO; // 成功
				
			}
			
			return null;
			
		}
		
		
	}
	
	

}
