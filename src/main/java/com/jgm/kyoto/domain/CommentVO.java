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
public class CommentVO {
	
	
	private String u_id;// varchar2(50) primary key 
	private int c_number;// number(4) not null // SEQ_COMMENT
	private String c_f_id;// varchar2(20) not null    // 施設のid
	private String c_text;// varchar2(1000)
	private String c_date;// varchar2(11) // java自動追加
	

}
