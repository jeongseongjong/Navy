package com.biz.navy.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.biz.navy.domain.ColorVO;
import com.biz.navy.domain.ProductVO;
import com.biz.navy.domain.SizeVO;
import com.biz.navy.service.CartServiceImpl;
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
	private final CartServiceImpl cartService;
	
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
		
		log.debug("여기에는 오니 ");
		List<ColorVO> colorList = new ArrayList<>();
		
		long p_code = Long.valueOf(id);
		productVO = proService.findById(p_code);
		log.debug("여기는 detail의 productVO " + productVO);
		
		log.debug("야"+p_code);
		System.out.println("야야야야" + p_code);
//		long s_p_code = Long.valueOf(productVO.getP_code());
		List<SizeVO> sizeList = cartService.findBySpCode(p_code);
		for(SizeVO s : sizeList) {
			log.debug("사이즈"+s);
			System.out.println("사이즈" + s);
		
//			long c_s_code = Long.valueOf(
//					s.getS_code()
//					sizeList.get(0).getS_code()
//					);
			
			colorList = cartService.findByCsCode(s.getS_code());
			// System.out.println("여기는 칼라 리스트" + colorList);
			for(ColorVO c : colorList) {
				log.debug("사이즐"+c);
				System.out.println("사이즐" + c);
			}
			
		}
		
		model.addAttribute("productVO", productVO);
		model.addAttribute("SIZELIST", sizeList);
		model.addAttribute("COLORLIST", colorList);
		
		System.out.println("여기는 사이즈 리스트" + sizeList);
		System.out.println("여기는 사이즈 리스트" + colorList);
		
		
		return "detail";
	}

}
