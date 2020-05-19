package com.biz.navy.controller;

import java.security.Principal;
import java.util.List;

import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.biz.navy.domain.CartListVO;
import com.biz.navy.domain.CartVO;
import com.biz.navy.domain.ProductVO;
import com.biz.navy.domain.UserDetailsVO;
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
		
		return "cart";
	}
	
	@ResponseBody
	@RequestMapping(value="/cart",method=RequestMethod.POST)
	public String cart(CartVO cartVO, Authentication authen,
			ProductVO productVO
			) {
		
		log.debug("프로덕트"+productVO.toString());
		
		try {
			// 카트 VO에서 시큐리티로 로그인한 사용자 이름 가져오기
			///////////////이 아랫줄을 보아라!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
			UserDetailsVO userVO = (UserDetailsVO) authen.getPrincipal();
//			cartVO.setUsername(userVO.getUsername());
//			cartVO.setBk_p_code(productVO.getP_code()+"");
			cartVO = CartVO.builder()
					.bk_p_code(productVO.getP_code())
					.bk_p_name(productVO.getP_name())
					.username(userVO.getUsername())
					.bk_p_size(productVO.getP_size())
					.bk_p_qty((int)productVO.getP_qty())
					.bk_p_oprice((int)productVO.getP_price())
					.build();
					
		} catch (Exception e) {
			
			return "LOGIN_FAIL";
		}
		
		// 
		log.debug("오류 ㅣ " + cartVO.getUsername());
		log.debug("카트:" + cartVO.toString());
		cartService.insert(cartVO);
		
		return "OK";
		
	}
	
	// 장바구니 목록
	@RequestMapping(value="/view", method=RequestMethod.GET)
	public String cart_view(Principal principal, Authentication authen, Model model) {
	
		log.debug("여기는 카트 컨트롤러 뷰 메서드 " + authen.toString());
		UsernamePasswordAuthenticationToken upa = (UsernamePasswordAuthenticationToken) principal;
		try {
			UserDetailsVO userVO = (UserDetailsVO) upa.getPrincipal();
			log.debug("여기는 카트뷰의 유저네임 284글자 " + userVO.getUsername());
			List<CartVO> cartList = cartService.selectCart(userVO.getUsername());
			model.addAttribute("CART_LIST",cartList);
			
		} catch (Exception e) {
			
			e.printStackTrace();
		}
		
		return "cart";
	}
	
	
	// 수량 업데이트
	@ResponseBody
	@RequestMapping(value="/qty_update/{seq}", method=RequestMethod.GET)
	public String qty_update(@PathVariable("seq")String seq,@RequestParam("p_qty") String p_qty) {
		
		long longSeq = Long.valueOf(seq);
		int intQty = Integer.valueOf(p_qty);
		int ret = cartService.qty_update(longSeq, intQty);
		
		return ret+"";
	}
	
	@RequestMapping(value="/cart_one_delete/{id}")
	public String cart_one_delete(@PathVariable("id")String seq) {
		
		long longSeq = Long.valueOf(seq);
		int ret = cartService.deleteOne(longSeq);
		log.debug("삭제할 상품 seq 번호 " + ret);
		
		return "redirect:/cart/view";
		
	}
	
	@ResponseBody
	@RequestMapping(value="/cart_list_delete",method=RequestMethod.POST)
	public Integer cart_list_delete(@RequestParam("delList[]")List<String> strSeqList) {

		log.debug("SEQ LIST : " + strSeqList);	
		
		Integer ret = cartService.cart_list_delete(strSeqList);
		
		
		return ret;
	}
	
	@RequestMapping(value="/cart_list_qty_update",method=RequestMethod.POST)
	public String cart_list_qty_update(CartListVO cartList) {
		
			log.debug("카트 " + cartList);		
			
			cartService.cart_list_qty_update(cartList);
			
		return "redirect:/cart/view";
	}
	
	@ResponseBody
	@RequestMapping(value="/cart_list_buy",method=RequestMethod.POST)
	public Integer cart_list_buy(@RequestParam("buyList[]") List<String> buyList) {
		
		Integer ret = cartService.cart_to_delivery(buyList);
		
		return ret;
	}
	
}
