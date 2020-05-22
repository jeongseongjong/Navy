package com.biz.navy.dao;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Many;
import org.apache.ibatis.annotations.Result;
import org.apache.ibatis.annotations.Results;
import org.apache.ibatis.annotations.Select;

import com.biz.navy.domain.ColorVO;
import com.biz.navy.domain.ProSizeColorVO;
import com.biz.navy.domain.ProductImgVO;
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
	
	@Select("SELECT * FROM tbl_size WHERE s_p_code = #{s_p_code}")
	@Results(value= {@Result(property = "s_code", column = "s_code"),
			@Result(property = "colorList", column = "s_code", javaType = List.class, many = @Many(select = "getCPcode"))})
	public SizeVO getSPcode(long s_p_code);
	
	@Select("SELECT * FROM tbl_color WHERE c_s_code = #{c_s_code}")
	public ColorVO getCPcode(long c_s_code);
	
	@Select("SELECT * FROM tbl_p_images WHERE p_img_p_code = #{p_img_p_code}")
	public List<ProductImgVO> getPImgSeq(long p_img_p_code);


	public int insert(ProductVO productVO);

	public int update(ProductVO productVO);

	@Delete("DELETE FROm tbl_product WHERE p_code = #{p_code}")
	public int delete(long p_code);

	// 상품 등록 사이즈 테이블 포함
	public void insertWithSize(List<SizeVO> sizeList);
	
	@Select("SELECT MAX(P_CODE) FROM tbl_product")
	public int findByMaxPCode();

	@Select("SELECT MAX(S_CODE) FROM tbl_size")
	public int findByMaxSizeCode();

	public void insertWithColor(List<ColorVO> colorList);

	
}
