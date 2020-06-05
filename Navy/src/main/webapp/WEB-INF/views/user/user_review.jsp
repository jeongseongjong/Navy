<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

				<!--review -->
				<div class="tab-pane fade" id="profile" role="tabpanel"
					aria-labelledby="profile-tab">
					<div class="d-flex justify-content-end">
						<!-- <button class="bt-review-wr" data-id="${productVO.p_code}">리뷰작성</button> -->
					</div>

					<!-- 리뷰List -->
					<c:choose>
						<c:when test="${empty productVO.reviewList}">
							<div class="container-fluid"
								style="border-bottom: 1px solid #8c8d90; margin: 40px;">
								<p>상품 REVIEW가 없습니다.</p>
							</div>
						</c:when>
						<c:otherwise>
							<c:forEach var="REVIEW" items="${productVO.reviewList}">
								<div data-id="${REVIEW.r_id}" class="container-fluid"
									style="border-bottom: 1px solid #8c8d90; margin: 40px;">
									<span class="pro-star">상품</span>

									<!-- 별점 -->
									<input type="radio" name="rating" value="1" id="star-1"
										class="star__radio visuhide" /> <input type="radio"
										name="rating" value="2" id="star-2"
										class="star__radio visuhide" /> <input type="radio"
										name="rating" value="3" id="star-3"
										class="star__radio visuhide" /> <input type="radio"
										name="rating" value="4" id="star-4"
										class="star__radio visuhide" /> <input type="radio"
										name="rating" value="5" id="star-5"
										class="star__radio visuhide" /> <label class="star__item"
										for="star-1"> <span class="visuhide">1 star</span>
									</label> <label class="star__item" for="star-2"> <span
										class="visuhide">2 stars</span>
									</label> <label class="star__item" for="star-3"> <span
										class="visuhide">3 stars</span>
									</label> <label class="star__item" for="star-4"> <span
										class="visuhide">4 stars</span>
									</label> <label class="star__item" for="star-5"> <span
										class="visuhide">5 stars</span>
									</label> <span>${REVIEW.r_start}</span>
									<!-- 별점 end -->

									<!-- 상품명 -->
									<span class="row"
										style="font-size: 20px; margin-top: 10px; color: #8c8d90; margin-bottom: 20px; margin-left: 30px;">${productVO.p_name}</span>
									<!-- 사이즈, 색깔 리스트 재수정해야 함 -->
									<c:forEach items="${productVO.m_size_list}" var="list">
										<span>${list.s_size}</span>
									</c:forEach>
									<div>${cartVO.bk_p_size}</div>
									<div class="container">
										<div class="row"
											style="margin-left: 30px; margin-bottom: 20px;">
											<div class="col-sm-4 d-flex justify-content-center">
												<img src="${rootPath}/resources/img/dress1.jpg"
													style="width: 50%;" />
											</div>
											<div class="col-sm-8"
												style="vertical-align: middle; top: 30px;">
												<span>${REVIEW.r_text}</span>
											</div>

											<!--사용자 id 작성 날짜-->
											<div class="mt-5">
												<span>${REVIEW.r_auth}</span> <span>&#124;</span> <span>${REVIEW.r_date}</span>
											</div>
										</div>
									</div>
									<!-- 상품명 end -->
								</div>
							</c:forEach>
						</c:otherwise>
					</c:choose>
					<!-- 리뷰List end -->
				</div>
				<!-- 리뷰 end -->

  