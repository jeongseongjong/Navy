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
$(function(){
	$("#pro_append").click(function(){
		
		let size_input = $("<input/>", {class:"auth form-control mb-3", name:"size", placeholder:"사이즈"})
		let color_input = $("<input/>", {class:"auth form-control mb-3", name:"color", placeholder:"색깔"})
		let qty_input = $("<input/>", {class:"auth form-control mb-3", name:"qty", placeholder:"수량"})
		// let auth_delete = $("<button class='btn btn-danger' type='button'>&times</button>")
		// auth_input.append($("<p/>",{text:'제거',class:'auth_delete'}))
		$("div#pro_size_list").append(size_input)
		$("div#pro_size_list").append(color_input)
		$("div#pro_size_list").append(qty_input)
		// $("div#auth_box").append(auth_delete)
	})
})
</script>
</head>
<body>
	<!-- 상품 입력 -->
		<div class="container">
			<c:if test="${adminBody == 'proInsert' }">
				<div>상품 정보 등록</div>
			</c:if>
			<c:if test="${adminBody == 'proUpdate' }">
				<div>상품 정보 수정</div>
			</c:if>
				<hr />
			<span>상품코드 : ${productVO.p_code}</span>
			<hr />
			<form:form modelAttribute="productVO">
			<div>
				<label for="p_name">상품 이름</label>
				<form:input path="p_name" value="${productVO.p_name}" placeholder="상품이름을 입력해주세요" />
			</div>
			<div>
				<label for="p_price">상품 가격</label> 
				<form:input path="p_price" value="${productVO.p_price}" placeholder="가격을 입력해주세요" />
			</div>
			<div id="select-container">
				<label>상품 종류</label>
				<div align="right">
					<button type="button" class="btn btn-success mb-3" id="pro_append">제품 종류
						정보 입력 추가</button>
				</div>
				<div id="pro_size_list">
				
				</div>
				<button type="button" id="btn-plus">추가</button>
				<div class="select-box">
					<select class="select" name="test" style="height: 30px;">
						<option value="black_s">BLACK S</option>
						<option value="black_m">BLACK M</option>
						<option value="black_l">BLACK L</option>
						<option value="white_s">WHITE S</option>
						<option value="white_m">WHITE M</option>
						<option value="white_l">WHITE L</option>
						<option value="red_s">RED S</option>
						<option value="red_m">RED M</option>
						<option value="red_l">RED L</option>
					</select> <input type="number" style="width: 50px;" /> <span
						class="delete-selectbox">&cross;</span>
				</div>
			</div>
			<!--이미지 및 상세 정보-->
			<div>
				<label for="p_image">이미지</label> 
				<form:input type="file" path="p_image" value="${productVO.p_image}" placeholder="" />
			</div>
			<label>상품 정보</label>
			<div>
				<textarea style="width: 100%;"></textarea>
			</div>
			<!--buton group-->
			<div class="d-flex justify-content-end mt-3">
				<button class="bt-pro-save">
					저장</button>
			</div>
			</form:form>
		</div>

</body>
</html>