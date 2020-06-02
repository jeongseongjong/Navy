<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
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
	
	$("div.image").hover(function() {
		let image = $(this).data("img")		
		$("div.image div.overlay-cont").css("background-image", "url('${rootPath}/images/" + image + "')")		
	})
	
	$(".moreDetail").click(function() {
		let id = $(this).data("id")
		document.location.href = "${rootPath}/product/detail/" + id
	})
	
})
</script>
<body>
<%@ include file = "/WEB-INF/views/include/include-nav.jspf" %>

<!--main 화면 img들어갈 것-->
<article class="all-browers">
	<div class="hr-sect mb-5">PRODUCT</div>

  	<!--상품 이미지슬라이드 들어갈 곳-->
	<div id="demo" class="carousel slide slide-width" data-ride="carousel" style="margin-bottom: 200px; margin-top: 100px;">
		<!-- Indicators -->
		<ul class="carousel-indicators">
		  <li data-target="#demo" data-slide-to="0" class="active"></li>
		  <li data-target="#demo" data-slide-to="1"></li>
		  <li data-target="#demo" data-slide-to="2"></li>
		</ul>

		<!-- The slideshow -->
  		<div class="carousel-inner">
    		<div class="carousel-item active">
      			<img src="${rootPath}/resources/img/gu-slide-1.jpg" alt="Los Angeles" class="d-block w-100" />
    		</div>
    		<div class="carousel-item">
      			<img src="${rootPath}/resources/img/gu-slide-2.jpg" alt="Chicago" class="d-block w-100" />
    		</div>
    		<div class="carousel-item">
      			<img src="${rootPath}/resources/img/gu-slide-3.jpg" alt="New York" class="d-block w-100" />
    		</div>
  		</div>
	</div><!--상품 이미지슬라이드 들어갈 곳 end -->

	<div class="hr-sect mt-5 mb-5">FEATURED ITEMS</div>

	<!-- 상품 갤러리 마우스 오버시 두가지 이미지-->
	<div class="container-fluid d-flex justify-content-center" style="margin-bottom: 200px; margin-top: 100px;">
		<div class="wrapper mr-5">
			<c:choose>
				<c:when test="${empty PROBESTLIST}">
					<div class="image">인기 상품 정보가 없습니다.</div>
				</c:when>
				<c:otherwise>
					<c:forEach items="${PROBESTLIST}" var="PROBLIST">
						<div class="image"  data-img="${PROBLIST.proDImgList[1].p_img_upload_name}">
      						<img class="show-img" src="${rootPath}/images/${PROBLIST.proDImgList[0].p_img_upload_name}" alt="dress1" style="display: block;" />
        					<div class="overlay">
          						<div class="overlay-cont">
            						<div class="share">
              							<a class="moreDetail" data-id="${PROBLIST.p_code}">MORE VIEW</a>
            						</div>
          						</div>
        					</div>
      					</div>
      					<p class="mt-4">${PROBLIST.p_name} : 
      						<fmt:formatNumber value="${PROBLIST.p_price}" type="number" maxFractionDigits="3" var="commaPrice"/>&#8361; ${commaPrice}</p>
					</c:forEach>
				</c:otherwise>
			</c:choose>
		</div>    	
  	</div>  	
</article>

<%@ include file= "/WEB-INF/views/include/include-footer.jspf" %>
</body>
</html>
