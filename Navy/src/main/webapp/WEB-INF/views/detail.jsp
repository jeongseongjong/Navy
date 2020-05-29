<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/views/include/include-head.jspf"%>
<%@ page import="java.util.*, java.text.*"%>

<script>
	$(function() {
		
		$("#sizeList").change(function() {
			
			let s_code = $(this).find("option:selected").data("id")
			alert(s_code)
			
			$.ajax({
			
				url : "${rootPath}/product/get_color_list_by_size",
				method : "GET",
				data : { s_code : s_code }
				
			})
			.done(function(colorList) {
						
				if(colorList == "FAIL") {
					alert("통신오류")
				} else if(!colorList.length) {
					alert("컬러리스트가 없습니다.")
				} else {
					colorList.forEach(function(vo) {
						$("#colorList").append($("<option/>", {value : vo.c_color, text : vo.c_color, 'data-id' : vo.c_code}))
					})
				}
				
			})
			
		})
			
			$("#colorList").change(function() {
			
				let c_code = $(this).find("option:selected").data("id")
				alert(c_code)
			
			})
		
		
		
		
		

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
			let p_color = $("#p_color").val()
			let p_size = $("#p_size").val()
			alert(p_size)
			alert(p_color)
			alert("${productVO.p_name}")

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
					p_size : p_size,
					p_color : p_color,
					p_qty : p_qty,
					// 포스트일 경우에는 이 값을 보내주어야 한다.
					"${_csrf.parameterName}" : "${_csrf.token}"
				},
				success : function(result) {

					if (result == 'LOGIN_FAIL') {
						alert("먼저 로그인을 수행해야 한다.")
					} else if (result == "OK") {
						if (confirm("상품을 카트에 담았습니다.\n" + "장바구니로 이동하겠습니까?")) {
							console.log(result)
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
	
	<!-- detail pages 정보 -->
	<div class="container">
		<div class="row">
	    	<img src="${rootPath}/resources/img/dress1.jpg"
	      		style="width: 450px; height: 400px; margin-right: 70px;" />
	      		
			<!--detail box-->
			<div class="detail-box" style="margin-left: 70px; margin-bottom: 100px;">
	  			<div class="mb-3 mt-5">
	    			<h2 class="black-text">${productVO.p_name}</h2>
	   	 			<span>${productVO.p_price} won</span>
	  			</div>
	  			<hr style="border: 1px solid #252c41;" />
				<br />
				
				<select id="sizeList">
					<option>선택</option>
					<c:forEach items="${sizeList}" var="size">
						<option value="${size.s_size}" data-id="${size.s_code}">${size.s_size}</option>
					</c:forEach>
				</select>
				
				<select id="colorList">
					
				</select>

			<!-- 
				<div class="col">
	  				<label class="mr-5">SIZE/COLOR</label>
	  				<form:form modelAttribute="productVO">
	  					<form:select id="p_size" path="m_size_list" multiple="false" class="menu">
							<form:option value="SIZE를 선택하세요" />
							<form:options items="${m_size_list}" itemLabel="o_name" itemValue="o_standard" />
						</form:select>
						<form:select id="p_color" path="m_color_list" multiple="false">
							<form:option value="COLOR를 선택하세요" />
							<form:options items="${m_color_list}" itemLabel="o_name" itemValue="o_standard" />
						</form:select>
	  				</form:form>
				</div>
			 -->
				
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
	</div><!-- detail pages 정보 end -->

	<div class="hr-sect mb-5">DETAIL INFO</div>
  
	<!-- 상세 정보 -->
	<div class="container">
	
		<!-- 상품 디테일 이미지 -->
		<div class="col w3-center mb-5">
			<c:choose>
				<c:when test="${empty productVO.proDImgList}">
					<div style="width: 50%; margin-bottom: 200px;">
						상품의 디테일 정보가 없습니다.
					</div>
				</c:when>
				<c:otherwise>
					<div>${productVO.proDImgList[0].p_img_upload_name}</div>
					<img src="${rootPath}/resources/img/dress2.jpg" style="width: 50%; margin-bottom: 200px;" />
					<div class="justify-content-center">
  						<input class="more-style" value="- MORE VIEW -" onclick="if(this.parentNode.getElementsByTagName('div')[0].style.display != '')
							{this.parentNode.getElementsByTagName('div')[0].style.display = '';this.value = '- FOLDING -';}
							else{this.parentNode.getElementsByTagName('div')[0].style.display = 'none'; this.value = '- MORE VIEW -';}"
							type="button" />
						<div style="display: none;">
							<c:forEach items="${productVO.proDImgList}" var="proDImg" begin="1">
								<div data-id="${proDImg.p_img_seq}" data-pcode="${productVO.p_code}">
									<div>${proDImg.p_img_upload_name}</div>
									<img src="${rootPath}/resources/img/dress2.jpg" style="width: 50%; margin-bottom: 200px;" />
								</div>
							</c:forEach>
						</div>
					</div>
				</c:otherwise>
			</c:choose>
  		</div><!-- 상품 디테일 이미지 end -->
  		
		<!-- 유의사항 review Q&A-->
		<ul class="nav nav-tabs" id="myTab" role="tablist">
		  <li class="nav-item">
		    <a class="nav-link active" id="home-tab" data-toggle="tab" href="#home" role="tab" aria-controls="home" aria-selected="true">유의사항</a>
		  </li>
		  <li class="nav-item">
		    <a class="nav-link" id="profile-tab" data-toggle="tab" href="#profile" role="tab" aria-controls="profile" aria-selected="false">REVIEW</a>
		  </li>
		  <li class="nav-item">
		    <a class="nav-link" id="contact-tab" data-toggle="tab" href="#contact" role="tab" aria-controls="contact" aria-selected="false">Q&A</a>
		  </li>
		</ul>
		
		<!--tab 본문-->
		<div class="tab-content" id="myTabContent">
			<!--유의 사항-->
			<div class="tab-pane fade show active" id="home" role="tabpanel" aria-labelledby="home-tab">
			 	<img src="${rootPath}/resources/img/shopguide.jpg" />
			</div>
			
			<!--review -->
			<%@ include file="/WEB-INF/views/user/user_review.jsp" %>
				
			<!-- qna  -->
			<%@ include file="/WEB-INF/views/user/user_qna.jsp" %>
		</div>
	</div><!-- 유의사항 review Q&A end-->
</article>

<%@ include file="/WEB-INF/views/include/include-footer.jspf"%>
</body>
</html>

