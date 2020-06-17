<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/views/include/include-head.jspf"%>
<%@ page import="java.util.*, java.text.*"%>

<script>
$(function() {
	
	// main img
	$(".small_thumb li a").click(function () {
		var address = $(this).children("img");
	    
		$(".big_pic img")
	    	.attr("src", address.attr("src"))
	        .attr("id", address.attr("id"));

		$(this).parent().addClass("on").siblings().removeClass("on");
	        return false;
	});
	
	// 옵션 선택
	$("#select_ck").change(function() {
		let s_code = $(this).find("option:selected").data("id")
		// alert(s_code)
    
		$.ajax({
			url : "${rootPath}/product/get_color_list_by_size",
			method : "GET",
			data : { s_code : s_code }

		})
		.done(function(colorList) {
			// color select의 전체 options를 삭제
			$("#colorList option").remove()
			
			if(colorList == "FAIL") {
				alert("통신오류")
			} else if(!colorList.length) {
				alert("컬러리스트가 없습니다.")
			} else {
				$("#colorList").append($("<option/>", {text : '[COLOR 필수] 옵션2을 선택해주세요'}))
				colorList.forEach(function(vo) {
					$("#colorList").append($("<option/>", {value : vo.c_color, text : vo.c_color, 'data-id' : vo.c_code, 'data-qty' : vo.c_qty
						,'data-c_seq' : vo.c_code}))
				})
			}
		})
	}) // select_ck.change end
	
	$("#colorList").change(function() {
		let c_code = $(this).find("option:selected").data("id")
		// alert(c_code)
	})
	
	// size, color 선택후 옵션 창
	$(document).on("change", "#colorList", function() {
		if ($("colorList").val() === "COLORLIST") {
			return false;
		}
		
		let select_ck = $("#select_ck").val()
		let colorList = $("#colorList").val()
		// let p_qty = $(this).find("option:selected").data("qty")
		
		let p_qty = $(this).find("option:selected").data("qty")

		$.ajax({
			url : "${rootPath}/cart/cartlist",
			type : "POST",
			data : {
				p_name : "${productVO.p_name}",
				p_code : "${productVO.p_code}",
				p_price :"${productVO.p_price}",
				p_size : select_ck,
				p_color : colorList,
				p_qty : p_qty,
				
				// 포스트일 경우에는 이 값을 보내주어야 한다.
				"${_csrf.parameterName}" : "${_csrf.token}"
			},
			success : function(result) {
				if (result == 'LOGIN_FAIL') {
					alert("먼저 로그인을 수행해야 한다.")
				} else {
					// 옵션창 생성
					let proQty = ""
					proQty += "<li class='detail_cart' data-id='" + result.bk_id + "'>"
					proQty += "<span class='tit'>"
					proQty += "<span>"+ result.bk_p_name + "/" + result.bk_p_size + "/" + result.bk_p_color + "</span>"
					proQty += "<span class='stock'>" + result.bk_p_qty + "개 남음</span>"
					proQty += "</span>"
					
					proQty += "<button type='button' class='del' data-id='" + result.bk_id  + "'>"
					proQty += "<i class='blind'>삭제</i>"
					proQty += "</button>"
					
					proQty += "<div class='middle_wrap'>"
					proQty += "<div class='price_area'>"
					proQty += "<div class='price'>"
					proQty += "<div class='total_price'>"
					proQty += "<span class='prmt_discount'>"
					proQty += "<strong class='bk_price'>" + result.bk_p_oprice + "</strong>won"
					proQty += "</span>"
					proQty += "</div>"
					proQty += "</div>"
					proQty += "</div>"
					
					proQty += "<div class='amount'>"
					proQty += "<input type='hidden' name='seq' value='" + result.bk_id + "'>"
					proQty += "<button type='button' class='minus'>"
					proQty += "<i class='blind'>수량감소</i>"
					proQty += "</button>"
					proQty += "<label>"
					proQty += "<input type='text' class='bk_qty' value='1' name='p_qty'>"
					proQty += "</label>"
					proQty += "<button class='plus' type='button'>"
					proQty += "<i class='blind'>수량증가</i>"
					proQty += "</button>"
					proQty += "</div>"
					proQty += "</div>"
					proQty += "<span class='prod_avail_count'>100개 구매가능</span>"
					proQty += "</li>"
	
					// 실제 반응
					$(".prod").append(proQty)
				}
			},
			error : function() {
				alert("서버 통신 오류")
			}
		})
	}) // size, color 선택후 옵션 창 end

	// 수량 감소
	$(document).on("click","button.minus",function() {
		var n = $('.amount').index(this);
	    var num = $(".bk_qty:eq("+n+")").val();
	    if(num == 1) {
	    	alert("최소 주문 수량은 1개입니다. 다시 선택해주세요.")
	    } else {
	    	num = $(".bk_qty:eq("+n+")").val(num*1-1);
	    }
	})
	
	// 수량 증가
	$(document).on("click","button.plus",function() {
<<<<<<< HEAD
		var n = $('.amount').index(this);
	    var num = $(".bk_qty:eq("+n+")").val();
	    if(num == 100) {
	    	alert("최대 100개까지 선택가능합니다.")
	    } else {
	    	num = $(".bk_qty:eq("+n+")").val(num*1+1); 
	    }
=======
		let p_qty = parseInt($("#p_qty").val())
		// alert(p_qty)
		
		if(p_qty <= 100) {
			$("#p_qty").append("value", "1")
					
		} else {
			var p_qtyplus = parseInt(p_qty) + 1 
			$("#p_qty").append("value", p_qtyplus)
		}
		
>>>>>>> 48d826b495a852cd2c0bcd165b0705613c6b31f9
	})
	
	// 디테일 선택된 상품 삭제
	$(document).on("click", ".del", function() {
		let seq = $(this).data("id")
		let id = "${productVO.p_code}"
									
		if (confirm("상품을 삭제할까요?")) {
			$.ajax({
				url : "${rootPath}/cart/detail_cart_one_delete/" + seq,
				 method : "GET",
				data : {
					bk_p_code : id,
					"${_csrf.parameterName}" : "${_csrf.token}"
				},
				success : function() {
					document.location.replace(document.location.href)
				},
				error : function() {
					alert("통신오류")
				}
			})
		}
	})
	
	// 장바구니
	$(document).on("click", ".btn-cart", function() {
		// js에서 비어있는 배열을 생성
		let cart_array = Array()

		// 본문에 있는 detail_cart 를 뽑아서 배열로 만들기
		// select 될 부분을 정확히 파악해야 한다.
		let cartList = $(".detail_cart")

		// 배열을 순회하면서
		// .detail_cart의 data-id 값을 찾아서
		// cart_array에 추가
		let index = 0;
		for (i = 0; i < cartList.length; i++) {
			if (cartList[i]) {
				cart_array[index++] = $(cartList[i]).data("id")
			}
		}
		// alert(JSON.stringify(cart_array))

		if (cart_array.length < 1) {
			alert("선택된 상품이 없습니다.\n" + "상품을 선택한 후 주문버튼을 클릭하세요")
			return false;
		}
		
		if (confirm(cart_array.length + " 개의 상품을 주문 처리 할까요?")) {
			$.ajax({
				url : "${rootPath}/cart/detail_to_cart",
				type : "GET",
				data : {
					"${_csrf.parameterName}" : "${_csrf.token}",					
					detailBuyList : cart_array
				},
				success : function(result) {
					if(result > 0) {
						if(confirm("상품을 카트에 담았습니다.\n" + "장바구니로 이동하겠습니까?")) {
							console.log(result)
							document.location.href = "${rootPath}/cart/view"
						}
					}
				},
				error : function() {
					alert("서버통신오류")
				}
			})
		}
	})
	
	// 바로주문
	$(document).on("click", ".bt-buy", function() {
		// js에서 비어있는 배열을 생성
		let cart_array = Array()

		// 본문에 있는 detail_cart 를 뽑아서 배열로 만들기
		// select 될 부분을 정확히 파악해야 한다.
		let cartList = $(".detail_cart")

		// 배열을 순회하면서
		// .detail_cart의 data-id 값을 찾아서
		// cart_array에 추가
		let index = 0;
		for (i = 0; i < cartList.length; i++) {
			if (cartList[i]) {
				cart_array[index++] = $(cartList[i]).data("id")
			}
		}
		// alert(JSON.stringify(cart_array))

		if (cart_array.length < 1) {
			alert("선택된 상품이 없습니다.\n" + "상품을 선택한 후 주문버튼을 클릭하세요")
			return false;
		}
		
		if (confirm(cart_array.length + " 개의 상품을 주문 처리 할까요?")) {
			$.ajax({
				url : "${rootPath}/cart/detail_to_deli",
				type : "GET",
				data : {
					"${_csrf.parameterName}" : "${_csrf.token}",					
					detailBuyList : cart_array
				},
				success : function(result) {
					if(result > 0) {
						if(confirm("주문하겠습니까?")) {
							console.log(result)
							document.location.href = "${rootPath}/cart/delivery_view"
						}
					}
				},
				error : function() {
					alert("서버통신오류")
				}
			})
		}
	
	})
	
	// 질문하기 버튼 나타나기
    $(".nav-item").click(function () {
        let id = $(this).attr("id");
        if (id == "li_click") {
          	$("#btn_que").show();
        } else {
          	$("#btn_que").hide();
        }
    });

})
</script>
</head>
<body>
<%@ include file="/WEB-INF/views/include/include-nav.jspf"%>

<article class="all-browsers">
	<div class="hr-sect mb-5">DETAIL PAGE</div>
     
     <!--detail pages 정보 -->
     <div class="container">
		<!-- 상품이미지 -->
		<div class="row justify-content-center" style="flex-wrap: nowrap;">
			<div class="">
				<div class="big_pic">
					<img class="main-img" src="${rootPath}/images/${productVO.p_image}" />
				</div>
				<div class="hover11 small_thumb justify-content-center">
					<ul>
						<c:forEach items="${productVO.proDImgList}" var="proDImg" begin="1">
							<li><a><img class="de_img" id="img-1" src="${rootPath}/images/${proDImg.p_img_upload_name}" /></a></li>
							</c:forEach>
						</ul>
					</div>
				</div><!-- 상품이미지 end -->
				<!--detail box-->
				<div class="detail-box" style="margin-left: 70px; margin-bottom: 100px;">
					<div class="mb-3 mt-5">
						<h2 class="black-text">${productVO.p_name}</h2>
						<span>${productVO.p_price}won</span>
					</div>
					<hr style="border: 1px solid #252c41;" />
					<br />
					<!-- 옵션 설정-->
					<div class="prch-option">
						<div class="iscroll_inner">
							<div class="prch-slt">
								<label class="tit_align_left">OPTION</label>
								<div class="select-s-box">
									<select class="dep-sel dep0" id="select_ck">
										<option>[SIZE 필수] 옵션1을 선택해주세요</option>
										<c:forEach items="${sizeList}" var="size">
											<option value="${size.s_size}" data-id="${size.s_code}">${size.s_size}</option>
										</c:forEach>
									</select>
								</div>
								<div class="select-c-box">
									<select id="colorList" class="dep-sel dep0">
										<option>[COLOR 필수] 옵션2을 선택해주세요</option>
									</select>
								</div>
								<ul class="prod">
								</ul>
							</div>
						</div>
					</div><!-- 옵션 설정 end -->
					<!--총구매금액-->
					<div class="opt_slt_price_box">
						<div class="item total">
							<span class="tit">총 상품금액</span>
							<span class="num">
								<strong>${productVO.p_price}</strong> won
							</span>
						</div>
					</div>
					<!-- 장바구니 상품 button -->
					<div class="ct_wrp order_btn">
						<div class="ct">
							<div class="purchase_list_box">
								<ul class="lst_order_btn">
									<li class="col_2">
										<button class="bt-css btn-cart">장바구니</button>
									</li>
									<li class="col_2">
										<button class="bt-css bt-buy">바로구매</button>
									</li>
								</ul>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div><!-- end -->

		<div class="hr-sect mb-5">DETAIL INFO</div>
		
		<!-- 상세 정보 -->
		<div class="container">
			<!-- 상품 디테일 이미지 -->
			<div class="col w3-center mb-5">
				<c:choose>
					<c:when test="${empty productVO.proDImgList}">
						<div style="width: 50%; margin-bottom: 200px;">상품의 디테일 정보가 없습니다.</div>
					</c:when>
					<c:otherwise>
						<img src="${rootPath}/images/${productVO.proDImgList[0].p_img_upload_name}"
							style="width: 50%; margin-bottom: 200px;" />
						<div class="justify-content-center">
							<input class="more-style" value="- MORE VIEW -" onclick="if(this.parentNode.getElementsByTagName('div')[0].style.display != '')
								{this.parentNode.getElementsByTagName('div')[0].style.display = '';this.value = '- FOLDING -';}
								else{this.parentNode.getElementsByTagName('div')[0].style.display = 'none'; this.value = '- MORE VIEW -';}" type="button" />
							<div style="display: none;">
								<c:forEach items="${productVO.proDImgList}" var="proDImg" begin="1">
									<div data-id="${proDImg.p_img_seq}" data-pcode="${productVO.p_code}">
										<img src="${rootPath}/images/${proDImg.p_img_upload_name}"
											style="width: 50%; margin-bottom: 200px;" />
									</div>
								</c:forEach>
							</div>
						</div>
					</c:otherwise>
				</c:choose>
			</div><!-- 상품 디테일 이미지 end -->
         
        	<!-- review & Q&A-->
        	 <!-- review Q&A-->
        	 
        	    <script>
          $(function () {

          });
        </script>
        <!-- review Q&A-->
        <ul class="nav nav-tabs" id="myTab" role="tablist">
          <li class="nav-item">
            <a
              class="nav-link"
              id="home-tab"
              data-toggle="tab"
              href="#home"
              role="tab"
              aria-controls="home"
              aria-selected="true"
              >유의사항</a
            >
          </li>
          <li class="nav-item">
            <a
              class="nav-link active"
              id="profile-tab"
              data-toggle="tab"
              href="#profile"
              role="tab"
              aria-controls="profile"
              aria-selected="false"
              >REVIEW</a
            >
          </li>
          <li class="nav-item" id="li_click">
            <a
              class="nav-link"
              id="contact-tab"
              data-toggle="tab"
              href="#contact"
              role="tab"
              aria-controls="contact"
              aria-selected="false"
              >Q&A
            </a>
          </li>
          <li>
            <button
              class="bt-review-wr"
              data-toggle="modal"
              data-target="#staticBackdrop"
              id="btn_que"
            >
              질문하기
            </button>
          </li>
        </ul>
        <!--tab 본문-->
        <div class="tab-content" id="myTabContent">
          <!--유의 사항-->
          <div
            class="tab-pane fade show active"
            id="home"
            role="tabpanel"
            aria-labelledby="home-tab"
          >
           <img src="${rootPath}/resources/img/shopguide.jpg" />
          </div>

          <!--review -->
          <%@ include file="/WEB-INF/views/user/user_review.jsp" %>
          
          <!-- qna -->
          <%@ include file="/WEB-INF/views/user/user_qna.jsp"%>
        
        </div> <!--reviews end-->
      </div>
<!--end-->
</article>
    
<%@ include file="/WEB-INF/views/include/include-footer.jspf"%>
</body>
<!-- Modal -->
<div
    class="modal fade"
    id="staticBackdrop"
    data-backdrop="static"
    data-keyboard="false"
    tabindex="-1"
    role="dialog"
    aria-labelledby="staticBackdropLabel"
    aria-hidden="true"
    style="top: 250px;"
  >
    <div class="modal-dialog">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title m_tit" id="staticBackdropLabel">질문하기</h5>
          <button
            type="button"
            class="close"
            data-dismiss="modal"
            aria-label="Close"
          >
            <span aria-hidden="true">&times;</span>
          </button>
        </div>
        <div class="modal-body">
          <textarea class="txt_box"></textarea>
        </div>
        <div class="modal-footer">
          <button type="button" class="bt_save" data-dismiss="modal">
            닫기
          </button>
          <button type="button" class="bt_save">저장</button>
        </div>
      </div>
    </div>
  </div>
</html>

