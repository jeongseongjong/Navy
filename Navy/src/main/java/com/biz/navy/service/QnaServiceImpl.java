package com.biz.navy.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.biz.navy.dao.QnaDao;
import com.biz.navy.domain.QnaVO;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Service
public class QnaServiceImpl implements QnaService {
	
	private final QnaDao qnaDao;

	@Override
	public int insert(QnaVO qnaVO) {
		// TODO Auto-generated method stub
		return qnaDao.insert(qnaVO);
	}

	@Override
	public List<QnaVO> selectAll() {
		// TODO Auto-generated method stub
		return qnaDao.selectAll();
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
	public QnaVO findByQId(long q_id) {
		// TODO Auto-generated method stub
		return qnaDao.findByQId(q_id);
	}

	@Override
	public QnaVO findByQPcode(long q_code) {
		// TODO Auto-generated method stub
		return qnaDao.findByQPcode(q_code);
	}

	@Override
	public List<QnaVO> findByUserId(String username) {
		// TODO Auto-generated method stub
		return qnaDao.findByUserId(username);
	}

}
