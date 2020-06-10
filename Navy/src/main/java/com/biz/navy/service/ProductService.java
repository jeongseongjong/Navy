package com.biz.navy.service;

import java.util.List;

import org.apache.ibatis.annotations.Select;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.biz.navy.domain.PageVO;
import com.biz.navy.domain.ProductImgVO;
import com.biz.navy.domain.ProductUpdateVO;
import com.biz.navy.domain.ColorVO;
import com.biz.navy.domain.InventoryChangeVO;
import com.biz.navy.domain.InventoryVO;
import com.biz.navy.domain.ProductVO;
import com.biz.navy.domain.SizeVO;

public interface ProductService {

	// main 상품 추천 리스트(현재는 날짜,시간 등록 최신순 기준)
	public List<ProductVO> findByBest();
	
	// 상품등록
	public int insert(ProductVO productVO);
	
	// 상품수정
	public int update(ProductVO productVO);
	
	// 상품삭제
	public int delete(long p_code);
	
	// 상품전체리스트
	public List<ProductVO> selectAll();

	public ProductVO findById(long p_code);
	
	public List<ColorVO> getColorListBySize(String s_code);

//	public int insert(ProductVO productVO, String[] size, String[] color, int[] qty);

//	public int insert(ProductVO productVO, String[] size, String[] color, int[] qty, MultipartFile file);
	
	public int insert(ProductVO productVO, String[] size, String[] color, int[] qty, MultipartHttpServletRequest files);

	public int imagesDelete(long img_seq);

	public List<ProductVO> selectAllPaging(PageVO pageVO);

	public long totalCount(String search);

	public List<ProductVO> findBySearchName(String search, PageVO pageVO);
	public List<SizeVO> getProSize(long s_p_code);

	public List<ColorVO> getProColor(long c_s_code);
	
	public List<ProductImgVO> getProImages(long p_img_p_code);

	public long countColor(String search);

	public List<InventoryVO> findStockBySearchName(String search, PageVO pageVO);

	public int updateRepImg(String imgName, long p_code);
	// DB에 존재하는 재고(사이즈, 컬러)리스트 삭제하기 위한 메서드
	public int existing_delete(long s_code, long c_code);
	// DB에 존재하는 재고 변경하기 위한 메서드
	public int existing_update(ProductVO productVO, String[] existing_color, int[] existing_qty, long[] existing_s_code, long[] existing_c_code, String[] images, MultipartHttpServletRequest files, int[] ex_qty);
	// 차트 구현하기 위해 월별 판매량 데이터 가져오기
	public String selectChanges();

	

	
	

}
