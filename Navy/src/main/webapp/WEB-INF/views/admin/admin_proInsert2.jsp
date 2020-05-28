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
	
    let templates = '<div class="select-box">';
    templates += '<select class="select" name="size" style="height: 30px;>';

    templates += '<option value="사이즈">사이즈를 선택하세요</option>';
    templates += '<option value="S">S</option>';
    templates += '<option value="M">M</option>';
    templates += '<option value="L">L</option>';
    templates += '<option value="XL">XL</option>';
    templates += '<option value="XXL">XXL</option>';
    templates += '<option value="FREE">FREE</option>';

    templates += '</select>';
    templates += ' <input class="ProColor" name="color" style="width: 50px;" placeholder="색깔" required="required"/>';
    templates += ' <input class="ProQty" name="qty" type="number" style="width: 50px;" placeholder="수량" required="required"/>';
    
    templates += '<span class="delete-selectbox">&cross;</span>';
    templates += '</div>';
	
	
    // 사이즈 종류 추가
	$("#btn-plus").click(function(){
		$('#select-container').append(templates);
	})
	
	// 사이즈 종류 셀렉트박스 제거
	//$(".delete-selectbox").click(function(){
		
    $(document).on('click', '.delete-selectbox', function () {
        $(this).closest('div').remove();
    });
    /* 권한 설정관련 두번째 예시
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
	*/
	 // 상품 종류 추가 관련해서 유효성 검사
	 $(".bt-pro-save").click(function(){
	   var ele = $(".select").length;
	   //alert("셀렉트 개수:"+ele)
	                 	  
	   var arrColor = new Array();
	   var arrQty = new Array();
	   
	   let color = $(".ProColor").val()
	   let proqty = $(".ProQty").val()
	   
	   if(ele < 1 ){
		   alert("상품 종류를 추가해주세요")
		   return false
	   } else if(color == ""){
	   	alert("컬러테스트:"+color)
			alert("색상을 입력하세요.")
			return false
		   //alert("된다")
		   //$("form").submit()
	   } else if(proqty == "") {
	   	alert("수량:"+proqty)
			alert("수량을 입력하세요.")
			return false
	   } else {
		   //alert("된다")
		   $("form").submit()
	   }
	   
	})
})
</script>
</head>
<body>
	<!-- 상품 입력 -->
		<div class="container">
			<div>상품 정보 등록</div>
			<hr />
			<span>상품코드 : ${productVO.p_code}</span>
			<hr />
			<form:form modelAttribute="productVO" 
				action="${rootPath}/admin/pro_insert?${_csrf.parameterName}=${_csrf.token}"
				enctype="multipart/form-data">
			<div>
				<label for="p_name">상품 이름</label>
				<form:input path="p_name" value="${productVO.p_name}" placeholder="상품이름을 입력해주세요" />
			</div>
			<div>
				<label for="p_price">상품 가격</label> 
				<form:input path="p_price" value="${productVO.p_price}" placeholder="가격을 입력해주세요" />
			</div>
			<div id="select-container">
				<!-- 
				<label>상품 종류</label>
				<div align="right">
					<button type="button" class="btn btn-success mb-3" id="pro_append">제품 종류
						정보 입력 추가</button>
				</div>
				 -->
				<div id="pro_size_list">
				
				</div>
				<button type="button" id="btn-plus">제품 종류
						정보 입력 추가</button>
				<p>
				<span>사이즈 색상 수량</span>
				<div class="select-box">

				</div>
			</div>
			<!--이미지 및 상세 정보-->
			<div>
				<label for="p_image">이미지</label> 
				<input multiple="multiple" type="file" id="p_file" name="file" >
				<!-- 
				<form:input type="file" path="p_image" value="${productVO.p_image}" placeholder="" />
				 -->
			</div>
			<label>상품 정보</label>
			<div>
				<textarea style="width: 100%;"></textarea>
			</div>
			<!--buton group-->
			<div class="d-flex justify-content-end mt-3">
				<button class="bt-pro-save" type="button">
					저장</button>
			</div>
			</form:form>
		</div>

</body>
</html>