<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ include file="/WEB-INF/views/include/include-head.jspf" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<!--page include-->
          <main class="col offset-2 h-100 user-main">
            <div class="row bg-light">
              <div class="col-12 py-4 text-center">
                <span style="font-size: 30px;">회원상세수정관리</span>
              </div>
            </div>
            <!--userdetail 정보-->
            <div class="row bg-white">
              <div class="col-12 py-4">
                <div class="card">
                  <div class="card-body">
                    <span>${userVO.id}</span>
                    <span class="ml-5">${userVO.username}</span>
                    <hr />
                    <form:form class="container" modelAttribute="userVO">
                      <div class="form-group row">
                        <label for="staticEmail" class="col-sm-2 col-form-label"
                          >이름</label
                        >
                        <div class="col-sm-10">
                          <form:input
                            type="text"
                            class="form-control-plaintext"
                            id="staticEmail"
                            path="username"
                            placeholder="이름을 입력하세요"
                          />
                        </div>
                        <label for="staticEmail" class="col-sm-2 col-form-label"
                          >전화번호</label
                        >
                        <div class="col-sm-10">
                          <form:input
                            type="tel"
                            class="form-control-plaintext"
                            id="staticEmail"
                            path="phone"
                            placeholder="전화번호를 입력해주세요"
                          />
                        </div>
                        <label for="staticEmail" class="col-sm-2 col-form-label"
                          >주소</label
                        >
                        <div class="col-sm-10">
                          <form:input
                            type="text"
                            class="form-control-plaintext"
                            id="staticEmail"
                            path="address"
                            placeholder="주소를 입력하세요"
                          />
                        </div>
                        <label for="staticEmail" class="col-sm-2 col-form-label"
                          >이메일</label
                        >
                        <div class="col-sm-10">
                          <form:input
                            type="email"
                            class="form-control-plaintext"
                            id="staticEmail"
                            path="email"
                            placeholder="이메일을 입력하세요"
                          />
                        </div>
                        <label for="enabled" class="col-sm-2 col-form-label"
                          >정지여부</label
                        >
                        <div class="col-sm-10">
                        	<form:checkbox 
                        	path="enabled" 
                            class="form-control-plaintext"
                          />
                        </div>
                        <label for="checkout" class="col-sm-2 col-form-label"
                          >탈퇴여부</label
                        >
                        <div class="col-sm-10">
                        	<form:checkbox 
                        	path="checkout" 
                            class="form-control-plaintext"
                          />
                        </div>
                        
						
                      </div>
                      <!--button group-->
	                    <div class="d-flex justify-content-end mb-5">
	                      <button type="button" class="mr-2 bt-bbs-style bt-bbs-list">
	                        목록
	                      </button>
	                      <!-- 회원일시 보이는 버튼-->
							<button type="button" class="mr-2 bt-bbs-style bt-bbs-update" id="btn_save" data-id="${userVO.username}">저장</button>
	                    </div>
	                    <!--button group end-->
                    </form:form>
                    	<h6><b>권한 추가하기</b></h6>
                        <select id="auth" class="custom-select custom-select-sm" name="auth">
							<option value="ADMIN">ADMIN</option>
							<option value="ROLE_ADMIN">ROLE_ADMIN</option>
							<option value="USER">USER</option>
							<option value="ROLE_USER">ROLE_USER</option>
						</select>
                    
                    <!--container end-->
                  </div>
                </div>
              </div>
            </div>
          </main>
          <!--page include-->
          <main class="col offset-2 h-100 user-main">
            <div class="row bg-light">
              <div class="col-12 py-4 text-center">
                <span style="font-size: 30px;">회원상세정보관리</span>
              </div>
            </div>
            <!--userdetail 정보-->
            <div class="row bg-white">
              <div class="col-12 py-4">
                <div class="card">
                  <div class="card-body">
                    <span>회원 코드 : ${userVO.id}</span>
                    <span class="ml-5">${userVO.username}</span>
                    <hr />
                    <table
                      style="
                        justify-content: center;
                        margin: 0 auto;
                        align-items: center;
                      "
                    >
                      <tr>
                        <th class="text-left">이름</th>
                        <td class="p-2">이정연</td>
                      </tr>
                      <tr>
                        <th class="text-left">전화번호</th>
                        <td class="p-2">${userVO.phone}</td>
                      </tr>
                      <tr>
                        <th class="text-left">주소</th>
                        <td class="p-2">${userVO.address}</td>
                      </tr>
                      <tr>
                        <th class="text-left">이메일</th>
                        <td class="p-2">
                          ${userVO.email}
                        </td>
                      </tr>
                      <tr>
                        <th class="text-left">정지여부</th>
                        <td class="p-2">
                        	<span>${userVO.enabled}</span>
                        </td>
                      </tr>
                      <tr>
                        <th class="text-left">탈퇴여부</th>
                        <td class="p-2">
                        	<span>${userVO.checkout}</span>
                        </td>
                      </tr>
                    </table>
                      <button type="button" class="mr-2 bt-bbs-style ad-us-list">
	                        목록
	                  </button>
                      <!-- 회원일시 보이는 버튼-->
                      <button
                        class="mr-2 bt-bbs-style ad-us-update"
                      >
                        수정
                      </button>
                      <button class="mr-2 bt-bbs-style">
                        삭제
                      </button>
                    <div class="d-flex justify-content-end mb-5">
                    </div>
                    <div id="auth_box">
							<!-- 
							<div align="right">
								<button type="button" class="btn btn-success mb-3" id="auth_append">권한
									정보 입력 추가</button>
							</div>
							 -->
								<div id="auth_list">
									<c:if test="${not empty userVO.authorities}">
										<p>현재 권한
										<c:forEach items="${userVO.authorities}" var="auth"
										varStatus="index">
										<div class="input-group mb-3">
										  <input name="auth" value="${auth.authority}" class="auth form-control-plaintext" placeholder="권한">
										  <div class="input-group-append">
										    <button class="btn btn-danger btn-delete" type="button" data-id="${auth.id}" data-username="${auth.username}">&times</button>
										  </div>
										</div>
										</c:forEach>
								</c:if>
							</div>
						</div>
                    <!-- review 정보 가져오기-->
                    <div class="container col mt-4">
                      <span>상품 구매 이력</span>
                      <div class="container" style="border: 1px solid #c6cad4;">
                        <p class="mr-5">
                          상품이름 : 금액 : 날짜
                        </p>
                        <small
                          onclick="$(document).on('click','small',function(){document.location.href='../shopDetail.html'})"
                        >
                          White pants : 15000 : 2020-05-13
                        </small>
                      </div>
                    </div>
                    <!--review 정보 box end-->
                    <!-- review 정보 가져오기-->
                    <div class="container col mt-4">
                      <span>댓글</span>
                      <div class="container" style="border: 1px solid #c6cad4;">
                        <p class="mr-5">
                          상품이름 : 리뷰내용 : 날짜
                        </p>
                        <small
                          onclick="$(document).on('click','small',function(){document.location.href='../shopDetail.html'})"
                        >
                          White pants : Lorem ipsum dolor sit amet, consectetur
                          adipiscing elit. : 2020-05-13
                        </small>
                      </div>
                    </div>
                    <!--review 정보 box end-->
                    <!--고객센터 게시판 글-->
                    <div class="container col mt-4">
                      <span>댓글</span>
                      <div class="container" style="border: 1px solid #c6cad4;">
                        <p class="mr-5">
                          게시판 제목 : 내용 : 날짜
                        </p>
                        <small
                          onclick="$(document).on('click','small',function(){document.location.href='../shopDetail.html'})"
                        >
                          White pants : Lorem ipsum dolor sit amet, consectetur
                          adipiscing elit. : 2020-05-13
                        </small>
                      </div>
                    </div>
                  </div>
                  <!--card body end-->
                </div>
              </div>
            </div>
            <!--userdetail 정보 end-->
          </main>
</body>
</html>