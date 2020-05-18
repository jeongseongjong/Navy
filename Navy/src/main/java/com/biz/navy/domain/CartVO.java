package com.biz.navy.domain;

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
public class CartVO {

	// 장바구니 들어갈 seq값
	private long bk_id;
	
	private String username;
	
	private long bk_p_code; 	// 상품코드
	
	private String bk_p_name;
	
	private int bk_p_oprice;	// 판매가격
	
	private int bk_p_qty;		// 수량
	
	private String bk_p_status;
 
}
