package com.jgm.kyoto.persistence;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;

import com.jgm.kyoto.domain.UserVO;

public interface MemberDao {

	@Select("SELECT COUNT(*) FROM tbl_user WHERE U_ID = #{u_id}")
	int selectById(String u_id);

	
	@Select("SELECT COUNT(*) FROM tbl_user WHERE U_NICKNAME = #{u_nickname}")
	int selectByNick(String u_nickname);


	@Insert("INSERT INTO tbl_user(U_ID, U_PASSWORD, U_NICKNAME, U_GRADE) VALUES(#{u_id}, #{u_password}, #{u_nickname}, #{u_grade})")
	int insert(UserVO userVO);
	
	
	

}
