package com.biz.navy.dao;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Many;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Result;
import org.apache.ibatis.annotations.Results;
import org.apache.ibatis.annotations.Select;

import com.biz.navy.domain.ColorVO;
import com.biz.navy.domain.PageVO;
import com.biz.navy.domain.ProductImgVO;
import com.biz.navy.domain.ProductVO;
import com.biz.navy.domain.QnaVO;
import com.biz.navy.domain.ReviewVO;
import com.biz.navy.domain.SizeVO;

public interface ProductDao {

	// 상품 전체 조회
	@Select("SELECT * FROM tbl_product ORDER BY p_code DESC")
	@Results(value= {@Result(property = "p_code", column = "p_code"),
			@Result(property = "sizeList", column = "p_code", javaType = List.class, many = @Many(select = "getProSize")),
			@Result(property = "proDImgList", column = "p_code", javaType = List.class, many = @Many(select = "getProImages")),
			@Result(property = "reviewList", column = "p_code", javaType = List.class, many = @Many(select = "getProReview"))})
	public List<ProductVO> selectAll();
	
	// 상품 조회
	@Select("SELECT * FROM tbl_product WHERE p_code = #{p_code}")
	@Results(value = {@Result(property = "p_code", column = "p_code"),
			@Result(property = "sizeList", column = "p_code", javaType = List.class, many = @Many(select = "getProSize")),
			@Result(property = "proDImgList", column = "p_code", javaType = List.class, many = @Many(select = "getProImages")),
			@Result(property = "reviewList", column = "p_code", javaType = List.class, many = @Many(select = "getProReview")),
			@Result(property = "qnaList", column = "p_code", javaType = List.class, many = @Many(select = "getProQna"))})
	public ProductVO findById(long p_code);
	
	// 상품 사이즈 조회
	@Select("SELECT * FROM tbl_size WHERE s_p_code = #{s_p_code}")
	@Results(value= {@Result(property = "s_code", column = "s_code"),
			@Result(property = "colorList", column = "s_code", javaType = List.class, many = @Many(select = "getProColor"))})
	public List<SizeVO> getProSize(long s_p_code);
	
	// 상품 색깔 조회
	@Select("SELECT * FROM tbl_color WHERE c_s_code = #{c_s_code}")
	public List<ColorVO> getProColor(long c_s_code);
	
	@Select("SELECT * FROM tbl_color "
			+ " LEFT JOIN tbl_size "
			+ " ON c_s_code = s_code "
			+ " WHERE c_s_code = #{longSCode} ORDER BY c_color ")
	public List<ColorVO> getColorListBySize(long longSCode);
	
	// 상품 이미지 조회
	@Select("SELECT * FROM tbl_p_images WHERE p_img_p_code = #{p_img_p_code}")
	public ProductImgVO getProImages(long p_img_p_code);
	
	// 상품 리뷰 조회
	@Select("SELECT * FROM tbl_review WHERE r_code = #{r_code}")
	public ReviewVO getProReview(long r_code);
	
	// 상품 qna 조회
	@Select("SELECT * FROM tbl_q_a WHERE q_code = #{q_code}")
	public QnaVO getProQna(long q_code);

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

	// 파일 업로드용 메서드
	public void insertWithImages(List<ProductImgVO> proImgList);


	@Delete("DELETE FROM tbl_p_images WHERE p_IMG_SEQ = #{img_seq}")
	public int imagesDelete(long img_seq);

	// 페이징
	public List<ProductVO> selectAllPaging(PageVO pageVO);

	// 검색 미포함한 페이징
	public long countAll();

	public long countSearch(@Param("searchList")List<String> searchList);

	// 제품 이름으로 검색, 페이징
	public List<ProductVO> findBySearchNameAndPaging(@Param("searchList")List<String> searchList, @Param("pageVO")PageVO pageVO);
	
}
