<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>빠져 보다, cinema</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
$(function() {
    var dt = new Date();
    var m = dt.getMonth() + 1;
    var month = (m < 10) ? "0" + m : m + ""; // 두 자리 수 만들기 ex) 04, 10
    var d = dt.getDate() - 1;
    var day = (d < 10) ? "0" + d : d + ""; // 두 자리 수 만들기 ex) 01, 12
    var y = dt.getFullYear();
    console.log("dt.getFullYear: ",y);
    var result = y + month + day;
    console.log("result: ", result);

    $.ajax({
        url: "http://www.kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList",
        method: 'GET',
        data: {
            key: 'c21c7feb4d426541f043770aecec0565',
            targetDt: result, // ex) 20240714
            itemPerPage: 20 // 20개씩만
        },
        dataType: "xml",
        success: function(data) {
            var $data = $(data).find("boxOfficeResult > dailyBoxOfficeList > dailyBoxOffice");
            if ($data.length > 0) {
                var table = $("<table/>").attr("class", "table"); // css와 테이블 선언
                var thead = $("<thead/>").append($("<tr/>"))
                    .append(
                        $("<th/>").html("&nbsp;&nbsp;영화 제목 및 개봉일"),
                        $("<th/>").html("&nbsp;&nbsp;영화 포스터")
                    );
                var tbody = $("<tbody/>"); // tody선언

                $data.each(function(i, o) {
                    var $movieCd = $(o).find("movieCd").text(); // 영화 고유 id 가져오기
                    var $movieNm = $(o).find("movieNm").text(); // 영화 제목
                    var $openDt = $(o).find("openDt").text(); // 개봉일

                    $.ajax({
                        url: "https://api.themoviedb.org/3/search/movie", // api 요청 url
                        method: "GET", 
                        data: {
                            api_key: '713076743ee17129fda347af138c628a',
                            query: $movieNm,// 제목으로 검색하기 위함
                            language: 'ko-KR' // 한국어
                        },
                        success: function(tmdbData) {
                            if (tmdbData.results.length > 0) { 
                                var movie = tmdbData.results[0]; // tmdb api 결과물들 중 가장 첫 번째
                                var posterPath = movie.poster_path; // 영화 포스터 이미지 경로
                                var title = movie.title; // 제목
                                var posterUrl = "https://image.tmdb.org/t/p/w500" + posterPath; // 포스터 요청 url
                               
                                // 랜덤 region 선택
                                var regions = ["서울", "경기", "인천", "강원", "대전/충청", "대구", "부산/울산", "경상", "광주/전라/제주"];
                                var randomRegion = regions[Math.floor(Math.random() * regions.length)];
                                
                                var row = $("<tr/>").append( // <tr> 생성 
                                    $("<td/>").append( // <td> 생성 
                                        $("<button/>").attr("id", "submitBtn") // 버튼 생성
                                            .text($movieNm + " (" + $openDt + ")") // 버튼 보이는 값
                                            .click(function() {
                                               $.ajax({
                                            	   url: "/api/theater/add",
                                            	   method: "POST",
                                            	   contentType: "application/json",
                                            	   data: JSON.stringify({
                                            		   title: title,
                                            		   region: randomRegion,
                                            		}),
                                            	   success : function(response){
                                            		   console.log("response: ",response);
                                            		   if (response === "Success") {
                                            	            alert("데이터베이스에 저장되었습니다.");
                                            	            // 성공 처리 로직 추가
                                            	        } else if (response === "fail") {
                                            	            alert("저장 실패했습니다.");
                                            	            // 실패 처리 로직 추가
                                            	        } 
                                            	   },
                                            	   error: function(xhr, status, error) {
                                                       console.error("저장 오류:", error);
                                                   }
                                               })
                                            })
                                    ),
                                    $("<td/>").append($("<img>").attr("src", posterUrl).attr("alt", title).css("max-width", "100px"))
                                );
                                tbody.append(row);
                            }
                        },
                        error: function(xhr, status, error) {
                            console.error("TMDB API 오류:", error);
                        }
                    });
                });

                table.append(thead);
                table.append(tbody);
                $(".wrap").append(table);
            }
        },
        error: function(xhr, status, error) {
            console.error("KOBIS API 오류:", error);
            alert("실시간 박스오피스 로딩중...");
        }
    });
    
   
});
</script>
</head>
<body>
<h3>영화 메인</h3>
<div class="wrap"></div>
</body>
</html>
