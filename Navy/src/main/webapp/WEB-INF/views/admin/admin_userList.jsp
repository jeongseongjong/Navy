<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/include-head.jspf" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<c:set var="num" value="${pageVO.totalCount - ((pageVO.currentPageNo-1) * 10) }"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>
	$(function(){
		// 유저 디테일 페이지 보이기
		$(document).on("click","tr.tr_user",function(){
			let username = $(this).data("id")
			
			document.location.href="${rootPath}/admin/user_detail_view/"+username
			/*
			$.get("${rootPath}/admin/user_detail_view/" + username,
					function(result){
				$("#admin_content").html(result)
			})
			*/
		})
	})
</script>
</head>
<body>
<%@ include file = "/WEB-INF/views/include/include-nav.jspf" %>
<article class="all-browsers">
      <div class="hr-sect">ADMIN</div>

      <div class="container">
        <!--sidebar-->
        <div class="row">
          <aside
            class="col-2 px-0"
            id="left"
            style="top: 250px; position: fixed; left: 0;"
          >
            <div class="list-group w-100">
				<%@ include file ="/WEB-INF/views/admin/admin-include-nav.jspf" %>
            </div>
          </aside>
			<main class="col offset-2 h-100 user-main" id="admin_content">
	<!--page include-->
            <div class="row bg-light">
              <div class="col-12 py-4 text-center">
                <span style="font-size: 30px;">회원관리</span>
              </div>
            </div>
            	<form>
					<input type="search" 
					class="bbs-search" 
					name="search" 
					value="${search}" 
					placeholder="ID를 입력 후 Enter...">
					<button class="bt-bbs-search">검색</button>
				</form>
            
            <div class="row bg-white">
              <div class="col-12 py-4">
                <table class="table">
                  <thead>
                    <tr>
                      <th class="in-ck-box">NO</th>
                      <th class="in-ck-box">회원ID</th>
                      <th class="in-ck-box">권한</th>
                      <th class="in-ck-box">권한유무</th>
                      <th class="in-ck-box">탈퇴유무</th>
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
								<td>${num}</td>
								<!-- 
								<td class="in-ck-box td-click">${i.count}</td>
								 -->
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
							<c:set var="num" value="${num-1}"></c:set>
						</c:forEach>
					</c:otherwise>
				   </c:choose>
                  </tbody>
                </table>
                

				
				
                <!--pagination-->
                <div class="d-flex justify-content-center">
                  <nav aria-label="Page navigation example">
                    <ul class="pagination">
                    	<c:if test="${pageVO.startPageNo > 1}">
                      <li class="page-item">
                        <a
                          class="page-link black-text"
                          href="${rootPath}/${controller}/${url}?currentPageNo=1"
                          aria-label="Previous"
                        >
                          <span aria-hidden="true" class="black-text"
                            >&laquo;</span
                          >
                          <span class="sr-only">Previous</span>
                        </a>
                      </li>
                      <li class="page-item">
                      	<a href="${rootPath}/${controller}/${url}?currentPageNo=${pageDTO.prePageNo}" 
                      		class="page-link black-text">&lt;</a>
                      	</li>
                      	</c:if>
                      	<c:forEach begin="${pageVO.startPageNo}" end="${pageVO.endPageNo}" var="pageNo">
                      		<li class="page-item <c:if test="${pageNo == pageDTO.currentPageNo}">active</c:if>">
                      		<a href="${rootPath}/${controller}/${url}?currentPageNo=${pageNo}" 
                      		class="page-link black-text">${pageNo}
                      		</a></li>
                      	</c:forEach>
                      <c:if test="${pageVO.endPageNo != pageVO.finalPageNo}">
                      
                      <li class="page-item">
                      	<a href="${rootPath}/${controller}/${url}?currentPageNo=${pageDTO.nextPageNo}" 
                      		class="page-link">&lt;</a>
                      	</li>
                      <li class="page-item black-text">
                        <a
                          class="page-link black-text"
                          href="${rootPath}/${controller}/${url}?currentPageNo=${pageVO.finalPageNo}"
                          aria-label="Next"
                        >
                          <span aria-hidden="true" class="black-text"
                            >&raquo;</span
                          >
                          <span class="sr-only black-text">Next</span>
                        </a>
                      </li>
                      </c:if>
                    </ul>
                  </nav>
                </div>
                <!--pagination end-->
              </div>
            </div>
			</main>
          
        </div>
      </div>
    </article>
</body>
<%@ include file = "/WEB-INF/views/include/include-footer.jspf" %>
</html>