package com.biz.navy.dao;

import java.util.List;

import org.apache.ibatis.annotations.Many;
import org.apache.ibatis.annotations.Result;
import org.apache.ibatis.annotations.Results;
import org.apache.ibatis.annotations.Select;

import com.biz.navy.domain.ProductImagesVO;
import com.biz.navy.domain.ProductVO;
import com.biz.navy.domain.SizeVO;

public interface ProductDao {

	@Select("SELECT * FROM tbl_product ORDER BY p_code DESC")
	public List<ProductVO> selectAll();

	/*
		@Select("SELECT * FROM tbl_product WHERE p_code = #{p_code}")
		public ProductVO findById(long p_code);
	*/
	
	@Select("SELECT * FROM tbl_product WHERE p_code = #{p_code}")
	@Results(value= {@Result(property = "p_code", column = "p_code"),
					@Result(property = "sizeList", column = "p_code", javaType = List.class, many = @Many(select = "getCPcode")),
					@Result(property = "proDImgList", column = "p_code", javaType = List.class, many = @Many(select = "getPImgSeq"))})
	public ProductVO findById(long p_code);
	
	@Select("SELECT * FROM tbl_size WHERE c_p_code = #{c_p_code}")
	public SizeVO getCPcode(long c_p_code);
	
	@Select("SELECT * FROM tbl_p_images WHERE p_img_seq = #{p_img_seq}")
	public List<ProductImagesVO> getPImgSeq(long p_img_seq);
	
}
