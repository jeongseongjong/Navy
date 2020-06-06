package com.biz.navy.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Service;

import com.biz.navy.domain.CartListVO;
import com.biz.navy.domain.CartVO;
import com.biz.navy.domain.ColorVO;
import com.biz.navy.domain.PageVO;
import com.biz.navy.domain.SizeVO;

public interface CartService {

	// 장바구니 개수
	public int cartCount();
	
	public List<CartVO> selectAll();
	
	public List<CartVO> selectByStatus(String status);
	
	// 카트에서 선택하기
	public List<CartVO> selectCart(String username);
	
	// 배송중인 상품을 보여주는 메서드
	public List<CartVO> paymentList(@Param("username")String username, @Param("pageVO")PageVO pageVO);
	
	public List<CartVO> selectDelivery(String username);
	
	
	// 장바구니 담기
	public int insert(CartVO cartVO);
	
	// 장바구니에 담긴 상품 단품 개수 수정
	public int qty_update(long bk_id, int bk_p_qty);
	
	// 장바구니 상품 삭제
	public int deleteOne(long bk_id);
	
	// 장바구니 선택된 상품 삭제
	public int cart_list_delete(List<String> seqList);
	
	// 장바구니 상품 전체 수량 수정
	public void cart_list_qty_update(CartListVO cartList);
	
	// 장바구니 담겨진 상품 총 금액
	public String sum();

	// 장바구니에 있는 상품상태를 delivery로 바꾸는 메서드
	public int cart_to_delivery(List<String> buyList);

	// product에서 size코드를 받아오는 메서드
	public List<SizeVO> findBySpCode(long s_p_code);
	
	// size에서 color코드를 받아오는 메서드
	public List<ColorVO> findByCsCode(long c_s_code);

	// 배송정보 업데이트
	public int recipient_update(List<String> bkSeqList, CartVO cartVO);

	public long countDelivery();

	// 주문정보 유저 아이디로 조회
	public List<CartVO> findBySearchUsername(String search, PageVO pageVO);
	
	// 총 개수 세기 
	public long totalCount(String search);

	// 관리자 유저 정보 화면에서 사용자가 주문한 내역 조회
	public List<CartVO> findByUserId(String username);
	

	
}
