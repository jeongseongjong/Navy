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
	$(function() {
		$(".main_btn").click(function() {
			document.location.href = "${rootPath}/"
		})
	})
</script>
<body>
	<%@ include file="/WEB-INF/views/include/include-nav.jspf"%>
	<c:choose>
		<c:when test="${empty DELIVERY_LIST}">
			<div>구매내역이 없습니다.</div>
		</c:when>
		<c:otherwise>
			<input type="hidden" name="${_csrf.parameterName}"
				value="${_csrf.token}">
			<div>
				<div>구매자 : ${USER_LIST.username}</div>
				<div>휴대폰번호 : ${USER_LIST.phone}</div>
				<div>주소 : ${USER_LIST.address} ${USER_LIST.address_etc }</div>
			</div>
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
			<div>
				결제정보
				<c:set var="total" value='0' />
				<c:forEach items="${DELIVERY_LIST}" var="delivery">
					<c:set var="total"
						value="${total + delivery.bk_p_oprice * delivery.bk_p_qty}" />
				</c:forEach>
				<div>총 결제 금액 :${total}</div>
			</div>
		</c:otherwise>
	</c:choose>
	<button class="main_btn">메인으로 가기</button>
	<button >결제하기</button>
</body>
</html>