package com.biz.navy.dao;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;

import com.biz.navy.domain.QnaVO;

public interface QnaDao {
	
	// Qna 전체 조회(등록 최신순)
	@Select("SELECT * FROM tbl_q_a ORDER BY q_id DESC")
	public List<QnaVO> selectAll();
	
	// Qna Id 조회
	@Select("SELECT * FROM tbl_q_a WHERE q_id = #{q_id}")
	public QnaVO findByQId(long q_id);
	
	// Qna 등록
	@Insert(" INSERT INTO tbl_q_a (q_id, q_code, q_title, q_text, q_r_text, q_auth, q_date) "
			+ " VALUES(SEQ_QA.NEXTVAL, #{q_code}, #{q_title, jdbcType=VARCHAR}, #{q_text, jdbcType=VARCHAR}, #{q_r_text, jdbcType=VARCHAR}, #{q_auth, jdbcType=VARCHAR}, #{q_date, jdbcType=VARCHAR}) ")
	public int insert(QnaVO qnaVO);
	
	// Qna p_code 조회
	@Select("SELECT * FROM tbl_q_a WHERE q_code = #{q_code}")
	public QnaVO findByQPcode(long q_code);
	
}
