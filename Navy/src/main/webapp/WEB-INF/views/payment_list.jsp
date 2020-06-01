<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <title>Page Title</title>
    <script src="https://code.jquery.com/jquery-latest.min.js"></script>
    <link
      rel="stylesheet"
      href="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css"
    />
    <!-- Popper JS -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>

    <!-- Latest compiled JavaScript -->
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>

    <link rel="stylesheet" href="../main.css" />
    <link rel="stylesheet" href="./user-main.css" />
    <link rel="stylesheet" href="./user-cart.css" />
  </head>
  <style></style>
  <script>
    $(document).on("click", ".scope", function () {
      (".scope");
    });
  </script>
  <body>
    <!--header include-->
    <header>
      <div class="d-flex">
        <ul class="nav ml-auto mr-5">
          <!-- input 검색창-->
          <li class="nav-item nav-input">
            <input class="input-style" />
            <img src="../img/scope.png" class="scope" />
          </li>
          <!-- annonimous& authentication-->
          <li class="nav-item">
            <a class="nav-link">login</a>
          </li>
          <li class="nav-item">
            <a class="nav-link">logout</a>
          </li>
          <!--로그인시 mypage-->
          <li class="nav-item">
            <a href="../user/user-main.html" class="nav-link black-text"
              >mypage</a
            >
          </li>
          <li class="nav-item">
            <a class="nav-link">join</a>
          </li>
        </ul>
      </div>
    </header>
    <!--nav include 할 것-->
    <nav
      class="navbar navbar-expand-sm bg-white d-flex ml-5 mt-5 mb-5 sticky-top"
    >
      <a href="../main.html" class="red-text mr-5 h-title h2"
        ><span>NAVIYA</span></a
      >
      <div class="d-flex">
        <a class="nav-link black-text" href="../shopList.html">SHOP</a>
        <a class="nav-link black-text" href="../basket.html">장바구니</a>
        <a class="nav-link black-text" href="../sponsor.html">고객센터</a>
        <a class="nav-link black-text" href="./admin/admin-main.html">관리자</a>
      </div>
    </nav>
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
                id="check_id"
                class="_check_all"
                checked="checked"
              />
              <label for="check_id"> </label>
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
          <div id="deal_lists">
            <div class="ct_prod_wp">
              <div class="prod">
                <label class="checks _check_all chk_type">
                  <input
                    type="checkbox"
                    id="check_item"
                    class="_check_all"
                    checked="checked"
                  />
                  <label for="check_item"> </label>
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
                      src="../img/gu-dress-2.jpg"
                      alt="Gucci dress"
                      style="width: 100%;"
                      class="pro-img"
                    />
                  </div>
                  <div class="prod_name">
                    <strong class="pr_name">Gucci Dress</strong>
                  </div>
                </div>
                <!--prod_tit end-->
                <div class="highlight_wrap">
                  <div class="p_item">
                    <p class="op_name">
                      <span>[black M] Gucci drass</span>
                    </p>

                    <div class="bt_cnt">
                      <button
                        type="button"
                        class="cnt_minus"
                        onClick="javascript:this.amount.value--;"
                      >
                        <i class="blind">수량빼기</i>
                      </button>
                      <input
                        type="text"
                        class="ip_quantity"
                        title="수량입력"
                        value="1"
                        name="amount"
                      />
                      <button
                        type="button"
                        class="cnt_plus"
                        onClick="javascript:this.amount.value++;"
                      >
                        <i class="blind">수량 더하기</i>
                      </button>
                    </div>

                    <div class="price">
                      <p class="_origin">
                        <span class="num">1,750,000</span>
                        won
                      </p>
                      <button type="button" class="bt_del">
                        <i class="blind">삭제</i>
                      </button>
                    </div>
                  </div>
                </div>
                <!--option 변경-->
                <div class="op_change">
                  <div class="term_wrap">
                    <div class="term_right">
                      <button type="button" class="bt_type">
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
                        <span>1,750,000</span>
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
          <!--deal list  1 end-->
          <!--2 장바구니 리스트-->

          <!--deal list end-->
        </section>
        <div class="product_footer">
          <label class="checks _check_all chk_type">
            <input
              type="checkbox"
              id="check_total"
              class="_check_all"
              checked="checked"
            />
            <label for="check_total"> </label>
            <span class="clicked_deal"> <i class="blind">상품한개선택</i></span>
          </label>
          <button class="bt_del_type bt_type">삭제</button>
          <p class="guide_txt">장바구니에 담긴 상품은 보관만 가능합니다</p>
        </div>
        <!--총 주문 금액-->
        <div class="ct_total">
          <h3 class="ct_total_tit">총 주문금액</h3>
          <dl class="matter">
            <dt>총상품금액</dt>
            <dd>
              <em>3,500,000</em>
              <span>won</span>
            </dd>
            <dt>배송비</dt>
            <dd>
              <em>0</em>
              <span>won</span>
            </dd>
          </dl>
          <dl class="total">
            <dt>결제 예상금액</dt>
            <dd>
              <em class="_total_amount">3,500,000</em>
              <span>won</span>
            </dd>
          </dl>
        </div>
        <!--총주문금액 end-->
        <!-- button -->
        <div class="bt_area">
          <button type="button" class="bt_continue">쇼핑계속하기</button>
          <button type="button" class="bt_submit">구매하기</button>
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
