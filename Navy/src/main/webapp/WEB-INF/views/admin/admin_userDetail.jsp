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
	// 유저정보 수정 화면 수정 버튼
	$(document).on("click",".ad-us-update",function(){
		
		let formdata = $("form").serialize()
		let username = $(this).data("name")
		$.get("${rootPath}/admin/user_update/"+username,formdata,function(result){
			//$("#admin_content").html(result)
			document.location.href="${rootPath}/admin/user_update/"+username
			//document.location.replace("${rootPath}/admin/user_update/"+username)
			
		})
		/*
		$.post("${rootPath}/admin/user_detail_view/"+username,formdata,function(result){
			$("#admin_content").html(result)
			alert("Update 성공!!")
		})
		*/
	})
	
	// 목록으로
	$(".ad-us-list").click(function(){
		document.location.href="${rootPath}/admin/userlist"
	})
	
})
</script>
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
	<!--page include-->
		<div class="row bg-light">
			<div class="col-12 py-4 text-center">
				<span style="font-size: 30px;">회원상세정보관리</span>
			</div>
		</div>
		<!--userdetail 정보-->
		<div class="row bg-white">
			<div class="col-12 py-4">
				<div class="card">
					<div class="card-body">
						<span>회원 코드 : ${userVO.id}</span> <span class="ml-5">유저 아이디 : ${userVO.username}</span>
						<hr />
						<table
							style="justify-content: center; margin: 0 auto; align-items: center;">
							<tr>
								<th class="text-left">이름</th>
								<td class="p-2">이정연</td>
							</tr>
							<tr>
								<th class="text-left">전화번호</th>
								<td class="p-2">${userVO.phone}</td>
							</tr>
							<tr>
								<th class="text-left">주소</th>
								<td class="p-2">${userVO.address}</td>
							</tr>
							<tr>
								<th class="text-left">이메일</th>
								<td class="p-2">${userVO.email}</td>
							</tr>
							<tr>
								<th class="text-left">정지여부</th>
								<td class="p-2"><span>${userVO.enabled}</span></td>
							</tr>
							<tr>
								<th class="text-left">탈퇴여부</th>
								<td class="p-2"><span>${userVO.checkout}</span></td>
							</tr>
						</table>
						<div class="d-flex justify-content-end mb-5">
							<button type="button" class="mr-2 bt-bbs-style ad-us-list user_list">
								목록</button>
							<!-- 회원일시 보이는 버튼-->
							<button class="mr-2 bt-bbs-style ad-us-update" type="button" data-name = "${userVO.username}">
								수정</button>
							<button class="mr-2 bt-bbs-style">삭제</button>
						</div>
						<!-- review 정보 가져오기-->
						<div class="container col mt-4">
							<span>상품 구매 이력</span>
							<div class="container" style="border: 1px solid #c6cad4;">
								<p class="mr-5">상품이름 : 금액 : 날짜</p>
								<small
									onclick="$(document).on('click','small',function(){document.location.href='../shopDetail.html'})">
									White pants : 15000 : 2020-05-13 </small>
							</div>
						</div>
						<!--review 정보 box end-->
						<!-- review 정보 가져오기-->
						<div class="container col mt-4">
							<span>댓글</span>
							<div class="container" style="border: 1px solid #c6cad4;">
								<p class="mr-5">상품이름 : 리뷰내용 : 날짜</p>
								<small
									onclick="$(document).on('click','small',function(){document.location.href='../shopDetail.html'})">
									White pants : Lorem ipsum dolor sit amet, consectetur
									adipiscing elit. : 2020-05-13 </small>
							</div>
						</div>
						<!--review 정보 box end-->
						<!--고객센터 게시판 글-->
						<div class="container col mt-4">
							<span>댓글</span>
							<div class="container" style="border: 1px solid #c6cad4;">
								<p class="mr-5">게시판 제목 : 내용 : 날짜</p>
								<small
									onclick="$(document).on('click','small',function(){document.location.href='../shopDetail.html'})">
									White pants : Lorem ipsum dolor sit amet, consectetur
									adipiscing elit. : 2020-05-13 </small>
							</div>
						</div>
					</div>
					<!--card body end-->
				</div>
			</div>
		</div>
		<!--userdetail 정보 end-->
					</main>
          
        </div>
      </div>
    </article>
</body>
<%@ include file = "/WEB-INF/views/include/include-footer.jspf" %>
</html>