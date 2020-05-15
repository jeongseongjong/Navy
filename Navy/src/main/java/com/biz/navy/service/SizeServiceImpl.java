package com.biz.navy.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.biz.navy.dao.SizeDao;
import com.biz.navy.domain.SizeVO;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequiredArgsConstructor
@Service
public class SizeServiceImpl implements SizeService {
	
	private final SizeDao sizeDao;
	
	@Override
	public List<SizeVO> selectAll() {
		return sizeDao.selectAll();
	}

	@Override
	public SizeVO findByCPcode(long c_p_code) {
		return sizeDao.findByCPcode(c_p_code);
	}

}
