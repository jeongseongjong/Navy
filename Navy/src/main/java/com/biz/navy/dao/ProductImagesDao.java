package com.biz.navy.dao;

import java.util.List;

import org.apache.ibatis.annotations.Select;

import com.biz.navy.domain.ProductImagesVO;

public interface ProductImagesDao {

	@Select("SELECT * FROM tbl_p_images")
	public List<ProductImagesVO> selectAll();
	
	@Select("SELECT * FROM tbl_p_images WHERE p_img_seq = #{p_img_seq}")
	public ProductImagesVO findByPImgSeq(long p_img_seq);
	
}
