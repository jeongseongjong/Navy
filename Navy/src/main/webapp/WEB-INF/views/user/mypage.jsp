<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%@ include file="/WEB-INF/views/include/include-head.jspf" %>
<script type="text/JavaScript"
	src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
</head>
<link rel="stylesheet" href="${rootPath}/resources/css/user-infoChange.css" />
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
<body>
<%@ include file="/WEB-INF/views/include/include-nav.jspf" %>
<!--main 화면 img들어갈 것-->
    <%@include file="/WEB-INF/views/include/include-menu.jspf" %>
        <!--개인정보 수정 창-->
        <div class="mypage_inr">
          <h3 class="tit">
            <span class="info">개인정보</span>
          </h3>
          <div class="myinfo">
              <h4 class="subtit">
                <span class="basic">기본정보</span>
              </h4>
              <form:form modelAttribute="userVO">
              <div class="myinfo_inr">
                <table cellspacing="0" border="1">
                  <caption>
                    기본정보
                  </caption>
                  <colgroup>
                    <col width="131" />
                    <col width="131" />
                    <col />
                  </colgroup>
                  <tbody>
                    <tr class="first">
                      <th scope="row">아이디</th>
                      <td colspan="2">
                      
                        <input
                          type="text"
                          class="txt dimmend"
                          name="username"
                          readonly="readonly"
                       
                          style="width: 167px;"
                          value="${userVO.username}"
                        />
                      </td>
                    </tr>
                    <tr>
                      <th scope="row">이름</th>
                      <td colspan="2">
                        <input
                          disabled="disabled"
                          value="이정연"
                          type="text"
                          class="txt dimmend"
                          style="width: 167px;"
                        />
                      </td>
                    </tr>
                    <tr>
                      <th scope="row">신규 비밀번호</th>
                      <td colspan="2">
                        <input
                          type="password"
                          name="password"
                          id="password"
                          class="txt fl"
                          style="width: 167px;"
                        />
                      </td>
                    </tr>
                    <tr class="new_pw">
                      <th scope="row">
                        신규 비밀번호 확인
                      </th>
                      <td colspan="2">
                        <input
                          class="txt"
                          type="password"
                          id="re_password"
                          name="re_password"
                          style="width: 167px;"
                        />
                        <span class="guide"
                          >신규 비밀번호를 한번 더 입력해주세요</span
                        >
                      </td>
                    </tr>
                    <tr>
                      <th scope="row">휴대폰 번호</th>
                      <td colspan="2">
                        <input type="text" class="txt" value="" name="phone"/>
                      </td>
                    </tr>
                    <tr>
                      <th scope="row">주소</th>
                      <td colspan="2">
                        <div>
                          <input id="postcode1" type="text" value="" class="addr1" />
                          -
                          <input id="postcode2" type="text" value="" class="addr1" />
                          <input id="zonecode" type="text" value="" class="addr1" />
                          <input type="button" value="Address" onClick="openDaumZipAddress();" class="addr_btn" />
                          
                        </div>
                        <input type="text" name="address" value="" id="address" class="addr2" />
                        <input type="text" name="address_etc" value="" id="address_etc" class="addr2" />
                      </td>
                    </tr>
                    <tr>
                      <th scope="row">이메일</th>
                      <td colspan="2">
                        <input type="email" class="txt" name="email" value=""/>
                      </td>
                    </tr>
                  </tbody>
                </table>
                <div class="btn_section">
                  <button
                    id="btn_mypage_save"
                    class="btn_modify btn_save"
                  >
                    개인정보수정
                  </button>
                  <button
                    type="button"
                    class="btn_leave"
                    onclick="$(document).on('click','.btn_leave',function(){document.location.href='./user-bye.html'})"
                  >
                    탈퇴
                  </button>
                </div>
              </div>
			</form:form>
	       	</div>
    	   </div>
        <!--개인정보 수정 end-->
      </div>
    </article>
  </body>
</html>
