package com.biz.navy.service;

import java.util.List;

import com.biz.navy.domain.ColorVO;

public interface ColorService {

	public List<ColorVO> selectAll();
	
	public ColorVO findByCPcode(long c_s_code);

}
