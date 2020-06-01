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
		
//		long totalCount = csService.totalCount(search);
		long totalCount = 30;
		PageVO pageVO = pageService.getPagination(totalCount, currentPageNo);
		
		List<CsVO> csList = csService.selectAll(); 
//		List<CsVO> csList = csService.findBySearchName(search, pageVO);
		
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
	public String Detail(@PathVariable("cs_id")long cs_id,Model model) {
		
		CsVO csVO = csService.findById(cs_id);
		
		model.addAttribute("CSVO",csVO);
		
		return "cs_detail";
	}
	
	@RequestMapping(value="/delete/{cs_id}",method=RequestMethod.GET)
	public String Delete(@PathVariable("cs_id")long cs_id) {
		int ret = csService.delete(cs_id);
		return "redirect:/cs/list";
	}
}
