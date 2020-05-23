<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/include-head.jspf"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<script>
$(function(){
	$(".main_btn").click(function(){
		document.location.href = "${rootPath}/"
	})
})
</script>
<body>
<%@ include file="/WEB-INF/views/include/include-nav.jspf" %>
	<c:choose>
	<c:when test="${empty DELIVERY_LIST}">
		<div>카드가 비어있습니다.</div>
	</c:when>
	<c:otherwise>
		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
			<c:forEach items="${DELIVERY_LIST}" var="delivery">
				<div class="delivery_list" data-id="${delivery.bk_id}">
					<div class="col-9">
						<p>상품이름 : ${delivery.bk_p_name}</p>
						<p>상품가격 : ${delivery.bk_p_oprice}</p>
						<p>색상 : ${delivery.bk_p_color}</p>
						<p>사이즈 : ${delivery.bk_p_size}</p>
						<p>수량 : ${delivery.bk_p_qty}</p>
						<input type="hidden" name="seq" value="${delivery.bk_id}">
					</div>
					<p>
				</div>
			</c:forEach>
	</c:otherwise>
</c:choose>
<button class="main_btn">메인으로 가기</button>
</body>
</html>