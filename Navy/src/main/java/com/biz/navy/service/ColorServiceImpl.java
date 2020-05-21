package com.biz.navy.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.biz.navy.dao.ColorDao;
import com.biz.navy.domain.ColorVO;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Service
public class ColorServiceImpl implements ColorService {
	
	private final ColorDao colorDao;

	@Override
	public List<ColorVO> selectAll() {
		// TODO Auto-generated method stub
		return colorDao.selectAll();
	}

	@Override
	public ColorVO findByCPcode(long c_s_code) {
		// TODO Auto-generated method stub
		return colorDao.findByCPcode(c_s_code);
	}

}
