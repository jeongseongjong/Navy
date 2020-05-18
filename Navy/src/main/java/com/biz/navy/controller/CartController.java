package com.biz.navy.controller;

import java.util.List;

import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.biz.navy.domain.CartVO;
import com.biz.navy.domain.ProductVO;
import com.biz.navy.service.CartService;
import com.biz.navy.service.ProductService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping(value="/cart")
@RequiredArgsConstructor
@Slf4j
public class CartController {

	private final ProductService proService;
	private final CartService cartService;

	// 상품 리스트
	@RequestMapping(value="/list",method=RequestMethod.GET)
	public String list(Model model) {
		
		List<ProductVO> proList = proService.selectAll();
		
		model.addAttribute("PRODUCT_LIST", proList);
		log.debug("상품 리스트를 가져오느냐"+ proList);
		
		return "user/user_main";
	}
	
	@ResponseBody
	@RequestMapping(value="/",method=RequestMethod.POST)
	public String cart(CartVO cartVO, Authentication authen) {
		
		try {
			// 카트 VO에서 시큐리티로 로그인한 사용자 이름 가져오기
			cartVO.setUsername(authen.getPrincipal().toString());	
		} catch (Exception e) {
			
			return "LOGIN_FAIL";
		}
		
		// 
		cartService.insert(cartVO);
		
		return "OK";
		
	}
	
	// 장바구니 목록
	@RequestMapping(value="/view", method=RequestMethod.GET)
	public String cart_view(Authentication authen, Model model) {
	
		try {
			String username = authen.getPrincipal().toString();
			List<CartVO> cartList = cartService.selectCart(username);
			model.addAttribute("CART_LIST",cartList);
			
		} catch (Exception e) {
			
			e.printStackTrace();
		}
		
		return "cart";
	}
	
	
	@RequestMapping(value="/qty_update/{seq}/p_qty")
	public String qty_update(@PathVariable("seq")String seq,@RequestParam("p_qty") String p_qty) {
		
		long longSeq = Long.valueOf(seq);
		int intQty = Integer.valueOf(p_qty);
		int ret = cartService.qty_update(longSeq, intQty);
		
		return ret+"";
	}
	
	@RequestMapping(value="/cart_one_delete/{seq}")
	public String cart_one_delete(@PathVariable("seq")String seq) {
		
		long longSeq = Long.valueOf(seq);
		cartService.deleteOne(longSeq);
		
		return "redirect:/user/product/cart_view";
		
	}
	
	@RequestMapping(value="/buy", method=RequestMethod.GET)
	public String buy() {
		
		return "buy";
	}
	
	
}
