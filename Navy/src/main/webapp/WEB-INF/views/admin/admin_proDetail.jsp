<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ include file="/WEB-INF/views/include/include-head.jspf"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>
	$(document)
			.ready(
					function() {
						let templates = '<div class="select-box">';
						templates += '<select class="select" name="test" style="height: 30px;>';

						templates += '<option value="black_s">BLACK S</option>';
						templates += '<option value="black_m">BLACK M</option>';
						templates += '<option value="black_l">BLACK L</option>';
						templates += '<option value="white_s">WHITE S</option>';
						templates += '<option value="white_m">WHITE M</option>';
						templates += '<option value="white_l">WHITE L</option>';
						templates += '<option value="red_s">RED S</option>';
						templates += '<option value="red_m">RED M</option>';
						templates += '<option value="red_l">RED L</option>';

						templates += '</select>';
						templates += ' <input type="number" style="width: 50px;" />';
						templates += '<span class="delete-selectbox">&cross;</span>';
						templates += '</div>';
						$('#btn-plus').click(function() {
							$('#select-container').append(templates);
						});

						$(document).on('click', '.delete-selectbox',
								function() {
									$(this).closest('div').remove();
								});
					});
</script>
</head>
<body>
		<!--detail pages 정보 -->
		<div class="container">
			<div class="row"  style="flex-wrap:nowrap">
				<img src="../img/dress1.jpg"
					style="width: 450px; height: 400px; margin-right: 70px;" />
					${productVO.p_image}
				<!--detail box-->
				<div class="detail-box"
					style="margin-left: 70px; margin-bottom: 100px;">
					<div class="mb-3 mt-5">
						<h2 class="black-text">${productVO.p_name}</h2>
						<span>${productVO.p_price}won</span>
					</div>
					<hr style="border: 1px solid #252c41;" />
					<br />

					<div class="col">
						<label class="mr-5">COLOR/SIZE</label>
						<ul class="menu">
							<li>BLACK S(20)</li>
							<li>BLACK M(20)</li>
							<li>BLACK L(20)</li>
							<li>RED S(20)</li>
							<li>RED M(20)</li>
							<li>RED L(20)</li>
							<li>WHITE S(20)</li>
							<li>WHITE M(20)</li>
							<li>WHITE L(20)</li>
						</ul>
					</div>
					<div class="col mb-5">
						<label class="mr-5">QUAN·TITY</label> <span>180개</span> <br /> <label
							class="mr-5">TOTAL</label> <span>2,700,000won</span>
					</div>

					<!-- 장바구니 상품 button -->
					<div class="d-flex justify-content-end mb-5">
						<button class="mr-2 bt-bbs-style ad-pro-list" type="button">
							목록</button>
						<!-- 회원일시 보이는 버튼-->
						<button class="mr-2 bt-bbs-style ad-pro-update" type="button"
							data-id="${productVO.p_code}">수정</button>
						<button class="mr-2 bt-bbs-style ad-pro-delete" type="button"
							data-id="${productVO.p_code}">삭제</button>
					</div>
				</div>
			</div>
		</div>
		<!-- end -->

</body>
</html>