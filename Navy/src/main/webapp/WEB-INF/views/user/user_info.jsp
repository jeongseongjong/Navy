<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%@ include file="/WEB-INF/views/include/include-head.jspf" %>
</head>
<link rel="stylesheet" href="${rootPath}/resources/css/user-pass.css" />
<script>
$(function() {
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
<%@ include file="/WEB-INF/views/include/include-nav.jspf" %>
 <%@ include file="/WEB-INF/views/include/include-menu.jspf" %>
        <!--password 입력 창-->
        <div class="mypage_ct_wrap">
          <div class="pw_cfm_ct">
            <div class="auth_tp inner">
              <p class="onemore_desc">
                개인정보를 안전하게 보호하기 위해
                <br />
                비밀번호를 한번 더 입력해주세요
              </p>
              <div class="insert_pw">
                <label class="pwInsert">
                  <input
                    name="password"
                    type="password"
                    id="password"
                    placeholder="비밀번호 입력"
                  />
                </label>
              </div>
              <div class="btn_confirm">
                <button
                  type="button"
                  class="btn_big btn_update"
                >
                  확인
                </button>
              </div>
            </div>
          </div>
        </div>
      </div>
    </article>
  </body>
</html>