package com.biz.navy.dao;

import java.util.List;

import org.apache.ibatis.annotations.Select;

import com.biz.navy.domain.SizeVO;

public interface SizeDao {

	@Select("SELECT * FROM tbl_size")
	public List<SizeVO> selectAll();
	
	@Select("SELECT * FROM tbl_size WHERE s_p_code = #{s_p_code}")
	public SizeVO findBySPcode(long s_p_code);
	
}
