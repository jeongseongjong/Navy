package com.biz.navy.service;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import org.springframework.stereotype.Service;

import com.biz.navy.dao.CsDao;
import com.biz.navy.domain.CsCommentVO;
import com.biz.navy.domain.CsVO;
import com.biz.navy.domain.PageVO;
import com.biz.navy.utils.DateTime;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Service
public class CsServiceImpl implements CsService{

	private final CsDao csDao;
	
	@Override
	public List<CsVO> selectAll() {
		return csDao.selectAll();
	}

	@Override
	public CsVO findById(long cs_id) {
		
		// 조회하면 조회수 +1 
		CsVO csVO = csDao.findById(cs_id);
		csVO.setCs_count(csVO.getCs_count()+1);
		csDao.update(csVO);
		
		return csDao.findById(cs_id);
	}

	@Override
	public int insert(CsVO csVO) {
		
		csVO.setCs_date(DateTime.Date());
		csVO.setCs_time(DateTime.Time());
		return csDao.insert(csVO);
	}

	@Override
	public int update(CsVO csVO) {
		return csDao.update(csVO);
	}

	@Override
	public int delete(long cs_id) {
		return csDao.delete(cs_id);
	}

	@Override
	public List<CsVO> findBySearchName(String search, PageVO pageVO) {
		
		List<String> searchList = Arrays.asList(search.split(" "));
		
		List<CsVO> csSearchList = new ArrayList<CsVO>();
		if(search != "") {
			csSearchList = csDao.findBySearchNameAndPaging(searchList,pageVO);
		} else {
			csSearchList = csDao.selectAllPaging(pageVO);
		}
		return csSearchList;
	}

	@Override
	public long totalCount(String search) {
		long ret = 0;
		if(search == "") {
			ret = csDao.countAll();
		} else {
			List<String> searchList = Arrays.asList(search.split(" "));
			// 검색 결과의 totalCount 구하기
			ret = csDao.countSearch(searchList);
		}
		return ret;
	}

	// 댓글 입력 메서드
	@Override
	public int insertComment(CsCommentVO csCommentVO, String username) {

		csCommentVO.setCs_c_writer(username);
		csCommentVO.setCs_c_date(DateTime.Date());
		csCommentVO.setCs_c_time(DateTime.Time());
		
		
		return csDao.insertComment(csCommentVO);
	}

	// 댓글 리스트로 뽑기
	@Override
	public List<CsCommentVO> findCommentByBId(long cs_id) {
		return csDao.findCommentByBId(cs_id);
	}

	// 댓글 삭제
	@Override
	public int deleteComment(long cid) {
		return csDao.deleteComment(cid);
	}

	
}
