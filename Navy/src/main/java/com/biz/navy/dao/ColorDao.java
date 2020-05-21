package com.biz.navy.dao;

import java.util.List;

import org.apache.ibatis.annotations.Select;

import com.biz.navy.domain.ColorVO;

public interface ColorDao {

	@Select("SELECT * FROM tbl_color")
	public List<ColorVO> selectAll();
	
	@Select("SELECT * FROM tbl_color WHERE c_s_code = #{c_s_code}")
	public ColorVO findByCPcode(long c_s_code);
	
}
