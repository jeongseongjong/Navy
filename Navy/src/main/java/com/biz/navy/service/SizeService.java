package com.biz.navy.service;

import java.util.List;

import com.biz.navy.domain.SizeVO;

public interface SizeService {

	public List<SizeVO> selectAll();
	
	public SizeVO findByCPcode(long c_p_code);

}
