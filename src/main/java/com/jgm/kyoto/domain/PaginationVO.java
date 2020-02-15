package com.jgm.kyoto.domain;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@ToString
@Builder
public class PaginationVO {

	// 1ページにポストの数
	private int pageSize = 10;
	
	// １ブロック（range)にページの数
	private int rangeSize = 7;
	
	private int curPage = 1;
	private int curRange = 1;
	
	// 総ポストの数
	private int allPostCnt;
	private int allPageCnt;
	private int allRangeCnt;
	
	private int startPage = 1;
	private int endPage = 1;
	
	// 一番上のポスト
	private int startIndex = 0;
	private int prevPage;
	private int nextPage;
}
