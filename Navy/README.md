# NAVIYA 프로젝트
## 05-13
 * UI & UX 메인페이지 구현
 	> - 메인페이지 view UI를 생성
 	> - 메인페이지 vsCode -> jsp로 구현
 	> - 시큐리티를 활용한 회원가입, 로그인, 로그아웃, 마이페이지 구현(UI 안됨)

## 05-14
 * MyPage 회원 정보 수정
  > - 본인의 비밀번호 확인 후 비밀번호, 이메일 등 정보 수정가능
  > - 관리자의 회원 권한 수정(진행중)

## 05-15
 * user/join, user/login view 삭제(중복 사유)
 * tbl_authority의 au_id -> id로 변경
 
## 05-16
 * ProductController의 productList에서 model에 심어보내는 PROIMGLIST가 어디에 쓰이는가 ?
  > - 지워도 되는 문구였음
 
## 05-18
 * tbl_cart 칼럼 수정
  > - bk_p_username -> username으로 수정
 * cart list 출력
 * cart 각각 삭제 
 
## 05-19
 * 테이블 수정
  > - tbl_product pk 삭제 ( 하나의 상품에 여러개의 사이즈 데이터가 담겨야 하기때문)
  > - tbl_size pk 삭제 
  > - VO수정 하다가 말았다
  
## 05-23
 * cart->구매내역 데이터 값 가져오기 완료
  > - latest.min.js:4 오류나던거 수정완료 (jackson없어서 그런것)
  
## 05-24
 * 회원가입, 결재시 주소입력 필요
  > - 다음 주소 api 사용
  > - 회원가입시 주소 검색 후 insert 완료(DB 입력 완료)
 * 회원수정시 주소 api 사용
  > - 회원수정 주소 api 완료
  > - 수정후에 로그아웃 후에 메인가야됨(지금은 로그인 된채로 메인으로 감)
 * tbl_users 수정
  > - VO (address_etc 추가)

## 05-25
 * cart -> delivery로 이동시 구매날짜 적용
 * 장바구니 버튼 nav에 추가
 * tbl_cart의 bk_p_buyTime 칼럼 추가
 
## 05-26
 * buyer(구매자정보 jsp 생성)
 
## 05-28
 * 장바구니 UI 적용
  > - 장바구니 상품 qty update
  > - 체크항목 삭제 (전체상품) / 내일 단일상품 삭제 적용해야함
  > - 총 주문금액 합산
  > - 구매하기 버튼 클릭시 구매목록으로 이동
  
## 05-29
 * 배송 받는사람 칼럼 추가
  	> - private String bk_recipient_name; 			// 배송 받는사람 이름
	> - private String bk_recipient_phone; 			// 받는사람 연락처
	> - private String bk_recipient_address;		// 받는사람 주소
	> - private String bk_recipient_address_etc;	// 받는사람 상세주소
	> - private String bk_recipient_message;		// 배송요청사항
	
## 05-31
 * productDao의 findByMaxPCode 리턴타임 int - > Integer로 변환
  > - primitive 타입 오류
  
## 06-01
 * size/colorList 값 추가 수정
 * main, include-nav, include-footer UI 적용
 * main 추천List 적용(날짜/시간 -> 추천수 변경, UI 수정 필요)
 * size/color -> Dao, Service, ServiceImpl 각 삭제
 * productServiceImpl의 findByMaxPCode 널포인트 문제 -> try catch문으로 해결
 
## 06-02
 * include-menu 생성
 * 구매자 정보 입력 view 완료
 * 구매내역 view 추출 완료

## 06-03
 * userDetail 권한 보여주는 부분에 이메일 나오는 것 수정
 * 재고관리 페이지 페이징
 * pro-mapper에 selectCount 추가
 * productService에 countColor  메서드 생성
 * productService에 findStockBySearchName 메서드 생성

## 06-04
 * 재고관리 리스트, 페이징 하기 위해 pro-mapper에 selectColorAll 생성
  > - ProductDao에도 selectColorAll 생성
  > - 재고관리 리스트 담을 InventoryVO 생성
 * 재고관리 검색 추가
 * 고객센터 검색 추가
 * 고객센터 댓글 추가
  > - 테이블 tbl_cs_comment 추가
  > - 시퀀스 SEQ_CS_COMMENT 추가
 * 고객센터 댓글에 답글 추가
 
## 06-05
 * 관리자 상품 수정에서 대표이미지 설정
  > - admin_proupdate.jspf에 ajax 추가
  > - adminController에 representativeImage 메서드 추가
 * 관리자 대시보드 고객센터 글 조회
  > - 각 글마다 조회할 수 있게 링크 연결
 * 고객센터 글 대댓글 입력 창 모달로 생성
 * 유저 디테일 jsp 구매이력 댓글이력
  >- ReviewService에 findByUserId 메서드 추가
  >- QnaService에 findByUserId 메서드 추가
  >- CartService에 findByUserId 메서드 추가
 * include-paging 수정
 * pageService에 listperpage 변경

## 06-08
 * 상품 대표이미지 변경 기능 구현
 * 관리자 - 주문정보 페이지에서 페이징
 * 관리자 - 주문정보 페이지에 검색 추가
 * 상품 수정에서 기존(컬러 테이블에 있는) 색상, 수량 변경
 * ProductUpdateVO 생성
 * tbl_inventory_changes 테이블 생성(차트 그리기 시도)
 * InventoryChangeVO 생성
 
## 06-09
 * gson 추가
 * 관리자 - 메인에 매출액 그래표 구현
 
## 06-10
 * 관리자 - 상품 수정 CSS 적용, 이미지 업로드, 수량 변동내역 DB에 저장