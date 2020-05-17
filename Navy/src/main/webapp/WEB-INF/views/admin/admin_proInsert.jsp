<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ include file="/WEB-INF/views/include/include-head.jspf" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<section>
	<c:if test="${adminBody == 'proInsert' }">
		<h3>상품 등록</h3>
		<hr/>
	</c:if>
	<c:if test="${adminBody == 'proUpdate' }">
		<h3>상품 수정</h3>
		<hr/>
	</c:if>
	<form:form modelAttribute="productVO">

		<div class="input-group mb-3">
			<div class="input-group-prepend">
				<label for="p_name" class="input-group-text">상품명</label>
			</div>
			<form:input type="text" path="p_name" class="form-control"/>
		</div>
		<div class="input-group mb-3">
			<div class="input-group-prepend">
				<label for="p_price" class="input-group-text">가격</label>
			</div>
			<form:input type="text" path="p_price" class="form-control" />
		</div>
		<div class="input-group mb-3">
			<div class="input-group-prepend">
				<label for="p_qty" class="input-group-text">수량</label>
			</div>
			<form:input type="text" path="p_qty" class="form-control" />
		</div>
		<div class="input-group mb-3">
			<div class="input-group-prepend">
				<label for="p_desc" class="input-group-text">상품설명</label>
			</div>
			<form:input type="text" path="p_desc" class="form-control" />
		</div>

		<div class="input-group mb-3">
			<div class="input-group-prepend">
				<label for="p_desc" class="input-group-text">사진업로드</label>
			</div>
			<input type="text" name="p_image" class="form-control" />
		</div>
		
		<button>저장</button>
	</form:form>
	
</section>
</body>
</html>