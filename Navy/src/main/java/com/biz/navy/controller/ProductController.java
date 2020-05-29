package com.biz.navy.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.biz.navy.domain.ColorVO;
import com.biz.navy.domain.ProductVO;
import com.biz.navy.domain.SizeVO;
import com.biz.navy.service.CartService;
import com.biz.navy.service.ProOptionsService;
import com.biz.navy.service.ProductImgService;
import com.biz.navy.service.ProductService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@RequiredArgsConstructor
@RequestMapping(value="/product")
@Controller
@Slf4j
public class ProductController {

	private final ProductService proService;
	private final ProductImgService proImgService;
	private final CartService cartService;
	// private final ProOptionsService optionsService;
	
	@ModelAttribute("productVO")
	public ProductVO newProductVO() {
		return new ProductVO();
	}
	
	// 상품 전체 리스트 
	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public String productList(ProductVO productVO, Model model) {
		
		List<ProductVO> proList = proService.selectAll();
		
		model.addAttribute("PROLIST", proList);
		log.debug("상품 리스트에 뭐가 담겼는가" + proList);
		
		return "allList";
	}
	
	// 상품 디테일 화면
	@RequestMapping(value="/detail/{id}", method = RequestMethod.GET)
	public String detail(ProductVO productVO, @PathVariable("id") String id, Model model) {

		long p_code = Long.valueOf(id);
		productVO = proService.findById(p_code);
		
		List<SizeVO> sizeList = null;
		List<ColorVO> colorList = null;
		
		long s_p_code =  productVO.getP_code();
		sizeList = proService.getProSize(s_p_code);
		
		for(SizeVO sVO : sizeList) {
			long c_s_code = sVO.getS_code();
			colorList = proService.getProColor(c_s_code);
		}
		
		model.addAttribute("productVO", productVO);
		model.addAttribute("sizeList", sizeList);
		model.addAttribute("colorList", colorList);
		
		
		
		/*
		model.addAttribute("m_size_list", optionsService.getSizeList());
		model.addAttribute("m_color_list", optionsService.getColorList());
		
		log.debug("여기는 디테일 컨트롤러" + productVO);
		log.debug("사이즈 리스트 " +  optionsService.getSizeList());
		log.debug("컬러 리스트 " +  optionsService.getColorList());
		*/
		return "detail";
	}
	
	@ResponseBody
	@RequestMapping(value = "/get_color_list_by_size", method = RequestMethod.GET)
	public Object get_color_list_by_size(String s_code) {
		List<ColorVO> proColorList = proService.getColorListBySize(s_code);

		if(proColorList == null) {
			return "FAIL";
		}
				
		return proColorList;
	}

}
