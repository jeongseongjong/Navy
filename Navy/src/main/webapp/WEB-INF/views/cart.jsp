<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="/WEB-INF/views/include/include-head.jspf"%>
<link rel="stylesheet" href="${rootPath}/resources/css/main.css" />
<link rel="stylesheet" href="${rootPath}/resources/css/user-main.css" />
<link rel="stylesheet" href="${rootPath}/resources/css/user-cart.css" />
<style>
.cart_list {
	border-bottom: 1px solid green;
	background-color: #ddd;
}
</style>
<script>
$(function() {

	$(".btn_one_qty").click(function() {

		let id = $(this).data("id")
		let qty = $("#p_" + id).val()
		alert("아이디" + id)
		alert("수량" + qty)

		$.ajax({
			url : "${rootPath}/cart/qty_update/"+id,
			type : "GET",
			data : {
				seq : id,
				p_qty : qty
			},
			success : function(result) {
				if (parseInt(result) > 0)
					alert("수량을 변경했습니다.")
				else
					alert("수량변경에 실패했습니다.")
			},
			error : function() {
				alert("서버 통신오류")
			}
		})
	})
	
	$(".btn_one_delete").click(function() {
		
		let id = $(this).data("id")
			if (confirm("상품을 삭제할까요?")) {
				alert(id)
				document.location.replace("${rootPath}/cart/cart_one_delete/" + id)
			}
	})
	
	$(".btn_list_delete").click(function() {
		// js에서 비어있는 배열을 생성
		let cart_array = Array()

		// 본문에 있는 cart_list_check를 뽑아서 배열로 생성
		let checkList = $(".cart_list_check")

		// 배열을 순회하면서
		// checked가 되어있는 checkbox만 찾아서
		// value 값을 cart_array에 추가
		let index = 0;
		for (i = 0; i < checkList.length; i++) {

			if (checkList[i].checked == true) {

				cart_array[index++] = checkList[i].value
			}
		}
		if (confirm("선택된 상품을 삭제할까요")) {

			$.ajax({
				url : "${rootPath}/cart/cart_list_delete",
				type : "POST",
				data : {
					delList : cart_array,
					"${_csrf.parameterName}" : "${_csrf.token}"
				},
				success : function(result) {
					if (result > 0) {
						alert("삭제성공")
						document.location.replace(document.location.href)
					}

				},
				error : function() {
					alert("서버통신오류")
				}
			})
		}
	})// btn_delete
	
	$(".btn_list_qty_update").click(function(){
		if(confirm("전체수량을 변경합니다.")){
			$("#cart_form").submit()	
		}
		
	})
	
	$(".btn_list_all_check").click(function(){
		let check = $(this).data("check")
		if(check == 1){
			$("input[type=checkbox]").attr("checked","checked")
			$(this).text("전체해제")
		}else{
			$("input[type=checkbox]").removeAttr("checked","")
			$(this).text("전체선택하기")
		}
		check *= (-1)
		
		$(this).data("check", check)
		
	})
	
	
	$(".btn_list_buy").click(function(){
		let cart_array = Array()
		alert("여기까지오니 " + cart_array)
		// 본문에 있는 cart_list_check를 뽑아서 배열로 생성
		let checkList = $(".cart_list_check")

		// 배열을 순회하면서
		// checked가 되어있는 checkbox만 찾아서
		// value 값을 cart_array에 추가
		let index = 0;
		for (i = 0; i < checkList.length; i++) {

			if (checkList[i].checked == true) {

				cart_array[index++] = checkList[i].value
			}
		}			
		if(cart_array.length < 1){
			alert("선택된 상품이 없습니다.\n"
					+ "상품을 선택한 후 주문버튼을 클릭하세요")
					return false;
			
		}
		alert(cart_array)
		if(confirm(cart_array.length + "개의 상품을 주문 처리할까요 ?")){
			
			$.ajax({
				url : "${rootPath}/cart/cart_list_buy",
				type : "POST",
				data : {
					buyList : cart_array,
					"${_csrf.parameterName}" : "${_csrf.token}"
				},
				success : function(result) {
					if (result > 0) {
						document.location.href = "${rootPath}/cart/delivery_view"
						alert("성공")
					}
				},
				error : function() {
					 alert("서버통신오류")
					
				}
			})
		}
	})
	

})
</script>
<body>
<%@ include file="/WEB-INF/views/include/include-nav.jspf" %>
<!--main 화면 img들어갈 것-->
    <article class="all-browers container">
      <div id="cart">
        <!--main-list-->
        <div class="mypage-header">
          <div class="image_title_area top_banner_mypage">
            <div class="img_title_inner">
              <div class="image_title_text">
                <h2 class="my_title">장바구니</h2>
                <strong>나비가 꽃을 찾아오듯</strong>
              </div>
            </div>
          </div>
          <p class="user_welcome"></p>
          <ul class="info-box">
            <li class="buy">
              <a>
                <dl>
                  <dt>주문상품</dt>
                  <dd>0</dd>
                </dl>
              </a>
            </li>
            <li class="delivery">
              <a>
                <dl>
                  <dt>배송중</dt>
                  <dd>2</dd>
                </dl>
              </a>
            </li>
            <li class="delivery">
              <a>
                <dl>
                  <dt>장바구니</dt>
                  <dd>5</dd>
                </dl>
              </a>
            </li>
            <li class="delivery">
              <a>
                <dl>
                  <dt>문의내역</dt>
                  <dd>10</dd>
                </dl>
              </a>
            </li>
          </ul>
        </div>
        <!--header-end-->

        <hr />
        <!--구매내역 nav include 하고 싶음 하시오-->
        <nav>
          <ul class="nav nav-tabs justify-content-center">
            <li class="nav-item">
              <a class="nav-link nav-atag" href="./user-main.html">구매내역</a>
            </li>
            <li class="nav-item">
              <a class="nav-link nav-atag" href="#">배송중</a>
            </li>
            <li class="nav-item">
              <a class="nav-link active nav-atag" href="./user-cart.html"
                >장바구니</a
              >
            </li>
            <li class="nav-item">
              <a class="nav-link nav-atag" href="#">문의내역</a>
            </li>
            <li class="nav-item">
              <a class="nav-link nav-atag" href="#">개인정보</a>
            </li>
          </ul>
        </nav>
        <!--구매내역 nav end-->
        <!--장바구니 container-->
        <div class="step_location">
          <span class="step_location_1 on">01 장바구니 > </span>
          <span class="step_location_2">02 주문/결제 > </span>
          <span class="step_location_3">03 결제완료</span>
        </div>
        <div class="cart_goods">
          <span class="cart_goods_text">
            전체
            <span class="cart_goods_num_cart_cnt">0</span>
            개
          </span>
        </div>
        <section id="ct_cont">
          <div class="prod_header">
            <label class="checks _check_all chk_type">
              <input
                type="checkbox"
                data-check="1"
                id="check_id"
                class="_check_all btn_list_all_check"
              />
              <span class="clicked_deal">
                <i class="blind">상품전체선택</i></span
              >
            </label>
            <ul class="u_title">
              <li class="u_info">상품정보</li>
              <li class="u_order">상품금액</li>
              <li class="u_delivery">배송비</li>
            </ul>
          </div>
          <!--장바구니 리스트-->
          <form id="cart_form" method="POST" action="${rootPath}/cart/cart_list_qty_update">
		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
			<c:forEach items="${CART_LIST}" var="cart">
          <div id="deal_lists" data-id="${cart.bk_id}">
            <div class="ct_prod_wp">
              <div class="prod">
                <label class="checks _check_all chk_type">
                  <input
                    type="checkbox"
                    id="${cart.bk_id}"
                    class="_check_all cart_list_check"
                    value="${cart.bk_id}"
                  />
                  <label for="${cart.bk_id}"> </label>
                  <span class="clicked_deal">
                    <i class="blind">상품한개선택</i></span
                  >
                </label>
                <div class="prod_tit">
                  <a href="../shopDetail.html"
                    ><!--여기에 디테일로 넘어갈 url입력--></a
                  >
                  <!--이미지 들어갈 tag-->
                  <div class="prod_thumb">
                    <img
                      src="${rootPath}/resources/img/gu-dress-2.jpg"
                      alt="Gucci dress"
                      style="width: 100%;"
                      class="pro-img"
                    />
                  </div>
                  <div class="prod_name">
                    <strong class="pr_name">${cart.bk_p_name}</strong>
                  </div>
                </div>
                <!--prod_tit end-->
                <div class="highlight_wrap">
                  <div class="p_item">
                    <p class="op_name">
                      <span>[${cart.bk_p_color} ${cart.bk_p_size}] ${cart.bk_p_name}</span>
                    </p>

                    <div class="bt_cnt">
                    <input type="hidden" name="seq" value="${cart.bk_id}">
                        <button
                          type="button"
                          class="cnt_minus"
                        >
                          <i class="blind">수량빼기</i>
                        </button>
                        <input
                          type="text"
                          class="ip_quantity"
                          title="수량입력"
                          value="${cart.bk_p_qty}"
                          id="p_${cart.bk_id}"
                          name="p_qty"
                        />
                        <button
                          type="button"
                          class="cnt_plus"
                        >
                          <i class="blind">수량 더하기</i>
                        </button>
                    </div>

                    <div class="price">
                      <p class="_origin">
                        <span class="num">${cart.bk_p_oprice}</span>
                        won
                      </p>
                      <button type="button" data-check="1" class="bt_del btn_list_check" value="">
                        <i class="blind">삭제</i>
                      </button>
                    </div>
                  </div>
                </div>
                <!--option 변경-->
                <div class="op_change">
                  <div class="term_wrap">
                    <div class="term_right">
                      <button type="button" class="bt_type btn_one_qty" data-id="${cart.bk_id}">
                        옵션 변경/추가
                      </button>
                    </div>
                  </div>
                </div>
                <!--end-->

                <!--주문금액-->
                <div class="order_price">
                  <div class="price_inner">
                    <div class="price_cont">
                      <p class="nomal">
                        <span>${cart.bk_p_oprice }</span>
                        won
                      </p>
                      <p></p>
                    </div>
                  </div>
                </div>
                <!--주문금액 end-->
                <div class="delivery_price">
                  <div class="price_inner">
                    <p>-</p>
                  </div>
                </div>
              </div>
            </div>
            <!-- prod end-->
          </div>
          </c:forEach>
          </form>
          <!--deal list end-->
        </section>
        <div class="product_footer">
         <label class="checks _check_all chk_type">
              <input
                type="checkbox"
                data-check="1"
                id="check_id"
                class="_check_all btn_list_all_check"
              />
              <span class="clicked_deal">
                <i class="blind">상품전체선택</i></span
              >
            </label>
          <button class="bt_del_type bt_type btn_list_delete">삭제</button>
          <p class="guide_txt">장바구니에 담긴 상품은 보관만 가능합니다</p>
        </div>
        <!--총 주문 금액-->
        <div class="ct_total">
          <h3 class="ct_total_tit">총 주문금액</h3>
          <dl class="matter">
            <dt>총상품금액</dt>
            <dd>
              <em><c:set var="total" value='0' />
				<c:forEach items="${CART_LIST}" var="cart">
					<c:set var="total"
						value="${total + cart.bk_p_oprice * cart.bk_p_qty}" />
				</c:forEach>
				${total}</em>
              <span>won</span>
            </dd>
            <dt>배송비</dt>
            <dd class="dd-won">
              <em>0</em>
              <span>won</span>
            </dd>
          </dl>
          <dl class="total">
            <dt>결제 예상금액</dt>
            <dd>
              <em class="_total_amount">
              <c:set var="total" value='0' />
				<c:forEach items="${CART_LIST}" var="cart">
					<c:set var="total"
						value="${total + cart.bk_p_oprice * cart.bk_p_qty}" />
				</c:forEach>
				총 결제 금액 : ${total}
              </em>
              <span>won</span>
            </dd>
          </dl>
        </div>
        <!--총주문금액 end-->
        <!-- button -->
        <div class="bt_area">
          <button type="button" class="bt_continue">쇼핑계속하기</button>
          <button class="bt_submit btn_list_buy">구매하기</button>
        </div>
      </div>
    </article>

</body>