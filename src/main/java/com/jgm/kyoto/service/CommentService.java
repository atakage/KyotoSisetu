package com.jgm.kyoto.service;

import java.text.SimpleDateFormat;
import java.util.Date;

import org.springframework.stereotype.Service;

import com.jgm.kyoto.domain.CommentVO;
import com.jgm.kyoto.persistence.CommentDao;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Service
public class CommentService {
	
	
	private final CommentDao commentDao;

	public int insert(CommentVO commentVO) {
		// TODO Auto-generated method stub
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		
		Date date = new Date();
		
		String  c_date = sdf.format(date);
		
		commentVO.setC_date(c_date);
		
		
		
		return commentDao.insert(commentVO);
	}

}
