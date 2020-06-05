<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <head>
<%@ include file="/WEB-INF/views/include/include-head.jspf" %>

    <link rel="stylesheet" href="${rootPath}/resources/css/join.css" />
  </head>
  <script type="text/JavaScript"
	src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script>
	$(function() {
		$(document).on("click", "#btn-join", function() {
			let username = $("#username")
			let password = $("#password")
			let re_password = $("#re_password")
			let address = $("#address")
			let address_etc = $("#address_etc")

			alert(address)
			if (username.val() == "") {
				alert("아이디를 입력하세요")
				username.focus()
				return false;
			}

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
			
			if (address.val() == "") {
				alert("주소를 입력하세요.")
				address.focus()
				return false;
			}
			
			if (address_etc.val() == "") {
				alert("상세주소를 입력하세요.")
				address_etc.focus()
				return false;
			}

			$("form").submit()
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
  <form:form method="POST" action="${rootPath}/user/join">
    <div class="join_wrap">
      <!--header start-->
      <div class="join_header">
        <h1 class="logo">
          <a href="../main.html">NAVIYA</a>
        </h1>
      </div>
      <!--header end-->
      <div class="join_contain join_form">
        <h2 class="join_title">회원정보 입력</h2>
        <dl class="form_wrap">
          <dt>아이디</dt>
          <dd>
            <div class="input">
              <input type="text" id="username" name="username" placeholder="아이디를 입력해주세요" />
            </div>
            <p class="msg dont">영문/숫자 4자 이상을 입력해주세요</p>
          </dd>
          <dt>비밀번호</dt>
          <dd>
            <div class="input">
              <input type="password" id="password" name="password" placeholder="비밀번호를 입력해주세요" />
            </div>
            <p class="msg dont">
              8~20의 영문 대/소문자, 숫자, 특수문자를 사용해주세요
            </p>
          </dd>
          <dt>비밀번호 재확인</dt>
          <dd>
            <div class="input">
              <input
                type="password"
                id="re_password"
                name="re_password"
                placeholder="비밀번호를 다시 한번 입력해주세요"
              />
            </div>
            <p class="msg dont"></p>
          </dd>
          <dt>연락처</dt>
          <dd>
            <div class="input">
              <input type="text" placeholder="연락처를 입력해주세요" />
            </div>
            <p class="msg">예) 000-0000-0000</p>
          </dd>
          <dt>
            주소
            <button
              type="button"
              class="btn_addr1"
              data-toggle="modal"
              data-target="#myModal"
            >
              우편번호
            </button>
          </dt>
          <dd>
            <div class="input">
              <input type="text" placeholder="주소를 입력해주세요" />
            </div>
            <p class="msg dont">주소를 입력해주세요</p>
          </dd>
          <dt>이메일</dt>
          <dd>
            <div class="input">
              <input type="text" placeholder="이메일을 입력해주세요" />
            </div>
            <p class="msg dont">이메일을 입력해주세요</p>
          </dd>
        </dl>
        <div class="btns_area">
          <button
            class="btn_join"
            onclick="$(document).on('click','.btn_join',function(){document.location.href='join-success.html'})"
          >
            가입하기
          </button>
        </div>
      </div>
      <div class="join_footer">
        <div class="copyright">
          COPYRIGHT. QUSSOA. 한국경영원 인재개발원
        </div>
      </div>
    </div>
    </form:form>
  </body>
  
</html>
