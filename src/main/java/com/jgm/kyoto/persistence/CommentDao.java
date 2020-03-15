package com.jgm.kyoto.persistence;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import com.jgm.kyoto.domain.CommentVO;

public interface CommentDao {

	
	@Insert("INSERT INTO tbl_COMMENT(U_ID, C_NUMBER, C_F_ID, C_TEXT, C_DATE, U_NICKNAME) VALUES(#{u_id}, SEQ_COMMENT.NEXTVAL, #{c_f_id}, #{c_text}, #{c_date}, #{u_nickname})")
	public int insert(CommentVO commentVO);

	public List<CommentVO> getCommentList(String c_f_id);

	public int delete(@Param("c_number") long c_number, @Param("u_id")String u_id);

	@Select("SELECT * FROM tbl_comment WHERE C_P_NUMBER = #{c_p_number} ORDER BY C_NUMBER")
	public List<CommentVO> getHensinList(int c_p_number);

	public int hensinInsert(CommentVO commentVO);

	public int checkPNumCount(CommentVO commentVO);

}
