<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ include file="/WEB-INF/views/include/include-head.jspf" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>나의 홈페이지</title>
<link rel="stylesheet" href="${rootPath}/resources/css/csList.css" />
<link rel="stylesheet" href="${rootPath}/resources/css/csList-Detail.css" />
  <script>
  $(function(){
	  $(".bt-bbs-list").click(function(){
		  document.location.href="${rootPath}/cs/list"
	  })
	  
	  $(".cs-delete").click(function(){
		  //let id = $("${CSVO.cs_id}")
		  let id = $(this).data("id")
		  if(confirm("삭제하시겠습니까?")){
			  document.location.replace("${rootPath}/cs/delete/"+id)
		  }
	  })
  })
  </script>
</head>
<body>
<%@ include file="/WEB-INF/views/include/include-nav.jspf" %>

    <article class="all-browsers">
      <div class="hr-sect mb-5">BULLETIN WRITE</div>

      <div class="container">
        <h3>${CSVO.cs_title}</h3>
        <hr style="border: 1px solid #afb1b6;" />
        <div>
          <span>${CSVO.cs_username}</span>
          <span>&#124;</span>
          <span>${CSVO.cs_date}</span>
          <span>&#124;</span>
          <span>조회수 : ${CSVO.cs_count}</span>
        </div>
        <hr />
        <div>
          <!-- upload 사진 보이는 img tag-->
          <c:if test="${CSVO.cs_file}">
	          <img src="./img/bts.jpg" style="width: 100%;" />
          </c:if>
          <p>
            ${CSVO.cs_text}
          </p>
        </div>

        <hr />
        <div class="d-flex justify-content-end mb-5">
          <button
          	type="button"
            class="mr-2 bt-bbs-style bt-bbs-list"
          >
            목록
          </button>
          <sec:authorize access="hasRole('ROLE_ADMIN')">
	          <button type="button" 
	          class="mr-2 bt-bbs-style cs-delete"
	          data-id="${CSVO.cs_id}"
	          >
	            삭제
	          </button>
          </sec:authorize>
        </div>
        <!-- 댓글 -->
        <div class="container">
          <span>댓글</span>
          <span>2</span>
          <div class="row" style="background-color: #f4f5f9;">
            <p class="col text-left">ADMIN</p>
            <p class="col text-right">2020-05-14</p>
            <p class="ml-4">
              Laoreet id donec ultrices tincidunt arcu non sodales neque. Eget
              felis eget nunc lobortis mattis aliquam faucibus purus. Faucibus
              interdum posuere lorem ipsum dolor sit.
            </p>
            <div class="ml-4 row">
              <p class="col text-left">ADMIN</p>
              <p class="col text-right">2020-05-14</p>
              <p class="ml-4">
                &#8627; Laoreet id donec ultrices tincidunt arcu non sodales
                neque. Eget felis eget nunc lobortis mattis aliquam faucibus
                purus. Faucibus interdum posuere lorem ipsum dolor sit.
              </p>
            </div>
          </div>
          <div class="mt-5">
            <span class="ml-3">댓글 달기</span>
            <div class="row justify-content-center mt-2">
              <input style="width: 80%; height: 50px;" />
              <button class="ml-5 bt-bbs-style">
                저장
              </button>

            </div>
          </div>
        </div>
	</div>
	</article>

</body>
<%@ include file="/WEB-INF/views/include/include-footer.jspf" %>
</html>