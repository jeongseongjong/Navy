<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ include file="/WEB-INF/views/include/include-head.jspf"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="${rootPath}/resources/css/admin-pro-update.css" />
<style>
.product_type {
	width: 100px;
	display: inline-block;
}
</style>
<script>
$(function(){
	
	$("#p_desc").summernote();
	
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
    templates += ' <input name="color" style="width: 50px;" placeholder="색깔"/>';
    templates += ' <input name="qty" type="number" style="width: 50px;" placeholder="수량"/>';
    
    templates += '<span class="delete-selectbox">&cross;</span>';
    templates += '</div>';
	
	
    // 사이즈 종류 추가
	$("#btn-plus").click(function(){
		$('#select-container').append(templates);
	})
	
	$(".delete-selectbox").click(function(){
		
    //$(document).on('click', '.delete-selectbox', function () {
        $(this).closest('div').remove();
    });
    
	// 기존에 있던 재고 보여주는 select 박스들 지우기
	$(".existing_delete-selectbox").click(function(){
		let s_code = $(this).data("s_code")
		let c_code = $(this).data("c_code")
		let p_code = "${productVO.p_code}"
		
		if(confirm("선택하신 재고(사이즈, 컬러)를 지우시겠습니까?")) {
			$.ajax({
				url : "${rootPath}/admin/pro_existing_delete" ,
				method : "POST",
				data : {
					s_code : s_code,
					c_code : c_code
				},
				beforeSend : function(ax) {
					ax.setRequestHeader(
						"${_csrf.headerName}","${_csrf.token}"		
					)					
				}, success : function(result) {
					if ( result == 'SUCCESS' ) {
						alert("성공")						
						document.location.replace("${rootPath}/admin/pro_update/" + p_code)
					} else {
						alert("재고(사이즈, 컬러) 삭제 실패")						
					}
				}, error : function(){
					alert("서버 통신 오류")
				}
				
				
			})				
		}
	})
    
	$("#pro_append").click(function(){
		
		let size_input = $("<input/>", {class:"product_type form-control mb-3", name:"size", placeholder:"사이즈"})
		let color_input = $("<input/>", {class:"product_type form-control mb-3", name:"color", placeholder:"색깔"})
		let qty_input = $("<input/>", {class:"product_type form-control mb-3", name:"qty", placeholder:"수량"})
		let hr = $("<hr/>")
		// let auth_delete = $("<button class='btn btn-danger' type='button'>&times</button>")
		// auth_input.append($("<p/>",{text:'제거',class:'auth_delete'}))
		$("div#pro_size_list").append(size_input)
		$("div#pro_size_list").append(color_input)
		$("div#pro_size_list").append(qty_input)
		$("div#pro_size_list").append(hr)
		// $("div#auth_box").append(auth_delete)
	})
	
	// 사진 삭제
	$(".ad_bt_del").click(function(){
		let id = $(this).data("id")
		let p_code = "${productVO.p_code}"
		
		var length = $(".ad_main_img").length
		if (confirm("사진을 삭제하겠습니까?")) {
			// document.location.replace("${rootPath}/admin/delete?id=" + id)
			if(length < 2) {
				alert("상품이미지는 최소 1개 이상이어야 합니다.")
				return false
			} else {
				$.get("${rootPath}/admin/pro_imgs_delete/"+id, function(result){
						if(result == "DELETE"){
							document.location.replace("${rootPath}/admin/pro_update/" + p_code)
						} else {
							alert("삭제불가")
						}
					}		
				)
			}
		}
	})
	
	$(".ad_main_img").click(function(){
		let imgName = $(this).data("name")
		let p_code = "${productVO.p_code}"
		//alert(imgName)
		
		if(confirm("대표이미지를 선택한 사진으로 바꾸시겠습니까?")) {
			$.ajax({
				url : "${rootPath}/admin/repimg" ,
				method : "POST",
				data : {
					imgName : imgName,
					p_code : p_code
				},
				beforeSend : function(ax) {
					ax.setRequestHeader(
						"${_csrf.headerName}","${_csrf.token}"		
					)					
				}, success : function(result) {
					if ( result > 0 ) {
						document.location.replace("${rootPath}/admin/pro_detail_view/"+p_code)
					} else {
						alert("대표 이미지 변경 실패")						
					}
				}, error : function(){
					alert("서버 통신 오류")
				}
				
				
			})			
		}
		
	})
	
	
})
</script>
<style>
/*파일 업로드 버튼*/
#file-upload-button {
	border: 1px solid rgb(168, 163, 163);
	border-radius: 10px;
}
</style>
</head>
<body>
	<%@ include file="/WEB-INF/views/include/include-nav.jspf"%>
	<article class="all-browsers">
		<div class="hr-sect">ADMIN</div>

		<form:form modelAttribute="productVO"
			action="${rootPath}/admin/pro_update/${productVO.p_code}?${_csrf.parameterName}=${_csrf.token}"
			enctype="multipart/form-data">
			<div class="container">
				<!--sidebar-->
				<div class="row">
					<aside class="col-2 px-0" id="left"
						style="top: 250px; position: fixed; left: 0;">
						<div class="list-group w-100">
							<%@ include file="/WEB-INF/views/admin/admin-include-nav.jspf"%>
						</div>
					</aside>
					<main class="col offset-2 h-100 user-main" id="admin_content">
						<!-- 상품 입력 -->
						<div class="container big_pro_box">
							<div class="pro_list_box">
								<div>상품 정보 수정</div>
								<span>상품코드 : ${productVO.p_code}</span>
								<hr />
								<div class="pro_list_in">
									<div class="mb-3">
										<label class="mr-3" for="p_name">상품 이름</label>
										<form:input path="p_name" value="${productVO.p_name}"
											placeholder="상품이름을 입력해주세요" />
									</div>
									<div class="mb-3">
										<label class="mr-3" for="p_price">상품 가격</label>
										<form:input type="number" path="p_price"
											value="${productVO.p_price}" placeholder="가격을 입력해주세요" />
									</div>
									<div id="select-container">
										<label class="mr-3">상품 종류</label>
										<button type="button" id="btn-plus"
											style="border: 1px solid rgb(168, 163, 163); border-radius: 10px;">추가</button>
										<div id="pro_size_list" class="select-box">
											<c:forEach items="${productVO.sizeList}" var="size">
												<c:if test="${!empty size.colorList}">
													<c:forEach items="${size.colorList}" var="color">
														<li></li>
														<span>사이즈 : ${size.s_size}</span>
														<input name="existing_color" style="width: 50px;"
															placeholder="색깔" value="${color.c_color}" />
														<input name="existing_qty" type="number"
															style="width: 50px;" placeholder="수량"
															value="${color.c_qty}" />
														<input type="hidden" name="ex_qty" value="${color.c_qty}">
														<input name="existing_s_code" type="hidden"
															value="${size.s_code}">
														<input name="existing_c_code" type="hidden"
															value="${color.c_code}">
														<span class="existing_delete-selectbox"
															data-s_code="${size.s_code}"
															data-c_code="${color.c_code}">&cross;</span>
													</c:forEach>
												</c:if>
											</c:forEach>
										</div>
									</div>
									</div>

									<script>
	                  $(function () {
	                    $("button#del_1").on("click", function () {
	                      $("#img_1").empty();
	                    });
	                  });
	                </script>
									<div class="pro_list_img">
										<c:forEach items="${productVO.proDImgList}" var="img"
											varStatus="i">
											<c:if test="${i.index % 2 == 0}">
												<div class="cl_mt"></div>
											</c:if>
											<div class="ad_img_lt">
												<img class="ad_main_img"
													src="${rootPath}/images/${img.p_img_upload_name}"
													data-id="${img.p_img_seq}"
													data-name="${img.p_img_upload_name}"
													style="width: 130px; height: 130px" />
												<button type="button" class="ad_bt_del"
													data-id="${img.p_img_seq}">삭제</button>
												<input type="hidden" name="images" value="${img.p_img_upload_name}">
											</div>
										</c:forEach>
										<c:if test="${!empty productVO.p_image}">
										</c:if>
									</div>
							</div>
							<!--이미지 및 상세 정보-->
							<div>
								<label class="mr-3" for="p_image">이미지</label> <input
									multiple="multiple" type="file" id="p_file" name="file">

							</div>
							<div class="mt-3">
								<label>상품 정보</label>
								<div>
									<textarea id="p_desc" name="p_desc" style="width: 100%;"></textarea>
								</div>
								<!--buton group-->
								<div class="d-flex justify-content-end mt-3">
									<button class="bt-pro-save">저장</button>
								</div>
							</div>
						</div>
					</main>

				</div>
			</div>
		</form:form>
	</article>
</body>
<%@ include file="/WEB-INF/views/include/include-footer.jspf"%>
</html>