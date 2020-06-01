<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/views/include/include-head.jspf" %>
<!-- Latest compiled and minified CSS -->
</head>
<script>
$(function() {
	$(document).on("click", ".scope", function() {
	      (".scope");
	});
}
</script>
<body>
<%@ include file = "/WEB-INF/views/include/include-nav.jspf" %>

    <!--main 화면 img들어갈 것-->
    <main>
      <div class="hr-sect mb-5">PRODUCT</div>

      <!--상품 이미지슬라이드 들어갈 곳-->

      <div id="demo" class="carousel slide slide-width" data-ride="carousel">
        <!-- Indicators -->
        <ul class="carousel-indicators">
          <li data-target="#demo" data-slide-to="0" class="active"></li>
          <li data-target="#demo" data-slide-to="1"></li>
          <li data-target="#demo" data-slide-to="2"></li>
        </ul>

        <!-- The slideshow -->
        <div class="carousel-inner">
          <div class="carousel-item active">
            <img
              src="${rootPath}/resources/img/chicago.jpg"
              alt="Los Angeles"
              class="d-block w-100"
            />
          </div>
          <div class="carousel-item">
            <img src="${rootPath}/resources/img/la.jpg" alt="Chicago" class="d-block w-100" />
          </div>
          <div class="carousel-item">
            <img src="${rootPath}/resources/img/ny.jpg" alt="New York" class="d-block w-100" />
          </div>
        </div>
      </div>

      <div class="hr-sect mt-5 mb-5">FEATURED ITEMS</div>

      <!-- 상품 갤러리 마우스 오버시 두가지 이미지-->
      <div class="d-flex flex-wrap justify-content-center">
        <div class="img-over m-3">
          <a href="#" id="img1"></a>
        </div>
        <div class="img-over m-3">
          <a href="#" id="img1"></a>
        </div>
        <div class="img-over m-3">
          <a href="#" id="img1"></a>
        </div>
      </div>
    </main>
  </body>

  <%@ include file= "/WEB-INF/views/include/include-footer.jspf" %>
</html>
