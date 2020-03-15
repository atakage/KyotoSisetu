package com.jgm.kyoto.service;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

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

	public List<CommentVO> getCommentList(String c_f_id) {
		// TODO Auto-generated method stub
		
		List<CommentVO> commentList = commentDao.getCommentList(c_f_id);
		return commentList;
	}

	public int delete(long c_number, String u_id) {
		// TODO Auto-generated method stub
		
		
		
		return commentDao.delete(c_number,u_id);
	}

	public List<CommentVO> getHensinList(int c_p_number) {
		// TODO Auto-generated method stub
		
		
		return commentDao.getHensinList(c_p_number);
	}

	public int hensinInsert(CommentVO commentVO) {
		// TODO Auto-generated method stub
		
		
		int count = commentDao.checkPNumCount(commentVO);
		
		if(count > 0) {
			return 0;
		}
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		
		Date date = new Date();
		
		String  c_date = sdf.format(date);
		
		commentVO.setC_date(c_date);

		
		return commentDao.hensinInsert(commentVO);
	}

}
