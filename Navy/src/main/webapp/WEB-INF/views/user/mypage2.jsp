<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>

<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/views/include/include-head.jspf"%>
<script type="text/JavaScript"
	src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script>
	$(function() {
		
		$(document).on("click","#btn_mypage_save", function(){
			let password = $("#password")
			let re_password = $("#re_password")


			if (password.val() == "") {
				alert("비밀번호를 입력하세요")
				password.focus()
				return false;
			}

			if (re_password.val() == "") {
				alert("비밀번호를 입력하세요.")
				password.focus()
				return false;
			}

			if (password.val() != re_password.val()) {
				alert("비밀번호가 맞지 않습니다.")
				password.focus()
				return false;
			}
			
			if(confirm("변경하시겠습니까??")){
				document.location.href = "${rootPath}/"
			}
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
</head>
<body>
	<%@ include file="/WEB-INF/views/include/include-nav.jspf"%>
	<div class="container" style="margin-top: 30px">
		<div class="w3-card-4">

			<div class="w3-container w3-green">
				<h2>${userVO.username}의MYPAGE</h2>
			</div>
			<hr />

			<form:form class="w3-container" modelAttribute="userVO">
				<label>아이디 : ${userVO.username}</label>
				<input type="hidden" name="username" value="${userVO.username}">
				<p>
					<label>변경할 비밀번호</label> 
					<input type="password" name="password" id="password" class="w3-input" placeholder="비밀번호">
					<label>변경할 비밀번호 확인</label>
					<input type="password" name="re_password" id="re_password" class="w3-input" placeholder="비밀번호 확인"> 
					<label>이메일</label> <input	type="email" name="email" class="w3-input" placeholder="이메일" value="${userVO.email}">
					<label>전화번호</label> <input type="text" name="phone" class="w3-input" placeholder="전화번호" value="${userVO.phone}">

					<label>주소</label>
					<input id="postcode1" type="text" value="" style="width: 50px;" readonly /> &nbsp;-&nbsp;
					<input id="postcode2" type="text" value="" style="width: 50px;" readonly /> &nbsp;&nbsp;
					<input id="zonecode" type="text" value="" style="width: 50px;" readonly /> &nbsp;
					<input type="button" onClick="openDaumZipAddress();" value="Address" />
					<br />
					<input type="text" id="address" name="address" value="${userVO.address }" style="width: 240px;" readonly />
					<input type="text" id="address_etc" name="address_etc" value="${userVO.address_etc}" style="width: 200px;" />

					


					<!--  <label>주소</label> <input type="text" name="address"
						class="w3-input" placeholder="주소" value="${userVO.address}"> -->

					<button id="btn_mypage_save"
						class="w3-button w3-white w3-border w3-border-green w3-round-large btn_save mt-3">저장</button>
			</form:form>

		</div>
	</div>
</body>
</html>