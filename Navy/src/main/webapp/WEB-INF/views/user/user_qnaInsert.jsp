<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

<script>
$(function() {
	var read1 = document.getElementById("read1");
	read1.readOnly = true;
	
	$("#btn-save").click( function() {
		$("form").submit()
	})
})
</script>

<div class="tab-pane fade" id="contact" role="tabpanel" aria-labelledby="contact-tab">
	<div class="d-flex justify-content-end">
		<button class="bt-review-wr">질문하기</button>
	</div>

	<!-- Qna input -->
	<div>
		<hr/>
			<form:form action="${rootPath}/product/detail/${productVO.p_code}" modelAttribute="qnaVO">
				<form:input type="hidden" path="q_id" /><br/>
				<form:input type="hidden" path="q_code" /><br/>
				<form:input id="read1" path="q_auth" /><br/>
				<form:input type="hidden" path="q_date" /><br/>
				<form:input path="q_text" /><br/>
			</form:form>
			<button id="btn-save" type="button">저장</button>
		<hr/>
	</div>
	<!-- Qna input end -->
	
	<!-- Qna List -->
	<div class="container">
		<c:choose>
			<c:when test="${empty productVO.qnaList}">
				<div style="border-bottom: 1px solid #8c8d90;" class="justify-content-center">
					<p>상품 QNA가 없습니다.</p>
				</div>
			</c:when>
			<c:otherwise>
				<c:forEach var="QNA" items="${productVO.qnaList}">
					<div  data-id="${QNA.q_id}" style="border-bottom: 1px solid #8c8d90;" class="justify-content-center">
						<div class="row mt-5" style="margin-bottom: 20px;">
							<span class="mr-2">${QNA.q_auth}</span>
                  			<span style="color: #8c8d90;">&#124;</span>
                  			<span class="ml-2">${QNA.q_date}</span>
						</div>
						<div>
							<p>${QNA.q_text}</p>
						</div>
						<div class="mb-3">
							<a style="margin-right: 10px;">댓글보기 : 0개</a>
							<span style="color: #8c8d90;">&#124;</span>
							<button style="margin-left: 10px;" class="qa-btn">댓글달기</button>
						</div>
					</div>
				</c:forEach>
			</c:otherwise>
		</c:choose>
	</div>
	<!-- Qna end -->
</div>
