package com.biz.navy.controller;

import java.security.Principal;
import java.util.List;

import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.biz.navy.domain.CsCommentVO;
import com.biz.navy.domain.CsVO;
import com.biz.navy.domain.PageVO;
import com.biz.navy.domain.UserDetailsVO;
import com.biz.navy.service.CsService;
import com.biz.navy.service.PageService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping(value="/cs")
@RequiredArgsConstructor
public class CsController {

	private final CsService csService;
	private final PageService pageService;
	
	
	@RequestMapping(value = "/list",method=RequestMethod.GET)
	public String list(Model model,
			@RequestParam(value="search", required = false, defaultValue = "") String search,
			@RequestParam(value="currentPageNo", required = false, defaultValue = "1") int currentPageNo
			) {
		
		long totalCount = csService.totalCount(search);
//		long totalCount = 30;
		PageVO pageVO = pageService.getPagination(totalCount, currentPageNo);
		
//		List<CsVO> csList = csService.selectAll(); 
		List<CsVO> csList = csService.findBySearchName(search, pageVO);
		
		model.addAttribute("pageVO",pageVO);
		
		model.addAttribute("CSLIST",csList);
		model.addAttribute("controller","cs");
		model.addAttribute("url","list");
		model.addAttribute("search",search);
		
		return "cs_list";
	}
	
	@RequestMapping(value="/insert",method=RequestMethod.GET)
	public String insert(Principal principal , Model model) {
		
		UsernamePasswordAuthenticationToken upa = (UsernamePasswordAuthenticationToken) principal;
		
		UserDetailsVO userVO = (UserDetailsVO)upa.getPrincipal();
		log.debug("유저 이름 확인용"+userVO);
		CsVO csVO = new CsVO();
		csVO.setCs_username(userVO.getUsername());
		
		model.addAttribute("csVO",csVO);
		
		return "cs_insert";
	}

	@RequestMapping(value="/insert",method=RequestMethod.POST)
	public String insertPost(CsVO csVO, Model model) {
		log.debug("아이디 넘어오는지:"+csVO.getCs_username());
		int ret = csService.insert(csVO);
		return "redirect:/cs/list";
	}
	
	@RequestMapping(value="/detail/{cs_id}",method=RequestMethod.GET)
	public String detail(@PathVariable("cs_id")long cs_id,Model model) {
		
		CsVO csVO = csService.findById(cs_id);
		
		List<CsCommentVO> commentList = csService.findCommentByBId(cs_id);
		int listSize = commentList.size();
		
		model.addAttribute("CSVO",csVO);
		model.addAttribute("COMMENTLIST",commentList);
		model.addAttribute("LISTSIZE",listSize);
		
		return "cs_detail";
	}
	
	@RequestMapping(value="/delete/{cs_id}",method=RequestMethod.GET)
	public String delete(@PathVariable("cs_id")long cs_id) {
		int ret = csService.delete(cs_id);
		return "redirect:/cs/list";
	}
	
	// 댓글 입력 메서드
	@RequestMapping(value="/comment",method=RequestMethod.POST)
	public String comment(Principal principal, CsCommentVO csCommentVO, Model model) {
		
		UsernamePasswordAuthenticationToken upa = (UsernamePasswordAuthenticationToken) principal;
		
		UserDetailsVO userVO = (UserDetailsVO)upa.getPrincipal();
		String username = userVO.getUsername();
		
		log.debug("댓글 : "+csCommentVO);
		int ret = csService.insertComment(csCommentVO,username);
		
		return "redirect:/cs/detail/" + csCommentVO.getCs_c_b_id();
	}
	
	// 댓글 삭제 메서드
	@RequestMapping(value="/comment/delete",method=RequestMethod.GET)
	public String cmtDelete(@RequestParam("c_id") long c_id, @RequestParam("b_id") long b_id) {
		int ret = csService.deleteComment(c_id);
		return "redirect:/cs/detail/" + b_id;
	}
	
	// 대댓글
	
	@RequestMapping(value = "/comment/repl",method=RequestMethod.GET)
	public String commentRepl(CsCommentVO csCommentVO, Model model) {
		log.debug("모달창 띄우는데 필요한 VO : "+csCommentVO);
		model.addAttribute("REPLCOMMENT",csCommentVO);
		return "cs_comment_insert";
	}
	@RequestMapping(value = "/comment/repl",method=RequestMethod.POST)
	public String commentRepl(Principal principal, CsCommentVO csCommentVO,Model model) {
		log.debug("댓글 왔나 : "+csCommentVO);
		UsernamePasswordAuthenticationToken upa = (UsernamePasswordAuthenticationToken) principal;
		
		UserDetailsVO userVO = (UserDetailsVO)upa.getPrincipal();
		String username = userVO.getUsername();
		
		int ret = csService.insertComment(csCommentVO, username);
		
		return "redirect:/cs/detail/" + csCommentVO.getCs_c_b_id();
	}
	
}
