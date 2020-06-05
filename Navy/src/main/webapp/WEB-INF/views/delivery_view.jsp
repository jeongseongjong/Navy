<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<c:set var="rootPath" value="${pageContext.request.contextPath}"  />
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width,initial-scale=1">
<title>NAVIYA</title>
<script src="https://code.jquery.com/jquery-latest.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script
      src="https://code.jquery.com/ui/1.12.1/jquery-ui.min.js"
      type="text/javascript"
    ></script>


<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>

<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css" />

<!--google chart-->
<script
  type="text/javascript"
  src="https://www.gstatic.com/charts/loader.js"
></script>
</head>
<link rel="stylesheet" href="${rootPath}/resources/css/main.css" />
<link rel="stylesheet" href="${rootPath}/resources/css/user-buy.css" />
<script type="text/JavaScript"
	src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>

<script>
	
	$(function() {
		$(".main_btn").click(function() {
			document.location.href = "${rootPath}/"
		})

		$(document).on("click", ".payment", function() {
			alert("클릭")
			var seqList = [];
			let dev_input = $("input[id='dev_list']")
			alert(dev_input.length)
			for(var i = 0 ; i < dev_input.length;i++) {
				seqList.push(dev_input[i].value)
			}
			
			alert(seqList)

			let username = $("#username").val()
			let phone = $("#phone").val()
			let address = $("#address").val()
			let address_etc = $("#address_etc").val()
			let message = $("#message").val()

			$.ajax({
				url : "${rootPath}/cart/recipient_update",
				method : "POST",
				traditional : true,
				data : {
					bkSeqList : seqList,
					bk_recipient_name : username,
					bk_recipient_phone : phone,
					bk_recipient_address : address,
					bk_recipient_address_etc : address_etc,
					bk_recipient_message : message,
					"${_csrf.parameterName}" : "${_csrf.token}"
				},
				success : function(result) {
					alert("배송자 정보 업데이트 성공" + result)
					document.location.href = "${rootPath}/cart/payment_list"
				},
				error : function(result) {
					alert("서버 통신 오류")
				}
			})
		})
	})
</script>
<script type="text/javascript">
	function openDaumZipAddress() {

		new daum.Postcode({

			oncomplete : function(data) {

				jQuery("#postcode1").val(data.postcode1);

				jQuery("#postcode2").val(data.postcode2);

				jQuery("#zonecode").val(data.zonecode);

				jQuery("#address").val(data.address);

				jQuery("#address_etc").focus();

				console.log(data);

			}

		}).open();

	}
</script>
  <body>
  
    <!--header include-->
    <header>
      <%@ include file="/WEB-INF/views/include/include-nav.jspf"%>
    </header>
    <!--main 화면 img들어갈 것-->
    <article class="all-browers">
      <div id="cart">
        <!--main-list-->
        <div class="p_content">
          <div
            class="checkout-wrap"
            style="min-height: 786px; min-height: 80vh;"
          >
            <div class="image_title_area top_banner_mypage">
              <div class="img_title_inner">
                <div class="image_title_text">
                  <h2 class="my_title">장바구니</h2>
                  <strong>나비가 꽃을 찾아오듯</strong>
                </div>
              </div>
            </div>

            <!--장바구니 container-->
            <div class="title-buy">
              <span class="step_location_1">01 장바구니 > </span>
              <span class="step_location_2 on">02 주문/결제 > </span>
              <span class="step_location_3">03 결제완료</span>
            </div>

            <!--buy main-->
            <div class="product">
              <span class="p_thumb">
                <img
                  src="${rootPath}/resources/img/gu-dress-2.jpg"
                  alt="주문상품"
                  style="width: 130px; height: 110px; margin-left: 30px;"
                />
              </span>
              <p class="p_title">
                <span class="txt1">
                  <em class="col_pink">
                    <i>${DELIVERY_LIST[0].bk_p_name}</i>
                  </em>
                  상품을 주문합니다
                </span>
                <span class="txt2"
                  >선택하신 상품의 가격과 옵션 정보는 하단 주문상품 정보에서
                  확인할 수 있습니다</span
                >
              </p>
            </div>
            <!--end-->

            <div class="checkout_content">
              <!-- 주문자 정보 2020-06-02-->
              <div class="checkout_delivery">
                <div class="info_section">
                  <h4>주문자 정보</h4>
                  <input type="hidden" name="${_csrf.parameterName}"
				value="${_csrf.token}">
                  <div class="tbl_wrap">
                    <table>
                      <colgroup>
                        <col style="width: 160px;" />
                        <col />
                      </colgroup>
                      <tbody>
                        <tr>
                          <th scope="row" class="bd0">이름</th>
                          <td>
                            <span>${USER_LIST.username }</span>
                          </td>
                        </tr>
                        <tr>
                          <th scope="row" class="bd0">연락처</th>
                          <td>
                            <span>${USER_LIST.phone}</span>
                          </td>
                        </tr>
                      </tbody>
                    </table>
                  </div>
                </div>
              </div>
              <!-- 배송지 정보 end-->
              <!-- 배송지 정보-->
              <div class="checkout_delivery">
                <div class="info_section">
                  <h4>배송지 정보</h4>
                  <div class="tbl_wrap">
                  	<c:forEach items="${DELIVERY_LIST}" var="delivery" varStatus="status">
						<input type="hidden" id="dev_list" name="seq" value="${delivery.bk_id}">
					</c:forEach>
                    <table>
                      <colgroup>
                        <col style="width: 160px;" />
                        <col />
                      </colgroup>
                      <tbody>
                        <tr>
                          <th scope="row" class="bd0">이름</th>
                          <td>
                            <input type="text" id="username" name="username" value="" class="user_name" />
                          </td>
                        </tr>
                        <tr>
                          <th scope="row" class="bd0">연락처</th>
                          <td>
                            <input type="text" id="phone" value="" name="phone" class="user_phone" />
                          </td>
                        </tr>
                        <tr>
                          <th scope="row" class="bd0">주소</th>

                          <td class="padding_td">
                            <div class="fl-wrap">
                              <input type="text" 
                              		id="zonecode"
                                	value=""
                              		class="addr1"
                              		readonly />
                              <input type="button" onClick="openDaumZipAddress();" value="우편번호" /> <br />
                            </div>
                            <p class="mt6">
                              <input type="text" id="address" class="addr_n2" name="address" value="" readonly />
                              <input type="text" class="addr_n3" id="address_etc" name="address_etc" value="" " />
                            </p>
                          </td>
                        </tr>
                      </tbody>
                    </table>
                  </div>
                </div>
              </div>
              <!-- 배송지 정보 end-->
              <!-- 주문 정보 -->
              <div class="info_section">
                <h4>주문상품 정보</h4>
                <div class="tbl_wrap">
                  <table class="product_table">
                    <colgroup>
                      <col style="width: 160px;" />
                      <col style="width: 440px;" />
                      <col style="width: 140px;" />
                      <col style="width: 100px;" />
                      <col style="width: 150px;" />
                      <col />
                    </colgroup>
                    <thead>
                      <tr>
                        <th scope="col" colspan="2">상품정보</th>
                        <th scope="col">상품금액</th>
                        <th scope="col">배송비</th>
                        <th scope="col">주문금액</th>
                        <th scope="col">-</th>
                      </tr>
                    </thead>
                    <tbody>
                      <tr class="_deal">
                        <td class="thumb">
                          <div class="product_thumb">
                            <a href="../shopDetail.html">
                              <img src="${rootPath}/resources/img/gu-dress-2.jpg" alt="gu_dress" />
                            </a>
                          </div>
                        </td>
                        <td class="v_top">
                          <div class="product_title">
                            <div class="info">
                              <p class="title">
                                <a href="../shopDetail.html">${DELIVERY_LIST[0].bk_p_name}</a>
                              </p>
                              <ul style="padding-left: 0;">
                                <li>
                                  <em class="name">${DELIVERY_LIST[0].bk_p_name} | ${DELIVERY_LIST[0].bk_p_size } | ${DELIVERY_LIST[0].bk_p_color}</em>
                                  <em class="num">
                                    <i>외 ${LIST_COUNT}</i>
                                    개
                                  </em>
                                </li>
                              </ul>
                            </div>
                            <div class="p-btn">
                              <button
                                type="button"
                                class="btn_change_amount"
                                data-toggle="modal"
                                data-target="#m_count"
                              >
                                수량변경
                              </button>
                            </div>
                          </div>
                        </td>
                        <td class="mgl align_center">
                          <span class="int_black">
                          <c:set var="total" value='0' />
							<c:forEach items="${DELIVERY_LIST}" var="delivery">
							<c:set var="total"
								value="${total + delivery.bk_p_oprice * delivery.bk_p_qty}" />
							</c:forEach>
                            <em>${total}</em>
                            <i class="won">won</i>
                          </span>
                        </td>
                        <td rowspan="1" class="mgl align_center">
                          <span class="int_black">
                            <em>-</em>
                          </span>
                        </td>
                        <td rowspan="1" class="mgl align_center">
                          <span class="int_black_big">
                            <c:set var="total" value='0' />
							<c:forEach items="${DELIVERY_LIST}" var="delivery">
							<c:set var="total"
								value="${total + delivery.bk_p_oprice * delivery.bk_p_qty}" />
							</c:forEach>
                            <em>${total}</em>
                            <i class="won">won</i>
                          </span>
                        </td>
                        <td rowspan="1" class="mgl align_center">
                          <span class="int_black">
                            <em>-</em>
                          </span>
                        </td>
                      </tr>
                      <tr class="inner_line">
                        <td colspan="6">
                          <div></div>
                        </td>
                      </tr>
                    </tbody>
                    <tfoot>
                      <tr>
                        <td colspan="6">
                          <div class="money_sum">
                            <ul>
                              <li>
                                <em class="title">상품금액</em>
                                <span class="int_black_big">
                                  <c:set var="total" value='0' />
							<c:forEach items="${DELIVERY_LIST}" var="delivery">
							<c:set var="total"
								value="${total + delivery.bk_p_oprice * delivery.bk_p_qty}" />
							</c:forEach>
                            <em>${total}</em>
                            <i class="won">won</i>
                          </span>
                              </li>
                              <li>
                                <em class="title">배송비</em>
                                <span class="int_black_big">
                                  <em>0</em>
                                  <i class="won">won</i>
                                </span>
                              </li>
                            </ul>
                          </div>
                        </td>
                      </tr>
                      <tr>
                        <td class="bd0" colspan="6">
                          <div class="money_tot">
                            <em class="title">총 주문금액</em>
                            <span class="int_black_big">
                              <c:set var="total" value='0' />
							<c:forEach items="${DELIVERY_LIST}" var="delivery">
							<c:set var="total"
								value="${total + delivery.bk_p_oprice * delivery.bk_p_qty}" />
							</c:forEach>
                            <em>${total}</em>
                            <i class="won">won</i>
                            </span>
                          </div>
                        </td>
                      </tr>
                    </tfoot>
                  </table>
                </div>
              </div>
              <!--주문 정보 end-->
              <!--결제 -->
              <script>
                $(function () {
                  /* 전체 선택 및 해제*/
                  $("#chk_all").click(function () {
                    if ($("#chk_all").is(":checked")) {
                      $(".chk").prop("checked", true);
                    } else {
                      $(".chk").prop("checked", false);
                    }
                  });
                  /* 1개 선택시 전체 선택 해제*/
                  $(".chk").click(function () {
                    if ($("input[name='chk']:checked").length == 3) {
                      $("#chk_all").prop("checked", true);
                    } else {
                      $("#chk_all").prop("checked", false);
                    }
                  });
                });
              </script>
              <div class="pay_section">
                <h4>약관동의</h4>
                <div class="tbl_wrap box_wrap agree">
                  <div class="left_box">
                    <dl>
                      <dt>
                        <label class="chk_type">
                          <input type="checkbox" id="chk_all" class="chk" />
                          <label for="chk_all"></label>
                        </label>
                        <em>전체 동의하기</em>
                      </dt>
                      <dd>
                        <ul>
                          <li>
                            <div class="checkBox01 hightlight">
                              <label class="chk_type">
                                <input
                                  type="checkbox"
                                  class="chk"
                                  name="chk"
                                  id="chk1"
                                />
                                <label for="chk1"></label>
                              </label>
                              <em>개인정보 제3자 제공에 동의합니다</em>
                            </div>
                            <a
                              href="#"
                              class="detail"
                              data-toggle="modal"
                              data-target="#m_detail_1"
                              >상세보기</a
                            >
                          </li>
                          <li>
                            <div class="checkBox01 small-font">
                              <label class="chk_type">
                                <input
                                  type="checkbox"
                                  class="chk"
                                  name="chk"
                                  id="chk2"
                                />
                                <label for="chk2"></label>
                              </label>
                              <em>결제대행서비스 이용약관에 동의합니다</em>
                            </div>
                            <a
                              href="#"
                              class="detail"
                              data-toggle="modal"
                              data-target="#m_detail_2"
                              >상세보기</a
                            >
                          </li>
                          <li>
                            <div class="checkBox01 small-font">
                              <label class="chk_type">
                                <input
                                  type="checkbox"
                                  class="chk"
                                  name="chk"
                                  id="chk3"
                                />
                                <label for="chk3"></label>
                              </label>
                              <em
                                >주문할 상품설명에 명시된 내용과 사용조건을
                                확이하였으며, 취소·환불규정에 동의합니다.</em
                              >
                            </div>
                          </li>
                        </ul>
                      </dd>
                    </dl>
                  </div>
                  <div class="right_box">
                    <div class="total_pay">
                      <ul>
                        <li>
                          <em class="tit">총 상품금액</em>
                          <span class="int_black_big">
                            <c:set var="total" value='0' />
							<c:forEach items="${DELIVERY_LIST}" var="delivery">
							<c:set var="total"
								value="${total + delivery.bk_p_oprice * delivery.bk_p_qty}" />
							</c:forEach>
                            <em>${total}</em>
                            <i class="won">won</i>
                          </span>
                        </li>
                        <li>
                          <em class="tit">배송비</em>
                          <span class="int_black_big">
                            <em>0</em>
                            <i class="won">won</i>
                          </span>
                        </li>
                      </ul>
                      <div class="total">
                        <em>총 결제금액</em>
                        <p>
                          <span class="int_pink">
                            <c:set var="total" value='0' />
							<c:forEach items="${DELIVERY_LIST}" var="delivery">
							<c:set var="total"
								value="${total + delivery.bk_p_oprice * delivery.bk_p_qty}" />
							</c:forEach>
                            <em>${total}</em>
                            <i class="won">won</i>
                          </span>
                        </p>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
              <!--결제 end-->
              <div>
                <div class="btn_buy_area">
                  <a class="btn_cancel" href="../shopDetail.html">취소</a>
                  <a class="btn_buy payment">결제하기</a>
                </div>
                <div class="notice">
                  <dl>
                    <dt>꼭 확인해주세요!</dt>
                    <dd>
                      <ul>
                        <li>
                          <i></i>
                          · BC카드 무이자할부 우리비자, 광주, 전북, 수협,
                          저축은행, 우체국, 새마을금고, 산업, 제주, 신협,
                          현대증권카드는 제외됩니다. “상품권 및 현금성 상품” 에
                          대하여 카드 할인혜택이 제외 될 수 있습니다 이벤트
                          종료일 23시 59분 59초까지 결제 요청된 경우에 할인이
                          적용됩니다. (서버시간은 컴퓨터마다 상이하니, 10분
                          전까지 결제완료 부탁드립니다.)
                        </li>
                      </ul>
                    </dd>
                  </dl>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </article>
  </body>

  <!--수량 modal-->
  <div class="modal fade" id="m_count" role="dialog">
    <div class="modal-dialog">
      <div
        class="modal-content layer_pop pop_amount"
        style="
          display: block;
          position: absolute;
          left: 50%;
          margin-left: -304px;
          z-index: 1000;
        "
      >
        <button type="button" class="close">닫기</button>
        <dl>
          <dt>상품 수량 변경</dt>
          <dd>
            <div class="product">
              <span class="thumb">
                <img src="../img/gu-dress-2.jpg" alt="gucci dress" />
              </span>
              <p class="p_title">
                <span class="txt1">GUCCI DRESS</span>
                <span class="txt2">M BLACK</span>
              </p>
            </div>
            <p class="col_gray f11">
              <em class="col_pink">(1인당 최대 999개 주문가능)</em>
            </p>
            <div class="amount">
              <table>
                <colgroup>
                  <col style="width: 230px;" />
                  <col style="width: 110px;" />
                  <col style="width: 110px;" />
                  <col />
                </colgroup>
                <tbody>
                  <tr>
                    <td class="m_title">
                      <em>GUCCI DRESS | M | BLACK</em>
                    </td>
                    <td>
                      <span class="count">
                        <button type="button" class="btn_minus">빼기</button>
                        <input type="text" class="cnt_input" value="1" />
                        <button type="button" class="btn_plus">더하기</button>
                      </span>
                    </td>
                    <td class="money">
                      <em>1,750,000</em>
                      won
                    </td>
                    <td class="center">
                      <button class="btn_del" type="button">삭제</button>
                    </td>
                  </tr>
                </tbody>
                <tfoot>
                  <tr>
                    <td colspan="4">
                      <div class="money_tot">
                        <em>총 주문금액</em>
                        <span class="int_black_big">
                          <em>1,750,000</em>
                          <i class="won"> won</i>
                        </span>
                      </div>
                    </td>
                  </tr>
                </tfoot>
              </table>
            </div>
            <div class="layer_btn_area">
              <button class="btn_cancel">취소하기</button>
              <button class="btn_ok">변경하기</button>
            </div>
          </dd>
        </dl>
      </div>
    </div>
  </div>
  <!--수량 modal end-->
  <!-- 약관동의 1 -->
  <div class="modal fade" id="m_detail_1" role="dialog">
    <div class="modal-dialog modal-sm">
      <div
        class="modal-content layer_pop pop_third_private"
        style="
          display: block;
          position: absolute;
          width: 500px;
          left: 50%;
          top: 150px;
          margin-left: -261px;
          z-index: 1000;
        "
      >
        <button type="button" class="close">닫기</button>
        <dl>
          <dt style="margin-bottom: 10px;">개인정보 제3자 정보제공 동의</dt>
          <dd>
            <div class="scroll">
              <div class="m_section">
                <ul>
                  <li class="m_title">
                    <em class="col_pink">
                      서비스 제공을 위해 아래 정보가 제공됩니다.
                    </em>
                    <br />
                    고객님께서는 정보제공에 동의하지 않을 수 있으며, 동의하지
                    않는 경우 서비스 이용이 제한될 수 있습니다.
                  </li>
                  <li>
                    <b>개인정보 제공 받는 자 : NAVIYA<br /></b>
                    <b>제공목적 : 구매한 상품의 배송<br /></b>
                    <b>제공정보 : 성명, 휴대폰번호, 주소<br /></b>
                    <b>보유 및 이용기간 : 서비스 제공완료 3개월 후 삭제</b>
                  </li>
                </ul>
              </div>
            </div>
          </dd>
        </dl>
        <div class="layer_btn_area">
          <button class="btn_ok">확인</button>
        </div>
      </div>
    </div>
  </div>
  <!--약관동의  1 end-->
  <!-- 약관동의 2 -->
  <div class="modal fade" id="m_detail_2" role="dialog">
    <div class="modal-dialog">
      <div
        class="modal-content layer_pop pop_third_private"
        style="
          display: block;
          position: absolute;
          width: 500px;
          left: 50%;
          top: 150px;
          margin-left: -261px;
          z-index: 1000;
        "
      >
        <button type="button" class="close">닫기</button>
        <dl>
          <dt style="margin-bottom: 10px;">결제 대행 서비스 약관</dt>
          <dd>
            <ul class="nav nav-tabs" id="myTab" role="tablist">
              <li class="nav-item" role="presentation">
                <a
                  class="nav-link li_style active"
                  id="home-tab"
                  data-toggle="tab"
                  href="#home"
                  role="tab"
                  aria-controls="home"
                  aria-selected="true"
                  >기본약관</a
                >
              </li>
              <li class="nav-item" role="presentation">
                <a
                  class="nav-link li_style"
                  id="profile-tab"
                  data-toggle="tab"
                  href="#profile"
                  role="tab"
                  aria-controls="profile"
                  aria-selected="false"
                  >개인정보 수집, 이용</a
                >
              </li>
              <li class="nav-item" role="presentation">
                <a
                  class="nav-link li_style"
                  id="contact-tab"
                  data-toggle="tab"
                  href="#contact"
                  role="tab"
                  aria-controls="contact"
                  aria-selected="false"
                  >개인정보 제공, 위탁</a
                >
              </li>
            </ul>
            <div class="tab-content scroll" id="myTabContent">
              <div
                class="tab-pane fade show active"
                id="home"
                role="tabpanel"
                aria-labelledby="home-tab"
              >
                <!--include 하시길 권고 함 -->
                제1장 총칙 제 1조 (목적) 본 약관은 엔에이치엔엔터테인먼트
                주식회사(이하 "회사"라 합니다)가 제공하는
                전자지급결제대행서비스, 선불전자지급수단의 발행 및 관리서비스,
                직불전자지급수단의 발행 및 관리서비스, 결제대금예치서비스,
                전자고지결제서비스(이하 통칭하여 "전자금융거래서비스"라
                합니다)를 "회원"이 이용함에 있어, "회사"와 "회원" 간 권리, 의무
                및 "회원"의 서비스 이용절차 등에 관한 사항을 규정하는 것을 그
                목적으로 합니다. 제2조 (정의) (1) 본 약관에서 정한 용어의 정의는
                아래와 같습니다. ① "전자금융거래"라 함은 "회사"가 "전자적
                장치"를 통하여 전자금융업무를 제공하고, "회원"이 "회사"의
                종사자와 직접 대면하거나 의사소통을 하지 아니하고 자동화된
                방식으로 이를 이용하는 거래를 말합니다. ② "전자지급거래"라 함은
                자금을 주는 자(이하 "지급인"이라 합니다)가 "회사"로 하여금
                전자지급수단을 이용하여 자금을 받는 자(이하 "수취인"이라
                합니다)에게 자금을 이동하게 하는 "전자금융거래"를 말합니다. ③
                "전자적 장치"라 함은 "전자금융거래" 정보를 전자적 방법으로
                전송하거나 처리하는데 이용되는 장치로써 현금자동지급기,
                자동입출금기, 지급용단말기, 컴퓨터, 전화기 그 밖에 전자적
                방법으로 정보를 전송하거나 처리하는 장치를 말합니다. ④
                "접근매체"라 함은 "전자금융거래"에 있어서 "거래지시"를 하거나
                이용자 및 거래내용의 진실성과 정확성을 확보하기 위하여 사용되는
                수단 또는 정보로서 "전자금융거래서비스"를 이용하기 위하여
                "회사"에 등록된 아이디 및 비밀번호, 기타 "회사"가 지정한 수단을
                말합니다. ⑤ "아이디"란 "회원"의 식별과 서비스 이용을 위하여
                "회원"이 설정하고 "회사"가 승인한 숫자와 문자의 조합을 말합니다.
                ⑥ "비밀번호"라 함은 "회원"의 동일성 식별과 "회원" 정보의 보호를
                위하여 "회원"이 설정하고 "회사"가 승인한 숫자와 문자의 조합을
                말합니다. ⑦ "회원"이라 함은 본 약관에 동의하고 본 약관에 따라
                "회사"가 제공하는 "전자금융거래서비스"를 이용하는 자를 말합니다.
                ⑧ "판매자"라 함은 "전자금융거래서비스"를 통하여 "회원"에게 재화
                또는 용역(이하 "재화 등"이라 합니다)을 판매하는 자를 말합니다. ⑨
                "거래지시"라 함은 "회원"이 본 약관에 따라 "회사"에게
                "전자금융거래"의 처리를 지시하는 것을 말합니다. ⑩ "오류"라 함은
                "회원"의 고의 또는 과실 없이 "전자금융거래"가 본 약관 또는
                "회원"의 "거래지시"에 따라 이행되지 아니한 경우를 말합니다. (2)
                본 조 및 본 약관의 다른 조항에서 정의한 것을 제외하고는
                전자금융거래법 등 관련 법령에 정한 바에 따릅니다. 제3조 (약관의
                명시 및 변경) (1) "회사"는 "회원"이 "전자금융거래"를 하기 전에
                본 약관을 서비스 페이지에 게시하고 본 약관의 중요한 내용을
                확인할 수 있도록 합니다. (2) "회사"는 "회원"의 요청이 있는 경우
                전자문서의 전송(이하 전자우편을 이용한 전송을 포함합니다),
                모사전송, 우편 또는 직접 교부의 방식에 의하여 본 약관의 사본을
                "회원"에게 교부합니다. (3) "회사"가 본 약관을 변경하는 때에는 그
                시행일 1월 전에 변경되는 약관을 금융거래정보 입력화면 또는
                서비스 홈페이지에 게시함으로써 "회원"에게 공지합니다. 제4조
                (거래내용의 확인) (1) "회사"는 서비스 페이지의 ‘구매내역’ 조회
                화면 을 통하여 "회원"의 거래내용("회원"의 "오류" 정정 요구사실
                및 처리결과에 관한 사항을 포함합니다)을 확인할 수 있도록 하며,
                "회원"이 거래내용에 대해 서면 교부를 요청하는 경우에는 요청을
                받은 날로부터 2주 이내에 모사전송, 우편 또는 직접 교부의
                방법으로 거래내용에 관한 서면을 교부합니다. (2) "회사"는
                제(1)항에 따른 "회원"의 거래내용 서면 교부 요청을 받은 경우
                "전자적 장치"의 운영장애, 그 밖의 사유로 거래내용을 제공할 수
                없는 때에는 즉시 "회원"에게 전자문서 전송의 방법으로 그러한
                사유를 알려야 하며, "전자적 장치"의 운영장애 등의 사유로
                거래내용을 제공할 수 없는 기간은 제(1)항의 거래내용에 관한
                서면의 교부기간에 산입하지 아니합니다. (3) 제(1)항의 대상이 되는
                거래내용 중 대상기간이 5년인 것은 다음 각 호와 같습니다. ①
                거래계좌의 명칭 또는 번호 ② "전자금융거래"의 종류 및 금액 ③
                "전자금융거래"의 상대방에 관한 정보 ④ "전자금융거래"의 거래일시
                ⑤ "전자적 장치"의 종류 및 "전자적 장치"를 식별할 수 있는 정보 ⑥
                "회사"가 "전자금융거래"의 대가로 받은 수수료 ⑦ "회원"의 출금
                동의에 관한 사항 ⑧ "전자금융거래"의 신청 및 조건의 변경에 관한
                사항 (4) 제(1)항의 대상이 되는 거래내용 중 대상기간이 1년인 것은
                다음 각 호와 같습니다. ① "회원"의 "오류" 정정 요구사실 및
                처리결과에 관한 사항 ② 기타 금융위원회가 고시로 정한 사항 (5)
                "회원"이 제(1)항에서 정한 서면 교부를 요청하고자 할 경우 다음의
                주소 및 전화번호로 요청할 수 있습니다. ① 주소: 경기도 성남시
                분당구 대왕판교로 645번길 16 NHN엔터테인먼트 플레이뮤지엄 ②
                이메일 주소: help@payco.com ③ 전화번호: 1544-6891 제5조
                ("거래지시"의 철회 등) 1) "회원"이 "회사"의
                "전자금융거래서비스"를 이용하여 "전자지급거래"를 한 경우,
                "회원"은 지급의 효력이 발생하기 전까지 본 약관에서 정한 바에
                따라 제4조 제(5)항에 기재된 연락처로 전자문서의 전송 또는 서비스
                페이지 내 철회에 의한 방법으로 "거래지시"를 철회할 수 있습니다.
                단, 각 서비스 별 "거래지시" 철회의 효력 발생시기는 본 약관
                제16조, 제21조, 제25조, 제29조에서 정한 바에 따릅니다. (2)
                "회원"은 전자지급의 효력이 발생한 경우에 전자상거래 등에서의
                소비자보호에 관한 법률 등 관련 법령상 청약 철회의 방법에 따라
                결제대금을 반환 받을 수 있습니다. 제6조 ("오류"의 정정 등) (1)
                "회원"은 "전자금융거래서비스"를 이용함에 있어 "오류"가 있음을 안
                때에는 "회사"에 대하여 그 정정을 요구할 수 있습니다. (2)
                "회사"는 전 항의 규정에 따른 "오류"의 정정 요구를 받은 때 또는
                스스로 "전자금융거래"에 "오류"가 있음을 안 때에는 이를 즉시
                조사하여 처리한 후 정정 요구를 받은 날 또는 "오류"가 있음을 안
                날부터 2주 이내에 그 결과를 문서, 전화 또는 전자우편으로
                "회원"에게 알려 드립니다. 다만, "회원"이 문서로 알려줄 것을
                요청하는 경우에는 문서로 알려 드립니다. 제7조 ("전자금융거래"
                기록의 생성 및 보존) (1) "회사"는 "회원"이 이용한
                "전자금융거래"의 내용을 추적, 검색하거나 그 내용에 "오류"가
                발생한 경우에 이를 확인하거나 정정할 수 있는 기록을 보존합니다.
                (2) 전 항의 규정에 따라 "회사"가 보존하여야 하는 기록의 종류 및
                보존기간은 다음 각 호와 같습니다. ① 다음 각 목의 거래기록은
                5년간 보존하여야 합니다. 가. 제4조 제(3)항 제①호 내지 제⑧호에
                관한 사항 나. 해당 "전자금융거래"와 관련한 "전자적 장치"의
                접속기록 다. 건당 거래금액이 1만원을 초과하는 "전자금융거래"에
                관한 기록 ② 다음 각 목의 거래기록은 1년간 보존하여야 합니다. 가.
                제4조 제(4)항 제①호에 관한 사항 나. 건당 거래금액이 1만원 이하인
                "전자금융거래"에 관한 기록 다. 전자지급수단 이용과 관련된
                거래승인에 관한 기록 라. 기타 금융위원회가 고시로 정한 사항
                제8조 ("전자금융거래"정보의 제공금지) (1) "회사"는
                "전자금융거래서비스"를 제공함에 있어서 취득한 "회원"의 인적
                사항, "회원"의 계좌, "접근매체" 및 "전자금융거래"의 내용과
                실적에 관한 정보 또는 자료를 법령에 의하거나 "회원"의 동의를
                얻지 아니하고 제3자에게 제공, 누설하거나 업무상 목적 외에
                사용하지 아니합니다. (2) "회사"는 "회원"이 안전하게
                "전자금융거래서비스"를 이용할 수 있도록 "회원"의 개인정보보호를
                위하여 개인정보취급방침을 운용합니다. "회사"의
                개인정보취급방침은 "회사"의 홈페이지 또는 서비스 페이지에 링크된
                화면에서 확인할 수 있습니다. 제9조 ("접근매체"의 관리) (1)
                "회사"는 "전자금융거래서비스" 제공시 "접근매체"를 선정하여
                "회원"의 신원, 권한 및 "거래지시"의 내용 등을 확인합니다. (2)
                "회사"는 "회원"이 "접근매체"의 분실 또는 도난 등을 통지하지 않아
                발생하는 손해에 대하여 책임지지 않습니다. (3) "회원"은
                "접근매체"를 사용함에 있어서 다른 법률에 특별한 규정이 없는 한
                다음 각 호의 행위를 하여서는 아니됩니다. ① "접근매체"를
                양도하거나 양수하는 행위 ② 대가를 수수•요구 또는 약속하면서
                "접근매체"를 대여받거나 대여하는 행위 또는 보관•전달•유통하는
                행위 ③ 범죄에 이용할 목적으로 또는 범죄에 이용될 것을 알면서
                "접근매체"를 대여받거나 대여하는 행위 또는 보관•전달•유통하는
                행위 ④ "접근매체"를 질권의 목적으로 하는 행위 ⑤ 제①호부터
                제④호까지의 행위를 알선하는 행위 (4) "회원"은 자신의
                "접근매체"를 제3자에게 누설 또는 노출하거나 방치하여서는 안되며,
                "접근매체"의 도용이나 위조 또는 변조를 방지하기 위하여 충분한
                주의를 기울여야 합니다. (5) "회사"는 "회원"으로부터 "접근매체"의
                분실이나 도난 등의 통지를 받은 때에는 그때부터 제3자가 그
                "접근매체"를 사용함으로 인하여 "회원"에게 발생한 손해를 배상할
                책임이 있습니다. 제10조 ("회사"의 책임) (1) "회사"는 다음 각
                호의 어느 하나에 해당하는 사고로 인하여 "회원"에게 손해가 발생한
                경우에는 그 손해를 배상할 책임을 집니다. ① "접근매체"의 위조나
                변조로 발생한 사고(단, "회사"가 "접근매체"의 발급 주체이거나
                사용, 관리 주체인 경우로 한정합니다) ② 계약체결 또는
                "거래지시"의 전자적 전송이나 처리 과정에서 발생한 사고 ③
                전자금융거래를 위한 "전자적 장치" 또는 정보통신망 이용촉진 및
                정보보호 등에 관한 법률 제2조 제1항 제1호에 따른 정보통신망에
                침입하여 거짓이나 그 밖의 부정한 방법으로 획득한 "접근매체"의
                이용으로 발생한 사고 (2) "회사"는 제(1)항에도 불구하고 다음 각
                호의 어느 하나에 해당하는 경우에는 그 책임의 전부 또는 일부를
                "회원"이 부담하게 할 수 있습니다. ① "회원"이 "접근매체"를
                제3자에게 대여하거나 그 사용을 위임한 경우 또는 양도나 담보의
                목적으로 제공한 경우 ② "회원"이 제3자가 권한 없이 "회원"의
                "접근매체"를 이용하여 "전자금융거래"를 할 수 있음을 알았거나
                쉽게 알 수 있었음에도 불구하고 자신의 "접근매체"를 누설하거나
                노출 또는 방치한 경우 ③ "회사"가 보안강화를 위하여
                "전자금융거래"시 요구하는 추가적인 보안조치를 "회원"이 정당한
                사유 없이 거부하여 제(1)항 제③호에 따른 사고가 발생한 경우 ④
                "회원"이 제③호에 따른 추가적인 보안조치에 사용되는 매체•수단
                또는 정보에 대하여 누설•노출 또는 방치하거나 제3자에게
                대여하거나 그 사용을 위임한 행위 또는 양도나 담보의 목적으로
                제공하는 행위를 하여 제(1)항 제③호에 따른 사고가 발생한 경우 ⑤
                법인(중소기업기본법 제2조 제2항에 의한 소기업을 제외합니다)인
                "회원"에게 손해가 발생한 경우로서 "회사"가 사고를 방지하기
                위하여 보안절차를 수립하고 이를 철저히 준수하는 등 합리적으로
                요구되는 충분한 주의의무를 다한 경우 (3) "회사"는 "회원"으로부터
                "거래지시"가 있음에도 불구하고 천재지변, "회사"의 귀책사유 없는
                기타의 불가항력적인 사유로 처리 불가능하거나 지연된 경우로서
                "회원"에게 처리 불가능 또는 지연 사유를 통지한 경우(금융회사
                또는 결제수단발행업자나 통신판매업자가 통지한 경우를 포함합니다)
                또는 "회사"가 고의•과실 없음을 입증한 경우에는 "회원"에 대하여
                이로 인한 손해배상책임을 지지 아니합니다. (4) "회사"는 컴퓨터 등
                정보통신설비의 보수점검, 교체의 사유가 발생하여
                "전자금융거래서비스"의 제공을 일시적으로 중단할 경우에는
                "회사"의 홈페이지 또는 서비스 페이지를 통하여 "회원"에게 중단
                일정 및 중단 사유를 사전에 공지합니다. 제11조 (분쟁처리 및
                분쟁조정) (1) "회원"은 "회사"의 서비스 페이지 하단에 게시된
                분쟁처리 담당자에 대하여 "전자금융거래"와 관련한 의견 및 불만의
                제기, 손해배상의 청구 등의 분쟁처리를 요구할 수 있습니다. (2)
                "회원"이 "회사"에 대하여 분쟁처리를 신청한 경우에는 "회사"는
                15일 이내에 이에 대한 조사 또는 처리 결과를 "회원"에게
                안내합니다. (3) "회원"은 "전자금융거래"의 처리에 관하여 이의가
                있을 때에는 금융위원회의 설치 등에 관한 법률에 따른 금융감독원의
                금융분쟁조정위원회 또는 소비자기본법에 따른 한국소비자원의
                소비자분쟁조정위원회에 분쟁조정을 신청할 수 있습니다. 제12조
                ("회사"의 안정성 확보 의무) "회사"는 "전자금융거래"가 안전하게
                처리될 수 있도록 "전자금융거래"의 종류 별로 전자적 전송이나
                처리를 위한 인력, 시설, "전자적 장치" 등의 정보기술부문 및
                전자금융업무에 관하여 금융위원회가 정하는 기준을 준수합니다.
                제13조 (약관 외 준칙) 본 약관에서 정하지 아니한 사항(용어의
                정의를 포함합니다)에 대하여는 전자금융거래법, 전자상거래
                등에서의 소비자보호에 관한 법률, 여신전문금융업법 등 소비자보호
                관련 법령 및 개별 약관에서 정한 바에 따릅니다. 제14조 (관할)
                "회사"와 "회원" 간에 발생한 분쟁에 관한 관할은 민사소송법에서
                정한 바에 따릅니다. 제2장 전자지급결제대행서비스 제15조 (정의)
                본 장에서 사용하는 용어의 정의는 다음과 같습니다. ①
                "전자지급결제대행서비스"라 함은 전자적 방법으로 재화 등의 구매에
                있어서 지급결제정보를 송신하거나 수신하는 것 또는 그 대가의
                정산을 대행하거나 매개하는 서비스를 말합니다. 제16조
                ("거래지시"의 철회) (1) "회원"이 "전자지급결제대행서비스"를
                이용한 경우, "회원"은 "거래지시"된 금액의 정보에 대하여 수취인의
                계좌가 개설되어 있는 금융회사 또는 "회사"의 계좌의 원장에
                입금기록이 끝나거나 "전자적 장치"에 입력이 끝나기 전까지
                "거래지시"를 철회할 수 있습니다. (2) "회사"는 "회원"의
                "거래지시"의 철회에 따라 지급거래가 이루어지지 않은 경우 수령한
                자금을 "회원"에게 반환하여야 합니다. 제17조 (한도 등) "회사"의
                정책 및 결제업체(이동통신사, 카드사 등)의 기준에 따라 "회원"의
                결제수단별 월 누적 결제액 및 결제한도가 제한될 수 있습니다.
                제3장 선불전자지급수단의 발행 및 관리서비스 제18조 (정의) 본
                장에서 사용하는 용어의 정의는 다음과 같습니다. ①
                "선불전자지급수단"이라 함은 페이코 포인트 등 "회사"가 발행 당시
                미리 "회원"에게 공지한 전자금융거래법상 선불전자지급수단을
                말합니다. 제19조 ("접근매체"의 관리) "회사"는 "회원"으로부터
                "접근매체"의 분실 또는 도난 등의 통지를 받기 전에 발생하는
                "선불전자지급수단"에 저장된 금액에 대한 손해에 대하여는 책임지지
                않습니다. 제20조 (환급 등) (1) "회원"이 충전한
                "선불전자지급수단"에 한하여, "회사"는 다음 각호의 어느 하나에
                해당하는 경우 "회원"이 환급을 요청했을 때 "회사"가 정한 절차에
                따라 환급합니다. 다만, "회사"는 사안에 따라 환급수수료를 징수할
                수 있으며, 환급할 때에는 소정의 환급수수료를 차감한 후 잔액의
                전부를 지급할 수 있습니다. ① "회원"이 충전한
                "선불전자지급수단"의 환급을 요청하는 경우 ② 천재지변 등의 사유로
                "판매자"가 재화 등을 제공하기 곤란하여 "선불전자지급수단"을
                사용하지 못하게 된 경우 ③"선불전자지급수단"의 결함으로
                "판매자"가 재화 등을 제공하지 못하는 경우 (2) "회원"은
                "회사"에서 정한 기한 및 이용방법에 따라 "선불전자지급수단"을
                이용할 수 있으며, "회사"는 그 구체적 사항을 서비스 페이지를 통해
                공지합니다. 제21조 ("거래지시"의 철회) (1) "회원"이
                "선불전자지급수단"을 이용하여 자금을 지급하는 경우, "회원"은
                "거래지시"된 금액의 정보가 수취인이 지정한 "전자적 장치"에
                도달하기 전까지 "거래지시"를 철회할 수 있습니다. (2) "회사"는
                "회원"의 "거래지시"의 철회에 따라 지급거래가 이루어지지 않은
                경우 수령한 자금을 "회원"에게 반환하여야 합니다. 제22조
                ("선불전자지급수단"의 한도 등) (1) "회사"는 "선불전자지급수단"에
                대해 실지명의 당 최고 200만원을 그 보유 한도로 합니다. 단 보유
                한도는 회사의 정책에 따라 감액될 수 있습니다. (2) 제2장
                전자지급결제대행서비스 제17조는 본 장에 준용합니다. 제23조
                (유효기간) (1) "회사"는 "회원"에 대하여 "선불전자지급수단"에
                대한 유효기간을 설정할 수 있으며, "회원"은 "회사"가 정한
                유효기간 내에서만 "선불전자지급수단"을 사용할 수 있습니다. (2)
                "회사"는 서비스 페이지 등을 통하여 전 항의 유효기간 설정 여부 및
                그 기간을 공지합니다. 제4장 직불전자지급수단의 발행 및
                관리서비스 제24조 (정의) 본 장에서 사용하는 용어의 정의는 다음과
                같습니다. ① "직불전자지급수단"이라 함은 "회원"과 "판매자" 간에
                전자적 방법에 따라 금융회사의 계좌에서 자금을 이체하는 방법으로
                재화 등의 제공과 그 대가의 지급을 동시에 이행할 수 있는
                전자금융거래법상 직불전자지급수단을 말합니다. 제25조
                ("거래지시"의 철회) (1) "회원"이 "직불전자지급수단"을 이용하여
                자금을 지급하는 경우, "회원"은 "거래지시"된 금액의 정보에 대하여
                수취인의 계좌가 개설되어 있는 금융회사의 계좌의 원장에
                입금기록이 끝나기 전까지 "거래지시"를 철회할 수 있습니다. (2)
                "회사"는 "회원"의 "거래지시"의 철회에 따라 지급거래가 이루어지지
                않은 경우 수령한 자금을 "회원"에게 반환하여야 합니다. 제26조
                ("직불전자지급수단"의 한도 등) (1) "회사"는 "회원"이
                "직불전자지급수단"을 이용하여 재화 등을 구매할 수 있는 최대
                이용한도(1회, 1일 이용한도 등)를 관련 법령 및 "회사"의 정책에
                따라 정할 수 있으며, "회원"은 "회사"가 정한 그 이용한도 내에서만
                "직불전자지급수단"을 사용할 수 있습니다. (2) "회사"는 서비스
                페이지 등을 통하여 전 항의 최대 이용한도를 공지합니다. 제5장
                결제대금예치서비스 제27조 (정의) 본 장에서 사용하는 용어의
                정의는 다음과 같습니다. ① "결제대금예치서비스"라 함은 서비스
                페이지에서 이루어지는 "선불식 통신판매"에 있어서, "회사"가
                "회원"이 지급하는 결제대금을 예치하고, 배송이 완료되는 등 구매가
                확정된 후 재화 등의 대금을 "판매자"에게 지급하는 서비스를
                말합니다. ② "선불식 통신판매"라 함은 "회원"이 재화 등을 공급받기
                전에 미리 대금의 전부 또는 일부를 지급하는 방식의 통신판매를
                말합니다. 제28조 (예치된 결제대금의 지급방법) (1) "회원"(그
                "회원"의 동의를 얻은 경우에는 재화 등을 공급받을 자를
                포함합니다. 이하 제(2)항 및 제(3)항에서 동일합니다)은 재화 등을
                공급받은 사실을 재화 등을 공급받은 날부터 3영업일 이내에
                "회사"에 통보하여야 합니다. (2) "회사"는 "회원"으로부터 재화
                등을 공급받은 사실을 통보 받을 경우 "회사"가 정한 기일 내에
                "판매자"에게 결제대금을 지급합니다. (3) "회사"는 "회원"이 재화
                등을 공급받은 날부터 3영업일이 지나도록 정당한 사유의 제시 없이
                그 공급받은 사실을 "회사"에 통보하지 아니하는 경우에 "회원"의
                동의 없이 "판매자"에게 결제대금을 지급할 수 있습니다. (4)
                "회사"가 "판매자"에게 결제대금을 지급하기 전에 "회원"이 그
                결제대금을 환급 받을 정당한 사유가 발생한 경우에는 그 결제대금을
                "회원"에게 환급합니다. 제29조 (거래지시의 철회) (1) "회원"이
                "결제대금예치서비스"를 이용한 경우, "회원"은 "거래지시"된 금액의
                정보가 수취인이 지정한 "전자적 장치"에 도달할 때까지 거래지시를
                철회할 수 있습니다. (2) "회사"는 "회원"의 거래지시의 철회에 따라
                지급거래가 이루어지지 않은 경우 수령한 자금을 "회원"에게
                반환하여야 합니다. 제6장 전자고지결제서비스 제30조 (정의) 본
                장에서 사용하는 용어의 정의는 다음과 같습니다. ①
                "전자고지결제서비스"라 함은 국세, 지방세, 공공요금, 각종
                지로요금 등의 지급과 관련하여 "청구서"등의 전자적인 방법으로
                자금 내역을 고지하고, 이를 수수하여 그 정산을 대행하는 업무를
                제공하는 시스템 및 서비스 일체를 말합니다. ② "청구서"라 함은
                "회사"가 수취인을 대행하여 지급인에게 전송하는 전자적인 방식의
                고지방법을 말합니다. 제 31조("거래지시"의 철회) 본 장에서
                사용하는 용어의 정의는 다음과 같습니다. ① "회원"이
                "전자고지결제서비스"를 이용하여 자금을 지급하는 경우 "회원"은
                "거래지시"된 금액의 정보가 수취인이 지정한 "전자적 장치"에
                도달할 때까지 "거래지시"를 철회할 수 있습니다. ② "회사"는
                "회원"의 "거래지시"의 철회에 따라 지급거래가 이루어지지 않은
                경우 수령한 자금을 "회원"에게 반환하여야 합니다. <부칙> 본
                약관은 2017년 2월 17일부터 적용됩니다.
              </div>
              <div
                class="tab-pane fade"
                id="profile"
                role="tabpanel"
                aria-labelledby="profile-tab"
              >
                1. 수집하는 개인정보의 항목 및 수집방법 가. 수집하는 개인정보의
                항목 PAYCO 회원가입, 원활한 고객상담, 각종 서비스의 제공을 위해
                아래와 같은 개인정보를 수집하고 있습니다. - 이메일주소 또는
                휴대폰번호(PAYCO ID), 비밀번호 서비스 이용과정에서 아래와 같은
                정보가 생성되어 수집될 수 있습니다. - IP Address, 쿠키, 방문
                일시, 서비스 이용 기록, 불량 이용 기록, 모바일 서비스 이용시
                단말기 정보(단말기 모델, 이동통신사 정보, 하드웨어 ID, 광고 ID,
                서비스 이용에 대한 기본 통계), 이용자 단말기 내 설치된
                어플리케이션 정보(앱 설치/실행시각 포함), 결제·구매기록,
                위치기반서비스 이용약관 동의시 이용자 위치정보 - 본인인증 시
                수집정보[이름, 생년월일, 성별, 암호화된 동일인 식별정보(CI),
                중복가입확인정 (DI)] 부정이용방지 및 비인가 사용방지를 위해
                PAYCO 결제 이용시 아래와 같은 정보가 추가적으로 수집될 수
                있습니다. - 전화번호, 단말기 정보(접속 단말기종류, OS유형, UUID,
                IMEI) 나. 개인정보 수집방법 회사는 다음과 같은 방법으로
                개인정보를 수집합니다. - 홈페이지, 모바일 기기, 서면양식, 팩스,
                전화, 상담 게시판, 이메일, 이벤트 응모, 배송요청 -
                협력회사로부터의 제공 - 생성정보 수집 툴을 통한 수집 또한,
                회사는 서비스 이용 도중 추가적인 정보를 수집할 수 있으며, 이
                경우 별도의 개인정보 수집 및 이용 동의를 받습니다. 2. 개인정보의
                수집 및 이용목적 회사는 수집한 개인정보를 다음의 목적을 위해
                활용합니다. - 이용자와 약속한 서비스 제공, 서비스 제공에 따른
                본인인증, 구매 및 요금결제, PAYCO 이용내역 제공, 상품 및
                서비스의 배송을 위하여 개인정보를 이용합니다. - 회원 가입 의사의
                확인, 연령 확인 및 법정대리인 동의 진행, 이용자 및 법정대리인의
                본인 확인, 이용자 식별, 회원탈퇴 의사의 확인, 문의사항 또는
                불만처리 등 회원관리를 위하여 개인정보를 이용합니다. - 법령 및
                이용약관을 위반하는 회원에 대한 이용 제한 조치, 부정 이용 행위를
                포함하여 서비스의 원활한 운영에 지장을 주는 행위 및 비인가
                행위에 대한 방지 및 제재, 계정도용 및 부정거래 방지, 고지사항
                전달, 분쟁 조정을 위한 기록보존 등 이용자 보호 및 서비스 운영을
                위하여 개인정보를 이용합니다. - 인구통계학적 특성에 따른 서비스
                제공, 접속 빈도 분석, 기능개선, 서비스 이용에 대한 통계, 서비스
                분석 및 통계에 기반하여 이용자의 상품 구매 및 서비스 이용 성향,
                관심, 이용기록 분석 등을 반영한 신규 서비스 제공(개인 맞춤형
                상품 추천 서비스 등 포함) 등에 개인정보를 이용합니다. - 이벤트
                정보, 광고성 정보 제공 등 이벤트 및 프로모션의 목적 등에
                개인정보를 이용합니다. 3. 개인정보의 보유 및 이용기간 회사는
                원칙적으로 이용자의 개인정보를 회원탈퇴 시까지 보관합니다. 단,
                회사는 개인정보 도용 등으로 인한 원치 않는 회원탈퇴 등에
                대비하기 위하여 회원탈퇴 요청 후, 7일간 개인정보를 보유합니다.
                그 외에도 다음의 정보에 대해서는 회원탈퇴 후에도 아래의 이유로
                명시한 기간 동안 보관합니다. 가. 회사 내부 방침에 의한 정보보유
                사유 별도 보유 정보 보존 이유, 보존 기간 부정이용기록,
                중복가입확인정보(DI), 본인인증기록(비회원 포함) - 부정이용 방지
                및 고객 상담 대응 등 - 보존 기간: 수집일로부터 1년 페이코티머니
                및 POP카드 발급 기록 - 보존이유: 회원 민원 대응 - 보존 기간: 2년
                TOAST PC 정산내역 - 보존이유: 회계증빙 및 회원민원 대응 - 보존
                기간: 5년 토스트앳 직원 근태 및 연봉정보 - 보존이유: 직원간 분쟁
                대응 - 보존 기간: 직원 탈퇴일로부터 6개월 또는 대표의 서비스
                탈퇴시까지 '핑크다이어리' 서비스 이용기록 - 보존 이유: 회원 민원
                대응 등 - 보존 기간: 30일 '핑크다이어리' 비회원의
                단말기정보(OS유형,광고ID 등), 단말기 내 설치된 어플케이션
                정보(앱 설치/실행시각 포함)등 서비스 이용기록 - 보존 이유:
                서비스의 제공, 부정이용방지와 비인가 사용방지, 개인 식별, 이용자
                관심 등에 기반한 신규 서비스 제공(개인 맞춤형 상품 추천 서비스
                등 포함) - 보존 기간: 수집일로부터 2년 '게임박스' 친구추천,
                퀘스트 수행 등에 따른 리워드지급내역 - 보존 이유: 부정 이용 방지
                - 보존 기간: 1년 나. 관련법령에 의한 정보보유 사유 상법,
                전자상거래 등에서의 소비자보호에 관한 법률 등 관계법령의 규정에
                의하여 보존할 필요가 있는 경우 회사는 관계법령에서 정한 일정한
                기간 동안 회원정보를 보관합니다. 이 경우 회사는 보관하는 정보를
                그 보관의 목적으로만 이용하며 보존기간은 아래와 같습니다. -
                웹사이트 방문기록 보존 이유 : 통신비밀보호법 보존 기간 : 3개월 -
                소비자의 불만 또는 분쟁처리에 관한 기록 보존 이유 : 전자상거래
                등에서의 소비자보호에 관한 법률 보존 기간 : 3년 - 계약 또는
                청약철회 등에 관한 기록 보존 이유 : 전자상거래 등에서의
                소비자보호에 관한 법률 보존 기간 : 5년 - 대금결제 및 재화 등의
                공급에 관한 기록 보존 이유 : 전자상거래 등에서의 소비자보호에
                관한 법률 보존 기간 : 5년 - 건당 거래금액이 1만원을 초과하는
                전자금융거래에 관한 기록 보존 이유 :전자금융거래법 보존 기간 :
                5년 - 건당 거래금액이 1만원을 이하인 전자금융거래에 관한 기록
                보존 이유 :전자금융거래법 보존 기간 : 1년
              </div>
              <div
                class="tab-pane fade"
                id="contact"
                role="tabpanel"
                aria-labelledby="contact-tab"
              >
                신용카드 - 위탁받는 자: NHN한국사이버결제 - 위탁업무 내용: PAYCO
                신용카드 결제처리 휴대폰 - 위탁받는 자: 모빌리언스,
                NHN한국사이버결제 - 위탁업무 내용: PAYCO 휴대폰 결제처리
                계좌(결제/송금) - 위탁받는 자: 세틀뱅크, 케이아이비넷 - 위탁업무
                내용: PAYCO 계좌결제 및 송금 처리 계좌이체 - 위탁받는 자:
                NHN한국사이버결제 - 위탁업무 내용: PAYCO 계좌이체 결제처리
                신용카드(일반) - 위탁받는 자: NHN한국사이버결제 - 위탁업무 내용:
                PAYCO 신용카드 결제처리 무통장입금 - 위탁받는 자: 세틀뱅크 -
                위탁업무 내용: PAYCO 무통장입금 결제처리 문화상품권 - 위탁받는
                자: NHN한국사이버결제 - 위탁업무 내용: PAYCO 문화상품권 결제처리
              </div>
            </div>
          </dd>
        </dl>
        <div class="layer_btn_area">
          <button class="btn_ok">확인</button>
        </div>
      </div>
    </div>
  </div>

  <!--약관동의  2 end-->

  <!-- footer include -->
  <footer class="bg-gray mt-5">
    <div class="container p-5">
      <div class="row">
        <h2 class="red-text">NAVIYA</h2>
      </div>
      <div class="pl-5 pr-5 d-flex row">
        <div class="col-sm-3">
          <div>
            shop
          </div>
          <div>
            main1
          </div>
          <div>
            main2
          </div>
          <div>
            QnA
          </div>
        </div>
        <div class="col-sm-3">
          <div>
            <span class="font-weight-bold"> TEAMLEADER </span><br />
            <span
              ><a class="atag-github" href="https://github.com/jeongseongjong"
                >&nbsp;&nbsp;- NAVI</a
              ></span
            >
          </div>
          <div>
            <span class="font-weight-bold">UI/UX</span> <br />
            <span
              ><a class="atag-github" href="https://github.com/qussoa"
                >&nbsp;&nbsp;- QUSSOA</a
              ></span
            >
          </div>
        </div>
        <div class="col-sm-3">
          <div>
            <span class="font-weight-bold">DEVELOPER</span><br />
            <span
              ><a class="atag-github" href="https://github.com/leeiter"
                >&nbsp;&nbsp;- PRINCESSEJIN</a
              ></span
            >
          </div>
          <div>
            <span class="font-weight-bold">DEVELOPER</span><br />
            <span
              ><a class="atag-github" href="https://github.com/bjmin17"
                >&nbsp;&nbsp; - BJ.MIN</a
              ></span
            >
          </div>
        </div>
        <div class="col-sm-3">
          <div>
            <small>
              광주광역시 북구 경양로170<br />
              한경빌딩 5층
            </small>
          </div>
          <div>
            <small>
              &copy; copyRight qussoa@naver.com
            </small>
          </div>
        </div>
      </div>
    </div>
  </footer>
</html>
