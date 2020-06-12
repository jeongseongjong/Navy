package com.biz.navy.service;

import java.util.List;

import com.biz.navy.domain.ReviewVO;

public interface ReviewService {

	// 리뷰등록
	public int insert(ReviewVO reviewVO);
	
	// 리뷰조회
	public List<ReviewVO> selectAll();
	
	// 리뷰수정
	public int update(ReviewVO reviewVO);
	
	// 리뷰삭제
	public String delete();
	
	// 상품별 리뷰조회
	public String findByPId();
	
	// 리뷰 조회
	public ReviewVO findByRId(long r_id);
	
	// 리뷰 상품 조회
	public ReviewVO findByRPcode(long r_code);

	// 관리자 유저 정보 화면에서 사용자가 입력한 review 조회
	public List<ReviewVO> findByUserId(String username);
	
	
}
