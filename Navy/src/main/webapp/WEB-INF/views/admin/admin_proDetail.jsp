<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ include file="/WEB-INF/views/include/include-head.jspf"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>
$(function(){
	// 상품 수정 페이지 이동
	$(document).on("click",".ad-pro-update",function(){
		let p_code = $(this).data("id")
		document.location.href="${rootPath}/admin/pro_update/"+p_code
		/*
		$.get("${rootPath}/admin/pro_update/" + p_code,
				function(result){
			$("#admin_content").html(result)
		})
		*/
	})
	
	// 상품 1개 삭제
	$(document).on("click",".ad-pro-delete",function(){
		let p_code = $(this).data("id")
		document.location.href="${rootPath}/admin/pro_delete/"+p_code
		/*
		$.get("${rootPath}/admin/pro_delete/" + p_code,
				function(result){
			document.location.replace("${rootPath}/admin/pro_delete/" + p_code)
		})
		*/
	})
	
	$(".ad-pro-list").click(function(){
		document.location.href="${rootPath}/admin/productlist"
	})
	
	// 대표이미지 설정하기
	$(".ad_main_img").click(function(){
		let imgName = $(this).data("name")
		let p_code = "${productVO.p_code}"
		//alert(imgName)
		//alert(p_code)
		
		if(confirm("대표이미지를 선택한 사진으로 바꾸시겠습니까?")) {
			$.ajax({
				url : "${rootPath}/admin/repimg" ,
				method : "POST",
				data : {
					imgName : imgName,
					p_code : p_code
				},
				beforeSend : function(ax) {
					ax.setRequestHeader(
						"${_csrf.headerName}","${_csrf.token}"		
					)					
				}, success : function(result) {
					if ( result > 0 ) {
						document.location.replace("${rootPath}/admin/pro_detail_view/"+p_code)
					} else {
						alert("대표 이미지 변경 실패")						
					}
				}, error : function(){
					alert("서버 통신 오류")
				}
				
				
			})			
		}
		
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
						<img src="${rootPath}/images/${img.p_img_upload_name}" class="ad_main_img"
							data-name="${img.p_img_upload_name}"
								style="width: 250px; height: 200px; margin-right: 70px;" />
					</c:forEach>
				</div>
			</div>
		</div>
		<!-- end -->
			</main>
          
        </div>
      </div>
    </article>
</body>
<%@ include file = "/WEB-INF/views/include/include-footer.jspf" %>
</html>