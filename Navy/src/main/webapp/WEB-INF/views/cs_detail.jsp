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
	  /*
  		let cmt_repl =
        ' <div class="mt-3 row">';
        cmt_repl +=
        '<form class="cmt-repl-form" action="${rootPath}/cs/comment/repl" method="POST" >';
        cmt_repl +=
        '<input type="hidden" name="cs_c_b_id" value="${CSVO.cs_id}" />';
        cmt_repl +=
        '<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />';
        
        cmt_repl +=
        '</form>';
        cmt_repl += "</div>";
        */  
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
	  
	  $(".cmt-repl").click(function(event){
		  let c_id = $(this).data("cid")
		  let b_id = "${CSVO.cs_id}"
		  
		  let cmt_repl_p_id = $("<input/>", {class:"form-control mb-3", type:"hidden", name:"cs_c_p_id", value:c_id})
		  let cmt_repl_input = $("<input/>", {class:"form-control mb-3", name:"cs_c_subject"})
		  let btn_cmt_repl = '<button type="button" class="btn-cmt-repl">답글저장</button>';

		  //$("div.cmt-repl2").append(cmt_repl_input)
		  /*
		  $("form.cmt-repl-form").append(cmt_repl_input)
		  $("form.cmt-repl-form").append(cmt_repl_p_id)
		  $("form.cmt-repl-form").append(btn_cmt_repl)
		  */
		  /*
		  $("div.cmt-input").append(cmt_repl)
		  $("div.cmt-input").append(cmt_repl_p_id)
		  $("div.cmt-input").append(cmt_repl_input)
		  $("div.cmt-input").append(btn_cmt_repl)
		  */
		  
		let data = {cs_c_b_id:b_id, cs_c_p_id:c_id}
		
		event.stopPropagation()
		
		$.get("${rootPath}/cs/comment/repl",data,function(result){
			$(".modal-body").html(result)
			$(".modal-main").css("display","block")
			
		})
	  })
	  
	  $(".cmt-del").click(function(){
		  let c_id = $(this).data("cid")
		  let b_id = $(this).data("bid")
		  alert(c_id)
		  if(confirm("삭제하시겠습니까?")) {
			  alert("삭제")
			  document.location.replace("${rootPath}/cs/comment/delete?c_id="+c_id+"&b_id="+b_id)
		  }
	  })
	  
	  $(".btn-cmt-repl").click(function(){
		  alert("버튼 클릭")
		  $("form.cmt-repl-form").submit()
	  })

      $("#bt-plus").click(function () {
        $("#select-container").append(cmt_repl);
      });
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
          <c:if test="${empty LISTSIZE}">
          	<span>1</span>
          </c:if>
          <c:if test="${!empty LISTSIZE}">
	          <span>${LISTSIZE}</span>
	      </c:if>
          <div class="cmt-input">
          </div>
          <c:forEach items="${COMMENTLIST}" var="comment">
          	<c:if test="${comment.cs_c_p_id == 0}">
	         <div style="background-color: #f4f5f9;">
	         	<p class="text-left" style="float:left; left:0">${comment.cs_c_writer}</p>
	            <p class="text-right" style=" right:0">${comment.cs_c_date} ${comment.cs_c_time}
	            <span class="cmt-repl" 
	            	data-cid="${comment.cs_c_id}"
	            	data-bid="${CSVO.cs_id}">답글 </span>
	            <span class="cmt-del" 
	            	data-cid="${comment.cs_c_id}"
	            	data-bid="${CSVO.cs_id}">삭제</span>
	            </p>
	            <p>
	            <div>
	            <p class="ml-4">
	              ${comment.cs_c_subject}
	            </p>
	            </div> 
	            <div class="cmt-repl" id="${comment.cs_c_id > 0}">
	            
	            </div>
	         </div>
          	</c:if>
          	<!-- 대댓글 -->
          	<c:if test="${comment.cs_c_p_id != 0}">
				<div style="background-color: #f4f5f9;">
					<div class="ml-4 ">
		         	<p class=" text-left" style="float:left; left:0">${comment.cs_c_writer}</p>
		            <p class=" text-right" style=" right:0">${comment.cs_c_date} ${comment.cs_c_time}
		            <span class="cmt-del" 
		            	data-cid="${comment.cs_c_id}"
		            	data-bid="${CSVO.cs_id}">삭제</span>
		            </p>
		            <p>
		            <div>
		            <p class="ml-4">
		              &#8627; ${comment.cs_c_subject}
		            </p>
		            </div>
	            </div> 
	         </div>        		
          	</c:if>
          </c:forEach>
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
          	<form action="${rootPath}/cs/comment" method="POST">
	            <span class="ml-3">댓글 달기</span>
	            <div class="row justify-content-center mt-2">
	            	<input type="hidden" name="cs_c_b_id" value="${CSVO.cs_id}"/>
	              <input  style="width: 80%; height: 50px;" name="cs_c_subject"/>
	              <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
	              <button class="ml-5 bt-bbs-style">
	                저장
	              </button>
	
	            </div>
            </form>
          </div>
          <div>
          <!-- 
	            <form class="cmt-repl-form" action="${rootPath}/cs/comment/repl" method="POST">
	            	<input type="hidden" name="cs_c_b_id" value="${CSVO.cs_id}"/>
	            	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
	            </form>
	             -->
	      </div>
        </div>
	</div>
	</article>
<div class="modal-main">
	<div class="modal-content">
		<div class="modal-header">
			<span class="modal-close">&times;</span>
		</div>
		<div class="modal-body">
			
		</div>
	</div>
</div>
</body>
<%@ include file="/WEB-INF/views/include/include-footer.jspf" %>
</html>