<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/views/include/include-head.jspf" %>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<script>
	$(function() {
		$("input").prop("readonly", true)
		$("#password").prop("readonly", false)
		$(document).on("click", ".btn_update", function() {
			let pass = $("#password").val()
			if (pass == "") {
				alert("수정하려면 비밀번호를 입력한 후 \n" + "다시 수정하기 버튼을 클릭하세요")
				// $("div.password").css("display","block")
				// $("#password").prop("readonly",false)
				$("#password").focus()
				return true
			}
			/* 보낼 데이터가 하나 뿐이라면 data뒤에 JSON 쓰지 않고 data값 하나만 넘겨줘도 된다.*/
			if (pass != "") {

				let token = $();

				$.ajax({
					url : '${rootPath}/user/password',
					method : 'POST',
					data : {
						password : pass,
						"${_csrf.parameterName}" : "${_csrf.token}"
					},
					success : function(result) {
						if (result == "PASS_OK") {
							alert("비밀번호 일치")
							$("input").prop("readonly", false)
							$("input").css("color", "blue")
							$("button#btn_save").prop("disabled", false)
							//$("button.btn_save").prop("disabled",false)
							$("button#btn_update").prop("disabled", true)
							//$("button.btn_update").prop("disabled",true)
							
							document.location.href = "${rootPath}/user/mypage"
							
						} else {
							alert("비밀번호가 일치하지 않습니다")
							return false;
						}

					},
					error : function() {
						$("#password").focus()
						alert("서버 통신 오류")
					}
				})
			}

		})
	})
</script>
<body>
	<form:form class="w3-container" modelAttribute="userVO">
		<label>아이디 : ${userVO.username}</label>
		<input type="hidden" name="username" value="${userVO.username}">
		<p>
		<div class="paswword-div">
			<div class="password">
				<div class="input-group mb-3 input-group-sm">
					<div class="input-group-prepend">
						<span class="input-group-text">비밀번호</span>
					</div>
					<input type="password" id="password" class="form-control "
						placeholder="비밀번호를 입력!!">
				</div>
			</div>
		</div>
		<button
			class="w3-button w3-white w3-border w3-border-blue w3-round-large btn_update mt-3"
			type="button">비밀번호 확인</button>
	</form:form>
</body>
</html>