<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/include-head.jspf" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
            <div class="row bg-light">
              <div class="col-12 py-4 text-center">
                <span style="font-size: 30px;">주문관리</span>
              </div>
            </div>
            <div class="row bg-white">
              <div class="col-12 py-4">
                <table class="table" style="width: 100%;">
                  <thead>
                    <tr>
                      <th class="in-ck-box">NO</th>
                      <th class="in-ck-box">회원ID</th>
                      <th class="in-ck-box">회원주소</th>
                      <th class="in-ck-box">상품이름</th>
                      <th class="in-ck-box">상품가격</th>
                      <th class="in-ck-box">상품수량</th>
                      <th class="in-ck-box">상품총가격</th>
                      <th class="in-ck-box">주문일자</th>
                      <th class="in-ck-box">주문현황</th>
                    </tr>
                  </thead>
                  <tbody>
                  	<c:choose>
                  		<c:when test="${empty CARTLIST}">
                  			<td class="in-ck-box td-click" colspan="9">주문정보가 없습니다.</td>
                  		</c:when>
                  		<c:otherwise>
		                  	<c:forEach items="${CARTLIST}" var="cart" varStatus="i">
		                  		<tr>
		                  			<td class="in-ck-box td-click">${i.count}</td>
		                  			<td class="in-ck-box td-click">${cart.username}</td>
		                  			<td class="in-ck-box td-click">주소</td>
		                  			<td class="in-ck-box td-click">${cart.bk_p_name}</td>
		                  			<td class="in-ck-box td-click">${cart.bk_p_oprice}</td>
		                  			<td class="in-ck-box td-click">${cart.bk_p_qty}</td>
		                  			<td class="in-ck-box td-click">총가격</td>
		                  			<td class="in-ck-box td-click">${cart.bk_p_buyTime}</td>
		                  			<td class="in-ck-box td-click">${cart.bk_p_status}</td>
		                  		</tr>
		                  	</c:forEach>
                  		</c:otherwise>
                  	</c:choose>
                  </tbody>
                </table>

                <!--pagination-->
					<%@ include file="/WEB-INF/views/include/include-paging.jspf" %>
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