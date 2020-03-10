package com.jgm.kyoto.persistence;

import org.apache.ibatis.annotations.Insert;

import com.jgm.kyoto.domain.CommentVO;

public interface CommentDao {

	
	@Insert("INSERT INTO tbl_COMMENT(U_ID, C_NUMBER, C_F_ID, C_TEXT, C_DATE) VALUES(#{u_id}, SEQ_COMMENT.NEXTVAL, #{c_f_id}, #{c_text}, #{c_date})")
	public int insert(CommentVO commentVO);

}
