<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ include file="/WEB-INF/views/include/include-head.jspf" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
	<script>
		$(function(){
			// 유저 리스트 보이기
			$(document).on("click","#user_list",function(){
				$.get("${rootPath}/admin/userlist",function(result){
					$("#admin_content").html(result)
				})
			})
			
			// 유저 디테일 페이지 보이기
			$(document).on("click","tr.tr_user",function(){
				let username = $(this).data("id")
				$.get("${rootPath}/admin/user_detail_view/" + username,
						function(result){
					$("#admin_content").html(result)
				}		
				)
			})
			
			// 상품 리스트 보이기
			$(document).on("click","#pro_list",function(){
				$.get("${rootPath}/admin/productlist",function(result){
					$("#admin_content").html(result)
				})
			})
			
			// 상품 디테일 페이지 보이기
			$(document).on("click","tr.tr_pro",function(){
				let p_code = $(this).data("id")
				
				$.get("${rootPath}/admin/pro_detail_view/" + p_code,
						function(result){
					$("#admin_content").html(result)
				})
			})
			
			// 상품 등록 페이지 이동
			$(document).on("click",".btn_pro_insert",function(){
				
				$.get("${rootPath}/admin/pro_insert",
						function(result){
					$("#admin_content").html(result)
				})
			})
			
			// 상품 수정 페이지 이동
			$(document).on("click",".btn_pro_update",function(){
				let p_code = $(this).data("id")
				$.get("${rootPath}/admin/pro_update/" + p_code,
						function(result){
					$("#admin_content").html(result)
				})
			})
			
			// 상품 1개 삭제
			$(document).on("click",".btn_pro_delete",function(){
				let p_code = $(this).data("id")
				$.get("${rootPath}/admin/pro_delete/" + p_code,
						function(result){
					document.location.replace("${rootPath}/admin/pro_delete/" + p_code)
				})
			})
			
			$(document).on("click","#order_list",function(){
				$.get("${rootPath}/admin/orderlist",function(result){
					$("#admin_content").html(result)
				})
			})
			
			$(document).on("click","#qna_list",function(){
				$.get("${rootPath}/admin/qna",function(result){
					$("#admin_content").html(result)
				})
			})
			
			$(document).on("click","#review_list",function(){
				$.get("${rootPath}/admin/review",function(result){
					$("#admin_content").html(result)
				})
			})
			
			$(document).on("click","#stock_list",function(){
				$.get("${rootPath}/admin/inventory",function(result){
					$("#admin_content").html(result)
				})
			})
			
			$(document).on("click","#support_list",function(){
				$.get("${rootPath}/admin/support",function(result){
					$("#admin_content").html(result)
				})
			})
			
			// 유저정보 수정 화면 저장 버튼
			$(document).on("click","button#btn_save",function(){
				let formdata = $("form").serialize()
				let username = $(this).data("id")

				$.post("${rootPath}/admin/user_detail_view/"+username,formdata,function(result){
					$("#admin_content").html(result)
					alert("Update 성공!!")
				})
				
			})
			// 유저정보 수정 화면 목록 버튼
			$(document).on("click",".ad-us-list",function(){
				document.location.href="${rootPath}/admin"
			})
			// 유저정보 수정 화면 수정 버튼
			$(document).on("click",".ad-us-update",function(){
				document.location.href="${rootPath}/admin"
			})
			
			
			
			$(document).on("change","#auth",function(){
					let item = $(this).val()
					$("div#auth_list").append($("<input/>",{class:"auth form-control-plaintext", name:"auth",value:item}))
			})
			
			$(document).on("click","#auth_append",function(){
			
				let auth_input = $("<input/>", {class:"auth form-control mb-3", name:"auth"})
				// let auth_delete = $("<button class='btn btn-danger' type='button'>&times</button>")
				// auth_input.append($("<p/>",{text:'제거',class:'auth_delete'}))
				$("div#auth_box").append(auth_input)
				// $("div#auth_box").append(auth_delete)
			})
			
			/*$(".btn-delete").click(function(){*/
			$(document).on("click",".btn-delete",function(){
				
				let id = $(this).data("id")
				//alert(id)
				let username = $(this).data("username")
				//alert(username)
				
				if (confirm("권한을 삭제하겠습니까?")) {
					// document.location.replace("${rootPath}/admin/delete?id=" + id)
					
					$.get("${rootPath}/admin/delete?id=" + id +"&username=" + username, function(result){
							$("#admin_content").html(result)
						}		
					)
				}
				
				//alert(id)
			})
			
		})
	</script>
	<style>
		#body{
			display: flex;
			width: 100%;
		}
		
		#body article {
			flex: 3;
			border: 1px solid blue;
			
			margin: 5px;
		}
	</style>
</head>
<body>
<%@ include file = "/WEB-INF/views/include/include-nav.jspf" %>
<article class="all-browsers">
      <div class="hr-sect">PRODUCT</div>

      <div class="container">
        <!--sidebar-->
        <div class="row">
          <aside
            class="col-2 px-0"
            id="left"
            style="top: 250px; position: fixed; left: 0;"
          >
            <div class="list-group w-100">
				<a id="user_list" href="javascript:void(0)" class="list-group-item">회원 관리</a>
				<a id="pro_list" href="javascript:void(0)" class="list-group-item">상품 정보</a>
				<a id="order_list" href="javascript:void(0)" class="list-group-item">주문 정보</a>
				<a id="qna_list" href="javascript:void(0)" class="list-group-item">QNA</a>
				<a id="review_list" href="javascript:void(0)" class="list-group-item">리뷰</a>
				<a id="stock_list" href="javascript:void(0)" class="list-group-item">재고</a>
				<a id="support_list" href="javascript:void(0)" class="list-group-item">고객센터</a>
            </div>
          </aside>
          
        </div>
      </div>
    </article>
	<article id="admin_content">
	</article>
	<%@ include file = "/WEB-INF/views/include/include-footer.jspf" %>
</body>
</html>