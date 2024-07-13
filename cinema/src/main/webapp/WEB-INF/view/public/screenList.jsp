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
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.24.0/moment.min.js"></script>
  	<link rel="icon" href="/resources/images/favicon.ico" type="image/x-icon">
</head>
<body>
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
                        	<img id="picture" alt="no-pricture" src="/resources/images/movie/no-graph03.jpg">
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
	
	$(function(data){
		$.ajax({
			url : "http://www.kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.xml?key=c21c7feb4d426541f043770aecec0565&targetDt="+result+"&itemPerPage=10",
			dataType : "xml",
			success : function(data) {
				var $data = $(data).find("boxOfficeResult>dailyBoxOfficeList>dailyBoxOffice");  // data 변수에 저장된 XML데이터를 jQery $()을 사용하여 jQuery객체로 변환 -> jQuery의 메소드를 사용하여 XML데이터를 쉽게 가져올 수 있음
				if ($data.length > 0) { // 데이터가 존재한다면 실행 
					var table = $("<table/>").attr("class", "table"); // 부트스트랩 입히기, 테이블 생성
					//<table>안에 테이블의 컬럼 타이틀 부분인 thead 태그
					var thead = $("<thead/>").append($("<tr/>"))
							.append( // <td>
									//추출하고자 하는 컬럼들의 타이틀 정의
									$("<th/>").html("&nbsp;순위"),
									$("<th/>").html("&nbsp;&nbsp;영화 제목"),
									$("<th/>").html("&nbsp;&nbsp;영화 개봉일"),
									$("<th/>").html("&nbsp;&nbsp;누적 매출액"),
									$("<th/>").html("&nbsp;&nbsp;누적 관객수"));
					var tbody = $("<tbody/>"); // tbody선언
					$.each($data, function(i, o) { // .each($반복할 데이터, function(index, value))
		
						//오픈 API에 정의된 변수와 내가 정의한 변수 데이터 파싱
						var $rank = $(o).find("rank").text(); // 순위
						var $movieNm = $(o).find("movieNm").text(); //영화명
						var $openDt = $(o).find("openDt").text();// 영화 개봉일
						var $salesAcc = $(o).find("salesAcc").text();//누적 매출액
						var $audiAcc = $(o).find("audiAcc").text(); //누적 관객수
						
						
						
						
						//<tbody><tr><td>태그안에 파싱하여 추출된 데이터 넣기
						var row = $("<tr/>").append( // .append는 새로운 구문 추가하는 것
								
								$("<td/>").text($rank), // <td></td>안에 $rank의 값 집어 넣기
								$("<td/>").text($movieNm),
								$("<td/>").text($openDt),
								$("<td/>").text($salesAcc),
								$("<td/>").text($audiAcc)
						);
		
						tbody.append(row); // 데이터가 입력된 한 행을 tbody에 반복해서 추가
		
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
			let detailUrl = 'https://api.themoviedb.org/3/movie/'+ path;
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
		
		//영화버튼 클릭시 극장 정보 가져오기
		$('button.movie-button').click(function(){
			let $movieButton = $(this);
			let valueNo = $movieButton.val();
			let texts = $movieButton.text();
			let attrNo =  $movieButton.attr('class');
			$('.explain-button p').css('display','none');
			$('button.list-theater-button').css('display','flex');
			$('#choiceMovieList-0').css('display','flex');
			if($movieButton.hasClass('active')){
				$('button.movie-button').removeClass('active');
				$('#picture').attr('src','/resources/images/movie/no-graph03.jpg');
				$('#picture-name').text("영화를 선택하세요");
			} else{
				$('button.movie-button').removeClass('active');
				$movieButton.addClass('active');
				$('#picture-name').text(texts);
				let detailUrl = "https://api.themoviedb.org/3/movie/" + valueNo;
				$.ajax({
					type:'get',
					url: detailUrl,
					data: {
						"api_key":"935cc74a36fab18e33ea802df5ebd3f4",
						language: "ko-KR",
						region: "KR"
					},
					dataType: 'json',
					success:function(movie){
						let imagePath = imageUrl + movie.poster_path;
						$('#picture').attr('src',imagePath);
					}
					})
			}
			//아래에 클릭시 이미지가 뜨도록 	
		})
		//해당하는 극장명이 출력된다. 
		$('button.list-theater-button').click(function(){
			let $dataAttr = $('div.theater-choies');
			$dataAttr.empty();
			let regionNo = $(this).attr('data-region');
			$.getJSON("/rest/theater",{regionNo: regionNo},function(response){
				$.each(response.items,function(index, theater){
						let output ="<button class='list-theater-button' data-theater="+theater.no+" title="+theater.name+">"+theater.name+"</button>"
						 $dataAttr.append(output);
				})
			})
		})
		//극장명을 클릭하면	
		$('div.theater-choies').on('click','button.list-theater-button',function(){
			let $dataAttr = $('div.movie-check');
			$('p.check-content').css('display','none');
			$dataAttr.empty();
			let $btn = $(this);
			let texts = $btn.text();
			if($btn.hasClass('active')){
				$('button.list-theater-button').removeClass('active');
				$('.check-theater').css('display','none');
			} else{
				$('button.list-theater-button').removeClass('active');
				$btn.addClass('active');
				$('.check-theater').text(texts);
				$('.check-theater').css('display','flex');
			}
			let day = $('button.mon.active').find('span.movie-week-of-day').text();
			let dayNm = parseInt(day);
			let theaterNo =$btn.attr('data-theater');
			let movieNo =$('button.movie-button.active').val();
			let timeNo = $('.time-check-button:eq(0)').text();
			let regionNo = $('.list-theater-button.active').attr('data-region');
			let $theaterNames = $('div.theater-choies');
			$.getJSON('/rest/theaterList',{movieNo: movieNo, theaterNo: theaterNo, timeNo: timeNo, dayNm:dayNm},function(response){
				$.each(response.items,function(index, theater){
					let $list  = $('div.theater-choies');
					let $movie = $('div.movie-check');
					if(theater.showTypeSubTitle == 'Y'){
						theater.showTypeSubTitle = "자막(O)";
					} else {
						theater.showTypeSubTitle = "자막(X)";
					}
					if(response.items == null){
						alert("해당하는 시간의 시간표가 존재하지 않습니다.");
					}
						let listputs="<button class='theater-choies-button'>"+theater.theaterName+"</button>";
						$list.append(listputs)
						
						//스케쥴에 출력되는 값 --> 나중에 시간설정 후 옮겨 놓을 것 
						let input ="<button type='button'  class='btn-on' value="+theater.showScheduleStartTime+" >";
		                input += "<div class='legend' data-screenNo="+theater.screenNo+" data-showScheDuleNo="+theater.showScheduleNo+"></div>";
		                input += "<span class='time'>";
		                input +="<strong title='상영시작' data-time="+theater.showScheduleStartTime+"'>"+theater.showScheduleStartTime+"</strong>";
		                input +="<em title='상영종료'>~"+theater.showScheduleEndTime+"</em>";
		                input +="</span>";
		                input +="<span class='title' data-regionNo="+theater.regionNo+">";
		                input +="<strong data-movieNo="+theater.movieNo+">"+theater.movieName+"</strong>";
		                input +="<em data-ratingNo="+theater.movieRatingNo+" data-showTypeNo="+theater.showTypeNo+">"+theater.showTypeName+theater.showTypeSubTitle+"</em>";   
		                input +="</span>";
		                input +="<div class='info'>";
		                input +="<span class='theater' data-theaterNo="+theater.theaterNo+" title='극장'>";
		                input +=""+theater.theaterName+"<br>";       
		                input +=""+theater.screenName;      
		                input +="</span>"; 
		                input +="<span class='seat'>";    
		                input +="<strong class='now' title='잔여좌석'>"+theater.reservableSeat+"</strong>";      
		                input +="<em class='all' title='"+theater.realTotalSeat+"'>/"+theater.realTotalSeat+"</em>";      
		                input +="</span>";   
		                input +="</div>";
		                input +="</button>";
		                $movie.append(input);
					
			})
		})
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
		function timeAppend(event) {
			let day = $('div.mon.active').find('span.movie-week-of-day').text();
			let dayNm = parseInt(day);
			let mday = Number(currentDate.getDate());
			if(dayNm != mday){
				for(let i = 1; i<25; i++){
					let button = "";
					let $time = $('div.time-check');
					button = document.createElement("button");
					button.classList='time-check-button';
					if(i > 24) {
						button.innerHTML=Number();
					} else if(i>10){
						button.innerHTML=Number(""+i);
						$time.append(button);
					} else {
						button.innerHTML=Number(i);
						$time.append(button);
					}
			}
			} else {
				let currentDate = new Date();
				let msg = Number(currentDate.getHours());
					for(let i = msg; i<msg+10; i++){
						let button = "";
						let $time = $('div.time-check');
						button = document.createElement("button");
						button.classList='time-check-button';
						if(i > 24) {
							button.innerHTML=Number();
						} else {
							button.innerHTML=Number(i);
							$time.append(button);
						}
					}
			}

		}
		//버튼 클릭시 정보저장하기
		$('div.movie-check').on('click','button.btn-on',function(e){
			 let $movie= $(this);
			 let movieNo = $movie.find('.title strong').attr('data-movieno');
			 let theaterNo = $movie.find('.theater').attr('data-theaterno');
			 let ratingNo = $movie.find('.title em').attr('data-ratingNo');
			 let showTypeNo = $movie.find('.title em').attr('data-showtypeno');
			 let screenNo = $movie.find('.legend').attr('data-screenno');
			 let regionNo = $movie.find('.title').attr('data-regionno');
			 let dayNo = $('button.mon.active').attr('data-day');
			 let showScheduleNo = $movie.find('.legend').attr('data-showScheDuleNo');
			 $('input[name=movieNo]').attr('value',movieNo);
			 $('input[name=theaterNo]').attr('value',theaterNo);
			 $('input[name=ratingNo]').attr('value',ratingNo);
			 $('input[name=time]').val($movie.val());
		     $('input[name=showTypeNo]').attr('value',showTypeNo);
		     $('input[name=screenNo]').attr('value',screenNo);
		     $('input[name=regionNo]').attr('value',regionNo);
		     $('input[name=day]').attr('value',dayNo);
		     $('input[name=showScheduleNo]').attr('value',showScheduleNo);
		     $('#form-post-List').submit();
		})
	})
</script>
</html>