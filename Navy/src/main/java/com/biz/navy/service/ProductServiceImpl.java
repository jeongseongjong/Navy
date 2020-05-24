package com.biz.navy.service;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

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
		
		// 가져온 사이즈 input 개수
		int intSize = size.length;
		
		// 가져온 값 정렬해서 DB에 넣기 위해 리스트에 담기
		List<ProSizeColorVO> proSCList = new ArrayList<>();
		for(int i = 0 ; i < intSize; i ++) {
			ProSizeColorVO proSCVO = new ProSizeColorVO();
			proSCVO.setSize(size[i].toUpperCase());
			proSCVO.setColor(color[i].toUpperCase());
			proSCVO.setQty(qty[i]);
			
			proSCList.add(proSCVO);
			log.debug("proSCList에 담길 VO 값 : " + proSCVO.toString());
			log.debug("proSCList에 담긴 값 : " + proSCList.get(0).toString());
		}
		
		for(ProSizeColorVO p : proSCList) {
			log.debug("proSCList 정렬하기 전 값 : " + p.toString());
		}
		
		// jsp에서 input으로 넣어준 값 사이즈를 기준으로 정렬하기
		Comparator<ProSizeColorVO> comparaPSC = new Comparator<ProSizeColorVO>() {
			@Override
			public int compare(ProSizeColorVO o1, ProSizeColorVO o2) {
				return o1.getSize().compareTo(o2.getSize());
			}
		};
		
		for(ProSizeColorVO p : proSCList) {
			log.debug("proSCList 정렬 입력한 값 : " + p.toString());
		}
		
		Collections.sort(proSCList, comparaPSC);
		// -------------- 정렬하기 끝 -----------------------
//		Collections.sort(proSCList, new Comparator<ProSizeColorVO>() {
//			@Override
//			public int compare(ProSizeColorVO o1, ProSizeColorVO o2) {
//				return o1.getSize().compareTo(o2.getSize());
//			}
//		});
		
		for(ProSizeColorVO p : proSCList) {
			log.debug("proSCList 정렬한 값 : " + p.toString());
		}
		
		//가장 큰 PCODE값 가져오기
		int maxPCode = proDao.findByMaxPCode();
		log.debug("PCODE 최대값:" + maxPCode);
		// 가장 큰 SCODE값 가져오기
		int maxSCode = proDao.findByMaxSizeCode();
		
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
		// DB 상품 테이블에 데이터 추가
		int ret = proDao.insert(productVO);
		
		/* 사이즈 테이블에 값 추가하기*/
		// 상품테이블 조회해서 PCODE 값 가져온 후 사이즈 테이블에 저장
		log.debug("상품은 저장 완료");
		List<SizeVO> sizeList = new ArrayList<>();
		List<ColorVO> colorList = new ArrayList<>();
		for(int i = 0 ; i < intSize; i ++) {
			log.debug("인트사이즈 : "+intSize);
			SizeVO sizeVO = new SizeVO();
			ColorVO colorVO = new ColorVO();
			
			sizeVO.setS_p_code(maxPCode);
			
			colorVO.setC_color(proSCList.get(i).getColor());
			colorVO.setC_qty(proSCList.get(i).getQty());
			
			// 첫번째 이후 값(두번째 부터) DB에 넣기
			log.debug("최대 사이즈 코드 값 : "+maxSCode);
			if(i > 0) {
				if(proSCList.get(i).getSize().equals(proSCList.get(i-1).getSize())) {
					sizeVO.setS_code(maxSCode);
					sizeVO.setS_size(proSCList.get(i).getSize());
					sizeList.add(sizeVO);
					
					colorVO.setC_s_code(maxSCode);
					colorList.add(colorVO);
				} else {
					sizeVO.setS_code(++maxSCode);
					sizeVO.setS_size(proSCList.get(i).getSize());
					sizeList.add(sizeVO);
					
					colorVO.setC_s_code(maxSCode);
					colorList.add(colorVO);
				}
			// 첫번째 값 넣기
			} else {
				sizeVO.setS_code(++maxSCode);
				sizeVO.setS_size(proSCList.get(i).getSize());
				sizeList.add(sizeVO);
				
				colorVO.setC_s_code(maxSCode);
				colorList.add(colorVO);
			}
			
			log.debug("사이즈VO"+sizeVO.toString());
//			sizeList.add(sizeVO);
		}
		for(SizeVO s : sizeList) {
			log.debug("사이즈리스트 값 : "+s);
		}
		
		// 사이즈 중복 제거하기 위해 리스트 새로 생성
		List<SizeVO> sizeDeduplication = new ArrayList<SizeVO>();
		int intSizeList= sizeList.size();
			
		for(int i = 0 ; i < intSizeList; i ++) {
			if(i > 0) {
				if(sizeList.get(i).getS_code() != sizeList.get(i-1).getS_code()) {
					sizeDeduplication.add(sizeList.get(i));
				}
			} else {
				sizeDeduplication.add(sizeList.get(i));
			}
		}
		
		// 중복 없는지 확인
		for(SizeVO s : sizeDeduplication) {
			log.debug("사이즈 중복 없는지 : " + s.toString());
		}

		for(ColorVO s : colorList) {
			log.debug("컬러리스트 값 : "+s);
		}
		// DB 사이즈 테이블에 데이터 추가
		proDao.insertWithSize(sizeDeduplication);
		// DB 컬러 테이블에 데이터 추가
		proDao.insertWithColor(colorList);
		return ret;
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

}
