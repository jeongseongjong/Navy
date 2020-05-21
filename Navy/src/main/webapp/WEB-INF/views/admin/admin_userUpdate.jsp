<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ include file="/WEB-INF/views/include/include-head.jspf"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
</head>
<body>
	<!--page include-->
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
						<span>회원 코드 : 1</span> <span class="ml-5">유저 아이디 : ${userVO.username}</span>
						<hr />
						<form:form class="container" modelAttribute="userVO">
							<div class="form-group row">
								<label for="staticName" class="col-sm-2 col-form-label">이름</label>
								<div class="col-sm-10">
									<input type="text" class="form-control-plaintext"
										id="staticName" placeholder="이름을 입력하세요"
										value="이름이 있으면 이름이 나오겠죠" />
								</div>
								<label for="phone" class="col-sm-2 col-form-label">전화번호</label>
								<div class="col-sm-10">
									<form:input type="tel" class="form-control-plaintext"
										path="phone" placeholder="전화번호를 입력해주세요"
										value="${userVO.phone}" />
								</div>
								<label for="address" class="col-sm-2 col-form-label">주소</label>
								<div class="col-sm-10">
									<form:input type="text" class="form-control-plaintext"
										path="address" placeholder="주소를 입력하세요"
										value="${userVO.address}" />
								</div>
								<label for="email" class="col-sm-2 col-form-label">이메일</label>
								<div class="col-sm-10">
									<form:input type="email" class="form-control-plaintext"
										path="email" placeholder="이메일을 입력하세요"
										value="${userVO.email}" />
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
											<p>
												현재 권한
												<c:forEach items="${userVO.authorities}" var="auth"
													varStatus="index">
													<div class="input-group mb-3">
														<input name="auth" value="${auth.authority}"
															class="auth form-control-plaintext" placeholder="권한">
														<div class="input-group-append">
															<button class="btn btn-danger btn-delete" type="button"
																data-id="${auth.id}" data-username="${auth.username}">&times</button>
														</div>
													</div>
												</c:forEach>
										</c:if>
									</div>
								</div>
							</div>
						<div class="d-flex justify-content-end mb-5">
							<button type="button" class="mr-2 bt-bbs-style bt-bbs-list ad-us-list">
								목록</button>
							<!-- 회원일시 보이는 버튼-->
							<button class="mr-2 bt-bbs-style bt-bbs-update">
								저장</button>
						</div>
						</form:form>
						<!--button group-->
						<!--button group end-->
						<!--container end-->
					</div>
					<h6>
						<b>권한 추가하기</b>
					</h6>
					<select id="auth" class="custom-select custom-select-sm"
						name="auth">
						<option value="ADMIN">ADMIN</option>
						<option value="ROLE_ADMIN">ROLE_ADMIN</option>
						<option value="USER">USER</option>
						<option value="ROLE_USER">ROLE_USER</option>
					</select>
				</div>
			</div>
		</div>

</body>
</html>