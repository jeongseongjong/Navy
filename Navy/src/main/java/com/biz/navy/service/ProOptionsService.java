package com.biz.navy.service;

import java.util.List;

import com.biz.navy.domain.ProOptionsVO;

public interface ProOptionsService {
	
	public List<ProOptionsVO> getSizeList();
	public List<ProOptionsVO> getColorList();

}
