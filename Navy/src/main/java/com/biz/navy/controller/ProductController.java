package com.biz.navy.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.biz.navy.domain.ProductImgVO;
import com.biz.navy.domain.ProductVO;
import com.biz.navy.service.ProductImgService;
import com.biz.navy.service.ProductService;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@RequestMapping(value="/product")
@Controller
public class ProductController {

	private final ProductService proService;
	private final ProductImgService proImgService;
	
	// 상품 전체 리스트 
	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public String productList(ProductVO productVO, Model model) {
		
		List<ProductVO> proList = proService.selectAll();
		
		model.addAttribute("PROLIST", proList);
		
		return "allList";
	}
	
	// 상품 디테일 화면
	@RequestMapping(value="/detail/{id}", method = RequestMethod.GET)
	public String detail(ProductVO productVO, @PathVariable("id") String id, Model model) {
		long p_code = Long.valueOf(id);
		productVO = proService.findById(p_code);
		model.addAttribute("productVO", productVO);	
		return "detail";
	}

}
