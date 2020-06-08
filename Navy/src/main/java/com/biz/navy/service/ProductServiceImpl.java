package com.biz.navy.service;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.biz.navy.dao.ProductDao;
import com.biz.navy.domain.ColorVO;
import com.biz.navy.domain.InventoryChangeVO;
import com.biz.navy.domain.InventoryVO;
import com.biz.navy.domain.PageVO;
import com.biz.navy.domain.ProSizeColorVO;
import com.biz.navy.domain.ProductImgVO;
import com.biz.navy.domain.ProductUpdateVO;
import com.biz.navy.domain.ProductVO;
import com.biz.navy.domain.SizeVO;
import com.biz.navy.utils.DateTime;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequiredArgsConstructor
@Service
public class ProductServiceImpl implements ProductService {

	private final ProductDao proDao;
	private final FileService fileService;

	@Override
	public int insert(ProductVO productVO) {
		return proDao.insert(productVO);
	}

	// 상품 사이즈, 컬러, 수량 포함해서 insert 수행
	@Override
//	public int insert(ProductVO productVO, String[] size, String[] color, int[] qty, MultipartFile file) {
	public int insert(ProductVO productVO, String[] size, String[] color, int[] qty,
			MultipartHttpServletRequest files) {

		// 가져온 사이즈 input 개수
		int intSize = 0;
		intSize = size.length;

		// 총 수량 담을 변수
		int p_qty = 0;

		// 가져온 값 정렬해서 DB에 넣기 위해 리스트에 담기
		List<ProSizeColorVO> proSCList = new ArrayList<>();
		for (int i = 0; i < intSize; i++) {
			ProSizeColorVO proSCVO = new ProSizeColorVO();
			proSCVO.setSize(size[i].toUpperCase());
			proSCVO.setColor(color[i].toUpperCase());
			proSCVO.setQty(qty[i]);

			proSCList.add(proSCVO);
			log.debug("proSCList에 담길 VO 값 : " + proSCVO.toString());
			log.debug("proSCList에 담긴 값 : " + proSCList.get(0).toString());

			// 수량 더하기
			p_qty += qty[i];
		}
		// 총 수량 VO에 담기
		productVO.setP_qty(p_qty);

		// 날짜, 시간 담기
		productVO.setP_date(DateTime.Date());
		productVO.setP_time(DateTime.Time());

		for (ProSizeColorVO p : proSCList) {
			log.debug("proSCList 정렬하기 전 값 : " + p.toString());
		}

		// jsp에서 input으로 넣어준 값 사이즈를 기준으로 정렬하기
		Comparator<ProSizeColorVO> comparaPSC = new Comparator<ProSizeColorVO>() {
			@Override
			public int compare(ProSizeColorVO o1, ProSizeColorVO o2) {
				return o1.getSize().compareTo(o2.getSize());
			}
		};

		for (ProSizeColorVO p : proSCList) {
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

		for (ProSizeColorVO p : proSCList) {
			log.debug("proSCList 정렬한 값 : " + p.toString());
		}

		// 가장 큰 PCODE값 가져오기
		int maxPCode = 0;
		int maxSCode = 0;
		try {
			maxPCode = proDao.findByMaxPCode();
			maxSCode = proDao.findByMaxSizeCode();
			
		} catch (Exception e) {
			// TODO: handle exception
		}
		log.debug("PCODE 최대값:" + maxPCode);
		// 가장 큰 SCODE값 가져오기


		// PCODE + 1
		maxPCode++;

		//////////////////////////////////////
		// 파일 이미지 업로드
		List<MultipartFile> fileList = files.getFiles("file");
		ProductImgVO proImgVO;

		// tbl_p_images테이블에 Insert 하기 위해 리스트 생성
		List<ProductImgVO> proImgList = new ArrayList<>();

		for (MultipartFile f : fileList) {
			f.getOriginalFilename();
			log.debug("파일 리스트 여러개 : " + f.getOriginalFilename());
			proImgVO = new ProductImgVO();
			proImgVO.setP_img_p_code(maxPCode);
			proImgVO.setP_img_origin_name(f.getOriginalFilename());

			// C드라이브 로컬에 파일을 저장하기 위한 코드
			String saveFilesName = fileService.file_up(f);
			// 파일을 저장한 이름 (UUID + 이름)을 set으로 저장해주기
			proImgVO.setP_img_upload_name(saveFilesName);

			proImgList.add(proImgVO);
		}

		// 파일 여러개 잘 담겼는지 확인
		// 로컬도 확인하고 로그도 확인하기
		for (ProductImgVO p : proImgList) {
			log.debug("파일 여러개 저장 : " + p);
		}

		// 잘 담겼으면 tbl_p_images테이블에 값 저장
		proDao.insertWithImages(proImgList);

		// 저장한 파일들 중 첫번째(대표이미지) 파일의 업로드 이름(UUID+파일이름)을
		// 대표이미지로 설정하기 위해 productVO의 p_image에 담앙주기
		productVO.setP_image(proImgList.get(0).getP_img_upload_name());
		/* 파일 이미지 업로드 끝 */
		////////////////////////////

		for (String s : size) {
			log.debug("서비스 상품등록 사이즈 값 : " + s);
		}
		for (String c : color) {
			log.debug("서비스 상품등록 사이즈 값 : " + c);
		}
		for (int q : qty) {
			log.debug("서비스 상품등록 사이즈 값 : " + q);
		}

		// 파일 업로드한 것 추가하기
//		String saveFileName = fileService.file_up(file);
//		log.debug("파일 저장경로 : "+file);
//		log.debug("저장한 파일 이름 : " + saveFileName);
//		productVO.setP_image(saveFileName);

		// DB 상품 테이블에 데이터 추가
		int ret = proDao.insert(productVO);

		/* 사이즈 테이블에 값 추가하기 */
		// 상품테이블 조회해서 PCODE 값 가져온 후 사이즈 테이블에 저장
		log.debug("상품은 저장 완료");
		List<SizeVO> sizeList = new ArrayList<>();
		List<ColorVO> colorList = new ArrayList<>();
		for (int i = 0; i < intSize; i++) {
			log.debug("인트사이즈 : " + intSize);
			SizeVO sizeVO = new SizeVO();
			ColorVO colorVO = new ColorVO();

			sizeVO.setS_p_code(maxPCode);

			colorVO.setC_color(proSCList.get(i).getColor());
			colorVO.setC_qty(proSCList.get(i).getQty());

			// 첫번째 이후 값(두번째 부터) DB에 넣기
			log.debug("최대 사이즈 코드 값 : " + maxSCode);
			if (i > 0) {
				if (proSCList.get(i).getSize().equals(proSCList.get(i - 1).getSize())) {
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

			log.debug("사이즈VO" + sizeVO.toString());
//			sizeList.add(sizeVO);
		}
		for (SizeVO s : sizeList) {
			log.debug("사이즈리스트 값 : " + s);
		}

		// 사이즈 중복 제거하기 위해 리스트 새로 생성
		List<SizeVO> sizeDeduplication = new ArrayList<SizeVO>();
		int intSizeList = sizeList.size();

		for (int i = 0; i < intSizeList; i++) {
			if (i > 0) {
				if (sizeList.get(i).getS_code() != sizeList.get(i - 1).getS_code()) {
					sizeDeduplication.add(sizeList.get(i));
				}
			} else {
				sizeDeduplication.add(sizeList.get(i));
			}
		}

		// 중복 없는지 확인
		for (SizeVO s : sizeDeduplication) {
			log.debug("사이즈 중복 없는지 : " + s.toString());
		}

		for (ColorVO s : colorList) {
			log.debug("컬러리스트 값 : " + s);
		}
		// DB 사이즈 테이블에 데이터 추가
		proDao.insertWithSize(sizeDeduplication);
		// DB 컬러 테이블에 데이터 추가
		proDao.insertWithColor(colorList);
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

	@Override
	public int imagesDelete(long img_seq) {
		return proDao.imagesDelete(img_seq);
	}

	@Override
	public List<ProductVO> selectAllPaging(PageVO pageVO) {
		return proDao.selectAllPaging(pageVO);
	}

	@Override
	public long totalCount(String search) {
		long ret = 0;
		if (search == "") {
			ret = proDao.countAll();
		} else {
			List<String> searchList = Arrays.asList(search.split(" "));
			// 검색 결과의 totalCount 구하기
			ret = proDao.countSearch(searchList);
		}
		return ret;
	}

	@Override
	public List<ProductVO> findBySearchName(String search, PageVO pageVO) {
		List<String> searchList = Arrays.asList(search.split(" "));

		List<ProductVO> proSearchList = new ArrayList<>();
		if (search != "") {
			proSearchList = proDao.findBySearchNameAndPaging(searchList, pageVO);
		} else {
			proSearchList = proDao.selectAllPaging(pageVO);
		}
		return proSearchList;
	}

	@Override
	public List<ColorVO> getColorListBySize(String s_code) {
		long longSCode = 0;
		try {
			longSCode = Long.valueOf(s_code);
		} catch (Exception e) {
			return null;
			// TODO: handle exception
		}
		List<ColorVO> proColorList = proDao.getColorListBySize(longSCode);
		// TODO Auto-generated method stub
		return proColorList;
	}

	@Override
	public List<SizeVO> getProSize(long s_p_code) {
		// TODO Auto-generated method stub
		return proDao.getProSize(s_p_code);
	}

	@Override
	public List<ColorVO> getProColor(long c_s_code) {
		// TODO Auto-generated method stub
		return proDao.getProColor(c_s_code);
	}

	@Override
	public List<ProductVO> findByBest() {
		// TODO Auto-generated method stub
		return proDao.findByBest();
	}

	@Override
	public List<ProductImgVO> getProImages(long p_img_p_code) {
		// TODO Auto-generated method stub
		return proDao.getProImages(p_img_p_code);
	}

  public long countColor(String search) {
		long ret = 0;
		if (search == "") {
			ret = proDao.countColorAll();
		} else {
			List<String> searchList = Arrays.asList(search.split(" "));
			// 검색 결과의 totalCount 구하기
			ret = proDao.countStockSearch(searchList);
		}
		return ret;
	}

	@Override
	public List<InventoryVO> findStockBySearchName(String search, PageVO pageVO) {
		List<String> searchList = Arrays.asList(search.split(" "));

		List<InventoryVO> proSearchList = new ArrayList<>();
		if (search != "") {
			proSearchList = proDao.findStockBySearchNameAndPaging(searchList, pageVO);
		} else {
			proSearchList = proDao.selectColorAll(pageVO);
		}
		return proSearchList;
	}

	// 대표이미지 변경 메서드
	@Override
	public int updateRepImg(String imgName, long p_code) {
		
		ProductVO proVO = findById(p_code);
		proVO.setP_image(imgName);
		return proDao.update(proVO);
	}

	// DB에 존재하는 재고(사이즈, 컬러)리스트 삭제하기 위한 메서드
	@Override
	public int existing_delete(long s_code, long c_code) {
		// TODO existing_delete
		int ret = proDao.existing_color_delete(c_code);
		// 컬러 테이블만 지워도 목록에는 안 뜨니
		// 사이즈 테이블은 안 지워도 괜찮다.
//				proDao.existing_size_delete(s_code);
		return ret;
	}

	// DB에 존재하는 재고 변경하기 위한 메서드
	@Override
	public int existing_update(ProductVO productVO, 
			String[] existing_color, 
			int[] existing_qty, 
			long[] existing_s_code, long[] existing_c_code) {
		// TODO existing_update
		ProductUpdateVO proUpdateVO ;
		List<ProductUpdateVO> proUpdateList = new ArrayList<>();
		int qty = 0;
		for(int i = 0 ; i < existing_color.length ; i ++) {
			proUpdateVO = new ProductUpdateVO();
			log.debug("사이즈 색상 수량 사이즈코드 컬러코드 : "
//					+ existing_size[i] + ", "
					+ existing_color[i] + ", "
					+ existing_qty[i] + ", "
					+ existing_s_code[i] + ", "
					+ existing_c_code[i]
					);
//			proUpdateVO.setS_size(existing_size[i]);
			proUpdateVO.setC_color(existing_color[i]);
			proUpdateVO.setC_qty(existing_qty[i]);
			proUpdateVO.setS_code(existing_s_code[i]);
			proUpdateVO.setC_code(existing_c_code[i]);
			qty += existing_qty[i];
			
			proUpdateList.add(proUpdateVO);
		}
		// 일단 컬러테이블의 컬러 칼럼과 수량 칼럼 교체
		int ret = 0;
		for(ProductUpdateVO p : proUpdateList) {
			ret = proDao.existing_update(p);
		}
		productVO.setP_qty(qty);
		proDao.update(productVO);
//		ret = proDao.existing_update(proUpdateList);
		return ret;
	}

	@Override
	public List<InventoryChangeVO> selectChanges() {
		// TODO selectChanges
		List<InventoryChangeVO> changeList = proDao.selectChanges();
		return changeList;
	}
}
