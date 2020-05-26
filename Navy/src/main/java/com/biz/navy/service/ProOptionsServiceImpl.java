package com.biz.navy.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.biz.navy.dao.ProOptionsDao;
import com.biz.navy.domain.ProOptionsVO;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Service
public class ProOptionsServiceImpl implements ProOptionsService {
	
	private final ProOptionsDao optionsDao;

	@Override
	public List<ProOptionsVO> getSizeList() {
		// TODO Auto-generated method stub
		return optionsDao.getSizeList();
	}

	@Override
	public List<ProOptionsVO> getColorList() {
		// TODO Auto-generated method stub
		return optionsDao.getColorList();
	}

}
