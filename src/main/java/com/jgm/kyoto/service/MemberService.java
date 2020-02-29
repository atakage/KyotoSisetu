package com.jgm.kyoto.service;

import org.springframework.stereotype.Service;

import com.jgm.kyoto.domain.UserVO;
import com.jgm.kyoto.persistence.MemberDao;

import lombok.RequiredArgsConstructor;

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
		return memberDao.insert(userVO);
	}
	
	

}
