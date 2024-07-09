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
				var $data = $(data).find("boxOfficeResult>dailyBoxOfficeList>dailyBoxOffice");  // data 변수에 저장된 XML데이터를 jQery $()을 사용하여 jQuery객체로 변환 -> jQuery의 메소드를 사용하여 XML데이터를 쉽게 가져올 수 있음.
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
					var tbody = $("<tbody/>"); // tbody선언.
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
			//에러 발생시 "실시간 박스오피스 로딩중"메시지가 뜨도록 한다.
			error : function() {
				alert("실시간 박스오피스 로딩중...");
			}
		});
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
	<div class="wrap container"></div>
</body>
</html>