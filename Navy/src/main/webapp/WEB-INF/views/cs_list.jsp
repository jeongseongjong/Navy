<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="/WEB-INF/views/include/include-head.jspf" %>
<c:set var="num" value="${pageVO.totalCount - ((pageVO.currentPageNo-1) * 10) }"/>
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
    })
    
    $(".bt-review-wr").click(function(){
    	document.location.href="${rootPath}/cs/insert"
    })
    
    $(".cs_tr").click(function(){
    	let id = $(this).data("id")
    	document.location.href="${rootPath}/cs/detail/"+id
    })
    
  })
  </script>
</head>
<body>
<%@ include file="/WEB-INF/views/include/include-nav.jspf" %>
    <!--main 화면 bbs 들어갈 것-->
    <article class="all-browsers">
      <div class="hr-sect mb-5">
			Service center</div>

      <!-- bbsList -->
      <div class="container">
      	<form>
	        <div class="bbs-search-div d-flex justify-content-center">
	          <input class="bbs-search" placeholder="검색내용을 입력해주세요" 
	          	name="search" value="${search}"/>
	          <button class="bt-bbs-search">검색</button>
	        </div>
        </form>
        <table class="table">
          <thead>
            <tr>
              <th>NO</th>
              <th>제목</th>
              <th>등록일</th>
              <th>작성자</th>
              <th>조회수</th>
            </tr>
          </thead>
          <tbody class="tbody-style">
          	<c:choose>
          		<c:when test="${empty CSLIST}">
          			<tr>
          				<td colspan="5">게시글이 없습니다.</td>
          			</tr>
          		</c:when>
          		<c:otherwise>
		          	<c:forEach items="${CSLIST}" var="cs">
		          		<tr class="cs_tr" data-id="${cs.cs_id}">
			          		<td>${num}</td>
			          		<td>${cs.cs_title}</td>
			          		<td>${cs.cs_date}</td>
			          		<td>${cs.cs_username}</td>
			          		<td>${cs.cs_count}</td>
		          		</tr>
		          		<c:set var="num" value="${num-1}"></c:set>
		          	</c:forEach>
          		</c:otherwise>
          	</c:choose>
          </tbody>
        </table>
        <div class="d-flex justify-content-end">
          <button
            class="bt-review-wr"
            type="button"
          >
            작성하기
          </button>
        </div>
        <!--pagination-->
        <div class="d-flex justify-content-center">
          <nav aria-label="Page navigation example">
          	<%@ include file="/WEB-INF/views/include/include-paging.jspf" %>
          </nav>
        </div>
        <!--pagination end-->
      </div>
    </article>



</body>
<%@ include file="/WEB-INF/views/include/include-footer.jspf" %>
</html>