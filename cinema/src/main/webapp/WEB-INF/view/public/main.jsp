<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

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
		var d = dt.getDate()-1;
		var day = (d < 10) ? "0" + d : d + ""; // 두 자리 수 만들기 ex) 01, 12
		var y = dt.getFullYear();
		var result = y + month + day;
		var date_result = '';
		if (d === 0){
			date_result = '2024-07-15'; // 0이 될때를 방지하고자 임의로 함.
		} else {
			date_result = y + "-" + month + "-" + day;
		}
		
		console.log('date_result: ',date_result);
		
		// 하루가 지난 데이터면 삭제하고자 함
		$.ajax({
			url : "/api/theater/checkDateResultDelete",
			method : "GET",
			data : {
				date : date_result
			},
			success : function(response){
				if(response != 1){ // 오늘 날짜가 아닐 경우 데이터 전체 초기화
					$.ajax({
						url : "/api/theater/delete",
						method : "POST",
						contentType : "application/json",
						success : function(response) { 
							if (response === "Success") {
								console.log("DB 삭제 성공");
							} 
							else if (response === "fail") {
								console.log("DB 삭제 실패");
							}
						},
						error: function( xhr, status, error ){
							console.error("삭제 오류:", error);
						}
					});				
				} else {
					console.log('최기화 필요 없음');
				}
			}
		})
		
		$.ajax({
			url : "http://www.kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList",
			method : 'GET',
			data : {
				key : 'c21c7feb4d426541f043770aecec0565',
				targetDt : result, // ex) 20240714
				itemPerPage : 20 // 20개씩만
			},
			dataType : "xml",
			success : function(data) {
				var $data = $(data).find("boxOfficeResult > dailyBoxOfficeList > dailyBoxOffice");
				if ($data.length > 0) {
					var table = $("<table/>").attr("class", "table"); // css와 테이블 선언
					var thead = $("<thead/>").append($("<tr/>")).append($("<th/>").html("&nbsp;&nbsp;영화 제목"),$("<th/>").html("&nbsp;&nbsp;영화 포스터"));
					var tbody = $("<tbody/>"); // tody선언
					
					// 랜덤 region 선택을 위한 locations 초기화
					let locations = [];
					locations.push(new Map([ [ "region", "인천" ],
							[ "theater_name", "주안역" ] ]));
					locations.push(new Map([ [ "region", "인천" ],
							[ "theater_name", "인천학익" ] ]));
					locations.push(new Map([ [ "region", "인천" ],
							[ "theater_name", "인천연수" ] ]));
					locations.push(new Map([ [ "region", "인천" ],
							[ "theater_name", "인천시민공원" ] ]));
					locations.push(new Map([ [ "region", "인천" ],
							[ "theater_name", "인천도화" ] ]));
					locations.push(new Map([ [ "region", "서울" ],
							[ "theater_name", "구로" ] ]));
					locations.push(new Map([ [ "region", "서울" ],
							[ "theater_name", "건대입구" ] ]));
					locations.push(new Map([ [ "region", "서울" ],
							[ "theater_name", "강변" ] ]));
					locations.push(new Map([ [ "region", "서울" ],
							[ "theater_name", "강남" ] ]));
					locations.push(new Map([ [ "region", "서울" ],
							[ "theater_name", "대학로" ] ]));
					locations.push(new Map([ [ "region", "부산/울산" ],
							[ "theater_name", "울산동구" ] ]));
					locations.push(new Map([ [ "region", "부산/울산" ],
							[ "theater_name", "센텀시티" ] ]));
					locations.push(new Map([ [ "region", "부산/울산" ],
							[ "theater_name", "서면" ] ]));
					locations.push(new Map([ [ "region", "부산/울산" ],
							[ "theater_name", "동래" ] ]));
					locations.push(new Map([ [ "region", "부산/울산" ],
							[ "theater_name", "대연" ] ]));
					locations.push(new Map([ [ "region", "대전/충청" ],
							[ "theater_name", "세종" ] ]));
					locations.push(new Map([ [ "region", "대전/충청" ],
							[ "theater_name", "대전가수원" ] ]));
					locations.push(new Map([ [ "region", "대전/충청" ],
							[ "theater_name", "대전" ] ]));
					locations.push(new Map([ [ "region", "대전/충청" ],
							[ "theater_name", "당진" ] ]));
					locations.push(new Map([ [ "region", "대전/충청" ],
							[ "theater_name", "논산" ] ]));
					locations.push(new Map([ [ "region", "대구" ],
							[ "theater_name", "대구현대" ] ]));
					locations.push(new Map([ [ "region", "대구" ],
							[ "theater_name", "대구연경" ] ]));
					locations.push(new Map([ [ "region", "대구" ],
							[ "theater_name", "대구스타디움" ] ]));
					locations.push(new Map([ [ "region", "대구" ],
							[ "theater_name", "대구수성" ] ]));
					locations.push(new Map([ [ "region", "대구" ],
							[ "theater_name", "대구" ] ]));
					locations.push(new Map([ [ "region", "광주/전라/제주" ],
							[ "theater_name", "목포" ] ]));
					locations.push(new Map([ [ "region", "광주/전라/제주" ],
							[ "theater_name", "나주" ] ]));
					locations.push(new Map([ [ "region", "광주/전라/제주" ],
							[ "theater_name", "광주상무" ] ]));
					locations.push(new Map([ [ "region", "광주/전라/제주" ],
							[ "theater_name", "광주금남로" ] ]));
					locations.push(new Map([ [ "region", "광주/전라/제주" ],
							[ "theater_name", "광양" ] ]));
					locations.push(new Map([ [ "region", "경상" ],
							[ "theater_name", "안동" ] ]));
					locations.push(new Map([ [ "region", "경상" ],
							[ "theater_name", "마산" ] ]));
					locations.push(new Map([ [ "region", "경상" ],
							[ "theater_name", "구미" ] ]));
					locations.push(new Map([ [ "region", "경상" ],
							[ "theater_name", "경산" ] ]));
					locations.push(new Map([ [ "region", "경상" ],
							[ "theater_name", "거제" ] ]));
					locations.push(new Map([ [ "region", "경기" ],
							[ "theater_name", "동두천" ] ]));
					locations.push(new Map([ [ "region", "경기" ],
							[ "theater_name", "다산" ] ]));
					locations.push(new Map([ [ "region", "경기" ],
							[ "theater_name", "김포운앙" ] ]));
					locations.push(new Map([ [ "region", "경기" ],
							[ "theater_name", "김포" ] ]));
					locations.push(new Map([ [ "region", "경기" ],
							[ "theater_name", "기흥" ] ]));
					locations.push(new Map([ [ "region", "강원" ],
							[ "theater_name", "춘천" ] ]));
					locations.push(new Map([ [ "region", "강원" ],
							[ "theater_name", "인제" ] ]));
					locations.push(new Map([ [ "region", "강원" ],
							[ "theater_name", "원통" ] ]));
					locations.push(new Map([ [ "region", "강원" ],
							[ "theater_name", "기린" ] ]));
					locations.push(new Map([ [ "region", "강원" ],
							[ "theater_name", "강릉" ] ]));

					let times = [];
					times.push(new Map([ [ "time", "09:50:00" ] ]));
					times.push(new Map([ [ "time", "10:00:00" ] ]));
					times.push(new Map([ [ "time", "10:50:00" ] ]));
					times.push(new Map([ [ "time", "11:00:00" ] ]));
					times.push(new Map([ [ "time", "13:30:00" ] ]));
					times.push(new Map([ [ "time", "14:00:00" ] ]));
					times.push(new Map([ [ "time", "15:10:00" ] ]));
					times.push(new Map([ [ "time", "16:20:00" ] ]));
					times.push(new Map([ [ "time", "18:30:00" ] ]));
					times.push(new Map([ [ "time", "19:50:00" ] ]));
					times.push(new Map([ [ "time", "20:00:00" ] ]));
					
					$data.each(function(i, o) {
						var $movieCd = $(o).find("movieCd").text(); // 영화 고유 id 가져오기
						var $movieNm = $(o).find("movieNm").text(); // 영화 제목
						
						$.ajax({
							url : "https://api.themoviedb.org/3/search/movie", // api 요청 url
							method : "GET",
							data : {
								api_key : '713076743ee17129fda347af138c628a',
								query : $movieNm,// 제목으로 검색하기 위함
								language : 'ko-KR' // 한국어
							},
							success : function(tmdbData) {
							if (tmdbData.results.length > 0) {
								var movie = tmdbData.results[0]; // tmdb api 결과물들 중 가장 첫 번째
								var posterPath = movie.poster_path; // 영화 포스터 이미지 경로
								var title = movie.title; // 제목
								var posterUrl = "https://image.tmdb.org/t/p/w500"+ posterPath; // 포스터 요청 url
								var row = $("<tr/>")
									.append($("<td/>")
									.append($("<button/>")
									.attr("id", "submitBtn")
									.data('title', $movieNm)
									.text( $movieNm )
									.click( function() {
										// 기존의 모든 초기화
									    $('.regionBtn').remove();
										$('.theaterBtn').remove();
										$('.mon').remove();
										$('.month').remove();
										$('.timeBtn').remove();
										console.log('영화 선택 초기화');
										
										var clickedTitle = $(this).data('title');
										$.ajax({
											url : "/api/theater/checkTitle",
											method : "GET",
											data : {
												title : $movieNm
											},
											success : function(response){
												if(response == 1){ // 제목이 이미 있을 경우
													console.log("제목이 존재 합니다");
												
												} else { // 제목이 없을 경우
									                
													console.log("제목이 존재하지 않습니다.");
													// 랜덤 데이터 생성
													for (var i = 0; i < 200; i++) {
														var randomLocation = locations[Math.floor(Math.random()* locations.length)]; // 랜덤한 location 선택
														var randomRegion = randomLocation.get("region");
														var randomTheater = randomLocation.get("theater_name");
														var randomTimes = times[Math.floor(Math.random()* times.length)]; // 랜덤한 time 선택
														var randomTime = randomTimes.get("time");
														// 자동으로 랜덤 데이터 주입
														$.ajax({
															url : "/api/theater/add",
															method : "POST",
															contentType : "application/json",
															data: JSON.stringify({
																title : title,
																region : randomRegion,
																theater_name : randomTheater,
																date : date_result,
																time : randomTime
															}), 
															success : function(response) {
																if (response === "Success") { // 데이터 주입 성공 시 실행
																	console.log("DB 저장 성공");
																} 
															} // success
														
														}); // ajax
													} // for 
												}
											}, error: function( xhr, status, error ){
												console.error("데이터를 읽어 올 수 없습니다.", error);
											}
										
										})
									
									// 지역 버튼 
									$.ajax({
										url : '/api/theater/getInfo',
										method : 'GET',
										data : {
											title : title
										},
										success : function(data) { // 성공 했을 때
											var $region = $('.region'); // 클래스가 region인 요소를 선택하여 jQuery 객체로 만듭니다.
											$region.empty(); // 기존 내용 삭제
											var title = clickedTitle; 
											console.log('region title: ',title);
											if (Array.isArray(data)) {
												data.forEach(function(item) { // 서버로 받은 데이터를 반복
													var $itemDiv = $('<div/>').addClass('data-item'); // div 영역 생성
													var $button = $('<button/>')
														.text(item.region)
														.addClass('regionBtn') // region 클래스 추가
														.data('title', title) // title data 
														.data('region', item.region); // 데이터를 버튼으로 생성
													$itemDiv.append($button); // div 안에 button 넣기
													$region.append($itemDiv); // div<button>을 region class에 넣기
												});
											} else { 
												console.error( '배열이 아닙니다: ', data);
											}
										},
										error : function(xhr,status,error) {
											console.error('에러 발생:',error);
										}
									});
									}) // click function
								), 
								// 포스터 이미지 출력
								$("<td/>").append($("<img>").attr("src",posterUrl).attr("alt",title).css("max-width","100px")));
								tbody.append(row);
							}
						},
						// 에러시
						error : function(xhr,status, error) {
							console.error("TMDB API 오류:", error);
						}
					});
				});
					table.append(thead);
					table.append(tbody);
					$(".wrap").append(table);
				}
			},
			error : function(xhr, status, error) {
				console.error("KOBIS API 오류:", error);
				alert("실시간 박스오피스 로딩중...");
			}
		});
	});

	// 동적으로 생성된 버튼의 클릭 이벤트 처리
	$(document).on('click', '.regionBtn', function() {
		var title = $(this).data('title');
		var regionValue = $(this).data('region'); // 클릭된 버튼의 value 값 가져오기
		
		
		
		$.ajax({
			url : '/api/theater/getTheaterInfo', // 해당 컨트롤러로
			method : 'GET',
			dataType : 'json',
			data : {
				title : title,
				region : regionValue
			// 클릭된 버튼의 value 값을 region에 할당
			},
			success : function(data) {
				var $theaterDiv = $('.theater'); // 클래스가 region인 요소를 선택하여 jQuery 객체로 만듦
				$theaterDiv.find('.theater-info').remove(); // 기존 theater 정보 삭제
				if (Array.isArray(data)) {
					data.forEach(function(item) { // 서버로 받은 데이터를 반복
						var $itemDiv = $('<div/>').addClass('theater-info'); // div 영역 생성
						var $theaterButton = $('<button/>').text(item.theater_name)// theater_name 데이터를 표시하는 버튼 생성
							.addClass('theaterBtn')
							.data('title', title)
							.data('region', regionValue )
							.data('theater_name', item.theater_name);
						$itemDiv.append($theaterButton);
						$theaterDiv.append($itemDiv); // div<theater_info>를 region class에 추가
					});
				} else {
					console.error('Data is not an array:', data);
				}
			},
			error : function(xhr, status, error) {
				console.error('Error fetching theater names:', error);
			}
		});
	});

	$(document).on('click', '.theaterBtn', function() {
		var title = $(this).data('title');
		var theaterValue = $(this).data('theater_name'); // 클릭된 버튼의 value 값 가져오기
		var region = $(this).data('region');
		const dataDate = new Date(); // 오늘 날짜 생성
		let year = dataDate.getFullYear(); // 이번 년도 
		let month = dataDate.getMonth(); // -1 월 출력
		let dataDay = dataDate.getDate(); // 일 출력
		let dayLabel = dataDate.getDay(); // 0 (일요일) ~ 6(토요일) ex) 오늘이 수요일이라면 3이 출력
		let dayNumber = Number(dataDay); // 이번 달의 최대 일 수 ex) 28, 30, 31 값 중에 하나
		$('div.month').text((Number(month) + 1) + "월"); // -1 월이므로 +1을 하고 월을 붙여서 div.month라는 클래스를 가진 모든 div요소를 선택
		
		console.log('title: ', title);
		console.log('region: ', region);
		console.log('theater_name: ', theaterValue);
		
		const reserveDate = $('div.now-day'); // 예약 날짜
		reserveDate.empty(); // 기존 날짜 버튼들을 모두 제거

		const weekOfDay = [ "일", "월", "화", "수", "목", "금", "토" ]; // 요일 배열

		// 선언
		let thisWeek = [];
		let button = "";
		let spanWeekOfDay = "";
		let spanDay = "";
		let div = "";

		for (let i = dayNumber; i <= dayNumber + 11; i++) { // 31이면 42까지 반복
			div = document.createElement("div"); // div라는 새로운 요소 생성
			button = document.createElement("button");
			spanWeekOfMonth = document.createElement("span");
			spanWeekOfDay = document.createElement("span");
			spanDay = document.createElement("strong");
			spanWeekOfMonth.classList = "movie-week-of-month"; // 새로 생성된 span 객체 spanWeekOfMonth에 classList를 사용하여 클래스를 추가 스타일 적용
			spanWeekOfDay.classList = 'movie-week-of-day';
			spanDay.classList = 'movie-day';

			let resultDay = new Date(year, month, i); // 새로운 객체 생성 
			let yyyy = resultDay.getFullYear(); // 년도 출력
			let mm = Number(resultDay.getMonth()) + 1; // -1 월이므로 +1
			let dd = resultDay.getDate(); // 일 출력
			let d = resultDay.getDay(); // 0 (일요일) ~ 6(토요일) ex) 오늘이 수요일이라면 3이 출력

			mm = String(mm).length === 1 ? '0' + mm : mm; // 월을 2자리수로 맞추기 위함
			dd = String(dd).length === 1 ? '0' + dd : dd; // 일을 2자리수로 맞추기 위함
			d = String(d).length === 1 ? '0' + d : d; // 오늘의 요일을 2자리수로 맞추기 위함

			spanWeekOfMonth.innerHTML = mm; // 값 넣기
			spanWeekOfDay.innerHTML = dd; // 값 넣기

			button.append(spanWeekOfDay); // spanWeekOfDay가 만약 01이었을 경우, <button><span>01</span></button> 형식으로 추가

			if (d == '01') { // 01 월요일일때
				d = weekOfDay[1]; //"월"
				button.classList = "mon";
				button.setAttribute('data-day', yyyy + mm + dd + d);
				button.setAttribute('title', title);
				button.setAttribute('region', region);
				button.setAttribute('theater_name', theaterValue);
			} else if (d == '02') {
				d = weekOfDay[2]; // "화"
				button.classList = "mon";
				button.setAttribute('data-day', yyyy + mm + dd + d);
				button.setAttribute('title', title);
				button.setAttribute('region', region);
				button.setAttribute('theater_name', theaterValue);
			} else if (d == '03') {
				d = weekOfDay[3]; // "수"
				button.classList = "mon";
				button.setAttribute('data-day', yyyy + mm + dd + d);
				button.setAttribute('title', title);
				button.setAttribute('region', region);
				button.setAttribute('theater_name', theaterValue);
			} else if (d == '04') {
				d = weekOfDay[4]; // "목"
				button.classList = "mon";
				button.setAttribute('data-day', yyyy + mm + dd + d);
				button.setAttribute('title', title);
				button.setAttribute('region', region);
				button.setAttribute('theater_name', theaterValue);
			} else if (d == '05') {
				d = weekOfDay[5]; // "금"
				button.classList = "mon";
				button.setAttribute('data-day', yyyy + mm + dd + d);
				button.setAttribute('title', title);
				button.setAttribute('region', region);
				button.setAttribute('theater_name', theaterValue);
			} else if (d == '06') {
				d = weekOfDay[6]; // "토"
				button.classList = "mon";
				button.setAttribute('data-day', yyyy + mm + dd + d);
				button.setAttribute('title', title);
				button.setAttribute('region', region);
				button.setAttribute('theater_name', theaterValue);
			} else if (d == '00') {
				d = weekOfDay[0]; // "일"
				button.classList = "mon";
				button.setAttribute('data-day', yyyy + mm + dd + d);
				button.setAttribute('title', title);
				button.setAttribute('region', region);
				button.setAttribute('theater_name', theaterValue);
			}
			spanDay.innerHTML = d; // <span>"화"</span>
			button.append(spanDay); // <button><span>"화"</span></button>
			reserveDate.append(button);
			thisWeek[i] = yyyy + "-" + mm + '-' + dd + '-' + d; // 이번주 2024-07-10 식으로 저장
		}
	});
	// mon 버튼 클릭 이벤트 추가 부분
	$(document).on('click','.mon', function() {
		var dataDay = $(this).attr('data-day'); // 클릭된 버튼의 data-day 값 가져오기
		var yyyy = dataDay.substring(0, 4); // 앞 4자리
		var mm = dataDay.substring(4, 6); // 중간 2자리
		var dd = dataDay.substring(6, 8); // 나머지 2자리
		$thisDay = yyyy + "-" + mm + '-' + dd;
		var $title = $(this).attr('title');
		var $region = $(this).attr('region');
		var $theaterName = $(this).attr('theater_name');
		
		console.log('.mon title:', $title);
		console.log('.mon region:', $region);
		console.log('.mon theaterName:', $theaterName);
		
		$.ajax({
			url : '/api/theater/getTimeInfo',
			method : 'POST',
			contentType: 'application/json',
			data : JSON.stringify({
				title : $title,
				region : $region,
				theater_name : $theaterName
			}),
			success : function(data) {
				console.log('data debug: ',data);
				var $timeSelect = $('.time-select');
				if (Array.isArray(data)) { // Array 형식인가?
					data.forEach(function(item) { // 서버로 받은 데이터를 반복
						var $timeBtn = $('<button/>')
						.text(item.time)
						.addClass('timeBtn')
						.data('title', $title)
						.data('region', $region)
						.data('theater_name', $theaterName)
						.data('thisDay', $thisDay)
						.data('time', item.time)
						$timeSelect.append($timeBtn); 
					});
				} else {
					console.error('배열이 아닙니다: ', data);
				}
			}, // success 
			error : function(xhr, status, error) {
				console.error('에러 발생: ', error);
			}
		});
	});
	
	// .timeBtn 버튼 클릭 이벤트 리스너
	$(document).on('click', '.timeBtn', function() {
		var title = $(this).data('title');
	    var resDate = $(this).data('thisDay');
	    var theaterName = $(this).data('theater_name');
	    var time = $(this).data('time');
	    
	    console.log('time title: ', title);
	    console.log('time resDate: ', resDate);
	    console.log('time theaterName: ', theaterName);
	    console.log('time time: ', time);
	    
	    // AJAX 요청 설정
	    $.ajax({
	        url: '/api/theater/updateResDate', // 실제 서버 URL로 변경하세요
	        method: 'POST',
	        contentType: 'application/json',
	        data: JSON.stringify({ // 데이터 객체를 JSON 문자열로 변환
	            res_date: resDate,
	            theater_name: theaterName,
	            time: time
	        }),
	        success: function(response) {
	            // 요청이 성공적으로 처리되었을 때의 콜백 함수
	            console.log('서버 응답:', response);
	        },
	        error: function(xhr, status, error) {
	            // 요청이 실패했을 때의 콜백 함수
	            console.error('AJAX 요청 실패:', status, error);
	        }
	    });
	    
	    // movie_no의 값을 찾아와 주기
	    $.ajax({
	    	url: '/api/theater/bringMovieNo',
	    	method: 'POST',
	    	contentType: 'application/json',
	    	data: JSON.stringify({
	    	    title : title,
	    	    theater_name : theaterName,
	    	    res_date : resDate,
	    	    time : time
	    	}),
	    	success : function(response){
	    		var movieNo = response.movie_no;
	    		console.log('time movieNo: ',movieNo);
	    		// 새로운 form element 생성
	    	    var form = $('<form>', {
	    	        action: '/auth/seatBooking',
	    	        method: 'POST'
	    	    });
	    	    form.append($('<input>',{
	    			type: 'hidden',
	    			name: 'movieNo',
	    			value: movieNo
	    		}));
	    		form.append($('<input>',{
	    			type: 'hidden',
	    			name: 'title',
	    			value: title
	    		}));
	    	    // form에 hidden input 요소 추가
	    	    form.append($('<input>', {
	    	        type: 'hidden',
	    	        name: 'resDate',
	    	        value: resDate
	    	    }));
	    	    form.append($('<input>', {
	    	        type: 'hidden',
	    	        name: 'theaterName',
	    	        value: theaterName
	    	    }));
	    	    form.append($('<input>', {
	    	        type: 'hidden',
	    	        name: 'time',
	    	        value: time
	    	    }));
	    	    // form을 body에 추가하고 제출
	    	    $('body').append(form);
	    	    form.submit();
	    	},
	    	error: function(xhr, status, error) {
	            console.error('AJAX 요청 실패: ', status, error);
	            alert('영화 정보를 불러오는 중 오류가 발생했습니다. 다시 시도해 주세요.');
	        }
	    })
	});
	
	
</script>
</head>
<body>
	<h3>영화 메인</h3>
	<div class="wrap"></div>
	<hr>
	<h3>지역</h3>
	<div class="region"></div>
	<hr>
	<h3>영화관</h3>
	<div class="theater"></div>
	<hr>
	<h3>날짜</h3>
	<div class="month"></div>
	<div class="now-day"></div>
	<hr>
	<h3>시간</h3>
	<div class="time-select"></div>
	<hr>
</body>
</html>
