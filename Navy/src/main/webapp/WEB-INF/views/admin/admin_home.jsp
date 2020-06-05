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
			$("a.cscard").click(function(){
				let id = $(this).data("id")
				document.location.href="${rootPath}/cs/detail/"+id
			})

		})
	</script>
	  <script>
    /* dashboard handling js*/
    $(function () {
      $(".column").sortable({
        // 드래그 앤 드롭 단위 css 선택자
        connectWith: ".column",
        // 움직이는 css 선택자
        handle: ".card-header",
        // 움직이지 못하는 css 선택자
        cancel: ".no-move",
        // 이동하려는 location에 추가 되는 클래스
        placeholder: "card-placeholder",
      });
      // 해당 클래스 하위의 텍스트 드래그를 막는다.
      $(".column .card").disableSelection();
    });

    /*
         1. ajax로 보내는 방법
        chart data 값 가져올때 참고 https://emflant.tistory.com/74
        ajax로 데이터 가져오고 json으로 보내기

        2. page rendering 하는 방법
        model에 담아서 페이지 로드 할때 같이 넘겨주기
        js에서 ${data} 이런식으로
    */

    google.charts.load("current", { packages: ["corechart"] });
    google.charts.setOnLoadCallback(allCurveChart);
    google.charts.setOnLoadCallback(todayCurveChart);

    /* chart 1*/
    function allCurveChart() {
      var data = google.visualization.arrayToDataTable([
        ["Year", "WhitePants", "Blackpanther"],
        ["3월", 1000, 400],
        ["4월", 1170, 460],
        ["5월", 660, 1120],
        ["6월", 1030, 540],
      ]);

      var options = {
        hAxis: {
          titleTextStyle: { color: "#333" },
          width: 100,
        },
        lineWidth: 5,
        series: {
          0: { color: "#1c91c0" },
          1: { color: "#e7711b" },
        },
        vAxis: { minValue: 0 },
      };

      var chart = new google.visualization.LineChart(
        document.getElementById("all_curve_chart")
      );

      chart.draw(data, options);
    }
    /*chart 2*/
    function todayCurveChart() {
      var data = google.visualization.arrayToDataTable([
        ["Year", "WhitePants"],
        ["3월", 500],
        ["4월", 300],
        ["5월", 1120],
        ["6월", 540],
      ]);

      var options = {
        hAxis: {
          titleTextStyle: { color: "#333" },
        },
        lineWidth: 5,
        series: {
          0: { color: "#1c91c0" },
          1: { color: "#e7711b" },
        },
        vAxis: { minValue: 0 },
      };

      var chart = new google.visualization.LineChart(
        document.getElementById("today_curve_chart")
      );

      chart.draw(data, options);
    }
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
			            <div class="row bg-light">
              <div class="col-12 py-4 text-center">
                <span style="font-size: 30px;">DASHBOARD</span>
              </div>
            </div>
            <!--DASHBORAD Contents-->
            <div class="container">
              <!-- 세로 리스트 박스 -->
              <div class="row">
                <!-- 각 카드 리스트 박스 -->
                <div class="col-6 column" style="border: none;">
                  <div class="card black-text" style="border: none;">
                    <div class="card-header" style="background-color: white;">
                      월매출
                    </div>
                    <div class="card-body d-flex justify-content-center">
                      <td>
                        <div id="all_curve_chart"></div>
                      </td>
                    </div>
                  </div>
                </div>
                <!--end-->
                <!-- 각 카드 리스트 박스
                <div class="col-6 column" style="border: none;">
                  <div class="card black-text" style="border: none;">
                    <div class="card-header" style="background-color: white;">
                      총매출
                    </div>
                    <div class="card-body d-flex justify-content-center">
                      <td>
                        <div id="today_curve_chart"></div>
                      </td>
                    </div>
                  </div>
                </div>    -->

                <!-- 세로 리스트 박스 -->
                <div class="col-6 column" style="border: none;">
                  <div class="card black-text" style="border: none;">
                    <div class="card-header" style="background-color: white;">
                      Q&A
                    </div>
                    <div class="card-body">
                      <div class="spn-list">
                      	<c:choose>
                      		<c:when test="${!empty QNALIST}">
								<c:forEach items="${QNALIST}" var="qna" begin="0" end="4">
									<a href="#" class="card-text">
		                          <span class="title mr-4">
		                            ${qna.q_title}</span
		                          >
		                          <span class="date">${qna.q_date}</span>
		                        </a>	
								</c:forEach>
                      		</c:when>
                      		<c:otherwise>
                      			<a href="#" class="card-text">
		                          <span class="title mr-4">
		                            Q&A가 없습니다.</span
		                          >
		                          <span class="date"></span>
		                        </a>		
                      		</c:otherwise>
                      	</c:choose>
                        <a href="#" class="card-text">
                          <span class="title mr-4">
                            Lorem ipsum dolor sit amet, consectetur adipiscing
                            elit, sed do eiusmod tempor incididunt ut labore et
                            dolore magna aliqua.</span
                          >
                          <span class="date">2020-05-19</span>
                        </a>
                        <a href="#" class="card-text">
                          <span class="title mr-4">
                            Lorem ipsum dolor sit amet, consectetur adipiscing
                            elit, sed do eiusmod tempor incididunt ut labore et
                            dolore magna aliqua.</span
                          >
                          <span class="date">2020-05-19</span>
                        </a>
                        <a href="#" class="card-text">
                          <span class="title mr-4">
                            Lorem ipsum dolor sit amet, consectetur adipiscing
                            elit, sed do eiusmod tempor incididunt ut labore et
                            dolore magna aliqua.</span
                          >
                          <span class="date">2020-05-19</span>
                        </a>
                        <a href="#" class="card-text">
                          <span class="title mr-4">
                            Lorem ipsum dolor sit amet, consectetur adipiscing
                            elit, sed do eiusmod tempor incididunt ut labore et
                            dolore magna aliqua.</span
                          >
                          <span class="date">2020-05-19</span>
                        </a>
                        <a href="#" class="card-text">
                          <span class="title mr-4">
                            Lorem ipsum dolor sit amet, consectetur adipiscing
                            elit, sed do eiusmod tempor incididunt ut labore et
                            dolore magna aliqua.</span
                          >
                          <span class="date">2020-05-19</span>
                        </a>
                        <a href="#" class="card-text">
                          <span class="title mr-4">
                            Lorem ipsum dolor sit amet, consectetur adipiscing
                            elit, sed do eiusmod tempor incididunt ut labore et
                            dolore magna aliqua.</span
                          >
                          <span class="date">2020-05-19</span>
                        </a>
                        <a href="#" class="card-text">
                          <span class="title mr-4">
                            Lorem ipsum dolor sit amet, consectetur adipiscing
                            elit, sed do eiusmod tempor incididunt ut labore et
                            dolore magna aliqua.</span
                          >
                          <span class="date">2020-05-19</span>
                        </a>
                      </div>
                      <a href="${rootPath}/admin/qna" class="card-link d-flex justify-content-end qna_list"
                        >더보기</a
                      >
                    </div>
                  </div>
                </div>
                <!--end-->
                <!--start-->
                <div class="col-6 column" style="border: none;">
                  <div class="card black-text" style="border: none;">
                    <div class="card-header" style="background-color: white;">
                      REVIEW
                    </div>
                    <div class="card-body">
                      <div class="spn-list">
                         <c:choose>
                      		<c:when test="${!empty REVIEWLIST}">
								<c:forEach items="${REVIEWLIST}" var="review" begin="0" end="4">
									<a href="#" class="card-text">
		                          <span class="title mr-4">
		                            ${review.r_text}</span
		                          >
		                          <span class="date">${review.r_date}</span>
		                        </a>	
								</c:forEach>
                      		</c:when>
                      		<c:otherwise>
                      			<a href="#" class="card-text">
		                          <span class="title mr-4">
		                            Review가 없습니다.</span
		                          >
		                          <span class="date"></span>
		                        </a>		
                      		</c:otherwise>
                      	</c:choose>
                        <a href="#" class="card-text">
                          <span class="title mr-4">
                            Lorem ipsum dolor sit amet, consectetur adipiscing
                            elit, sed do eiusmod tempor incididunt ut labore et
                            dolore magna aliqua.</span
                          >
                          <span class="date">2020-05-19</span>
                        </a>
                        <a href="#" class="card-text">
                          <span class="title mr-4">
                            Lorem ipsum dolor sit amet, consectetur adipiscing
                            elit, sed do eiusmod tempor incididunt ut labore et
                            dolore magna aliqua.</span
                          >
                          <span class="date">2020-05-19</span>
                        </a>
                        <a href="#" class="card-text">
                          <span class="title mr-4">
                            Lorem ipsum dolor sit amet, consectetur adipiscing
                            elit, sed do eiusmod tempor incididunt ut labore et
                            dolore magna aliqua.</span
                          >
                          <span class="date">2020-05-19</span>
                        </a>
                        <a href="#" class="card-text">
                          <span class="title mr-4">
                            Lorem ipsum dolor sit amet, consectetur adipiscing
                            elit, sed do eiusmod tempor incididunt ut labore et
                            dolore magna aliqua.</span
                          >
                          <span class="date">2020-05-19</span>
                        </a>
                      </div>
                      <a href="${rootPath}/admin/review" class="card-link d-flex justify-content-end review_list"
                        >더보기</a
                      >
                    </div>
                  </div>
                </div>
                <!--end-->
                <!-- 세로 리스트 박스 -->
                <div class="col-6 column" style="border: none;">
                  <div class="card black-text" style="border: none;">
                    <div class="card-header" style="background-color: white;">
                      고객센터
                    </div>
                    <div class="card-body">
                      <div class="spn-list">
                        <c:choose>
                      		<c:when test="${!empty CSLIST}">
								<c:forEach items="${CSLIST}" var="cs" begin="0" end="4">
									<a href="#" class="card-text cscard" data-id="${cs.cs_id}">
		                          <span class="title mr-4">
		                            ${cs.cs_title}</span
		                          >
		                          <span class="date">${cs.cs_date}</span>
		                        </a>	
								</c:forEach>
                      		</c:when>
                      		<c:otherwise>
                      			<a href="#" class="card-text">
		                          <span class="title mr-4">
		                            고객센터 글이 없습니다.</span
		                          >
		                          <span class="date"></span>
		                        </a>		
                      		</c:otherwise>
                      	</c:choose>
                      </div>
                      <a href="${rootPath}/cs/list" class="card-link d-flex justify-content-end"
                        >더보기</a
                      >
                    </div>
                  </div>
                </div>
                <!-- end-->
              </div>
            </div>
			
			</main>
          
        </div>
      </div>
    </article>
</body>
<%@ include file = "/WEB-INF/views/include/include-footer.jspf" %>
</html>