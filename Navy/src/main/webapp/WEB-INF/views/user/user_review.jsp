<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<script>
$(function(){
	$(".like").click(function(){
		$like = $(this)
		let like = $(this).data("like")
		let r_id = $(this).data("id")
		alert(like)
		alert($(this).children("span").text())
		let r_like = like += 1
		
		
		$.ajax({
			url : "${rootPath}/user/update",
			method : "POST",
			data : {
				r_id : r_id,
				r_like : r_like,
				"${_csrf.parameterName}" : "${_csrf.token}"
			},
			success : function(result){
				if(result == "OK"){
					alert(r_like)	
					$($like).children("span").text(r_like)
				}else{
					alert("실패")
				}
			},
			error : function(){
				alert("서버통신 오류")
			}
		})
	})
})
</script>
<!--review -->
<div class="tab-pane fade" id="profile" role="tabpanel"
	aria-labelledby="profile-tab">
	<div class="d-flex justify-content-end">
		<!-- <button class="bt-review-wr" data-id="${productVO.p_code}">리뷰작성</button> -->
	</div>

	<!-- 리뷰List -->
	<c:choose>
		<c:when test="${empty productVO.reviewList}">
			<div class="container-fluid"
				style="border-bottom: 1px solid #8c8d90; margin: 40px;">
				<p>상품 REVIEW가 없습니다.</p>
			</div>
		</c:when>
		<c:otherwise>
		
			<c:forEach var="REVIEW" items="${productVO.reviewList}">
			
				<div data-id="${REVIEW.r_id}" class="container-fluid"
					style="margin: 40px;">
						<div class="container-fluid"
							style="border-bottom: 1px solid #8c8d90; margin: 15px;">
							<!--상품명-->
							<!--별점-->
							<c:if test="${REVIEW.r_star == 0}">
							<div class="starRev one-line">
								<label class="la_st_box"> 별점
								 	<span class="starR">별1</span>
									<span class="starR">별2</span> 
									<span class="starR">별3</span>
									<span class="starR">별4</span> 
									<span class="starR">별5</span>
								</label>
								<div class="re_cmd like"  data-like="${REVIEW.r_like}" data-id="${REVIEW.r_id}">♡<span>${REVIEW.r_like}</span></div>
							</div>
							</c:if>
							<c:if test="${REVIEW.r_star == 1}">
							<div class="starRev one-line">
								<label class="la_st_box"> 별점
								 	<span class="starR on">별1</span>
									<span class="starR">별2</span> 
									<span class="starR">별3</span>
									<span class="starR">별4</span> 
									<span class="starR">별5</span>
								</label>
								<div class="re_cmd like"  data-like="${REVIEW.r_like}" data-id="${REVIEW.r_id}">♡<span>${REVIEW.r_like}</span></div>
							</div>
							</c:if>
							<c:if test="${REVIEW.r_star == 2}">
							<div class="starRev one-line">
								<label class="la_st_box"> 별점
								 	<span class="starR on">별1</span>
									<span class="starR on">별2</span> 
									<span class="starR">별3</span>
									<span class="starR">별4</span> 
									<span class="starR">별5</span>
								</label>
								<div class="re_cmd like"  data-like="${REVIEW.r_like}" data-id="${REVIEW.r_id}">♡<span>${REVIEW.r_like}</span></div>
							</div>
							</c:if>
							<c:if test="${REVIEW.r_star == 3}">
							<div class="starRev one-line">
								<label class="la_st_box"> 별점
								 	<span class="starR on">별1</span>
									<span class="starR on">별2</span> 
									<span class="starR on">별3</span>
									<span class="starR">별4</span> 
									<span class="starR">별5</span>
								</label>
								<div class="re_cmd like"  data-like="${REVIEW.r_like}" data-id="${REVIEW.r_id}">♡<span>${REVIEW.r_like}</span></div>
							</div>
							</c:if>
							<c:if test="${REVIEW.r_star == 4}">
							<div class="starRev one-line">
								<label class="la_st_box"> 별점
								 	<span class="starR on">별1</span>
									<span class="starR on">별2</span> 
									<span class="starR on">별3</span>
									<span class="starR on">별4</span> 
									<span class="starR">별5</span>
								</label>
								<div class="re_cmd like"  data-like="${REVIEW.r_like}" data-id="${REVIEW.r_id}">♡<span>${REVIEW.r_like}</span></div>
							</div>
							</c:if>
							<c:if test="${REVIEW.r_star == 5}">
							<div class="starRev one-line">
								<label class="la_st_box"> 별점
								 	<span class="starR on">별1</span>
									<span class="starR on">별2</span> 
									<span class="starR on">별3</span>
									<span class="starR on">별4</span> 
									<span class="starR on">별5</span>
								</label>
								<div class="re_cmd like"  data-like="${REVIEW.r_like}" data-id="${REVIEW.r_id}">♡<span>${REVIEW.r_like}</span></div>
							</div>
							</c:if>
							<!-- 별점 end -->

							<div class="container">
								<div class="img_rw_box">
									<img src="${rootPath}/resources/img/dress1.jpg" class="img_rw" />

									<span class="rw_pr_tit">${productVO.p_name}</span> <span
										class="rw_txt">${REVIEW.r_text} </span>
								</div>

								<!--사용자 id 작성 날짜-->
								<div class="mt-5">
									<span>${REVIEW.r_auth }</span> <span>&#124;</span> <span>${REVIEW.r_date}</span>
								</div>
							</div>
						</div>
						<!-- 상품명 end -->
				</div>
			</c:forEach>
		</c:otherwise>
	</c:choose>
	<!-- 리뷰List end -->
</div>
<!-- 리뷰 end -->

