package com.biz.navy.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.biz.navy.domain.CartVO;
import com.biz.navy.domain.PageVO;
import com.biz.navy.domain.ProductVO;
import com.biz.navy.domain.QnaVO;
import com.biz.navy.domain.ReviewVO;
import com.biz.navy.domain.UserDetailsVO;
import com.biz.navy.service.CartService;
import com.biz.navy.service.PageService;
import com.biz.navy.service.ProductImgService;
import com.biz.navy.service.ProductService;
import com.biz.navy.service.QnaService;
import com.biz.navy.service.ReviewService;
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
	private final CartService cartService;
	private final ReviewService reviewService;
	private final QnaService qnaService;
	private final PageService pageService;
	
	
	
	@RequestMapping(value="",method=RequestMethod.GET)
	public String admin(Model model) {
		
		List<ReviewVO> reviewList = reviewService.selectAll();
		List<QnaVO> qnaList = qnaService.selectAll();
		
		model.addAttribute("REVIEWLIST",reviewList);
		model.addAttribute("QNALIST",qnaList);
		
		return "admin/admin_home";
	}
	
	// 회원 리스트
	@RequestMapping(value="/userlist",method=RequestMethod.GET)
	public String userList(Model model,
			@RequestParam(value="search", required = false, defaultValue = "") String search,
			@RequestParam(value="currentPageNo", required = false, defaultValue = "1") int currentPageNo
			) {
		
		log.debug("컨트롤러 검색어 : " + search);
		
		long totalCount = userService.totalCount(search);
		PageVO pageVO = pageService.getPagination(totalCount, currentPageNo);
		
//		List<UserDetailsVO> userList =  userService.selectAll();
//		List<UserDetailsVO> userList =  userService.selectAllPaging(pageVO);
		List<UserDetailsVO> userNameList = userService.findBySearchName(search,pageVO);
		
		model.addAttribute("pageVO",pageVO);
		
		// 페이징에 보내줄 URL들 미리 만들어두기
		model.addAttribute("controller","admin");
		model.addAttribute("url","userlist");
		
		model.addAttribute("userList", userNameList);
		
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
		
		return "redirect:/admin/user_detail_view/"+username;
	}
	
	
	// 상품 정보
	@RequestMapping(value="/productlist",method=RequestMethod.GET)
	public String productlist(Model model,
			@RequestParam(value="search", required = false, defaultValue = "") String search,
			@RequestParam(value="currentPageNo", required = false, defaultValue = "1") int currentPageNo
			) {
		
		long totalCount = proService.totalCount(search);
		PageVO pageVO = pageService.getPagination(totalCount, currentPageNo);
		
//		List<ProductVO> proList = proService.selectAll();
		List<ProductVO> proListPaging = proService.findBySearchName(search, pageVO);
		
		model.addAttribute("PROLIST",proListPaging);
		model.addAttribute("pageVO",pageVO);
		
		// 페이징에 보내줄 URL들 미리 만들어주기
		model.addAttribute("controller","admin");
		model.addAttribute("url","productlist");
		model.addAttribute("search",search);
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
	public String proInsert(ProductVO productVO, Model model, 
			String[] size,
			String[] color,
			int[] qty,
			
			MultipartHttpServletRequest files
			) {
		int ret = proService.insert(productVO, size, color, qty, files);
		
		return "redirect:/admin/productlist";
	}
	
	// 상품 수정하는 페이지로 이동
	@RequestMapping(value="/pro_update/{p_code}",method=RequestMethod.GET)
	public String proUpdate(@PathVariable("p_code") String p_code, ProductVO productVO, Model model) {
		
		productVO = proService.findById(Long.valueOf(p_code));
		
		model.addAttribute("productVO",productVO);
		model.addAttribute("adminBody","proUpdate");
		
		return "admin/admin_proUpdate";
	}
	
	// 상품 수정하고 DB에 저장
	@RequestMapping(value="/pro_update/{p_code}",method=RequestMethod.POST)
	public String proUpdatePOST(@PathVariable("p_code") String p_code, ProductVO productVO, Model model) {
		
		int ret = proService.update(productVO);
		
		return "redirect:/admin/pro_detail_view/\"+productVO.getP_code()";
	}
	
	// 상품 삭제
	@RequestMapping(value="/pro_delete/{p_code}",method=RequestMethod.GET)
	public String proDelete(@PathVariable("p_code") String p_code) {
		int ret = proService.delete(Long.valueOf(p_code));
		return "redirect:/admin/productlist";
	}
	
	// 상품 이미지 삭제
	@ResponseBody
	@RequestMapping(value="/pro_imgs_delete/{img_seq}",method=RequestMethod.GET)
	public String pro_imgs_delete(@PathVariable("img_seq") long img_seq) {
		log.debug("이미지 시퀀스 : "+img_seq);
		int ret = proService.imagesDelete(img_seq);
		if(ret > 0) {
			return "DELETE";
		} else {
			return "NO";
		}
	}
	
	
	// 주문 정보
	@RequestMapping(value="/orderlist",method=RequestMethod.GET)
	public String orderlist(Model model) {
		
		List<CartVO> cartList = cartService.selectAll();
		
		model.addAttribute("CARTLIST",cartList);
		
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
	public String inventory(Model model) {
		
		List<ProductVO> proList = proService.selectAll();
		log.debug("상품 리스트 : " + proList.toString());
		model.addAttribute("PROLIST",proList);
		
		return "admin/admin_inventory";
	}
	
	// 고객센터 정보
	@RequestMapping(value="/support",method=RequestMethod.GET)
	public String support() {
		
		return "admin/admin_support";
	}

}
