package com.biz.navy.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Service;

import com.biz.navy.dao.ProductDao;
import com.biz.navy.domain.ColorVO;
import com.biz.navy.domain.ProSizeColorVO;
import com.biz.navy.domain.ProductVO;
import com.biz.navy.domain.SizeVO;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequiredArgsConstructor
@Service
public class ProductServiceImpl implements ProductService {
	
	private final ProductDao proDao;
	
	@Override

	public int insert(ProductVO productVO) {
		return proDao.insert(productVO);
	}
	// 상품 사이즈, 컬러, 수량 포함해서 insert 수행
	@Override
	public int insert(ProductVO productVO, String[] size, String[] color, int[] qty) {
		
		//가장 큰 PCODE값 가져오기
		int maxPCode = proDao.findByMaxPCode();
		log.debug("PCODE 최대값:" + maxPCode);
		// 가장 큰 SCODE값 가져오기
		int maxSCode = proDao.findByMaxSizeCode();
		
		int maxSizeCode = maxSCode + 1;
		// PCODE + 1
		maxPCode++;
		
		for(String s : size) {
			log.debug("서비스 상품등록 사이즈 값 : " + s);
		}
		for(String c : color) {
			log.debug("서비스 상품등록 사이즈 값 : " + c);
		}
		for(int q : qty) {
			log.debug("서비스 상품등록 사이즈 값 : " + q);
		}
		ProSizeColorVO pscVO = new ProSizeColorVO();
		int intSize = size.length;
		// DB 상품 테이블에 데이터 추가
		int ret = proDao.insert(productVO);
		
		/* 사이즈 테이블에 값 추가하기*/
		// 상품테이블 조회해서 PCODE 값 가져온 후 사이즈 테이블에 저장
		log.debug("상품은 저장 완료");
		List<SizeVO> sizeList = new ArrayList<>();
		for(int i = 0 ; i < intSize; i ++) {
			SizeVO sizeVO = new SizeVO();
			log.debug("인트사이즈 : "+intSize);
			// 테스트를 위해 CODE 부여
			// 완료되면 위에줄 없애기
			sizeVO.setS_p_code(maxPCode);
			sizeVO.setS_size(size[i]);
			
			if(i>0) {
				if(size[i].equals(size[i-1])) {
					sizeVO.setS_code(maxSizeCode);
				} else {
					sizeVO.setS_code(++maxSCode);
				}
			} else {
				sizeVO.setS_code(++maxSCode);
			}
			
			log.debug("사이즈VO"+sizeVO.toString());
			sizeList.add(sizeVO);
		}
		for(SizeVO s : sizeList) {
			log.debug("사이즈리스트 값 : "+s);
		}
		// DB 사이즈 테이블에 데이터 추가
		proDao.insertWithSize(sizeList);
//////////////////////////////////////////////////////////////////////////
		// DB 컬러 테이블에 데이터 추가 
		/* 사이즈 테이블에 값 입력 완료 */
		
		// DB 컬러 테이블에 데이터 추가할 차례
		
		// 이미 입력된 사이즈 테이블에서 가장 큰 값 가져오기
//		int maxSCode = proDao.findByMaxSizeCode();
		int maxSCodeRepeat = maxSCode + 1;
		log.debug("사이즈 최대 코드값 확인 : "+maxSCode);
		List<ColorVO> colorList = new ArrayList<>();
		
		for(int i = 0 ; i < intSize; i++) {
		ColorVO colorVO = new ColorVO();
		
		colorVO.setC_color(color[i]);
		colorVO.setC_qty(qty[i]);
		
		if(i>0) {
		if(size[i].equals(size[i-1])) {
		colorVO.setC_s_code(maxSCodeRepeat);
		} else {
		++maxSCode;
		colorVO.setC_s_code(maxSCode);
		}
		
		} else {
		++maxSCode;
		colorVO.setC_s_code(maxSCode);
		}
		log.debug("컬러VO : " + colorVO.toString());
		colorList.add(colorVO);
		log.debug("컬러리스트 "+ i +" 번째 값 : " + colorList.get(i).toString());
		
		}
		for(ColorVO co : colorList) {
		log.debug("컬러리스트 값 추출 : "+co.toString());
		}
		proDao.insertWithColor(colorList);
//////////////////////////////////////////////////////////////////
		return ret;
//		return 0;
	}

	@Override
	public int update(ProductVO productVO) {
		return proDao.update(productVO);
	}

	@Override
	public int delete(long p_code) {
		// TODO Auto-generated method stub
		return proDao.delete(p_code);
	}

	@Override
	public List<ProductVO> selectAll() {
		return proDao.selectAll();
	}

	@Override
	public ProductVO findById(long p_code) {
		return proDao.findById(p_code);
	}

	private void insertWithColor(String[] size, String[] color, int[] qty) {
		/* 사이즈 테이블에 값 입력 완료 */
		
		// DB 컬러 테이블에 데이터 추가할 차례
		
		// 이미 입력된 사이즈 테이블에서 가장 큰 값 가져오기
		int maxSCode = proDao.findByMaxSizeCode();
		int maxSCodeRepeat = maxSCode + 1;
		log.debug("사이즈 최대 코드값 확인 : "+maxSCode);
		List<ColorVO> colorList = new ArrayList<>();
		
		int intSize = size.length;
		
		for(int i = 0 ; i < intSize; i++) {
		ColorVO colorVO = new ColorVO();
		
		colorVO.setC_color(color[i]);
		colorVO.setC_qty(qty[i]);
		
		if(i>0) {
		if(size[i].equals(size[i-1])) {
		colorVO.setC_s_code(maxSCodeRepeat);
		} else {
		++maxSCode;
		colorVO.setC_s_code(maxSCode);
		}
		
		} else {
		++maxSCode;
		colorVO.setC_s_code(maxSCode);
		}
		log.debug("컬러VO : " + colorVO.toString());
		colorList.add(colorVO);
		log.debug("컬러리스트 "+ i +" 번째 값 : " + colorList.get(i).toString());
		
		}
		for(ColorVO co : colorList) {
		log.debug("컬러리스트 값 추출 : "+co.toString());
		}
		proDao.insertWithColor(colorList);
	}


}
