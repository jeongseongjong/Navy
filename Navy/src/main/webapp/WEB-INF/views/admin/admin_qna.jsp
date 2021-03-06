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
                                <span style="font-size: 30px;">Q&A관리</span>
                            </div>
                        </div>
                        <div class="row bg-white">
                            <div class="col-12 py-4">
                                <table class="table" style="width: 100%;">
                                    <thead>
                                        <tr>
                                            <th class="in-ck-box">NO</th>
                                            <th class="in-ck-box">회원ID</th>
                                            <th class="in-ck-box">상품코드</th>
                                            <th class="in-ck-box">상품이름</th>
                                            <th class="in-ck-box">댓글내용</th>
                                            <th class="in-ck-box">피드백유무</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <td class="in-ck-box td-click">1</td>
                                            <td class="in-ck-box td-click">qussoa</td>
                                            <td class="in-ck-box td-click">000001</td>
                                            <td class="in-ck-box td-click">Whtie pants</td>
                                            <td class="in-ck-box td-click">이거언제와요?</td>
                                            <td class="in-ck-box td-click">Y</td>
                                        </tr>
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
			</main>
          
        </div>
      </div>
    </article>
</body>
<%@ include file = "/WEB-INF/views/include/include-footer.jspf" %>
</html>