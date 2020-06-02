<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <head>
  <%@ include file="/WEB-INF/views/include/include-head.jspf"%>
    <meta charset="utf-8" />
    <title>Page Title</title>

    <link rel="stylesheet" href="../main.css" />
    <link rel="stylesheet" href="./user-main.css" />
  </head>
  <style></style>
  <script>
    $(document).on("click", ".scope", function () {
      (".scope");
    });
  </script>
  <body>
  <%@ include file="/WEB-INF/views/include/include-nav.jspf" %>
   
    <!--main 화면 img들어갈 것-->
    <article class="all-browers container">
      <div>
        <%@ include file="/WEB-INF/views/include/include-menu.jspf" %>
        <!--구매내역 container-->

        <div class="date_control">
          <ul class="date_list dl_fit">
            <li class="date_all">
              <a class="a_on">전체</a>
            </li>
            <li class="date_all">
              <a>1개월</a>
            </li>
            <li class="date_all">
              <a>3개월</a>
            </li>
          </ul>
        </div>
        <!--기간 end-->
        <!--상품 구매내역 1-->
        <span class="h5" style="padding-left: 90px;">상품 구매내역</span>
        <div class="buy_list">
          <table cellspacing="0" border="1">
            <caption>
              구매내역
            </caption>
            <colgroup>
              <col width="170" />
              <col width="500" />
              <col width="120" />
              <col width="140" />
            </colgroup>
            <thead>
              <tr>
                <th colspan="2" scope="colgroup">구매내역</th>
                <th scope="col">배송상태</th>
                <th scope="col">관리</th>
              </tr>
            </thead>
              	<c:forEach items="${DELIVERY_LIST }" var="delivery">
            <tbody>
              <tr>
              		<td colspan="2">${delivery.bk_p_name}</td>
                <td scope="col">배송중</td>
                <td scope="col"></td>
              </tr>
            </tbody>
              	</c:forEach>
          </table>
        </div>
        <!--content end-->

        <!--pagination-->
        <div class="d-flex justify-content-center mt-3">
          <nav aria-label="Page navigation example">
            <ul class="pagination">
              <li class="page-item">
                <a class="page-link black-text" href="#" aria-label="Previous">
                  <span aria-hidden="true" class="black-text">&laquo;</span>
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
                <a class="page-link black-text" href="#" aria-label="Next">
                  <span aria-hidden="true" class="black-text">&raquo;</span>
                  <span class="sr-only black-text">Next</span>
                </a>
              </li>
            </ul>
          </nav>
        </div>
        <!--pagination end-->
        <div class="delivery_process_area">
          <h3 class="h_delivery_process">배송상태안내 및 유의사항</h3>
          <div class="delivery_process">
            <ul class="1st-delivery_process"></ul>
          </div>
          <ul class="fst_delivery_caution">
            <li>
              <span>·</span>
              배송지 수정 및 구매취소는 주문하신 배송상품이 '결제완료' 상태일
              때만 가능합니다.
            </li>
            <li>
              <span>·</span>
              환불/교환 요청은 '배송완료 다음날부터 7일'까지 가능합니다. (환불은
              '배송준비중', 교환은 '배송완료' 상태일 때 부터 요청가능)
            </li>
            <li>
              <span>·</span>
              환불/교환 요청 후 1~3일 내에 택배사에서 상품을 수거하게 되니 잠시
              기다려 주세요.
            </li>
            <li>
              <span>·</span>
              구매 시의 상품정보와 현재 상품 정보가 상이할 수 있습니다.
            </li>
          </ul>
        </div>
      </div>
    </article>
  </body>

  <!-- footer include -->
  <footer class="bg-gray mt-5">
    <div class="container p-5">
      <div class="row">
        <h2 class="red-text">NAVIYA</h2>
      </div>
      <div class="pl-5 pr-5 d-flex row">
        <div class="col-sm-3">
          <div>
            shop
          </div>
          <div>
            main1
          </div>
          <div>
            main2
          </div>
          <div>
            QnA
          </div>
        </div>
        <div class="col-sm-3">
          <div>
            <span class="font-weight-bold"> TEAMLEADER </span><br />
            <span
              ><a class="atag-github" href="https://github.com/jeongseongjong"
                >&nbsp;&nbsp;- NAVI</a
              ></span
            >
          </div>
          <div>
            <span class="font-weight-bold">UI/UX</span> <br />
            <span
              ><a class="atag-github" href="https://github.com/qussoa"
                >&nbsp;&nbsp;- QUSSOA</a
              ></span
            >
          </div>
        </div>
        <div class="col-sm-3">
          <div>
            <span class="font-weight-bold">DEVELOPER</span><br />
            <span
              ><a class="atag-github" href="https://github.com/leeiter"
                >&nbsp;&nbsp;- PRINCESSEJIN</a
              ></span
            >
          </div>
          <div>
            <span class="font-weight-bold">DEVELOPER</span><br />
            <span
              ><a class="atag-github" href="https://github.com/bjmin17"
                >&nbsp;&nbsp; - BJ.MIN</a
              ></span
            >
          </div>
        </div>
        <div class="col-sm-3">
          <div>
            <small>
              광주광역시 북구 경양로170<br />
              한경빌딩 5층
            </small>
          </div>
          <div>
            <small>
              &copy; copyRight qussoa@naver.com
            </small>
          </div>
        </div>
      </div>
    </div>
  </footer>
</html>

