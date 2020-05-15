package com.biz.navy.service;

import java.util.List;

import com.biz.navy.domain.ProductImagesVO;

public interface ProduceImagesService {

	public List<ProductImagesVO> selectAll();
	
	public ProductImagesVO findByPImgSeq(long p_img_seq);

}
