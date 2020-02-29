package com.jgm.kyoto.domain;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
@Builder
public class UserVO {

	
	private String u_id;
	private String u_password;
	private String u_nickname;
	private String u_grade;
}
