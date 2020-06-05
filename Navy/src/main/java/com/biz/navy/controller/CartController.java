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
import com.biz.navy.domain.ColorVO;
import com.biz.navy.domain.PageVO;
import com.biz.navy.domain.ProductVO;
import com.biz.navy.domain.SizeVO;
import com.biz.navy.domain.UserDetailsVO;
import com.biz.navy.service.CartService;
import com.biz.navy.service.PageService;
import com.biz.navy.service.ProductService;
import com.biz.navy.service.secure.UserService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping(value = "/cart")
@RequiredArgsConstructor
@Slf4j
public class CartController {

	private final ProductService proService;
	private final CartService cartService;
	private final UserService userService;
	private final PageService pageService;

// <<<<<<< HEAD
	@ResponseBody
	@RequestMapping(value = "/cart", method = RequestMethod.POST)
	public String cart(CartVO cartVO, Authentication authen, ProductVO productVO, String[] size, SizeVO sizeVO,
			ColorVO colorVO) {

		log.debug("프로덕트" + productVO.toString());

		try {
			// 카트 VO에서 시큐리티로 로그인한 사용자 이름 가져오기
			/////////////// 이 아랫줄을 보아라!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
			UserDetailsVO userVO = (UserDetailsVO) authen.getPrincipal();
//			cartVO.setUsername(userVO.getUsername());
//			cartVO.setBk_p_code(productVO.getP_code()+"");

			cartVO = CartVO.builder()
					.bk_p_code(productVO.getP_code())
					.bk_p_name(productVO.getP_name())
					.username(userVO.getUsername())
					.bk_p_oprice((int) productVO.getP_price())
					.bk_p_size(productVO.getP_size())
					.bk_p_color(productVO.getP_color())
					.bk_p_qty((int) productVO.getP_qty())
					.build();

		} catch (Exception e) {

			return "LOGIN_FAIL";
		}

		//
		log.debug("오류 " + cartVO.getUsername());
		log.debug("카트:" + cartVO.toString());
		int ret = cartService.insert(cartVO);
		log.debug("여기는 카트 메서드의 인서트실행 코드 " + ret);

		return "OK";

	}
// <<<<<<< HEAD

	// 장바구니 목록
	@RequestMapping(value = "/view", method = RequestMethod.GET)
	public String cart_view(Principal principal, Authentication authen, Model model) {

		log.debug("여기는 카트 컨트롤러 뷰 메서드 " + authen.toString());
		UsernamePasswordAuthenticationToken upa = (UsernamePasswordAuthenticationToken) principal;
		try {
			UserDetailsVO userVO = (UserDetailsVO) upa.getPrincipal();
			log.debug("여기는 카트뷰의 유저네임 284글자 " + userVO.getUsername());
			List<CartVO> cartList = cartService.selectCart(userVO.getUsername());
			model.addAttribute("CART_LIST", cartList);

		} catch (Exception e) {

			e.printStackTrace();
		}

		return "cart";
	}

	// 배송중 상품을 보여주는 메서드
	@RequestMapping(value = "/delivery_view", method = RequestMethod.GET)
	public String cart_list_delivery(Principal principal, Authentication authen, Model model) {

		UsernamePasswordAuthenticationToken upa = (UsernamePasswordAuthenticationToken) principal;
		try {
			UserDetailsVO userVO = (UserDetailsVO) upa.getPrincipal();
			List<CartVO> deliveryList = cartService.selectDelivery(userVO.getUsername());
			UserDetailsVO userList = userService.findByUserName(userVO.getUsername());
			log.debug("여기는 딜리버리 리스트 " + deliveryList.toString());
			log.debug("구매자 정보" + userList.toString());
			int size = deliveryList.size();
			model.addAttribute("USER_LIST", userList);
			model.addAttribute("DELIVERY_LIST", deliveryList);

			model.addAttribute("LIST_COUNT", size - 1);

			log.debug("딜리버리 리스트 " + deliveryList);
		} catch (Exception e) {
			// TODO: handle exception
		}

		return "delivery_view";
	}

	// 구매버튼 클릭 시 p_status가 cart->Deliv 로 바뀌는 메소드
	@ResponseBody
	@RequestMapping(value = "/cart_list_buy", method = RequestMethod.POST)
	public int cart_list_buy(@RequestParam("buyList[]") List<String> buyList) {
		log.debug("여기는 카트에서 구매했을때 넘어가는 리스트 " + buyList);
		Integer ret = cartService.cart_to_delivery(buyList);
		// log.debug("여기는 구매목록 " + ret+"");
		return ret;
	}

	// 수량 업데이트
	@ResponseBody
	@RequestMapping(value = "/qty_update/{seq}", method = RequestMethod.GET)
	public String qty_update(@PathVariable("seq") String seq, @RequestParam("p_qty") String p_qty) {

		long longSeq = Long.valueOf(seq);
		int intQty = Integer.valueOf(p_qty);
		int ret = cartService.qty_update(longSeq, intQty);

		return ret + "";
	}

	@RequestMapping(value = "/cart_one_delete/{id}")
	public String cart_one_delete(@PathVariable("id") String seq) {

		long longSeq = Long.valueOf(seq);
		int ret = cartService.deleteOne(longSeq);
		log.debug("삭제할 상품 seq 번호 " + ret);

		return "redirect:/cart/view";

	}

	// 장바구니 전체 삭제 메서드
	@ResponseBody
	@RequestMapping(value = "/cart_list_delete", method = RequestMethod.POST)
	public Integer cart_list_delete(@RequestParam("delList[]") List<String> strSeqList) {

		log.debug("SEQ LIST : " + strSeqList);

		Integer ret = cartService.cart_list_delete(strSeqList);

		return ret;
	}

	// 장바구니 전체 수량 업데이트 메서드
	@RequestMapping(value = "/cart_list_qty_update", method = RequestMethod.POST)
	public String cart_list_qty_update(CartListVO cartList) {

		log.debug("카트 " + cartList);

		cartService.cart_list_qty_update(cartList);

		return "redirect:/cart/view";
	}

	@ResponseBody
	@RequestMapping(value = "/recipient_update", method = RequestMethod.POST)
	public int recipient_update(@RequestParam("bkSeqList") List<String> bkSeqList, CartVO cartVO) {

		log.debug("LENGTH" + bkSeqList.size());
		log.debug("SEQ List" + bkSeqList.toString());

//		long seq = Long.valueOf(bk_id);
//		log.debug("여기는 컨트롤러 구매목록 업데이트" + bk_id);
		int ret = cartService.recipient_update(bkSeqList, cartVO);

		return ret;
//		return 0;
	}

	// 결제완료 상품을 보여주는 메서드
	@RequestMapping(value = "/payment_list", method = RequestMethod.GET)
	public String payment_list(Principal principal, Authentication authen, Model model, 
							@RequestParam(value="currentPageNo", required = false, defaultValue = "1")int currentPageNo) {

		// 구매내역 리스트 개수를 totalCount에 집어넣기
		long totalCount = cartService.countDelivery();
		log.debug("구매내역 총 개수 " + totalCount);
		
		// 구매내역 개수와 현재 페이지를 pageVO에 주입
		PageVO pageVO = pageService.getPagination(totalCount, currentPageNo);
		log.debug("페이먼트리스트 pageVO " +pageVO);
		UsernamePasswordAuthenticationToken upa = (UsernamePasswordAuthenticationToken) principal;
		try {
			UserDetailsVO userVO = (UserDetailsVO) upa.getPrincipal();
			List<CartVO> deliveryList = cartService.paymentList(userVO.getUsername(), pageVO);
			UserDetailsVO userList = userService.findByUserName(userVO.getUsername());
			log.debug("여기는 페이먼트 리스트" + deliveryList.toString());
			log.debug("구매자 정보" + userList.toString());
			
			int size = deliveryList.size();
			
			model.addAttribute("USER_LIST", userList);
			model.addAttribute("DELIVERY_LIST", deliveryList);
			model.addAttribute("pageVO" + pageVO);
			model.addAttribute("LIST_COUNT", size - 1);
			log.debug("cart컨트롤러 pageVO " + pageVO);
			// 페이징에 보내줄 URL들 미리 만들어주기
			model.addAttribute("controller","cart");
			model.addAttribute("url","payment_list");
			
			log.debug("결제 리스트 " + deliveryList);
		} catch (Exception e) {
			// TODO: handle exception
		}

		return "payment_list";
	}

	// 배송중 상품을 보여주는 메서드
	@RequestMapping(value = "/delivery_list", method = RequestMethod.GET)
	public String delivery_list(Principal principal, Authentication authen, Model model) {

		UsernamePasswordAuthenticationToken upa = (UsernamePasswordAuthenticationToken) principal;
		try {
			UserDetailsVO userVO = (UserDetailsVO) upa.getPrincipal();
			List<CartVO> deliveryList = cartService.selectDelivery(userVO.getUsername());
			UserDetailsVO userList = userService.findByUserName(userVO.getUsername());
			log.debug("여기는 배송중 리스트" + deliveryList.toString());
			log.debug("구매자 정보" + userList.toString());
			int size = deliveryList.size();
			model.addAttribute("USER_LIST", userList);
			model.addAttribute("DELIVERY_LIST", deliveryList);

			model.addAttribute("LIST_COUNT", size - 1);

			log.debug("결제 리스트 " + deliveryList);
		} catch (Exception e) {
			// TODO: handle exception
		}

		return "delivery_list";
	}

}
