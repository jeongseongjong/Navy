package com.biz.navy.service;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.biz.navy.domain.PageVO;
import com.biz.navy.domain.ColorVO;
import com.biz.navy.domain.ProductVO;
import com.biz.navy.domain.SizeVO;

public interface ProductService {

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

	public long countColor(String search);

	public List<ProductVO> findStockBySearchName(String search, PageVO pageVO);

	

	
	

}
