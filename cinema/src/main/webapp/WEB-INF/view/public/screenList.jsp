<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset='utf-8'>
    <meta http-equiv='X-UA-Compatible' content='IE=edge'>
    <title>CINEMA</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
  	<link rel="icon" href="/resources/images/favicon.ico" type="image/x-icon">
</head>
<body>
	<div class="wrap"></div>
    <div class="container" style="width: 1250px;">
        <div class="row mb-3">
            <div class="col">
                <h2>빠른 예매</h2>
            </div>
        </div>
        <div class="col-10">
            <div class="my-box">
                <div class="day">
                    <div class="month"></div>
                   	<div class="now-day"></div>
                </div>
                <div class="movie-container">
                <div class="left-one">
                    <h3>영화</h3>
                    <div class="movie-name">
                        <button class="movie-name-button" type="button">전체</button>
                    </div>
                    <div class="movie-list">
	                    <c:choose>
	                    	<c:when test="${param.no eq 0}">
	                    		<c:forEach var="movie" items="${movies}">
			                    	<button class="movie-button" type="button" value="${movie.movieNo}" >
			                            <img src="${movie.ratingImageURL} " alt="${movie.ratingName}"/>
			                            <span class="txt">${movie.movieName}</span>
			                            <img src="/resources/images/btn/ico-heart.png" alt="heart" class="buttonicon">
			                        </button>
			                    </c:forEach>
	                    	</c:when>
	                    	<c:otherwise>
	                    		<c:forEach var="movie" items="${movies}">
			                    	<button class="movie-button ${movie.movieNo eq param.no ? 'active' : '' }" type="button" value="${movie.movieNo}"  >
			                            <img src="${movie.ratingImageURL} " alt="${movie.ratingName}"/>
			                            <span class="txt">${movie.movieName}</span>
			                            <img src="/resources/images/btn/ico-heart.png" alt="heart" class="buttonicon">
			                        </button>
			                    </c:forEach>
	                    	</c:otherwise>
	                    </c:choose>
                    </div>
                    <div class="movie-img">
                        <div class="choice-list" id="choiceMovieList-0">
                        	<p id="picture-name">영화를 클릭하세요</p>
                        </div>
                    </div>
                </div>
                <div class="center-one">
                    <h3>극장</h3>
                    <div class="theater-list">
                        <button class="theater-all-button">전체</button>
                        <div class="theater-spacial-button"></div>
                    </div>
                    <div class="list-theater-detail">
                        <div class="all-theater-list">
                         	<div class="explain-button">
                         		<p style="display:flex">영화를 선택하세요</p>
                         		<c:forEach var="region" items="${regions }">
	                        		<button class='list-theater-button' data-region='${region.no }' style="display:none">${region.name }</button>
	                        	</c:forEach>
                         	</div>
                        </div>
                        <div class="theater-choies">
                        
                        </div>
                    </div>
                    <div class="theater-choies-check">
                        <p class="check-content" style="display:flex;">전체극장<br>
                            목록에서 극장을 선택하세요
                        </p>
                        <!--선택했을 경우 클릭하면 입력되고 아니면 열리지 않는다.-->
                        <div class="check-theater" style="display:none;">
                        
                        </div>
                    </div>
                </div>
                <div class="right-one">
                    <h3>시간</h3>
                    <div class="time-check">
                    </div>
                    <div class="movie-check">
                    </div>
                </div>
            </div>
        </div>
        </div>
        
      </div>
      <form action="/ticketing/ticketingList" method="post" id="form-post-List">
      	<input type="hidden" name="day" value="" />
      	<input type="hidden" name="movieNo" value="" />
      	<input type="hidden" name="theaterNo" value="" />
      	<input type="hidden" name="time" value="" />
      	<input type="hidden" name="ratingNo" value="" />
      	<input type="hidden" name="showTypeNo" value="" />
      	<input type="hidden" name="screenNo" value="" />
      	<input type="hidden" name="regionNo" value="" />
      	<input type="hidden" name="showScheduleNo" value="" />
      </form>
</body>

<script type="text/javascript">
	var dt = new Date();
	
	var m = dt.getMonth() + 1;
	// 월의 두 자리 형식 맞추기 위함
	if (m < 10) {
		var month = "0" + m;
	} else {
		var month = m + "";
	}
	
	// 두 자리 형식 맞추기 위함
	var d = dt.getDate() - 1;
	if (d < 10) {
		var day = "0" + d;
	} else {
		var day = d + "";
	}
	
	// 년도 가져옴
	var y = dt.getFullYear();
	var year = y + "";
	
	// ex) 20240709
	var result = year + month + day;
	
	$(function(){
	    var apiKey = '713076743ee17129fda347af138c628a';
	    var gteDate = '2024-06-15'; // 2024-06-15이때부터 
	    var lteDate = '2024-08-15'; // 2024-08-15까지 
	    var language = 'ko-KR';

	    // TMDB API 호출
	    $.ajax({
	        url: "https://api.themoviedb.org/3/discover/movie",
	        dataType: 'json',
	        data: {
	            api_key: apiKey,
	            'primary_release_date.gte': gteDate,
	            'primary_release_date.lte': lteDate,
	            video: false, // 극장 개봉 영화만 필터링
	            language: language
	            
	        },
	        success: function(tmdbData) {
	            console.log('TMDB API 확인:', tmdbData);
	            if (tmdbData && tmdbData.results.length > 0) { // 데이터가 존재한다면 실행 
	                var table = $("<table/>").attr("class", "table"); // 부트스트랩 스타일의 테이블 생성

	                // 테이블 헤더 생성
	                var thead = $("<thead/>").append($("<tr/>"))
	                    .append(
	                        $("<th/>").html("&nbsp;&nbsp;영화 제목"),
	                        $("<th/>").html("&nbsp;&nbsp;영화 개봉일"),
	                        $("<th/>").html("&nbsp;&nbsp;관람 등급"),
	                        $("<th/>").html("&nbsp;&nbsp;영화 포스터")
	                    );

	                var tbody = $("<tbody/>");

	                // 각 영화 정보 처리
	                $.each(tmdbData.results, function(i, movie) {
	                    var $id = movie.id; // 영화 고유 번호
	                    var $title = movie.title; // 영화 제목
	                    var $release_date = movie.release_date; // 영화 개봉일

	                    // KOBIS API 호출을 위한 영화 제목 설정
	                    $.ajax({
	                        url: "https://www.kobis.or.kr/kobisopenapi/webservice/rest/movie/searchMovieList.json",
	                        dataType: 'json',
	                        data: {
	                            key: 'c21c7feb4d426541f043770aecec0565',
	                            'movieNm': $title
	                        },
	                        success: function(kobisData) {
	                            if (kobisData.movieListResult.movieList.length > 0) {
	                                var movieCd = kobisData.movieListResult.movieList[0].movieCd;
									console.log("movieCd: ",movieCd);
	                                // KOBIS API를 통해 영화 상세 정보 가져오기
	                                $.ajax({
	                                    url: "http://www.kobis.or.kr/kobisopenapi/webservice/rest/movie/searchMovieInfo.json",
	                                    dataType: 'json',
	                                    data: {
	                                        key: 'c21c7feb4d426541f043770aecec0565',
	                                        'movieCd': movieCd
	                                    },
	                                    success: function(detail) {
	                                        // 관람 등급 정보 가져오기
	                                        var watchGradeNm = detail.movieInfoResult.movieInfo.audits && detail.movieInfoResult.movieInfo.audits.length > 0 ? detail.movieInfoResult.movieInfo.audits[0].watchGradeNm : "미정";
	                                        console.log("watchGradeNm: ", watchGradeNm)
	                                        // TMDB API에서 포스터 이미지 URL 가져오기
	                                        var posterPath = movie.poster_path;
	                                        var posterUrl = "https://image.tmdb.org/t/p/w500" + posterPath;
	                                        // 테이블에 영화 정보 추가
	                                        var row = $("<tr/>").append(
	                                            $("<td/>").text($title),
	                                            $("<td/>").text($release_date),
	                                            $("<td/>").text(watchGradeNm),
	                                            $("<td/>").append($("<img>").attr("src", posterUrl).attr("alt", $title).css("max-width", "100px")),
	                                        );
	                                        tbody.append(row);
	                                        table.append(tbody);
	                                        $(".wrap").append(table);
	                                    },
	                                    error: function(xhr, status, error) {
	                                        console.error("KOBIS API 오류:", error);
	                                    }
	                                });
	                            } else {
	                                console.log("KOBIS에서 영화를 찾을 수 없습니다.");
	                            }
	                        },
	                        error: function(xhr, status, error) {
	                            console.error("KOBIS API 오류:", error);
	                        }
	                    });
	                });

	                table.append(thead);
	                table.append(tbody);
	                $(".wrap").append(table);
	            } else {
	                console.log("TMDB API에서 영화를 찾을 수 없습니다.");
	            }
	        },
	        error: function(xhr, status, error) {
	            console.error("TMDB API 오류:", error);
	            alert("실시간 박스오피스 로딩중...");
	        }
	    });
	});

		
	
	
	/* $(function(data){
		$.ajax({
			url : "http://www.kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList",
			method: 'GET',
			data: {
				key :'c21c7feb4d426541f043770aecec0565',
				targetDt : result,
				itemPerPage: 10
			},		
			dataType : "xml",
			success : function(data) {
				var $data = $(data).find("boxOfficeResult>dailyBoxOfficeList>dailyBoxOffice");  // data 변수에 저장된 XML데이터를 jQery $()을 사용하여 jQuery객체로 변환 -> jQuery의 메소드를 사용하여 XML데이터를 쉽게 가져올 수 있음
				if ($data.length > 0) { // 데이터가 존재한다면 실행 
					var table = $("<table/>").attr("class", "table"); // 부트스트랩 입히기, 테이블 생성
					//<table>안에 테이블의 컬럼 타이틀 부분인 thead 태그
					var thead = $("<thead/>").append($("<tr/>"))
							.append( // <td>
									//추출하고자 하는 컬럼들의 타이틀 정의
									$("<th/>").html("&nbsp;&nbsp;영화 제목"),
									$("<th/>").html("&nbsp;&nbsp;영화 개봉일"),
									$("<th/>").html("&nbsp;&nbsp;영화 포스터")
							);
					var tbody = $("<tbody/>"); // tbody선언
					$.each($data, function(i, o) { // .each($반복할 데이터, function(index, value))
		
						//오픈 API에 정의된 변수와 내가 정의한 변수 데이터 파싱
						var $movieCd = $(o).find("movieCd").text(); // 영화 고유 번호
						var $movieNm = $(o).find("movieNm").text(); //영화명
						var $openDt = $(o).find("openDt").text();// 영화 개봉일
						console.log("movieCd: "+$movieCd);
						console.log("movieNm: "+$movieNm);
						console.log("openDt: "+$openDt);
						
						$.ajax({
							url : "https://api.themoviedb.org/3/search/movie",
							method: "GET",
							data: {
								api_key: '713076743ee17129fda347af138c628a',
	                            query: $movieNm,
	                            language: 'ko-KR'
							},
							success : function(tmdbData){
								console.log('TMDB API 응답:', tmdbData);
								if(tmdbData) { // 존재한다면
									var movie = tmdbData.results[0];
								 	var posterPath = movie.poster_path;
	                                var title = movie.title;
	                                console.log("movie:", movie);
	                                console.log("posterPath:", posterPath);
	                                console.log("title:", title);
	                                // 포스터 이미지 URL
	                                var posterUrl = "https://image.tmdb.org/t/p/w500"+posterPath;
	                                console.log("posterUrl:",posterUrl);
	                              //<tbody><tr><td>태그안에 파싱하여 추출된 데이터 넣기
	        						var row = $("<tr/>").append( // .append는 새로운 구문 추가하는 것
	        							$("<td/>").text($movieNm),
	        							$("<td/>").text($openDt),
	        						    $("<td/>").append($("<img>").attr("src", posterUrl).attr("alt", title).css("max-width", "100px"))
	        						);
	        						tbody.append(row); // 데이터가 입력된 한 행을 tbody에 반복해서 추가
								}
							}
						})
					});// end of each 
					table.append(thead); // 테이블에 thead추가
					table.append(tbody); // 테이블에 tbody추가
					$(".wrap").append(table); // class wrap에 만들어진 table을 추가 
				}
			},
			//에러 발생시 "실시간 박스오피스 로딩중"메시지가 뜨도록 한다
			error : function() {
				alert("실시간 박스오피스 로딩중...");
			}
		});
	});
 */
	$(function(){
		
		
		let apiKey ="713076743ee17129fda347af138c628a";
		let imageUrl = "https://image.tmdb.org/t/p/w500/";
		let movieId = $('button.movie-button,active').val();
		
		const dataDate = new Date(); // 오늘 날짜 생성
		let year = dataDate.getFullYear(); // 이번 년도 
		console.log("year -->"+year); 
		let month = dataDate.getMonth(); // -1 월 출력
		console.log("month -->"+month); 
		let dataDay = dataDate.getDate(); // 일 출력
		console.log("dataDay -->"+dataDay); 
		let dayLabel = dataDate.getDay();  // 0 (일요일) ~ 6(토요일) ex) 오늘이 수요일이라면 3이 출력
		console.log("dayLabel -->"+dayLabel);
		let dayNumber = Number(dataDay); // 이번 달의 최대 일 수 ex) 28, 30, 31 값 중에 하나
		console.log("dayNumber -->"+dayNumber);
		$('div.month').text((Number(month)+1)+"월"); // -1 월이므로 +1을 하고 월을 붙여서 div.month라는 클래스를 가진 모든 div요소를 선택
		
		const reserveDate = $('div.now-day'); // 예약 날짜
		
		const weekOfDay = ["일", "월", "화", "수", "목", "금", "토"]; // 요일 배열
		// 선언
		let thisWeek = []; 
		let button = "";
		let spanWeekOfDay = "";
		let spanDay = "";
		let div = "";
		
		for(let i = dayNumber ; i<=dayNumber+11 ; i++) { // 31이면 42까지 반복
			
			div = document.createElement("div"); // div라는 새로운 요소 생성
			button = document.createElement("button"); 
			spanWeekOfMonth = document.createElement("span");
			spanWeekOfDay = document.createElement("span");
			spanDay = document.createElement("strong");
			spanWeekOfMonth.classList="movie-week-of-month"; // 새로 생성된 span 객체 spanWeekOfMonth에 classList를 사용하여 클래스를 추가 스타일 적용
			spanWeekOfDay.classList = 'movie-week-of-day';
			spanDay.classList ='movie-day';
			let resultDay = new Date(year, month, i); // 새로운 객체 생성 
			let yyyy = resultDay.getFullYear(); // 년도 출력
			let mm = Number(resultDay.getMonth())+1; // -1 월이므로 +1
			let dd = resultDay.getDate(); // 일 출력
			let d = resultDay.getDay(); // 0 (일요일) ~ 6(토요일) ex) 오늘이 수요일이라면 3이 출력
			
			mm = String(mm).length === 1 ? '0'+mm : mm; // 월을 2자리수로 맞추기 위함
			dd = String(dd).length === 1 ? '0'+dd : dd; // 일을 2자리수로 맞추기 위함
			d = String(d).length === 1 ? '0'+d : d; // 오늘의 요일을 2자리수로 맞추기 위함
			spanWeekOfMonth.innerHTML = mm; // 값 넣기
			spanWeekOfDay.innerHTML = dd; // 값 넣기
			
			button.append(spanWeekOfDay); // spanWeekOfDay가 만약 01이었을 경우, <button><span>01</span></button> 형식으로 추가
			if(d == '01'){ // 01 월요일일때
				d=weekOfDay[1]; //"월"
				button.classList = "mon";
				button.setAttribute('data-day',yyyy+mm+dd+d);
			} else if(d == '02'){
				d=weekOfDay[2]; // "화"
				button.classList = "mon";
				button.setAttribute('data-day',yyyy+mm+dd+d);
			} else if(d == '03'){
				d=weekOfDay[3]; // "수"
				button.classList = "mon";
				button.setAttribute('data-day',yyyy+mm+dd+d);
			} else if(d == '04'){
				d=weekOfDay[4]; // "목"
				button.classList = "mon";
				button.setAttribute('data-day',yyyy+mm+dd+d);
			} else if(d == '05'){
				d=weekOfDay[5]; // "금"
				button.classList = "mon";
				button.setAttribute('data-day',yyyy+mm+dd+d);
			} else if(d == '06'){
				d=weekOfDay[6]; // "토"
				button.classList ="mon sat";
				button.setAttribute('data-day',yyyy+mm+dd+d);
			} else if(d == '00'){
				d=weekOfDay[0]; // "일"
				button.classList="mon sun";
				button.setAttribute('data-day',yyyy+mm+dd+d);
			}
			if(i===dayNumber){
				button.classList="mon active";
				//해당날짜는 버튼이 눌려있게 설정함
			}
			spanDay.innerHTML = d; // <span>"화"</span>
			button.append(spanDay); // <button><span>"화"</span></button>
			reserveDate.append(button); 
		
			thisWeek[i] = yyyy + "-" + mm +'-' +dd +'-'+d ; // 이번주 2024-07-10 식으로 저장
	}
	//날짜 클릭시 활성화 버튼과 hidden으로 data값 전송
	$('div.now-day').on('click','button.mon',function(){
		let $btnActive = $(this); // 클릭된 button.mon를 jQuery 객체로 만듦 
		let dataAttr = $btnActive.attr('data-day'); // 클린된 버튼에서 data-day(yyyy+mm+dd+d)의 속성값
		console.log(dataAttr); // 값이 제대로 들어왔는지 디버깅
		if($btnActive.hasClass('active')){ // active 속성을 가지고 있는가? yes -> true or false를 반환
			$('button.mon').removeClass('active'); // 속성'active' 삭제
			console.log("삭제"); // 잘 실행 되었는지 디버깅 
		} else {
			$('button.mon').removeClass('active'); // 해당 버튼만 active를 가지기 위해서 삭제
			$btnActive.addClass('active'); // active 추가
			console.log("삭제 후 추가"); // 잘 실행 되었는지 디버깅
		}
	})
	//날짜 클릭했으면 활성화버튼 해제 
	$('div.now-day').on('click','button.active',function(){ // div class="now-day" 중 active된 버튼을 클릭했을 때
		let $btnMon = $(this); // 클릭된 버튼을 jQuery 객체로 저장
		$btnMon.attr('class','mon'); // 클릭된 button의 속성을 active -> mon으로 변경
	})
	
	$('button.movie-button').ready(function(){ // 페이지가 준비되면 'button.movie-button' 속성을 가진 버튼 선택
			let valueNo = $('button.movie-button.active').val(); // active인 movie-button 요소의 value 저장
			let texts = $('button.movie-button.active').text(); // active인 내용을 변수에 저장
			let path = '${param.no}' 
			let detailUrl = 'https://api.themoviedb.org/3/discover/movie?api_key=713076743ee17129fda347af138c628a&language=ko-KR&region=KR&sort_by=popularity.desc&primary_release_date.lte=2024-07-14'+ path;
			$('#choiceMovieList-0').css('display','flex');
			$.ajax({
				type:'get',
				url: detailUrl,
				data: {
					"api_key":"713076743ee17129fda347af138c628a",
					language: "ko-KR",
					region: "KR"
				},
				dataType: 'json',
				success:function(movie){ // 요청이 성공한다면
					let imagePath = imageUrl + movie.poster_path;
					$('#picture').attr('src',imagePath);
				}
				})
				$('#picture-name').text(texts);
			
			$('.explain-button').find('p').css('display','none');
			$('.explain-button').find('.list-theater-button').css('display','flex');
		})
		
		
		//시간출력하는 부분
		$('div.time-check').append(function(){
			let currentDate = new Date(); // 날짜 선언
			let msg = Number(currentDate.getHours()); // 현재 시간을 가져옴
			console.log("현재 시각: "+msg); 
			
			for(let i = msg; i<msg+10; i++){ // 현재 시간 +10시간 동안
				let button = ""; // 버튼 초기화
				let $time = $('div.time-check'); // jQuery로 선택
				button = document.createElement("button"); // 문서 내에 "button" 요소 생성
				button.classList='time-check-button'; // 버튼에 클래스 추가
				if(i > 24) { // 24시를 넘는다면
					button.innerHTML=Number(); // 버튼 내용을 비움
					console.log("i > 24: "+button);
				} else { // 그렇지 않다면
					button.innerHTML=Number(i); // 버튼 내용을 i 값으로 설정
					$time.append(button); // div.time-check에 버튼 추가
					console.log(" i <= 24: "+button);
				}
			}
		})
		
	})
</script>
</html>