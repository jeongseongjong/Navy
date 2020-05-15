package com.biz.navy.service;

import java.util.List;

import com.biz.navy.domain.ProductVO;

public interface ProductService {

	// 상품등록
	public String insert();
	
	// 상품수정
	public String update();
	
	// 상품삭제
	public String delete();
	
	// 상품전체리스트
	public List<ProductVO> selectAll();
	
	// 상품조회
	public ProductVO findById(long p_code);
	
}
