<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%@ include file="/WEB-INF/views/include/include-head.jspf"%>
</head>
<link rel="stylesheet" href="${rootPath}/resources/css/main.css" />
<link rel="stylesheet" href="${rootPath}/resources/css/user-main.css" />
<link rel="stylesheet" href="${rootPath}/resources/css/user-cart.css" />
<script type="text/JavaScript"
	src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>

<script>
	
	$(function() {
		$(".main_btn").click(function() {
			document.location.href = "${rootPath}/"
		})

		$(document).on("click", ".payment", function() {
			alert("클릭")
			var seqList = [];

			$('input[name="seq"]').each(function(i, e) {
				seqList.push( $("${DELIVERY_LIST.bk_id}") );
			});
			alert(seqList)

			let username = $("#username").val()
			let address = $("#address").val()
			let address_etc = $("#address_etc").val()
			let message = $("#message").val()

			$.ajax({
				url : "${rootPath}/cart/recipient_update",
				method : "POST",
				data : {
					bk_id : seqList,
					username : username,
					bk_recipient_address : address,
					bk_recipient_address_etc : address_etc,
					bk_recipient_message : message,
					"${_csrf.parameterName}" : "${_csrf.token}"
				},
				success : function(result) {
					alert("배송자 정보 업데이트 성공" + result)
					document.location.href = "${rootPath}/cart/payment_list"
				},
				error : function(result) {
					alert("서버 통신 오류")
				}
			})
		})
	})
</script>
<script type="text/javascript">
	function openDaumZipAddress() {

		new daum.Postcode({

			oncomplete : function(data) {

				jQuery("#postcode1").val(data.postcode1);

				jQuery("#postcode2").val(data.postcode2);

				jQuery("#zonecode").val(data.zonecode);

				jQuery("#address").val(data.address);

				jQuery("#address_etc").focus();

				console.log(data);

			}

		}).open();

	}
</script>
<body>
	<%@ include file="/WEB-INF/views/include/include-nav.jspf"%>

	<c:choose>
		<c:when test="${empty DELIVERY_LIST}">
			<div>구매내역이 없습니다.</div>
			<button class="main_btn">메인으로 가기</button>
		</c:when>
		<c:otherwise>
			<input type="hidden" name="${_csrf.parameterName}"
				value="${_csrf.token}">
			<div>
				<div>구매자 : ${USER_LIST.username}</div>
				<div>휴대폰번호 : ${USER_LIST.phone}</div>
				<div>주소 : ${USER_LIST.address} ${USER_LIST.address_etc }</div>
			</div>
			<div>
				<p>받는사람 정보
				<p>
					<label>이름</label> 
					<input type="text" id="username" name="username" class="w3-input">
				</p>
				<p>
					<label>연락처</label> 
					<input type="text" id="phone" name="phone" class="w3-input">
				</p>
				<input id="postcode1" type="text" value="" style="width: 50px;"	readonly /> 
				<input id="postcode2" type="text" value="" style="width: 50px;" readonly /> 
				<input id="zonecode" type="text" value="" style="width: 50px;" readonly /> 
				<input type="button" onClick="openDaumZipAddress();" value="Address" /> <br /> 
				<input type="text" id="address" name="address" value="" style="width: 240px;" readonly /> 
				<input type="text" id="address_etc" name="address_etc" value="" style="width: 200px;" />
				<c:forEach items="${DELIVERY_LIST}" var="delivery" varStatus="status">
					<input type="hidden" id="seq" name="seq" value="${delivery.bk_id}">
				</c:forEach>
				<div>요청사항</div>
				<input type="text" id="message" placeholder="요청사항">
			</div>
			<div class="col-9">
				<p>상품이름 : ${DELIVERY_LIST[0].bk_p_name} 외 ${LIST_COUNT}개</p>
			</div>
			<p>
			<div>
				결제정보
				<c:set var="total" value='0' />
				<c:forEach items="${DELIVERY_LIST}" var="delivery">
					<c:set var="total"
						value="${total + delivery.bk_p_oprice * delivery.bk_p_qty}" />
				</c:forEach>
				<div>총 결제 금액 :${total}</div>
			</div>
			<button type="button" class="main_btn">메인으로 가기</button>
			<button class="payment">결제하기</button>
		</c:otherwise>
	</c:choose>
</body>
</html>