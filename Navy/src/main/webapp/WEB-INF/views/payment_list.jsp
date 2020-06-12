7<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/views/include/include-head.jspf"%>
<meta charset="utf-8" />
<title>Page Title</title>
</head>
<script>

$(function(){
	$(".bt-save").click(function(){
		let bk_p_code = $("#bk_p_code").val()
		let text = $("#text").val()
		let title = $("#title").val()
		let star = $("#star").val()

		alert(bk_p_code)
		alert(text)
		alert(title)
		alert(star)
		
		$.ajax({
			url : "${rootPath}/user/review",
			method : "POST",
			data : {
				r_code : bk_p_code,
				r_title : title,
				r_text : text,
				r_star : star,
				"${_csrf.parameterName}" : "${_csrf.token}"
			},
			success : function(result){
				if(result == "OK"){
					alert("리뷰 작성 성공"+ bk_p_code)
					document.location.href = "${rootPath}/cart/payment_list"	
				}else{
					alert("작성실패")
				}
			},
			error : function(result){
				alert("서버통신오류")
			}
		})
	})
})

</script>
<body>
	<!--header include-->
	<!--nav include 할 것-->
	<%@ include file="/WEB-INF/views/include/include-nav.jspf"%>
	<!--main 화면 img들어갈 것-->
	<article class="all-browers container">
		<div>
			<!--main-list-->
			<%@ include file="/WEB-INF/views/include/include-menu.jspf" %>
			
			<!--구매내역 nav end-->
			<!--구매내역 container-->

			<div class="date_control">
				<ul class="date_list dl_fit">
					<li class="date_all"><a class="a_on">전체</a></li>
					<li class="date_all"><a>1개월</a></li>
					<li class="date_all"><a>3개월</a></li>
				</ul>
			</div>
			<!--기간 end-->
			<!--상품 구매내역 1-->
			<span class="h5" style="padding-left: 90px;">상품 구매내역</span>
			<c:forEach items="${DELIVERY_LIST}" var="delivery">
				<div class="buy_list">
					<table cellspacing="0" border="1">
						<caption>구매내역</caption>
						<colgroup>
							<col width="170" />
							<col width="500" />
							<col width="120" />
							<col width="140" />
						</colgroup>
						<thead>
							<tr>
								<th colspan="2" scope="colgroup">구매내역</th>
								<th scope="col">배송상태</th>
								<th scope="col">관리</th>
							</tr>
						</thead>
						<tbody>
							<th scope="rowgroup" rowspan="4" class="deal_info">
								<div class="date_num">
									<p class="dt">
										<strong>${delivery.bk_p_buyTime }</strong>
									</p>
									<p>(13:00:01)</p>
									<p class="buy_num">
										<em class="txt">주문번호</em> <strong>000${delivery.bk_id}</strong>
									</p>
								</div>
							</th>
							<tr>
								<td colspan="3" class="delivery_wrap">
									<div class="delivery_num">
										<span>배송번호 : </span> <em>${delivery.bk_id}</em>
									</div>
								</td>
							</tr>
							<tr>
								<th class="sum_up">
									<div class="thmb_area">
										<a href="../shopDetail.html"> <img
											src="${rootPath}/resources/img/gu-dress.jpg" width="110"
											height="110" alt="구매상품" class="thmb" />
										</a>
										<h4>
											<a href="../shopDetail.html">${delivery.bk_p_name}</a>
										</h4>
										<p class="pay_info">
											<span class="won"> <em>${delivery.bk_p_oprice }</em>
												won
											</span>
											<!-- </span> (결제완료) -->
										</p>
									</div>
									<p class="add_date_info">&nbsp;</p>
									<p class="add_date_info">
										배송완료일 : <strong>${delivery.bk_p_buyTime }</strong>
									</p>
									<ul class="shop_list">
										<li>
											<div class="detail">
												<div class="tit">
													<strong> color : ${delivery.bk_p_color } / Size :
														${delivery.bk_p_size} </strong>
													<p>
														(구매수량 <em>${delivery.bk_p_qty}</em> 개)
													</p>
												</div>
											</div>
										</li>
									</ul>
								</th>
								<td class="expiry">
									<div class="delivery_condition">
										<strong>배송중</strong>
									</div>
								</td>
								<td class="review_write">
									<input type="hidden" id="bk_p_code" name="bk_p_code" value="${delivery.bk_p_code }"/>
									<button id="rev" data-name="${delivery.bk_p_code}" data-id="${delivery.bk_id}"
									 		data-toggle="modal" data-target="#staticBackdrop"class="review-btn">리뷰쓰기</button>
								</td>
							</tr>
							<tr>
								<td colspan="3" class="delivery last-border"><span title
									class="addr">
										<p class="addr">
											<em>배송지 정보 : <span>${delivery.username},
													${delivery.bk_recipient_address}
													${delivery.bk_recipient_address_etc}</span>
											</em>
										</p>
								</span></td>
							</tr>
						</tbody>
					</table>
				</div>
			</c:forEach>
			<!--content end-->
			<!--pagination-->
			<%@ include file="/WEB-INF/views/include/include-paging2.jspf" %>
			<!--pagination end-->
			<div class="delivery_process_area">
				<h3 class="h_delivery_process">배송상태안내 및 유의사항</h3>
				<div class="delivery_process">
					<ul class="1st-delivery_process"></ul>
				</div>
				<ul class="fst_delivery_caution">
					<li><span>·</span> 배송지 수정 및 구매취소는 주문하신 배송상품이 '결제완료' 상태일 때만
						가능합니다.</li>
					<li><span>·</span> 환불/교환 요청은 '배송완료 다음날부터 7일'까지 가능합니다. (환불은
						'배송준비중', 교환은 '배송완료' 상태일 때 부터 요청가능)</li>
					<li><span>·</span> 환불/교환 요청 후 1~3일 내에 택배사에서 상품을 수거하게 되니 잠시 기다려
						주세요.</li>
					<li><span>·</span> 구매 시의 상품정보와 현재 상품 정보가 상이할 수 있습니다.</li>
				</ul>
			</div>
		</div>
	</article>
</body>
<%@ include file="/WEB-INF/views/include/include-footer.jspf" %>
<!-- Modal -->
<form:form modelAttribute="reviewVO" action="${rootPath}/user/reivew" method="POST" class="modal_insert"> 
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
          <h5 class="modal-title m_tit" id="staticBackdropLabel">리뷰쓰기</h5>
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
          <div>
            <label>제목</label>
            <input id="title" name="r_title" class="md_tit" type="text" />
            <!--별점-->
            <div class="starRev one-line">
              <label class="la_st_box">
                별점
                <input
                  type="range"
                  min="0"
                  max="5"
                  step="1"
                  onmousemove="rangevalue1.value=value"
                  id="star"
                  name="r_star"
                />
                <output class="ran_output" id="rangevalue1"></output>
              </label>
              <span class="md_sub">*상품의 별점을 1~5까지 선택해주세요</span>
            </div>
          </div>
          <textarea class="txt_box" id="text" name="r_text" placeholder="후기를 작성해 주세요"></textarea>
          <input type="file" />
        </div>
        <div class="modal-footer">
          <button type="button" class="bt_close" data-dismiss="modal">
            닫기
          </button>
          <button type="button" class="bt-save">저장</button>
        </div>
      </div>
    </div>
  </div>
  </form:form>
</html>
