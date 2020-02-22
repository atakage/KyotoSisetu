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
public class FacilityVO {
	
	private String id;
	private String name;
	private String department;
	private String address;
	private String pic;
	private String note;
	private String tel;
	private String url;
	private String optime;
	private String holiday;
	private String fee;
}
