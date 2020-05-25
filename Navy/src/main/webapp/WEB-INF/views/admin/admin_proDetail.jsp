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
<body>
		<!--detail pages 정보 -->
		<div class="container">
			<div class="row"  style="flex-wrap:nowrap">
				<c:choose>
					<c:when test="${empty productVO.p_image}">
						<img src="../img/dress1.jpg"
							style="width: 450px; height: 400px; margin-right: 70px;" />
					</c:when>
					<c:otherwise>
						<img src="${rootPath}/images/${productVO.p_image}"
							style="width: 450px; height: 400px; margin-right: 70px;" />
					</c:otherwise>
				</c:choose>

				<!--detail box-->
				<div class="detail-box"
					style="margin-left: 70px; margin-bottom: 100px;">
					<div class="mb-3 mt-5">
						<h2 class="black-text">${productVO.p_name}</h2>
						<span>${productVO.p_price}원</span>
					</div>
					<hr style="border: 1px solid #252c41;" />
					<br />
					<div class="col">
						<label class="mr-5">SIZE/COLOR</label>
						<!-- <ul class="menu"> -->
						<ul>
							<c:forEach items="">
								<li>
							</c:forEach>
							
							<c:forEach items="${productVO.sizeList}" var="size">
								<c:if test="${!empty size.colorList}">
									<c:forEach items="${size.colorList}" var="color">
									<li> ${size.s_size} ${color.c_color} (${color.c_qty})</li>
									</c:forEach>
								</c:if>
							</c:forEach>
							
						</ul>
					</div>
					<div class="col mb-5">
						<label class="mr-5">QUAN·TITY</label> <span>${productVO.p_qty}개</span> <br /> 
					</div>

					<!-- 장바구니 상품 button -->
					<div class="d-flex justify-content-end mb-5">
						<button class="mr-2 bt-bbs-style ad-pro-list" type="button">
							목록</button>
						<!-- 회원일시 보이는 버튼-->
						<button class="mr-2 bt-bbs-style ad-pro-update" type="button"
							data-id="${productVO.p_code}">수정</button>
						<!-- 삭제버튼 없애기
						<button class="mr-2 bt-bbs-style ad-pro-delete" type="button"
							data-id="${productVO.p_code}">삭제</button>
							 -->
					</div>
					<c:forEach items="${productVO.proDImgList}" var="img">
						<img src="${rootPath}/images/${img.p_img_upload_name}"
								style="width: 250px; height: 200px; margin-right: 70px;" />
					</c:forEach>
				</div>
			</div>
		</div>
		<!-- end -->

</body>
</html>