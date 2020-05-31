<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/include-head.jspf" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<!--page include-->
            <div class="row bg-light">
              <div class="col-12 py-4 text-center">
                <span style="font-size: 30px;">회원관리</span>
              </div>
            </div>
            <div class="row bg-white">
              <div class="col-12 py-4">
                <table class="table">
                  <thead>
                    <tr>
                      <th class="in-ck-box">SEQ</th>
                      <th class="in-ck-box">USER.ID</th>
                      <th class="in-ck-box">AUTHORITY</th>
                      <th class="in-ck-box">Account suspension</th>
                      <th class="in-ck-box">Withdrawal</th>
                    </tr>
                  </thead>
                  <tbody>
                  <c:choose>
					<c:when test="${empty userList}">
						<tr><td colspan="5">User 정보 없음</td></tr>
					</c:when>
					<c:otherwise>
						<c:forEach items="${userList}" var="user" varStatus="i">
							<tr data-id="${user.username}" class="tr_user">
								<td class="in-ck-box td-click">${i.count}</td>
								<td class="in-ck-box td-click">${user.username}</td>
								<c:forEach items="${user.authorities}" var="auth">
									<c:if test="${auth.authority == 'ROLE_ADMIN' }">
										<td class="in-ck-box td-click">관리자</td>
									</c:if>
									<c:if test="${auth.authority == 'ROLE_USER' }">
										<td class="in-ck-box td-click">회원</td>
									</c:if>
								</c:forEach>
								<td class="in-ck-box td-click">${user.enabled}
									<!-- <input type="checkbox" value="${user.enabled}" > -->
								</td>
								<td class="in-ck-box td-click">${user.checkout}
									<!-- <input type="checkbox" value="${user.checkout}" > -->
								</td>
							</tr>
						</c:forEach>
					</c:otherwise>
				   </c:choose>
                  </tbody>
                </table>

                <!--pagination-->
                <div class="d-flex justify-content-center">
                  <nav aria-label="Page navigation example">
                    <ul class="pagination">
                      <li class="page-item">
                        <a
                          class="page-link black-text"
                          href="#"
                          aria-label="Previous"
                        >
                          <span aria-hidden="true" class="black-text"
                            >&laquo;</span
                          >
                          <span class="sr-only">Previous</span>
                        </a>
                      </li>
                      <li class="page-item black-text">
                        <a class="page-link black-text" href="#">1</a>
                      </li>
                      <li class="page-item black-text">
                        <a class="page-link black-text" href="#">2</a>
                      </li>
                      <li class="page-item black-text">
                        <a class="page-link black-text" href="#">3</a>
                      </li>
                      <li class="page-item black-text">
                        <a
                          class="page-link black-text"
                          href="#"
                          aria-label="Next"
                        >
                          <span aria-hidden="true" class="black-text"
                            >&raquo;</span
                          >
                          <span class="sr-only black-text">Next</span>
                        </a>
                      </li>
                    </ul>
                  </nav>
                </div>
                <!--pagination end-->
              </div>
            </div>
</body>
</html>