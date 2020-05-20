package com.biz.navy.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.biz.navy.domain.ProductVO;
import com.biz.navy.domain.UserDetailsVO;
import com.biz.navy.service.ProductImgService;
import com.biz.navy.service.ProductService;
import com.biz.navy.service.secure.UserService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequiredArgsConstructor
@Controller
@RequestMapping(value="/admin")
public class AdminController {

	private final UserService userService;
	private final ProductService proService;
	private final ProductImgService proImgService;
	
	@RequestMapping(value="",method=RequestMethod.GET)
	public String admin() {
		
		return "admin/admin_home";
	}
	
//	<li><a href="${rootPath}/admin/userlist">회원 리스트</a></li>
//	<li><a href="${rootPath}/admin/productlist">상품 정보</a></li>
//	<li><a href="${rootPath}/admin/orderlist">주문 정보</a></li>
//	<li><a href="${rootPath}/admin/qna">QNA</a></li>
//	<li><a href="${rootPath}/admin/review">리뷰</a></li>
//	<li><a href="${rootPath}/admin/inventory">재고</a></li>
//	<li><a href="${rootPath}/admin/support">고객센터</a></li>

	// 회원 리스트
	@RequestMapping(value="/userlist",method=RequestMethod.GET)
	public String userList(Model model) {
		
		List<UserDetailsVO> userList =  userService.selectAll();
		model.addAttribute("userList", userList);
		
		return "admin/admin_userList";
	}
	
	// 회원 디테일
	@RequestMapping(value="/user_detail_view/{username}",method=RequestMethod.GET)
	public String userDetailView(@PathVariable("username") String username, Model model) {
		
		UserDetailsVO userVO =  userService.findByUserName(username);
		model.addAttribute("userVO", userVO);
		
		return "admin/admin_userDetail";
	}
	

	
	// 권한 삭제
	@RequestMapping(value="/delete",method=RequestMethod.GET)
	public String auth_delete(@RequestParam("id") long id, UserDetailsVO userVO) {
		
		int ret = userService.delete(id);
		
		return "redirect:/admin/user_detail_view/" + userVO.getUsername();
	}
	
	// 유저 정보 수정
	@RequestMapping(value="/user_update/{username}",method=RequestMethod.GET)
	public String userUpdate(@PathVariable("username") String username, Model model) {
		
		UserDetailsVO userVO =  userService.findByUserName(username);
		model.addAttribute("userVO", userVO);
		
		return "admin/admin_userUpdate";
	}
	
	@RequestMapping(value="/user_update/{username}",method=RequestMethod.POST)
	public String userUpdate(@PathVariable("username") String username, UserDetailsVO userVO, String[] auth, Model model) {
		

		int ret = userService.update(userVO, auth);
		
		return "redirect:/admin";
	}
	
	
	// 상품 정보
	@RequestMapping(value="/productlist",method=RequestMethod.GET)
	public String productlist(Model model) {
		
		List<ProductVO> proList = proService.selectAll();
		
		model.addAttribute("PROLIST",proList);
		
		return "admin/admin_allList";
	}
	
	// 상품 디테일 정보 보여주기
	@RequestMapping(value="/pro_detail_view/{p_code}",method=RequestMethod.GET)
	public String proDetailView(@PathVariable("p_code") String p_code, Model model) {
		
		long id = Long.valueOf(p_code);
		ProductVO productVO = proService.findById(id);
		model.addAttribute("productVO", productVO);
		
		return "admin/admin_proDetail";
	}
	
	// 상품 등록 페이지 보여주기
	@RequestMapping(value="/pro_insert",method=RequestMethod.GET)
	public String proInsert(ProductVO productVO, Model model) {
		
		model.addAttribute("productVO",productVO);
		model.addAttribute("adminBody","proInsert");
		
		return "admin/admin_proInsert";
	}
	
	// 상품 등록에 작성한 내용 DB에 심기
	@RequestMapping(value="/pro_insert",method=RequestMethod.POST)
	public String proInsert(ProductVO productVO, Model model, String dummy) {
		
		int ret = proService.insert(productVO);
		
		return "redirect:/admin";
	}
	
	// 상품 수정하는 페이지로 이동
	@RequestMapping(value="/pro_update/{p_code}",method=RequestMethod.GET)
	public String proUpdate(@PathVariable("p_code") String p_code, ProductVO productVO, Model model) {
		
		productVO = proService.findById(Long.valueOf(p_code));
		
		model.addAttribute("productVO",productVO);
		model.addAttribute("adminBody","proUpdate");
		
		return "admin/admin_proInsert";
	}
	
	// 상품 수정하고 DB에 저장
	@RequestMapping(value="/pro_update/{p_code}",method=RequestMethod.POST)
	public String proUpdatePOST(@PathVariable("p_code") String p_code, ProductVO productVO, Model model) {
		
		int ret = proService.update(productVO);
		
		return "redirect:/admin";
	}
	
	// 상품 삭제
	@RequestMapping(value="/pro_delete/{p_code}",method=RequestMethod.GET)
	public String proDelete(@PathVariable("p_code") String p_code) {
		int ret = proService.delete(Long.valueOf(p_code));
		return "redirect:/admin/productlist";
	}
	
	// 주문 정보
	@RequestMapping(value="/orderlist",method=RequestMethod.GET)
	public String orderlist() {
		
		return "admin/admin_orderList";
	}
	
	// Q&A 정보
	@RequestMapping(value="/qna",method=RequestMethod.GET)
	public String qna() {
		
		return "admin/admin_qna";
	}
	
	// 리뷰 정보
	@RequestMapping(value="/review",method=RequestMethod.GET)
	public String review() {
		
		return "admin/admin_review";
	}
	
	// 재고 정보
	@RequestMapping(value="/inventory",method=RequestMethod.GET)
	public String inventory() {
		
		return "admin/admin_inventory";
	}
	
	// 고객센터 정보
	@RequestMapping(value="/support",method=RequestMethod.GET)
	public String support() {
		
		return "admin/admin_support";
	}

}
