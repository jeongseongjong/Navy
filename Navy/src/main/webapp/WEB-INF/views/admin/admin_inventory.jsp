<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/include-head.jspf" %>
<c:set var="num" value="${pageVO.totalCount - ((pageVO.currentPageNo-1) * 10) }"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>
$(function(){
	// 재고에서 표 클릭하면
	$(document).on("click","tr.tr_stock",function(){
		let p_code = $(this).data("proid")
		document.location.href="${rootPath}/admin/pro_detail_view/"+p_code
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
            <div class="row bg-light">
              <div class="col-12 py-4 text-center">
                <span style="font-size: 30px;">재고관리</span>
              </div>
            </div>
			<form>
				<input type="search" 
				class="bbs-search" 
				name="search" 
				value="${search}" 
				placeholder="상품명을 입력 후 Enter...">
				<button class="bt-bbs-search">검색</button>
			</form>
            <div class="row bg-white">
              <div class="col-12 py-4">
                <table class="table" style="width: 100%;">
                  <thead>
                    <tr>
                      <th class="in-ck-box">NO</th>
                      <th class="in-ck-box">상품코드</th>
                      <th class="in-ck-box">상품이름</th>
                      <th class="in-ck-box">상품가격</th>
                      <th class="in-ck-box">상품사이즈</th>
                      <th class="in-ck-box">상품컬러</th>
                      <th class="in-ck-box">상품수량</th>
                      <th class="in-ck-box">상품총수량</th>
                      <th class="in-ck-box">상품총가격</th>
                    </tr>
                  </thead>
                  <tbody>
                  
                  	<c:choose>
						<c:when test="${empty STOCKLIST}">
							<tr>
								<td colspan="9">상품 정보 없음</td>
							</tr>
						</c:when>
						<c:otherwise>
	                    <c:forEach items="${STOCKLIST}" var="stock">
	                 		<tr class="tr_stock" data-proid="${stock.p_code}">
								<td>${num}</td>
		                   		<td class="in-ck-box td-click">${stock.p_code}</td>
		                   		<td class="in-ck-box td-click">${stock.p_name}</td>
		                   		<td class="in-ck-box td-click">${stock.p_price}</td>
		                   		<td class="in-ck-box td-click">${stock.s_size}</td>
		                   		<td class="in-ck-box td-click">${stock.c_color}</td>
		                   		<td class="in-ck-box td-click">${stock.c_qty}</td>
		                   		<td class="in-ck-box td-click">${stock.p_qty}</td>
			           			 <c:set var="total" value='0' />
			               		<c:set var="total"
			                 		 value="${total + stock.p_price * stock.c_qty}" />
		                   		<td class="in-ck-box td-click">${total}</td>
	                  		</tr>
							<c:set var="num" value="${num-1}"></c:set>
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
  