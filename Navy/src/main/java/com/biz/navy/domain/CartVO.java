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
	
	private String username;	// 회원 이름
	
	private long bk_p_code; 	// 상품코드
	
	private String bk_p_name; 	// 상품 이름
	
	private int bk_p_oprice;	// 판매가격
	
	private int bk_p_qty;		// 수량
	
	private String bk_p_status;	// 상품 상태
	
	private String bk_p_size;	// 상품 사이즈
	private String bk_p_color;	// 상품 색상
	private String bk_p_buyTime;// 구매 시각
	
	private String bk_recipient_name; 			// 배송 받는사람 이름
	private String bk_recipient_phone; 			// 받는사람 연락처
	private String bk_recipient_address;		// 받는사람 주소
	private String bk_recipient_address_etc;	// 받는사람 상세주소
	private String bk_recipient_message;		// 배송 요청사항
	
	
 
}
