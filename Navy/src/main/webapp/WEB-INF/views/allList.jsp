<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
 <%@ include file="/WEB-INF/views/include/include-head.jspf" %>
 
 <script>
$(function() {
	
	$(".card").click(function() {
		let id = $(this).data("id")
		document.location.href = "${rootPath}/product/detail/" + id
	})
	
})
 </script>
</head>
<body>
<%@ include file = "/WEB-INF/views/include/include-nav.jspf" %>

<!-- product img list -->
<article class="all-browsers">
	<div class="hr-sect mb-5">PRODUCT LIST</div>
	
	<div class="container d-flex flex-wrap justify-content-center">
		<c:choose>
			<c:when test="${empty PROLIST}">
				<div class="row">
        			<div class="col-sm">
        				<p>상품정보가 없습니다.</p>
        			</div>
        		</div>
			</c:when>
			<c:otherwise>
				<c:forEach var="PRO" items="${PROLIST}">
					<div class="row">
			        	<div class="col-sm">
			           		<div class="card" style="border: none;" data-id="${PRO.p_code}">
			          			<div class="scale" style="overflow: hidden;">
			               			<img class="detail-img" src="${rootPath}/images/${PRO.p_image}" style="width: 30%;" />
			           			</div>
			           			<div class="card-body" style="border: none;">
			               			<h6>
			               				<span>${PRO.p_name}</span><br />
			               				<small>${PRO.p_price}won</small>
			               			</h6>
			           			</div>
			           		</div>
			        	</div>
			     	</div>
				</c:forEach>
			</c:otherwise>
		</c:choose>
	</div>
</article>

<%@ include file="/WEB-INF/views/include/include-paging.jspf" %>
<%@ include file= "/WEB-INF/views/include/include-footer.jspf" %>
</body>
</html>
  