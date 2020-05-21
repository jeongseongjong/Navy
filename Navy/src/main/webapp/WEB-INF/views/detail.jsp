<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/views/include/include-head.jspf"%>
<%@ page import="java.util.*, java.text.*"%>

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
			let p_qty = parseInt($("#p_qty").val())
			let c_color = $("#c_color").val()
			let s_size = $("#s_size").val()
			alert(s_size)
			alert(c_color)
			console.log("야이 개새끼야")
			if (p_qty <= 0) {
				alert("수량은 0개 이상")
				return false;
			}

			$.ajax({
				url : "${rootPath}/cart/cart",
				type : "POST",
				data : {
					p_name : "${productVO.p_name}",
					p_code : "${productVO.p_code}",
					p_price : "${productVO.p_price}",
					p_size : s_size,
					p_color : c_color,
					p_qty : p_qty,
					// 포스트일 경우에는 이 값을 보내주어야 한다.
					"${_csrf.parameterName}" : "${_csrf.token}"
				},
				success : function(result) {

					if (result == 'LOGIN_FAIL') {
						alert("먼저 로그인을 수행해야 한다.")
					} else if (result == "OK") {
						if (confirm("상품을 카트에 담았습니다.\n" + "장바구니로 이동하겠습니까?")) {
							document.location.href = "${rootPath}/cart/view"
						}
					}
				},
				error : function() {
					alert("서버 통신 오류")
				}
			})
		})

		$("#btn-buy").click(function() {
			// let id = $(this).data("id")
			document.location.href = "${rootPath}/cart/buy" // + id
		})
		
		$(".bt-review-wr").click(function() {
			let id = $(this).data("id")
			document.location.href = "${rootPath}/user/review/" + id
		})

	})
</script>
</head>
<body>
	<%@ include file="/WEB-INF/views/include/include-nav.jspf"%>

    <article class="all-browsers">
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
           				<div class="dropdownbox">
							<p>컬러를 선택해주세요</p>
						</div>
						<c:if test="${!empty productVO.sizeList}">
							<select id="p_size">
								<c:forEach items="${productVO.sizeList}" var="size">
									<option value="${size.s_size}">${size.s_size}</option>
									<c:if test="${!empty size.colorList}">
										<c:forEach items="${size.colorList}" var="color">
											<option value="${color.c_color}">${color.c_color}</option>
										</c:forEach>
									</c:if>
								</c:forEach>
							</select>
						</c:if>
						
						<!-- 
						<div id="color_box"></div>
					
						<script>
						$(function(){
							   $(document).on("change","#color",function(){
					               let size = $("#size").val()            
					               let item = $(this).val()
					               $("div#color_box").append($("<input/>",{class:"auth form-control-plaintext", name:"size",value:size}))
					               $("div#color_box").append($("<input/>",{class:"auth form-control-plaintext", name:"color",value:item}))
							   })
						})
						</script>
					 
						<c:if test="${!empty productVO.sizeList}">
							<select id="size">
								<option selected="selected">사이즈를 선택하세요</option>
								<c:forEach 	items="${SIZELIST}" var="size">
									<option id="s_size" value="${size.s_size}">${size.s_size}</option>
								</c:forEach>
							</select>
							<select id="color">
								<option selected="selected">색상을 선택하세요</option>
								<c:forEach items="${COLORLIST}" var="color">
									<option id="c_color" value="${color.c_color}">${color.c_color}</option>
								</c:forEach>
							</select>
						</c:if>
						-->
      				</div>

			        <div class="col mb-5">
			        	<label class="mr-5">QUAN·TITY</label>
			          	<input id="p_qty" type="number" class="text-center" style="width: 80px;" />
			        </div>
			
			        <!-- 장바구니 상품 button -->
			        <div class="d-flex justify-content-center">
			        	<button id="btn-cart" class="bt-css">장바구니</button>
			          	<button id="btn-buy" class="bt-css">바로구매</button>
			        </div>
				</div>
			</div>
		</div>
		<!-- end -->

      	<div class="hr-sect mb-5">DETAIL INFO</div>
      	<!-- 상세 정보 -->
      	<div class="container">
		 	<!-- 상품 디테일 이미지 -->
			<div class="col w3-center mb-5">
				<c:choose>
					<c:when test="${empty productVO.proDImgList}">
						<div style="width: 50%; margin-bottom: 200px;">상품의 디테일정보가 없습니다.</div>
					</c:when>
					<c:otherwise>
						<img src="${rootPath}/resources/img/dress2.jpg" style="width: 50%;" />
						<div style="width: 50%; margin-bottom: 200px;">
							${productVO.proDImgList[0].p_img_upload_name}
						</div>
						<div class="justify-content-center">
							<input class="more-style" value="- MORE VIEW -"
								onclick="if(this.parentNode.getElementsByTagName('div')[0].style.display != '')
				            	{this.parentNode.getElementsByTagName('div')[0].style.display = '';this.value = '- FOLDING -';}
				            	else{this.parentNode.getElementsByTagName('div')[0].style.display = 'none'; this.value = '- MORE VIEW -';}"
								type="button" />
							<div style="display: none;">
								<c:forEach items="${productVO.proDImgList}" var="proDImg" begin="1">
									<div data-id="${proDImg.p_img_seq}" data-pcode="${productVO.p_code}">
										<img src="${rootPath}/resources/img/dress2.jpg" style="width: 50%;" />
										<div style="width: 50%; margin-bottom: 200px;">${proDImg.p_img_upload_name}</div>
									</div>
								</c:forEach>
							</div>
						</div>
					</c:otherwise>
				</c:choose>
			</div><!-- 상품 디테일 이미지 end -->

        	<!-- review Q&A-->
        	<ul class="nav nav-tabs" id="myTab" role="tablist">
          		<li class="nav-item">
            		<a class="nav-link active" id="home-tab" data-toggle="tab"
						href="#home" role="tab" aria-controls="home" aria-selected="true">유의사항</a>
          		</li>
          		<li class="nav-item">
            		<a class="nav-link" id="profile-tab" data-toggle="tab"
						href="#profile" role="tab" aria-controls="profile" aria-selected="false">REVIEW</a>
          		</li>
          		<li class="nav-item">
            		<a class="nav-link" id="contact-tab" data-toggle="tab"
					href="#contact" role="tab" aria-controls="contact" aria-selected="false">Q&A</a>
          		</li>
        	</ul>
        	
        	<!--tab 본문-->
        	<div class="tab-content" id="myTabContent">
          		<!--유의 사항-->
          		<div class="tab-pane fade show active" id="home" role="tabpanel" aria-labelledby="home-tab">
            		<img src="${rootPath}/resources/img/shopguide.jpg" />
          		</div>

          		<!--review -->
		        <div class="tab-pane fade" id="profile" role="tabpanel" aria-labelledby="profile-tab">
					<div class="d-flex justify-content-end">
						<button class="bt-review-wr"  data-id="${productVO.p_code}">리뷰작성</button>
					</div>
					
					<!-- 리뷰List -->
					<c:choose>
						<c:when test="${empty productVO.reviewList}">
							<div class="container-fluid" style="border-bottom: 1px solid #8c8d90; margin: 40px;">
								<p>상품 REVIEW가 없습니다.</p>
							</div>
						</c:when>
						<c:otherwise>
							<c:forEach var="REVIEW" items="${productVO.reviewList}">
								<div data-id="${REVIEW.r_id}" class="container-fluid" style="border-bottom: 1px solid #8c8d90; margin: 40px;">
									<span class="pro-star">상품</span>
									
									<!-- 별점 -->
									<input type="radio" name="rating" value="1" id="star-1" class="star__radio visuhide" />
									<input type="radio" name="rating" value="2" id="star-2" class="star__radio visuhide" />
									<input type="radio" name="rating" value="3" id="star-3" class="star__radio visuhide" />
									<input type="radio" name="rating" value="4" id="star-4" class="star__radio visuhide" />
									<input type="radio" name="rating" value="5" id="star-5" class="star__radio visuhide" />
									
									<label class="star__item" for="star-1">
										<span class="visuhide">1 star</span>
									</label>
									<label class="star__item" for="star-2">
										<span class="visuhide">2 stars</span>
									</label>
									<label class="star__item" for="star-3">
										<span class="visuhide">3 stars</span>
									</label>
									<label class="star__item" for="star-4">
										<span class="visuhide">4 stars</span>
									</label>
									<label class="star__item" for="star-5">
										<span class="visuhide">5 stars</span>
									</label>
									<span>${REVIEW.r_start}</span><!-- 별점 end -->
									
									<!-- 상품명 -->
									<span class="row" style="font-size: 20px; margin-top: 10px; color: #8c8d90;
											margin-bottom: 20px; margin-left: 30px;">${productVO.p_name}</span>
											<!-- 사이즈, 색깔 리스트 재수정해야 함 -->
											<c:forEach items="${productVO.sizeList}" var="list">
												<span>${list.s_size}</span>	
											</c:forEach>
									<div class="container">
										<div class="row" style="margin-left: 30px; margin-bottom: 20px;">
											<div class="col-sm-4 d-flex justify-content-center">
												<img src="${rootPath}/resources/img/dress1.jpg" style="width: 50%;" />
											</div>
											<div class="col-sm-8" style="vertical-align: middle; top: 30px;">
												<span>${REVIEW.r_text}</span>
											</div>
											
											<!--사용자 id 작성 날짜-->
											<div class="mt-5">
												<span>${REVIEW.r_auth}</span> <span>&#124;</span> <span>${REVIEW.r_date}</span>
											</div>
										</div>
									</div><!-- 상품명 end -->
								</div>
							</c:forEach>
						</c:otherwise>
					</c:choose><!-- 리뷰List end -->
				</div><!-- 리뷰 end -->

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
                  <span class="mr-2">qus**</span>
                  <span style="color: #8c8d90;">&#124;</span>
                  <span class="ml-2">2020-05-13</span>
                </div>
                <!--질문-->
                <div>
                  <p>
                    Lorem ipsum dolor sit amet, consectetur adipiscing elit.
                    Cras luctus nunc ut maximus consequat. Vestibulum et mi
                    vulputate, convallis tortor quis, blandit mi. Suspendisse?
                  </p>
                </div>
                <div class="mb-3">
                  <a style="margin-right: 10px;">댓글보기 : 0개</a>
                  <span style="color: #8c8d90;">&#124;</span>
                  <button style="margin-left: 10px;" class="qa-btn">
                    댓글달기
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
                  <span class="mr-2">qus**</span>
                  <span style="color: #8c8d90;">&#124;</span>
                  <span class="ml-2">2020-05-13</span>
                </div>
                <!--질문-->
                <div>
                  <p>
                    Lorem ipsum dolor sit amet, consectetur adipiscing elit.
                    Cras luctus nunc ut maximus consequat. Vestibulum et mi
                    vulputate, convallis tortor quis, blandit mi. Suspendisse?
                  </p>
                </div>
                <div class="mb-3">
                  <a style="margin-right: 10px;">댓글보기 : 0개</a>
                  <span style="color: #8c8d90;">&#124;</span>
                  <button style="margin-left: 10px;" class="qa-btn">
                    댓글달기
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
                  <span class="mr-2">qus**</span>
                  <span style="color: #8c8d90;">&#124;</span>
                  <span class="ml-2">2020-05-13</span>
                </div>
                <!--질문-->
                <div>
                  <p>
                    Lorem ipsum dolor sit amet, consectetur adipiscing elit.
                    Cras luctus nunc ut maximus consequat. Vestibulum et mi
                    vulputate, convallis tortor quis, blandit mi. Suspendisse?
                  </p>
                </div>
                <div class="mb-3">
                  <a style="margin-right: 10px;">댓글보기 : 0개</a>
                  <span style="color: #8c8d90;">&#124;</span>
                  <button style="margin-left: 10px;" class="qa-btn">
                    댓글달기
                  </button>
                </div>
              </div>
            </div>
            <!--end-->
          </div>
        </div>

        <!--reviews end-->
      </div>

      <!--end-->
    </article>
	
	<!--  -->

	<%@ include file="/WEB-INF/views/include/include-footer.jspf"%>
</body>
</html>

