<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/views/include/include-head.jspf" %>

<script>
$(function() {
	
	var read1 = document.getElementById("read1");
	var read2 = document.getElementById("read2");
	var read3 = document.getElementById("read3");
	read1.readOnly = true;
	read2.readOnly = true;
	read3.readOnly = true;
	
	var toolbar = [
		['style',['bold','italic','underline'] ],
		['fontsize',['fontsize']],
		['font Style',['fontname']],
		['color',['color']],
		['para',['ul','ol','paragraph']],
		['height',['height']],
		['table',['table']],
		// ['insert',['link','hr','picture']],
		['view',['fullscreen','codeview']]
	]
	
	$("#r_text").summernote({
		lang:'ko-KR',
		placeholder:'본문을 입력하세요',
		width:'100%',
		toolbar:toolbar,
		height:'200px',
		disableDragAndDrop : true
	})
	
	
	$("#btn-save").click( function() {
		
		$("form").submit()
		
	})

	
})
</script>

</head>
<body>
<%@ include file = "/WEB-INF/views/include/include-nav.jspf" %>
<h3>사용자 리뷰 페이지</h3>
<div>상품이름 : ${productVO.p_name}</div>
<form:form action="${rootPath}/user/review/${productVO.p_code}" modelAttribute="reviewVO">
	<form:input type="hidden" path="r_id" /><br/>
	
	<label>별점 : </label>
	<form:input type="number" path="r_start" min="1" max="5" /><br/>
	
	<form:input type="hidden"  id="read1" path="r_code" /><br/>
	
	<label>사용자이름 : </label>
	<form:input id="read2"  path="r_auth" /><br/>
		
	<label>날짜 : </label>
	<form:input id="read3" path="r_date" /><br/>
	
	<label>내용 : </label>
	<form:textarea path="r_text" />
	
	<label>이미지 : </label>
	<form:input path="r_image" /><br/>
</form:form>

<button id="btn-save" type="button">저장</button>
 
 
 <div>카트상품코드 : ${cartVO.username}</div>
<div>상품코드 : ${productVO.p_code}</div>
<div>상품이름 : ${productVO.p_name}</div>
<div>사용자이름 : ${userVO.username}</div>

 
<%@ include file= "/WEB-INF/views/include/include-footer.jspf" %>
</body>
</html>
  