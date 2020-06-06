package com.biz.navy.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.biz.navy.dao.ReviewDao;
import com.biz.navy.domain.ReviewVO;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequiredArgsConstructor
@Service
public class ReviewServiceImpl implements ReviewService {
	
	private final ReviewDao reviewDao;
	
	@Override
	public int insert(ReviewVO reviewVO) {
		return reviewDao.insert(reviewVO);
	}

	@Override
	public List<ReviewVO> selectAll() {
		// TODO Auto-generated method stub
		return reviewDao.selectAll();
	}

	@Override
	public String update() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public String delete() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public String findByPId() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public ReviewVO findByRId(long r_id) {
		// TODO Auto-generated method stub
		return reviewDao.findByRId(r_id);
	}

	@Override
	public ReviewVO findByRPcode(long r_code) {
		// TODO Auto-generated method stub
		return reviewDao.findByRPcode(r_code);
	}

	@Override
	public List<ReviewVO> findByUserId(String username) {
		// TODO Auto-generated method stub
		return reviewDao.findByUserId(username);
	}


}
