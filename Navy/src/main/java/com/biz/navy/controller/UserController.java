package com.biz.navy.controller;

import java.security.Principal;
import java.time.LocalDate;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;

import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.biz.navy.domain.ProductVO;
import com.biz.navy.domain.ReviewVO;
import com.biz.navy.domain.UserDetailsVO;
import com.biz.navy.service.ProductService;
import com.biz.navy.service.ReviewService;
import com.biz.navy.service.secure.UserService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequiredArgsConstructor
@RequestMapping(value = "/user")
@Controller
public class UserController {

	private final UserService userService;
	private final ProductService proService;
	private final ReviewService reviewService;
	
	@RequestMapping(value="/login",method=RequestMethod.GET)
	public String login() {
		return "login";
	}
	
	@RequestMapping(value="/join",method=RequestMethod.GET)
	public String join() {
		return "join";
	}
	
//	@ResponseBody
	@RequestMapping(value = "/join",method=RequestMethod.POST,
			produces = "text/html;charset=UTF-8")
	public String join(String username, String password) {
		
		int ret = userService.insert(username,password);
		
		return "redirect:/";
	}
	
	@ResponseBody
	@RequestMapping(value="/mypagetest",method=RequestMethod.GET)
	public String mypageTest(Principal principal, Model model) {
		
		return principal.toString();
	}
	
	@ResponseBody
	@RequestMapping(value="/password",method=RequestMethod.POST)
	public String password(String password) {
		boolean ret = userService.check_password(password);
		if(ret) return "PASS_OK";
		return "PASS_FAIL";
	}
	
	@RequestMapping(value="/mypage",method=RequestMethod.GET)
	public String mypage(Principal principal, Model model) {
	
		UsernamePasswordAuthenticationToken upa = (UsernamePasswordAuthenticationToken) principal;
		
		UserDetailsVO userVO = (UserDetailsVO)upa.getPrincipal();
		
		userVO.setAuthorities(upa.getAuthorities());
		
		model.addAttribute("userVO",userVO);
		
		return "user/mypage";
	}
	
	@RequestMapping(value="/mypage",method=RequestMethod.POST)
	public String mypage(UserDetailsVO userVO, String[] auth, Model model, String password) {
		log.debug("마이페이지 userVO : "+userVO.toString());
		
		log.debug("컨트롤러 패스워드"+password);
		int ret = userService.update(userVO, password);
		
		return "redirect:/";
	}
	
	//
	// -- Review 
	@RequestMapping(value="/review/{id}", method=RequestMethod.GET)
	public String review(ProductVO productVO, @PathVariable("id") String id, Principal principal, Model model) {
		long p_code = Long.valueOf(id);
		productVO = proService.findById(p_code);
			
		UsernamePasswordAuthenticationToken upa = (UsernamePasswordAuthenticationToken) principal;
		UserDetailsVO userVO = (UserDetailsVO)upa.getPrincipal();
		userVO.setAuthorities(upa.getAuthorities());
		
		ReviewVO reviewVO = new ReviewVO();
		LocalDate localDate = LocalDate.now();
		String curDate = localDate.toString();
		DateTimeFormatter dt = DateTimeFormatter.ofPattern("HH:mm:ss");
		LocalTime localTime = LocalTime.now();
		String curTime = localTime.format(dt).toString();
		reviewVO.setR_date(curDate + " " + curTime);
		reviewVO.setR_code((int) p_code);
		reviewVO.setR_auth(userVO.getUsername());
		
		model.addAttribute("productVO", productVO);
		model.addAttribute("userVO",userVO);
		model.addAttribute("reviewVO", reviewVO);
		
		return "user/user_review";
	}
	
	@RequestMapping(value = "/review/{id}", method = RequestMethod.POST)
	public String review_input(@ModelAttribute("reviewVO") ReviewVO reviewVO, @PathVariable("id") String id, Model model) {
		long p_code = Long.valueOf(id);
		ProductVO productVO = proService.findById(p_code);
		model.addAttribute("productVO", productVO);	
		
		log.debug("REVIEW : " + reviewVO.toString());
		reviewService.insert(reviewVO);
		return "redirect:/product/detail/" + id;
	}
}
