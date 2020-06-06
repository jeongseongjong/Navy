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
										<span>배송번호 : </span> <em>${bk_id}</em>
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
									<button class="review-btn">리뷰쓰기</button>
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

<!-- footer include -->
<footer class="bg-gray mt-5">
	<div class="container p-5">
		<div class="row">
			<h2 class="red-text">NAVIYA</h2>
		</div>
		<div class="pl-5 pr-5 d-flex row">
			<div class="col-sm-3">
				<div>shop</div>
				<div>main1</div>
				<div>main2</div>
				<div>QnA</div>
			</div>
			<div class="col-sm-3">
				<div>
					<span class="font-weight-bold"> TEAMLEADER </span><br /> <span><a
						class="atag-github" href="https://github.com/jeongseongjong">&nbsp;&nbsp;-
							NAVI</a></span>
				</div>
				<div>
					<span class="font-weight-bold">UI/UX</span> <br /> <span><a
						class="atag-github" href="https://github.com/qussoa">&nbsp;&nbsp;-
							QUSSOA</a></span>
				</div>
			</div>
			<div class="col-sm-3">
				<div>
					<span class="font-weight-bold">DEVELOPER</span><br /> <span><a
						class="atag-github" href="https://github.com/leeiter">&nbsp;&nbsp;-
							PRINCESSEJIN</a></span>
				</div>
				<div>
					<span class="font-weight-bold">DEVELOPER</span><br /> <span><a
						class="atag-github" href="https://github.com/bjmin17">&nbsp;&nbsp;
							- BJ.MIN</a></span>
				</div>
			</div>
			<div class="col-sm-3">
				<div>
					<small> 광주광역시 북구 경양로170<br /> 한경빌딩 5층
					</small>
				</div>
				<div>
					<small> &copy; copyRight qussoa@naver.com </small>
				</div>
			</div>
		</div>
	</div>
</footer>
</html>
