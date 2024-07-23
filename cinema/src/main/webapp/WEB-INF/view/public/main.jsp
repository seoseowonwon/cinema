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
	    var date_result = y +"-"+month+"-"+day;
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
					
	                
	                // 랜덤 region 선택을 위한 locations 초기화
	                let locations = [];
	                locations.push(new Map([["region", "인천"], ["theater_name", "주안역"]]));
	                locations.push(new Map([["region", "인천"], ["theater_name", "인천학익"]]));
	                locations.push(new Map([["region", "인천"], ["theater_name", "인천연수"]]));
	                locations.push(new Map([["region", "인천"], ["theater_name", "인천시민공원"]]));
	                locations.push(new Map([["region", "인천"], ["theater_name", "인천도화"]]));
	                locations.push(new Map([["region", "서울"], ["theater_name", "구로"]]));
	                locations.push(new Map([["region", "서울"], ["theater_name", "건대입구"]]));
	                locations.push(new Map([["region", "서울"], ["theater_name", "강변"]]));
	                locations.push(new Map([["region", "서울"], ["theater_name", "강남"]]));
	                locations.push(new Map([["region", "서울"], ["theater_name", "대학로"]]));
	                locations.push(new Map([["region", "부산/울산"], ["theater_name", "울산동구"]]));
	                locations.push(new Map([["region", "부산/울산"], ["theater_name", "센텀시티"]]));
	                locations.push(new Map([["region", "부산/울산"], ["theater_name", "서면"]]));
	                locations.push(new Map([["region", "부산/울산"], ["theater_name", "동래"]]));
	                locations.push(new Map([["region", "부산/울산"], ["theater_name", "대연"]]));
	                locations.push(new Map([["region", "대전/충청"], ["theater_name", "세종"]]));
	                locations.push(new Map([["region", "대전/충청"], ["theater_name", "대전가수원"]]));
	                locations.push(new Map([["region", "대전/충청"], ["theater_name", "대전"]]));
	                locations.push(new Map([["region", "대전/충청"], ["theater_name", "당진"]]));
	                locations.push(new Map([["region", "대전/충청"], ["theater_name", "논산"]]));
	                locations.push(new Map([["region", "대구"], ["theater_name", "대구현대"]]));
	                locations.push(new Map([["region", "대구"], ["theater_name", "대구연경"]]));
	                locations.push(new Map([["region", "대구"], ["theater_name", "대구스타디움"]]));
	                locations.push(new Map([["region", "대구"], ["theater_name", "대구수성"]]));
	                locations.push(new Map([["region", "대구"], ["theater_name", "대구"]]));
	                locations.push(new Map([["region", "광주/전라/제주"], ["theater_name", "목포"]]));
	                locations.push(new Map([["region", "광주/전라/제주"], ["theater_name", "나주"]]));
	                locations.push(new Map([["region", "광주/전라/제주"], ["theater_name", "광주상무"]]));
	                locations.push(new Map([["region", "광주/전라/제주"], ["theater_name", "광주금남로"]]));
	                locations.push(new Map([["region", "광주/전라/제주"], ["theater_name", "광양"]]));
	                locations.push(new Map([["region", "경상"], ["theater_name", "안동"]]));
	                locations.push(new Map([["region", "경상"], ["theater_name", "마산"]]));
	                locations.push(new Map([["region", "경상"], ["theater_name", "구미"]]));
	                locations.push(new Map([["region", "경상"], ["theater_name", "경산"]]));
	                locations.push(new Map([["region", "경상"], ["theater_name", "거제"]]));
	                locations.push(new Map([["region", "경기"], ["theater_name", "동두천"]]));
	                locations.push(new Map([["region", "경기"], ["theater_name", "다산"]]));
	                locations.push(new Map([["region", "경기"], ["theater_name", "김포운앙"]]));
	                locations.push(new Map([["region", "경기"], ["theater_name", "김포"]]));
	                locations.push(new Map([["region", "경기"], ["theater_name", "기흥"]]));
	                locations.push(new Map([["region", "강원"], ["theater_name", "춘천"]]));
	                locations.push(new Map([["region", "강원"], ["theater_name", "인제"]]));
	                locations.push(new Map([["region", "강원"], ["theater_name", "원통"]]));
	                locations.push(new Map([["region", "강원"], ["theater_name", "기린"]]));
	                locations.push(new Map([["region", "강원"], ["theater_name", "강릉"]]));
	                
	                let times = [];
	                times.push(new Map([["time", "09:50:00"]]));
	                times.push(new Map([["time", "10:00:00"]]));
	                times.push(new Map([["time", "10:50:00"]]));
	                times.push(new Map([["time", "11:00:00"]]));
	                times.push(new Map([["time", "13:30:00"]]));
	                times.push(new Map([["time", "14:00:00"]]));
	                times.push(new Map([["time", "15:10:00"]]));
	                times.push(new Map([["time", "16:20:00"]]));
	                times.push(new Map([["time", "18:30:00"]]));
	                times.push(new Map([["time", "19:50:00"]]));
	                times.push(new Map([["time", "20:00:00"]]));

	                
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
	                                var row = $("<tr/>").append( // <tr> 생성 
	                                    $("<td/>").append( // <td> 생성 
	                                        $("<button/>").attr("id", "submitBtn") // 버튼 생성
	                                            .text($movieNm + " (" + $openDt + ")") // 버튼 보이는 값
	                                            .click(function() { 
	                                            	
	                                            	$.ajax({
	                                                    url: "/api/theater/delete",
	                                                    method: "POST",
	                                                    contentType: "application/json",
	                                                    success: function(response) {
	                                                        console.log("response: ", response);
	                                                        if (response === "Success") {
	                                                            console.log("DB 삭제 성공");
	                                                        } else if (response === "fail") {
	                                                            console.log("DB 삭제 실패");
	                                                        }
	                                                    },
	                                                    error: function(xhr, status, error) {
	                                                        console.error("삭제 오류:", error);
	                                                    }
	                                                });
	                                            	
	                                            	 for (var i = 0; i < 500; i++) {
	                                                     var randomLocation = locations[Math.floor(Math.random() * locations.length)]; // 랜덤한 location 선택
	                                                     var randomRegion = randomLocation.get("region");
	                                                     var randomTheater = randomLocation.get("theater_name");
	                                                     var randomTimes = times[Math.floor(Math.random() * times.length)]; // 랜덤한 time 선택
	                                                     var randomTime = randomTimes.get("time");
														 var message = "";
	                                                     $.ajax({
	                                                         url: "/api/theater/add",
	                                                         method: "POST",
	                                                         contentType: "application/json",
	                                                         data: JSON.stringify({
	                                                             title: title,
	                                                             region: randomRegion,
	                                                             theater_name: randomTheater,
	                                                             date: date_result,
	                                                             time: randomTime
	                                                         }),
	                                                         success: function(response) {
	                                                             console.log("response: ", response);
	                                                             if (response === "Success") {
	                                                             	console.log("DB 저장 성공");
	                                                             } else if (response === "fail") {
	                                                            	 console.log("DB 저장 실패");
	                                                             }
	                                                         },
	                                                         error: function(xhr, status, error) {
	                                                             console.error("저장 오류:", error);
	                                                         }
	                                                     });
	                                                 }
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
