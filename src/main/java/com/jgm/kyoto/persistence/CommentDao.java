package com.jgm.kyoto.persistence;

import java.util.List;

import org.apache.ibatis.annotations.Insert;

import com.jgm.kyoto.domain.CommentVO;

public interface CommentDao {

	
	@Insert("INSERT INTO tbl_COMMENT(U_ID, C_NUMBER, C_F_ID, C_TEXT, C_DATE, U_NICKNAME) VALUES(#{u_id}, SEQ_COMMENT.NEXTVAL, #{c_f_id}, #{c_text}, #{c_date}, #{u_nickname})")
	public int insert(CommentVO commentVO);

	public List<CommentVO> getCommentList(String c_f_id);

}
