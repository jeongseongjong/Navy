package com.biz.navy.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import org.springframework.web.bind.annotation.RequestParam;
import com.biz.navy.domain.PageVO;
import com.biz.navy.service.PageService;

import org.springframework.web.bind.annotation.ResponseBody;

import com.biz.navy.domain.ColorVO;
import com.biz.navy.domain.ProductVO;
import com.biz.navy.domain.SizeVO;
import com.biz.navy.service.CartService;

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
	private final PageService pageService;
	private final CartService cartService;
	// private final ProOptionsService optionsService;

	
	@ModelAttribute("productVO")
	public ProductVO newProductVO() {
		return new ProductVO();
	}
	
	// 상품 전체 리스트 
	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public String productList(ProductVO productVO, Model model,
			@RequestParam(value="search", required = false, defaultValue = "") String search,
			@RequestParam(value="currentPageNo", required = false, defaultValue = "1") int currentPageNo
			) {
		
		long totalCount = proService.totalCount(search);
		int listPerPage = 15;
		PageVO pageVO = pageService.getPagination(totalCount, currentPageNo, listPerPage);
//		List<ProductVO> proList = proService.selectAll();
//		List<ProductVO> proListPaging = proService.selectAllPaging(pageVO);
		List<ProductVO> proListPaging = proService.findBySearchName(search, pageVO);
		log.debug("페이지VO값:"+pageVO);
		log.debug("서치 값"+search);
		
		model.addAttribute("pageVO",pageVO);
		model.addAttribute("PROLIST", proListPaging);
		log.debug("상품 페이징 리스트에 뭐가 담겼는가" + proListPaging);
		
		// 페이징에 보내줄 URL들 미리 만들어주기
		model.addAttribute("controller","product");
		model.addAttribute("url","list");
		
//		log.debug("상품 리스트에 뭐가 담겼는가" + proList);
		
		return "allList";
	}
	
	// 상품 디테일 화면
	@RequestMapping(value="/detail/{id}", method = RequestMethod.GET)
	public String detail(ProductVO productVO, @PathVariable("id") String id, Model model) {

		long p_code = Long.valueOf(id);
		productVO = proService.findById(p_code);
		log.debug("여기는 product컨트롤러의 productVO " + productVO);
		List<SizeVO> sizeList = null;
		List<ColorVO> colorList = null;
		
		long s_p_code =  productVO.getP_code();
		log.debug("여기는 product컨트롤러의 code " + s_p_code);
		sizeList = proService.getProSize(s_p_code);
		log.debug("product컨트롤러의 sizeList " + sizeList);
		for(SizeVO sVO : sizeList) {
			long c_s_code = sVO.getS_code();
			colorList = proService.getProColor(c_s_code);
		}
		
		model.addAttribute("productVO", productVO);
		model.addAttribute("sizeList", sizeList);
		model.addAttribute("colorList", colorList);
		
		log.debug("여기는 컨트롤러의 사이즈 리스트 " +  sizeList);
		
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
