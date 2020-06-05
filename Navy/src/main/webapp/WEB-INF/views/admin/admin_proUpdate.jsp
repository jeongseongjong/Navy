<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ include file="/WEB-INF/views/include/include-head.jspf"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
	
	$(".pro_images").click(function(){
		let id = $(this).data("id")
		let p_code = "${productVO.p_code}"
		if (confirm("사진을 삭제하겠습니까?")) {
			// document.location.replace("${rootPath}/admin/delete?id=" + id)
			
			$.get("${rootPath}/admin/pro_imgs_delete/"+id, function(result){
					if(result == "DELETE"){
						document.location.replace("${rootPath}/admin/pro_detail_view/" + p_code)
					} else {
						alert("삭제불가")
					}
				}		
			)
		}
		
	})
	
	
})
</script>
<style>
/*파일 업로드 버튼*/
#file-upload-button{
    border: 1px solid rgb(168, 163, 163);
    border-radius: 10px;
}
</style>
</head>
<body>
<%@ include file = "/WEB-INF/views/include/include-nav.jspf" %>
<article class="all-browsers">
      <div class="hr-sect">ADMIN</div>

      <div class="container">
        <!--sidebar-->
        <div class="row">
          <aside
            class="col-2 px-0"
            id="left"
            style="top: 250px; position: fixed; left: 0;"
          >
            <div class="list-group w-100">
				<%@ include file ="/WEB-INF/views/admin/admin-include-nav.jspf" %>
            </div>
          </aside>
			<main class="col offset-2 h-100 user-main" id="admin_content">
	<!-- 상품 입력 -->
		<div class="container">
			<div>상품 정보 수정</div>
			<span>상품코드 : ${productVO.p_code}</span>
			<hr />
			<form:form modelAttribute="productVO" 
				action="${rootPath}/admin/pro_update/${productVO.p_code}?${_csrf.parameterName}=${_csrf.token}"
				enctype="multipart/form-data">
			<div class="mb-3">
				<label class="mr-3" for="p_name">상품 이름</label>
				<form:input path="p_name" value="${productVO.p_name}" placeholder="상품이름을 입력해주세요" />
			</div>
			<div class="mb-3">
				<label class="mr-3" for="p_price">상품 가격</label> 
				<form:input type="number" path="p_price" value="${productVO.p_price}" placeholder="가격을 입력해주세요" />
			</div>
			<div id="select-container">
				<label class="mr-3">상품 종류</label>
				<!-- 
				<div align="right">
					<button type="button" class="btn btn-success mb-3" id="pro_append">제품 종류
						정보 입력 추가</button>
				</div>
				 -->
				<button type="button" id="btn-plus"
				        style="
                    border: 1px solid rgb(168, 163, 163);
                    border-radius: 10px;
                  ">추가</button>
				<div id="pro_size_list" class="select-box">
					<c:forEach items="${productVO.sizeList}" var="size">
						<c:if test="${!empty size.colorList}">
							<c:forEach items="${size.colorList}" var="color">
							<li> ${size.s_size} ${color.c_color} (${color.c_qty})</li>
							<select class="select" name="size" style="height: 30px;" >
							    <option value="${size.s_size}">${size.s_size}</option>
							    <option value="S">S</option>
							    <option value="M">M</option>
							    <option value="L">L</option>
							    <option value="XL">XL</option>
							    <option value="XXL">XXL</option>
							    <option value="FREE">FREE</option>
							</select>
							<input name="color" style="width: 50px;" placeholder="색깔" value="${color.c_color}"/>
							<input name="qty" type="number" style="width: 50px;" placeholder="수량" value="${color.c_qty}"/>
							<input name="s_code" type="hidden" value="${size.s_code}">
							<input name="c_code" type="hidden" value="${color.c_code}">
							</c:forEach>
						</c:if>
					</c:forEach>
				</div>
				<script>
                  $(function () {
                    $("button#del_1").on("click", function () {
                      $("#img_1").empty();
                    });
                  });
                </script>
				<div class="pro_list_img">
                  <div class="ad_img_lt" id="img_1">
                    <img class="ad_main_img" src="../img/gu-dress-2.jpg" />
                    <button class="ad_bt_del" id="del_1">삭제</button>
                  </div>
                  <c:forEach items="${productVO.proDImgList}" var="img">
	                  <div class="ad_img_lt">
	                    <img class="ad_main_img" src="${rootPath}/images/${img.p_img_upload_name}"
	                    data-id="${img.p_img_seq}" />
	                    <button type="button" class="ad_bt_del">삭제</button>
	                  </div>
                  </c:forEach>
                  <div class="cl_mt"></div>
                  <div class="ad_img_lt">
                    <img class="ad_main_img" src="../img/gu-dress-2.jpg" />
                    <button type="button" class="ad_bt_del">삭제</button>
                  </div>
                  <div class="ad_img_lt">
                    <img class="ad_main_img" src="../img/gu-dress-2.jpg" />
                    <button type="button" class="ad_bt_del">삭제</button>
                  </div>
                </div>
			</div>
			<!--이미지 및 상세 정보-->
			<div>
				<label class="mr-3" for="p_image">이미지</label>
				<input multiple="multiple" type="file" id="p_file" name="file">

			</div>
			<div class="mt-3">
			<label>상품 정보</label>
			<div>
				<textarea id="p_desc" name="p_desc" style="width: 100%;" ></textarea>
			</div>
			<!--buton group-->
			<div class="d-flex justify-content-end mt-3">
				<button class="bt-pro-save">
					저장</button>
			</div>
			</div>
			</form:form>
		</div>
			</main>
          
        </div>
      </div>
    </article>
</body>
<%@ include file = "/WEB-INF/views/include/include-footer.jspf" %>
</html>