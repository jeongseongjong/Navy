package com.biz.navy.dao;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Many;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Result;
import org.apache.ibatis.annotations.Results;
import org.apache.ibatis.annotations.Select;

import com.biz.navy.domain.ColorVO;
import com.biz.navy.domain.InventoryChangeVO;
import com.biz.navy.domain.InventoryVO;
import com.biz.navy.domain.PageVO;
import com.biz.navy.domain.ProductImgVO;
import com.biz.navy.domain.ProductUpdateVO;
import com.biz.navy.domain.ProductVO;
import com.biz.navy.domain.QnaVO;
import com.biz.navy.domain.ReviewVO;
import com.biz.navy.domain.SizeVO;

public interface ProductDao {
	
	// main 상품 추천 리스트(현재는 날짜,시간 등록 최신순 기준)
	@Select("SELECT * FROM (SELECT * FROM tbl_product ORDER BY p_date DESC, p_time DESC) WHERE ROWNUM <= 3")
	@Results(value = {@Result(property = "p_code", column = "p_code"),
		@Result(property = "proDImgList", column = "p_code", javaType = List.class, many = @Many(select = "getProImages"))})
	public List<ProductVO> findByBest();

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
	@Results(value= {
			@Result(property = "s_code", column = "s_code"),
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
	public List<ProductImgVO> getProImages(long p_img_p_code);
	
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
	public Integer findByMaxPCode();

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

	// 검색 포함한 페이징
	public long countSearch(@Param("searchList")List<String> searchList);

	// 재고관리 페이지 위한 메서드들
	// 제품 이름으로 검색, 페이징
	public List<ProductVO> findBySearchNameAndPaging(@Param("searchList")List<String> searchList, @Param("pageVO")PageVO pageVO);

	// 재고관리 총 개수 세기
	public long countColorAll();
	
	// 재고관리 이름으로 검색 후 페이징
	public List<InventoryVO> findStockBySearchNameAndPaging(@Param("searchList") List<String> searchList, @Param("pageVO")PageVO pageVO);
	
	// 재고관리 검색 후 개수 세기
	public long countStockSearch(@Param("searchList")List<String> searchList);
	
	// 재고관리 총 개수 세기
	public List<InventoryVO> selectColorAll(PageVO pageVO);
	
	// 대표이미지 변경 메서드
	public int updateRepImg(String imgName);
	
	// DB에 존재하는 재고(사이즈)리스트 삭제하기 위한 메서드
	@Delete("DELETE FROM tbl_size WHERE s_code = #{s_code} ")
	public void existing_size_delete(long s_code);
	
	// DB에 존재하는 재고(컬러)리스트 삭제하기 위한 메서드
	@Delete("DELETE FROM tbl_color WHERE c_code = #{c_code} ")
	public int existing_color_delete(long c_code);
	
	// DB에 존재하는 재고, 컬러 변경하기 위한 메서드
//	public int existing_update(@Param("proUpdateList") List<ProductUpdateVO> proUpdateList);
	public int existing_update(ProductUpdateVO proVO);
	
	// 차트 구현하기 위해 월별 판매량 데이터 가져오기	
	public List<InventoryChangeVO> selectChanges();

	// 차트 구현하는데 필요한 row(ex:월별) 개수 세기
	public int countChange();

	// 그래프에 쓸 변동량 데이터 Insert위한 코드
	public void update_changes(List<InventoryChangeVO> exQtyList);

}
