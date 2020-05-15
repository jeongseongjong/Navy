package com.biz.navy.dao;

import java.util.List;

import org.apache.ibatis.annotations.Select;

import com.biz.navy.domain.SizeVO;

public interface SizeDao {

	@Select("SELECT * FROM tbl_size")
	public List<SizeVO> selectAll();
	
	@Select("SELECT * FROM tbl_size WHERE c_p_code = #{c_p_code}")
	public SizeVO findByCPcode(long c_p_code);
	
}
