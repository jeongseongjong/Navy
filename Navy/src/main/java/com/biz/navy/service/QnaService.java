package com.biz.navy.service;

import java.util.List;

import com.biz.navy.domain.QnaVO;

public interface QnaService {


	// 질문 등록
	public int insert(QnaVO qnaVO);
	
	// 질문 조회
	public List<QnaVO> selectAll();
	
	// 질문 수정
	public String update();
	
	// 질문 삭제
	public String delete();
	
	// 상품별 질문조회
	public QnaVO findByQId(long q_id);

	// 질문 상품 조회
	public QnaVO findByQPcode(long q_code);
}
