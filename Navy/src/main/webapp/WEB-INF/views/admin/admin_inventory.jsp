<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/include-head.jspf" %>
            <div class="row bg-light">
              <div class="col-12 py-4 text-center">
                <span style="font-size: 30px;">재고관리</span>
              </div>
            </div>
            <div class="row bg-white">
              <div class="col-12 py-4">
                <table class="table" style="width: 100%;">
                  <thead>
                    <tr>
                      <th class="in-ck-box">NO</th>
                      <th class="in-ck-box">상품코드</th>
                      <th class="in-ck-box">상품이름</th>
                      <th class="in-ck-box">상품가격</th>
                      <th class="in-ck-box">상품컬러</th>
                      <th class="in-ck-box">상품사이즈</th>
                      <th class="in-ck-box">상품수량</th>
                      <th class="in-ck-box">상품총수량</th>
                      <th class="in-ck-box">상품총가격</th>
                    </tr>
                  </thead>
                  <tbody>
                    <c:forEach items="${PROLIST}" var="pro" >
                   		<c:forEach items="${pro.sizeList}" var="size" varStatus="i">
							<c:if test="${!empty size.colorList}">
								<c:forEach items="${size.colorList}" var="color">
									<tr class="tr_stock" data-proid="${pro.p_code}">
										<td class="in-ck-box td-click">${i.count}</td>
			                    		<td class="in-ck-box td-click">${pro.p_code}</td>
			                    		<td class="in-ck-box td-click">${pro.p_name}</td>
			                    		<td class="in-ck-box td-click">${pro.p_price}</td>
			                    		<td class="in-ck-box td-click">${color.c_color}</td>
			                    		<td class="in-ck-box td-click">${size.s_size}</td>
			                    		<td class="in-ck-box td-click">${color.c_qty}</td>
			                    		<td class="in-ck-box td-click">${pro.p_qty}</td>
			                    		<td class="in-ck-box td-click">총 가격은 얼마</td>
	                    			</tr>
								</c:forEach>
							</c:if>
						</c:forEach>
                    </c:forEach>
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

  