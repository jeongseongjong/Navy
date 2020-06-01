<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ include file="/WEB-INF/views/include/include-head.jspf" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>나의 홈페이지</title>
<link rel="stylesheet" href="${rootPath}/resources/css/csList.css" />
  <script>
  $(function(){
    $(document).on("click", ".scope", function () {
      (".scope");
    });
    $(".bt-review-wr").click(function(){
    	document.location.href="${rootPath}/cs/insert"
    })
  })
  </script>
</head>
<body>
<%@ include file="/WEB-INF/views/include/include-nav.jspf" %>
    <!--main 화면 bbs 들어갈 것-->
    <!--main 화면 img들어갈 것-->
    <article class="all-browsers">
      <div class="hr-sect mb-5">WRITE</div>
      <!--입력 form-->
      <div class="container">
      <form:form modelAttribute="csVO">
        <span>게시글 작성</span>
        <hr />
        <div class="container">
          <div>
            <label>제목</label>
            <br />
            <input type="hidden" name="cs_username" value="${csVO.cs_username}">
            <form:input path="cs_title" style="width: 100%;" />
          </div>
          <div class="mt-3">
            <!--summernote 들어갈 자리-->
            <label>내용</label>
            <br />
            <form:textarea path="cs_text" style="width: 100%; height: 300px;"/>
          </div>
          <div class="d-flex justify-content-end">
            <button class="bt-bbs-save">저장</button>
          </div>
        </div>
        </form:form>
      </div>
    </article>
</body>
<%@ include file="/WEB-INF/views/include/include-footer.jspf" %>
</html>