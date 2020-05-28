<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ include file="/WEB-INF/views/include/include-head.jspf"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
	$(function(){
		$(".ad-us-list").click(function(){
			document.location.href="${rootPath}/admin/userlist"
		})
	})
</script>
</head>
<body>
            <div class="row bg-light">
              <div class="col-12 py-4 text-center">
                <span style="font-size: 30px;">회원상세수정관리</span>
              </div>
            </div>
            <!--userdetail 정보-->
            <div class="row bg-white">
              <div class="col-12 py-4">
                <div class="card">
                  <div class="card-body">
                    <span>회원 코드 : ${userVO.id}</span>
                    <span class="ml-5">유저 아이디 : ${userVO.username}</span>
                    <hr />
                    <form:form class="container" modelAttribute="userVO">
                      <div class="form-group">
                        <label for="staticEmail">이름</label>
                        <div class="mb-3">
                          <input
                            type="text"
                            class="form-control-plaintext input-form"
                            placeholder="이름을 입력하세요"
                            readonly="readonly"
                          />
                          <small class="red-text"
                            >*이름은 변경이 불가능합니다</small
                          >
                        </div>

                        <label for="phone">전화번호</label>
                        <div class="mb-3">
                          <form:input
                            type="tel"
                            class="form-control-plaintext input-form"
                            path="phone"
                            placeholder="전화번호를 입력해주세요"
                            value="${userVO.phone}"
                          />
                          <small class="red-text">* -까지 입력해주세요</small>
                        </div>

                        <input onclick="openDaumZipAddress();" type="button" value="주소"/>
                        <label for="address">주소</label>
                        <button
                          type="button"
                          class="bt-bbs-style ml-3"
                          data-toggle="modal"
                          data-target="#exampleModalCenter"
                          style="border: 1px solid black; border-radius: 10px;"
                        >
                          주소찾기
                        </button>
                        <div class="mb-3">
                          <form:input
                            type="text"
                            class="form-control-plaintext input-form"
                            path="address"
                            placeholder="주소를 입력하세요"
                            value="${userVO.address}"
                          />
                          <form:input
                            class="form-control-plaintext input-form mt-2"
                            path="address_etc"
                            placeholder="나머지 주소 입력해주세요"
                            value="${userVO.address_etc}"
                          />

                          <!--modal 창-->
                          <!-- Button trigger modal -->

                          <!-- Modal -->
                          <div
                            class="modal fade"
                            id="exampleModalCenter"
                            tabindex="-1"
                            role="dialog"
                            aria-labelledby="exampleModalCenterTitle"
                            aria-hidden="true"
                          >
                            <div
                              class="modal-dialog modal-dialog-centered"
                              role="document"
                            >
                              <div class="modal-content">
                                <div class="modal-header">
                                  <span
                                    class="modal-title"
                                    style="font-size: 20px;"
                                    id="exampleModalCenterTitle"
                                  >
                                    주소로 검색하기
                                  </span>
                                  <button
                                    type="button"
                                    class="close"
                                    data-dismiss="modal"
                                    aria-label="Close"
                                  >
                                    <span aria-hidden="true">&times;</span>
                                  </button>
                                </div>
                                <div class="modal-body">
                                  <p>예)광주광역시 남구 백운동</p>
                                  <input placeholder="주소를 입력해주세요" />
                                  <button type="button" class="bt-bbs-style">
                                    검색
                                  </button>
                                </div>
                                <div class="modal-footer">
                                  <button type="button" class="bt-bbs-style">
                                    확인
                                  </button>
                                  <button
                                    type="button"
                                    class="bt-bbs-style"
                                    data-dismiss="modal"
                                  >
                                    닫기
                                  </button>
                                </div>
                              </div>
                            </div>
                          </div>
                          <!--modal 끝-->
                        </div>
                        <div class="mb-3">
                          <label for="staticEmail">이메일</label>

                          <input
                            type="email"
                            class="form-control-plaintext input-form"
                            placeholder="이메일을 입력하세요"
                          />
                          <small class="red-text"
                            >abcd@abcd.abc 처럼 입력해주세요</small
                          >
                        </div>
						<label for="enabled">정지여부</label>
                        <div class="mb-3">
                          <form:checkbox
                            class="form-control-plaintext input-form"
                            path="enabled"
                            value="${userVO.enabled}"
                          />
                        </div>
						<label for="checkout">탈퇴여부</label>
                        <div class="mb-3">
                          <form:checkbox
                            class="form-control-plaintext input-form"
                            path="checkout"
                            value="${userVO.checkout}"
                          />
                        </div>
                        
                        <!-- 권한설정 추가 script-->
                        <script>
                          $(document).ready(function () {
                            let auth =
                              ' <div class="select-box  d-flex flex-row">';
                            auth +=
                              '<select class="s-box custom-select custom-select-sm" name="auth" >';
                            auth +=
                              "<option selected>권한을 설정해주세요</option>";
                            auth += '<option value="ROLE_ADMIN">ROLE_ADMIN</option>';
                            auth += '<option value="ROLE_USER">ROLE_USER</option>';
                            auth += '<option value="ADMIN">ADMIN</option>';
                            auth += '<option value="USER">USER</option>;';
                            auth += "</select>";
                            auth +=
                              '<span class="delete-selectbox">&cross;</span>';
                            auth += "</div>";
                            $("#bt-plus").click(function () {
                              $("#select-container").append(auth);
                            });
                            $(document).on(
                              "click",
                              ".delete-selectbox",
                              function () {
                                $(this).closest(".select-box").remove();
                              }
                            );
                          });
                          /*
                          function count_select(){
                        	  var ele = $(".select-box").length;
                        	  alert("개수:"+ele)
                        	  if(ele < 1){
                        		  alert("권한은 최소 1개 이상 설정해야 합니다.")
                        		  return false
                        	  }
                          }
                          */
                          
                          // 권한설정 관련해서 유효성 검사
                          $("#bt-bbs-update").click(function(){
                        	  var ele = $(".s-box").length;
                        	  //alert("셀렉트 개수:"+ele)
                        	  
                        	  let selectText = $(".s-box option:selected").text()
                        	  alert("셀렉트 텍스트:"+selectText)
                        	  
                        	  var searchText = selectText.indexOf("권한")
                        	  alert(searchText)
                        	  
							  if(searchText > -1){
								  alert("권한을 설정해 주세요.")
								  return false
							  }
                        	  
                        	  if(ele < 1){
                        		  alert("권한은 최소 1개 이상 설정해야 합니다.")
								  return false
                        	  } else{
                        		  //alert("된다")
	                        	  $("form").submit()
                        		  
                        	  }
                        	  
                          })
                          
                          
                        </script>
                        <!-- end -->
                        <!--select  박스-->
                        <div id="select-container">
                          <label for="staticEmail" class="col-form-label"
                            >권한설정</label
                          >
                          <button
                            id="bt-plus"
                            type="button"
                            class="bt-bbs-style col-form-label"
                          >
                            추가
                          </button>
                     		<c:forEach items="${userVO.authorities}" var="auth"
								varStatus="index">
								<div class="select-box  d-flex flex-row">
									<select
		                              class="s-box custom-select custom-select-sm"
		                              name="auth"
		                            >
		                            <option selected value="${auth.authority}">${auth.authority}</option>
		                            	<option value="ROLE_ADMIN">ROLE_ADMIN</option>
		                              <option value="ROLE_USER">ROLE_USER</option>
		                              <option value="ADMIN">ADMIN</option>
		                              <option value="USER">USER</option>
									</select>
									<span class="delete-selectbox">&cross;</span>
								</div>
							</c:forEach>
                          <div class="select-box d-flex flex-row">
                          	<c:if test="${empty userVO.authorities}">
	                            <select
	                              class="s-box custom-select custom-select-sm"
	                              name="auth"
	                            >
	                              <option selected>권한을 설정해주세요.</option>
	                              <option value="ROLE_ADMIN">ROLE_ADMIN</option>
	                              <option value="ROLE_USER">ROLE_USER</option>
	                              <option value="ADMIN">ADMIN</option>
	                              <option value="USER">USER</option>
	                            </select>
	                            <span class="delete-selectbox">&cross;</span>
                            </c:if>
                          </div>
                        </div>
                        <!--select  박스 끝-->
                      </div>
                    <!--button group-->
					<div class="d-flex justify-content-end mb-5">
						<button type="button" class="mr-2 bt-bbs-style bt-bbs-list ad-us-list">
							목록</button>
						<!-- 회원일시 보이는 버튼-->
						<button type="button" class="mr-2 bt-bbs-style bt-bbs-update" id="bt-bbs-update">
							저장</button>
					</div>
                    </form:form>
                    <!--button group end-->
                    <!--container end-->
                  </div>
                </div>
              </div>
            </div>

</body>
</html>