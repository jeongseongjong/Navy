package com.biz.navy.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.biz.navy.dao.ProductImagesDao;
import com.biz.navy.domain.ProductImagesVO;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequiredArgsConstructor
@Service
public class ProduceImagesServiceImpl implements ProduceImagesService {
	
	private final ProductImagesDao proImgsDao;

	@Override
	public List<ProductImagesVO> selectAll() {
		return proImgsDao.selectAll();
	}

	@Override
	public ProductImagesVO findByPImgSeq(long p_img_seq) {
		return proImgsDao.findByPImgSeq(p_img_seq);
	}
	
}
