package com.biz.navy.service;

import java.util.List;

import com.biz.navy.domain.CsCommentVO;
import com.biz.navy.domain.CsVO;
import com.biz.navy.domain.PageVO;

public interface CsService {

	public List<CsVO> selectAll();
	
	public CsVO findById(long cs_id);
	
	public int insert(CsVO csVO);
	public int update(CsVO csVO);
	public int delete(long cs_id);

	public List<CsVO> findBySearchName(String search, PageVO pageVO);

	public long totalCount(String search);

	public int insertComment(CsCommentVO csCommentVO, String username);

	public List<CsCommentVO> findCommentByBId(long cs_id);

	public int deleteComment(long cid);
	
}
