package com.biz.navy.dao;

import java.util.List;

import org.apache.ibatis.annotations.Select;

import com.biz.navy.domain.ProOptionsVO;
import com.biz.navy.domain.SizeVO;

public interface ProOptionsDao {
	
	@Select("SELECT * FROM tbl_pro_options WHERE o_division = 'SIZE'")
	public List<ProOptionsVO> getSizeList();

	@Select("SELECT * FROM tbl_pro_options WHERE o_division = 'COLOR'")
	public List<ProOptionsVO> getColorList();
		
	// Size
	@Select("SELECT COUNT(*) FROM tbl_size WHERE s_p_code = #{p_code} AND s_size = #{s_size}")
	public int getSize(SizeVO sizeVO);

}
