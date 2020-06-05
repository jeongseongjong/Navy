<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="rootPath" value="${pageContext.request.contextPath}" />

<%@ taglib uri="http://www.springframework.org/security/tags" 
			prefix="sec"%>
<%@ taglib uri="http://www.springframework.org/tags/form" 
			prefix="form" %>			
<html>			
<head>			
<%@ include file="/WEB-INF/views/include/include-head.jspf" %>
<link rel="stylesheet" href="${rootPath}/resources/css/login.css" />
</head>
  <script>
$(function(){
	$(document).on("click","button.login",function(){
		document.location.href = "${rootPath}/"
	})
})

</script>
  <body>
	<form:form action="${rootPath}/login" method="POST" class="login_form">
	    <div class="social_login_ct_wrap">
	      <div class="pagepop_wrap">
	        <div class="social_login_cont join_cont">
	            <a href="${rootPath}/"><h2 class="tit_bi">NAVIYA</h2></a>
	            <c:if test="${not empty SPRING_SECURITY_LAST_EXCEPTION}" >
						<span>${SPRING_SECURITY_LAST_EXCEPTION.message}</span>
					</c:if>
	            <label for="username" class="id_ipt login_ipt_box on">
	              <input
	              	id="username"
	              	name="username"
	              	placeholder="USER ID"
	                type="text"
	                class="input_txt"
	                style="outline: none;"
	              />
	            </label>
	            <label for="password" id="password" class="pw_ipt login_ipt_box">
	              <input
	                type="password"
	                name="password"
	                id="password"
	                placeholder="비밀번호"
	                class="input_txt"
	                style="outline-style: none;"
	              />
	            </label>
	            <button class="btn_login login" >로그인</button>
	            <div class="bottom_button_box">
	              <a href="#">아이디 찾기</a>
	              <span class="icon_division"></span>
	              <a href="#">비밀번호 찾기</a>
	              <span class="icon_division join"></span>
	              <a href="${rootPath}/user/join">회원가입</a>
	            </div>
	        </div>
	      </div>
	    </div>
	</form:form>
  </body>
</html>