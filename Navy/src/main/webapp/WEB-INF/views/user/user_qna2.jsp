<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

<script>
$(function() {
	
	$("bt-qna-wr").click(function() {
		
		$("div.qnainputbox").css("display", "block")
		
		
	})
	
	
})
</script>

<style>
div.qnainputbox {
	display:none;
	border: 1px solid red;
}
</style>

<div class="tab-pane fade" id="contact" role="tabpanel" aria-labelledby="contact-tab">
	<div class="d-flex justify-content-end">
		<button class="bt-qna-wr">질문하기</button>
	</div>
	
	<div class="qnainputbox">
		<p>보여라라라라라라</p>
	</div>
		
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
