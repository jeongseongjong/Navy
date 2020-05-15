<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/views/include/include-head.jspf"%>

<script>
$(function() {

	$(document).ready(function() {
		$(".dropdownbox").click(function() {
			$(".menu").toggleClass("showMenu");
			$(".menu > li").click(function() {
				$(".dropdownbox > p").text($(this).text());
				$(".menu").removeClass("showMenu");
			});
		});
	});

	$("#btn-cart").click(function() {
		// let id = $(this).data("id")
		document.location.href = "${rootPath}/cart/list" // + id
	})

	$("#btn-buy").click(function() {
		// let id = $(this).data("id")
		document.location.href = "${rootPath}/cart/buy" // + id
	})

})
</script>
</head>
<body>
<%@ include file="/WEB-INF/views/include/include-nav.jspf"%>

<div class="hr-sect mb-5">DETAIL PAGE</div>

<!--detail pages 정보 -->
<div class="container">
	<div class="row">
		<img src="${rootPath}/resources/img/dress1.jpg" style="width: 450px; height: 400px; margin-right: 70px;" />
		
		<!--detail box-->
		<div class="detail-box" style="margin-left: 70px; margin-bottom: 100px;">
			<div class="mb-3 mt-5">
				<h2 class="black-text">${productVO.p_name}</h2>
          			<span>${productVO.p_price} won</span>
			</div>
			<hr style="border: 1px solid #252c41;" />
			<br />
			<div class="col">
				<label class="mr-5">COLOR/SIZE</label>
				<div class="dropdownbox">
					<p>색과 사이즈를 선택해주세요</p>
				</div>
              	<c:if test="${!empty productVO.sizeList}">
              		<c:forEach items="${productVO.sizeList}" var="size">
              			<ul class="menu" data-id="${size.c_p_code}" data-pcode="${productVO.p_code}">
			                <li>BLACK S(${size.c_black_s})</li>
			                <li>BLACK M(${size.c_black_m})</li>
			                <li>BLACK L(${size.c_black_l})</li>
			                <li>RED S(${size.c_red_s})</li>
			                <li>RED M(${size.c_red_m})</li>
			                <li>RED L(${size.c_red_l})</li>
			                <li>WHITE S(${size.c_white_s})</li>
			                <li>WHITE M(${size.c_white_m})</li>
			                <li>WHITE L(${size.c_white_l})</li>
		              	</ul>
              		</c:forEach>
              	</c:if>
			</div>
			<div class="col mb-5">
				<label class="mr-5">QUAN·TITY</label>
				<input type="number" class="text-center" style="width: 80px;" />
			</div>

			<!-- 장바구니 상품 button -->
			<div class="d-flex justify-content-center">
				<button id="btn-cart" class="bt-css">장바구니</button>
          			<button id="btn-buy" class="bt-css">바로구매</button>
			</div>
		</div><!--detail box end-->
	</div>
</div><!-- end -->

<div class="hr-sect mb-5">DETAIL INFO</div>

<!-- 상세정보 -->
<div class="container">





























</div><!--상세정보 end-->


















	<br />
	<br />
	<br />
	<br />
	<br />
	<p>------------------------------------------------------------------------------------------------------기준점--------------------------------------------------------------</p>
	<br />
	<br />
	<br />
	<br />
	<br />
	<br />
	<br />
	<br />
	
	
		<c:choose>
		<c:when test="${empty PROIMGLIST}">
			<div class="row">
				<div class="col m-3">
					<p>보여라라라라라라라라라ㅓ라라</p>
				</div>
			</div>
		</c:when>
		<c:otherwise>
			<c:forEach var="PROS" items="${PROIMGLIST}">
				<div class="row">
					<div class="col m-3">
						<div class="card" data-id="${PROS.p_img_seq}">
							<img class="detail-img" src="${rootPath}/resources/img/dress1.jpg" style="width: 100%;" />
							<div class="w3-container">
								<h6>
									<span>${PROS.p_img_p_code}</span><br />
									<small>${PROS.p_img_origin_name} won</small>
								</h6>
							</div>
						</div>
					</div>
				</div>
			</c:forEach>
		</c:otherwise>
	</c:choose>
	
	
	
	<div class="col w3-center mb-5">
	<c:choose>
		<c:when test="${empty productVO.proDImgList}">
			<div style="margin-bottom: 200px;">상품의 디테일정보가 없습니다.</div>
		</c:when>
		<c:otherwise>
			<c:forEach items="${productVO.proDImgList}" var="proDImg">
				<div data-id="${proDImg.p_img_seq}" data-pcode="${productVO.p_code}">
					<div>${proDImg.p_img_seq}</div>
					<div>${proDImg.p_img_p_code}</div>
					<div>${proDImg.p_img_origin_name}</div>
					<div>${proDImg.p_img_upload_name}</div>
				
				</div>
				
			</c:forEach>
		</c:otherwise>
	</c:choose>
	</div>	

	<div class="col w3-center mb-5">
		<c:if test="${!empty productVO.proDImgList}">
			<c:forEach items="${productVO.proDImgList}" var="proDImg">
				<div data-id="${proDImg.p_img_seq}" data-pcode="${productVO.p_code}">
					<div>${proDImg.p_img_seq}</div>
					<div>${proDImg.p_img_p_code}</div>
					<div>${proDImg.p_img_origin_name}</div>
					<div>${proDImg.p_img_upload_name}</div>
				
				</div>
				
			</c:forEach>
		</c:if>
	</div>	




			<!-- 상품 디테일 이미지 -->
			<div class="col w3-center mb-5">
				<img src="img/dress2.jpg" style="width: 50%; margin-bottom: 200px;" />
				<div class="justify-content-center">
					<input class="more-style" value="- MORE VIEW -"
						onclick="if(this.parentNode.getElementsByTagName('div')[0].style.display != '')
              {this.parentNode.getElementsByTagName('div')[0]
              .style.display = '';this.value = '- FOLDING -';}
              else{this.parentNode.getElementsByTagName('div')[0]
              .style.display = 'none'; this.value = '- MORE VIEW -';}"
						type="button" />
					<div style="display: none;">
						<img src="img/dress2.jpg"
							style="width: 50%; margin-bottom: 200px;" /> <img
							src="img/dress2.jpg" style="width: 50%; margin-bottom: 200px;" />
						<img src="img/dress2.jpg"
							style="width: 50%; margin-bottom: 200px;" />
					</div>
				</div>
			</div><!-- 상품 디테일 이미지 end -->
			
			
			
			

			<!-- review Q&A-->
			<ul class="nav nav-tabs" id="myTab" role="tablist">
				<li class="nav-item"><a class="nav-link active" id="home-tab"
					data-toggle="tab" href="#home" role="tab" aria-controls="home"
					aria-selected="true">유의사항</a></li>
				<li class="nav-item"><a class="nav-link" id="profile-tab"
					data-toggle="tab" href="#profile" role="tab"
					aria-controls="profile" aria-selected="false">REVIEW</a>
				</li>
				<li class="nav-item"><a class="nav-link" id="contact-tab"
					data-toggle="tab" href="#contact" role="tab"
					aria-controls="contact" aria-selected="false">Q&A</a>
				</li>
			</ul>
			<!--tab 본문-->
			<div class="tab-content" id="myTabContent">
				<!--유의 사항-->
				<div class="tab-pane fade show active" id="home" role="tabpanel"
					aria-labelledby="home-tab">
					<img src="./img/shopguide.jpg" />
				</div>

				<!--review -->

				<div class="tab-pane fade" id="profile" role="tabpanel"
					aria-labelledby="profile-tab">
					<div class="d-flex justify-content-end">
						<button class="bt-review-wr">리뷰작성</button>
					</div>
					<div class="container-fluid"
						style="border-bottom: 1px solid #8c8d90; margin: 40px;">
						<span class="pro-star">상품</span> <input type="radio" name="rating"
							value="1" id="star-1" class="star__radio visuhide" />
						<input type="radio" name="rating" value="2" id="star-2"
							class="star__radio visuhide" /> <input
							type="radio" name="rating" value="3" id="star-3"
							class="star__radio visuhide" /> <input
							type="radio" name="rating" value="4" id="star-4"
							class="star__radio visuhide" /> <input
							type="radio" name="rating" value="5" id="star-5"
							class="star__radio visuhide" /> <label
							class="star__item" for="star-1"><span
							class="visuhide">1 star</span></label> <label class="star__item"
							for="star-2"><span class="visuhide">2
								stars</span></label> <label class="star__item" for="star-3"><span
							class="visuhide">3 stars</span></label> <label class="star__item"
							for="star-4"><span class="visuhide">4
								stars</span></label> <label class="star__item" for="star-5"><span
							class="visuhide">5 stars</span></label>

						<!--상품명-->
						<span class="row"
							style="font-size: 20px; margin-top: 10px; color: #8c8d90; margin-bottom: 20px; margin-left: 30px;">White
							pants</span>
						<div class="container">
							<div class="row" style="margin-left: 30px; margin-bottom: 20px;">
								<div class="col-sm-4 d-flex justify-content-center">
									<img src="./img/dress1.jpg" style="width: 50%;" />
								</div>
								<div class="col-sm-8" style="vertical-align: middle; top: 30px;">
									<span>Lorem ipsum dolor sit
										amet, consectetur adipiscing elit. Cras luctus nunc ut maximus
										consequat. Vestibulum et mi vulputate, convallis tortor quis,
										blandit mi. Suspendisse vulputate ligula turpis, id tincidunt
										ipsum vestibulum ac. </span>
								</div>
								<!--사용자 id 작성 날짜-->
								<div class="mt-5">
									<span>quss**</span> <span>&#124;</span> <span>2020-05-13</span>
								</div>
							</div>
						</div>
					</div>
					<!--end-->
					<div class="container-fluid"
						style="border-bottom: 1px solid #8c8d90; margin: 40px;">
						<button class="bt-css">장바구니</button>
						<span class="pro-star">상품</span> <input type="radio" name="rating"
							value="1" id="star-1" class="star__radio visuhide" />
						<input type="radio" name="rating" value="2" id="star-2"
							class="star__radio visuhide" /> <input
							type="radio" name="rating" value="3" id="star-3"
							class="star__radio visuhide" /> <input
							type="radio" name="rating" value="4" id="star-4"
							class="star__radio visuhide" /> <input
							type="radio" name="rating" value="5" id="star-5"
							class="star__radio visuhide" /> <label
							class="star__item" for="star-1"><span
							class="visuhide">1 star</span></label> <label class="star__item"
							for="star-2"><span class="visuhide">2
								stars</span></label> <label class="star__item" for="star-3"><span
							class="visuhide">3 stars</span></label> <label class="star__item"
							for="star-4"><span class="visuhide">4
								stars</span></label> <label class="star__item" for="star-5"><span
							class="visuhide">5 stars</span></label>

						<!--상품명-->
						<span class="row"
							style="font-size: 20px; margin-top: 10px; color: #8c8d90; margin-bottom: 20px; margin-left: 30px;">White
							pants</span>
						<div class="container">
							<div class="row" style="margin-left: 30px; margin-bottom: 20px;">
								<div class="col-sm-4 d-flex justify-content-center">
									<img src="./img/dress1.jpg" style="width: 50%;" />
								</div>
								<div class="col-sm-8" style="vertical-align: middle; top: 30px;">
									<span>Lorem ipsum dolor sit
										amet, consectetur adipiscing elit. Cras luctus nunc ut maximus
										consequat. Vestibulum et mi vulputate, convallis tortor quis,
										blandit mi. Suspendisse vulputate ligula turpis, id tincidunt
										ipsum vestibulum ac. </span>
								</div>
								<!--사용자 id 작성 날짜-->
								<div class="mt-5">
									<span>quss**</span> <span>&#124;</span> <span>2020-05-13</span>
								</div>
							</div>
						</div>
					</div>
					<!--end-->
					<div class="container-fluid"
						style="border-bottom: 1px solid #8c8d90; margin: 40px;">
						<span class="pro-star">상품</span> <input type="radio" name="rating"
							value="1" id="star-1" class="star__radio visuhide" />
						<input type="radio" name="rating" value="2" id="star-2"
							class="star__radio visuhide" /> <input
							type="radio" name="rating" value="3" id="star-3"
							class="star__radio visuhide" /> <input
							type="radio" name="rating" value="4" id="star-4"
							class="star__radio visuhide" /> <input
							type="radio" name="rating" value="5" id="star-5"
							class="star__radio visuhide" /> <label
							class="star__item" for="star-1"><span
							class="visuhide">1 star</span></label> <label class="star__item"
							for="star-2"><span class="visuhide">2
								stars</span></label> <label class="star__item" for="star-3"><span
							class="visuhide">3 stars</span></label> <label class="star__item"
							for="star-4"><span class="visuhide">4
								stars</span></label> <label class="star__item" for="star-5"><span
							class="visuhide">5 stars</span></label>

						<!--상품명-->
						<span class="row"
							style="font-size: 20px; margin-top: 10px; color: #8c8d90; margin-bottom: 20px; margin-left: 30px;">White
							pants</span>
						<div class="container">
							<div class="row" style="margin-left: 30px; margin-bottom: 20px;">
								<div class="col-sm-4 d-flex justify-content-center">
									<img src="./img/dress1.jpg" style="width: 50%;" />
								</div>
								<div class="col-sm-8" style="vertical-align: middle; top: 30px;">
									<span>Lorem ipsum dolor sit
										amet, consectetur adipiscing elit. Cras luctus nunc ut maximus
										consequat. Vestibulum et mi vulputate, convallis tortor quis,
										blandit mi. Suspendisse vulputate ligula turpis, id tincidunt
										ipsum vestibulum ac. </span>
								</div>
								<!--사용자 id 작성 날짜-->
								<div class="mt-5">
									<span>quss**</span> <span>&#124;</span> <span>2020-05-13</span>
								</div>
							</div>
						</div>
					</div>
					<!--end-->
				</div>

				<div class="tab-pane fade" id="contact" role="tabpanel"
					aria-labelledby="contact-tab">
					<div class="d-flex justify-content-end">
						<button class="bt-review-wr">질문하기</button>
					</div>
					<!--구매자 id-->
					<div class="container">
						<div style="border-bottom: 1px solid #8c8d90;"
							class="justify-content-center">
							<div class="row mt-5" style="margin-bottom: 20px;">
								<span class="mr-2">qus**</span> <span style="color: #8c8d90;">&#124;</span>
								<span class="ml-2">2020-05-13</span>
							</div>
							<!--질문-->
							<div>
								<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit.
									Cras luctus nunc ut maximus consequat. Vestibulum et mi
									vulputate, convallis tortor quis, blandit mi. Suspendisse?</p>
							</div>
							<div class="mb-3">
								<a style="margin-right: 10px;">댓글보기 : 0개</a> <span
									style="color: #8c8d90;">&#124;</span>
								<button style="margin-left: 10px;" class="qa-btn">댓글달기
								</button>
							</div>
						</div>
					</div>
					<!--end-->
					<!--구매자 id-->
					<div class="container">
						<div style="border-bottom: 1px solid #8c8d90;"
							class="justify-content-center">
							<div class="row mt-5" style="margin-bottom: 20px;">
								<span class="mr-2">qus**</span> <span style="color: #8c8d90;">&#124;</span>
								<span class="ml-2">2020-05-13</span>
							</div>
							<!--질문-->
							<div>
								<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit.
									Cras luctus nunc ut maximus consequat. Vestibulum et mi
									vulputate, convallis tortor quis, blandit mi. Suspendisse?</p>
							</div>
							<div class="mb-3">
								<a style="margin-right: 10px;">댓글보기 : 0개</a> <span
									style="color: #8c8d90;">&#124;</span>
								<button style="margin-left: 10px;" class="qa-btn">댓글달기
								</button>
							</div>
						</div>
					</div>
					<!--end-->
					<!--구매자 id-->
					<div class="container">
						<div style="border-bottom: 1px solid #8c8d90;"
							class="justify-content-center">
							<div class="row mt-5" style="margin-bottom: 20px;">
								<span class="mr-2">qus**</span> <span style="color: #8c8d90;">&#124;</span>
								<span class="ml-2">2020-05-13</span>
							</div>
							<!--질문-->
							<div>
								<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit.
									Cras luctus nunc ut maximus consequat. Vestibulum et mi
									vulputate, convallis tortor quis, blandit mi. Suspendisse?</p>
							</div>
							<div class="mb-3">
								<a style="margin-right: 10px;">댓글보기 : 0개</a> <span
									style="color: #8c8d90;">&#124;</span>
								<button style="margin-left: 10px;" class="qa-btn">댓글달기
								</button>
							</div>
						</div>
					</div>
					<!--end-->
				</div>
			</div><!--reviews end-->

			








	<%@ include file="/WEB-INF/views/include/include-footer.jspf"%>
</body>
</html>
