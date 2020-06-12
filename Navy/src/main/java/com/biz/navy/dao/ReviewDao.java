package com.biz.navy.dao;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;

import com.biz.navy.domain.ReviewVO;

public interface ReviewDao {
	
	// Review 전체 조회(등록 최신순)
	@Select("SELECT * FROM tbl_review ORDER BY r_id DESC")
	public List<ReviewVO> selectAll();
	
	// Review Id 조회
	@Select("SELECT * FROM tbl_review WHERE r_id = #{r_id}")
	public ReviewVO findByRId(long r_id);
	
	// Review 등록
	public int insert(ReviewVO reviewVO);
	
	@Select("SELECT * FROM tbl_review WHERE r_code = #{r_code}")
	public ReviewVO findByRPcode(long r_code);

	// 유저ID로 사용자가 입력한 review 조회	
	@Select("SELECT * FROM tbl_review WHERE r_auth = #{username}")
	public List<ReviewVO> findByUserId(String username);

	public int update(ReviewVO reviewVO);
	
	
	
	
	

}
