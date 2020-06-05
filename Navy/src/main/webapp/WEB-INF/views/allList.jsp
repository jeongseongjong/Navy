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
 
<style>
 	div.card {

	}
</style>
</head>
<body>
<%@ include file = "/WEB-INF/views/include/include-nav.jspf" %>

<!-- product img list -->
<article class="all-browsers">
	<div class="hr-sect mb-5">PRODUCT LIST</div>
	
	<div class="container d-flex flex-wrap justify-content-center">
		<c:choose>
			<c:when test="${empty PROLIST}">
				<p>상품정보가 없습니다.</p>
			</c:when>
			<c:otherwise>
				<c:forEach var="PRO" items="${PROLIST}" varStatus="i">
			    	<div class="card" style="border: none;" data-id="${PRO.p_code}">
			        	<div class="scale" style="overflow: hidden; width: 207px;">
			            	<img class="detail-img" src="${rootPath}/images/${PRO.p_image}" style="width: 100%;" />
			           	</div>
			           	<div class="card-body" style="border: none;">
	          				<span>${PRO.p_name}</span><br />
	           				<small>${PRO.p_price}won</small>
	           			</div>
	           		</div>
	           		<c:if test="${i.count % 3 == 0}"><br /></c:if>
				</c:forEach>
			</c:otherwise>
		</c:choose>
	</div>
	<%@ include file="/WEB-INF/views/include/include-paging.jspf" %>
</article>

<%@ include file= "/WEB-INF/views/include/include-footer.jspf" %>
</body>
</html>
  