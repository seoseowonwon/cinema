<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>순위</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
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
		if($btnActive.hasClass('active')){ // active 속성을 가지고 있는가? yes -> true or false를 반환
			$('button.mon').removeClass('active'); // 속성'active' 삭제
		} else {
			$('button.mon').removeClass('active'); // 해당 버튼만 active를 가지기 위해서 삭제
			$btnActive.addClass('active'); // active 추가
		}
	})
	//날짜 클릭했으면 활성화버튼 해제 
	$('div.now-day').on('click','button.active',function(){ // div class="now-day" 중 active된 버튼을 클릭했을 때
		let $btnMon = $(this); // 클릭된 버튼을 jQuery 객체로 저장
		$btnMon.attr('class','mon'); // 클릭된 button의 속성을 active -> mon으로 변경
	})
	
	//시간출력하는 부분
	$('div.time-check').append(function(){
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
		})
	});
</script>

<!-- 박스오피스 테이블에 마우스를 올렸을때 hover효과 -->
<style type="text/css">
tbody>tr>td:hover{
	background:#ccc;cursor;
}
</style>
</head>
<body>
	<h3>실시간 박스오피스</h3>
	<div class="container">
		<div class="wrap"></div> <!-- 리스트 -->
		<div class="month"></div>
		 <div class="now-day"></div>
        <div class="time-check"></div>
        <div class="theater-choies"></div>
        <div class="movie-check"></div>
	</div>
	
</body>
</html>