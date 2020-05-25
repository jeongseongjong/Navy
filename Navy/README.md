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