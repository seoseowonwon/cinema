<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.time.LocalDate, java.time.format.DateTimeFormatter, java.time.DayOfWeek" %>	
<%
	String title = request.getParameter("title");
	String theaterName = request.getParameter("theaterName");
	String resDate = request.getParameter("resDate");
	String time = request.getParameter("time");
	String trimmedTime = time.substring(0, time.length() - 3);
	DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
	LocalDate date = LocalDate.parse(resDate, formatter);
    DayOfWeek dayOfWeek = date.getDayOfWeek();
    
    // 요일을 한글로 변환
    String dayOfWeekInKorean;
    switch (dayOfWeek) {
        case MONDAY:
            dayOfWeekInKorean = "월";
            break;
        case TUESDAY:
            dayOfWeekInKorean = "화";
            break;
        case WEDNESDAY:
            dayOfWeekInKorean = "수";
            break;
        case THURSDAY:
            dayOfWeekInKorean = "목";
            break;
        case FRIDAY:
            dayOfWeekInKorean = "금";
            break;
        case SATURDAY:
            dayOfWeekInKorean = "토";
            break;
        case SUNDAY:
            dayOfWeekInKorean = "일";
            break;
        default:
            dayOfWeekInKorean = "알 수 없음";
            break;    
	}     
    
%>
<!DOCTYPE html>
<html>
<head>
    <title>좌석 선택</title>
    <style>
        .seat {
            display: inline-block;
            width: 30px;
            height: 30px;
            margin: 1px;
            background-color: lightgray;
            text-align: center;
            line-height: 30px;
            cursor: pointer;
        }
        .selected {
            background-color: #CEF279;
        }
         .seat:hover {
            background-color: #F15F5F; /* Hover 상태에서의 색상 변경 */
        }
        
        input[type="radio"] {
            display: none;
        }
        /* 커스텀 라디오 버튼의 스타일 */
        .custom-radio {
            display: inline-block;
            cursor: pointer;
            position: relative;
            width: 30px; /* 버튼 너비 */
            height: 30px; /* 버튼 높이 */
            border: 2px solid #000; /* 버튼 테두리 */
            background-color: #fff; /* 버튼 배경색 */
            text-align: center; /* 텍스트 중앙 정렬 */
            line-height: 26px; /* 텍스트 높이 맞춤 */
            margin-right: 1px;
            font-size: 16px; /* 텍스트 크기 */
            font-weight: bold; /* 텍스트 굵기 */
            color: #000; /* 텍스트 색상 */
        }
        /* 체크된 상태의 커스텀 라디오 버튼 스타일 */
        input[type="radio"]:checked + .custom-radio {
            background-color: #5D5D5D; /* 선택된 상태의 배경색 */
           	color: #F6F6F6;
        }
    </style>
   
</head>
<body>
    <h1>좌석 선택</h1>
    <p><%=title%></p>
    <p>영화관: <%=theaterName%></p>
    <p>일시: <%=resDate%>(<%=dayOfWeekInKorean%>) <%=trimmedTime %></p>

    <h2>인원/좌석</h2>
    * 최대 8명 선택 가능
    <table>
    	<tr>
    		<td>일반</td>
    		<td>
    			<label>
                    <input type="radio" value="0" name="default" checked>
                    <span class="custom-radio">0</span>
                </label>
    			<label>
                    <input type="radio" value="1" name="default">
                    <span class="custom-radio">1</span>
                </label>
                <label>
                    <input type="radio" value="2" name="default">
                    <span class="custom-radio">2</span>
                </label>
                <label>
                    <input type="radio" value="3" name="default">
                    <span class="custom-radio">3</span>
                </label>
                <label>
                    <input type="radio" value="4" name="default">
                    <span class="custom-radio">4</span>
                </label>
                <label>
                    <input type="radio" value="5" name="default">
                    <span class="custom-radio">5</span>
                </label>
                <label>
                    <input type="radio" value="6" name="default">
                    <span class="custom-radio">6</span>
                </label>
                <label>
                    <input type="radio" value="7" name="default">
                    <span class="custom-radio">7</span>
                </label>
                <label>
                    <input type="radio" value="8" name="default">
                    <span class="custom-radio">8</span>
                </label>
    		</td>
    	</tr>
    	<tr>
    		<td>청소년&nbsp;</td>
    		<td>
    			<label>
                    <input type="radio" value="0" name="teenager" checked>
                    <span class="custom-radio">0</span>
                </label>
    			<label>
                    <input type="radio" value="1" name="teenager">
                    <span class="custom-radio">1</span>
                </label>
                <label>
                    <input type="radio" value="2" name="teenager">
                    <span class="custom-radio">2</span>
                </label>
                <label>
                    <input type="radio" value="3" name="teenager">
                    <span class="custom-radio">3</span>
                </label>
                <label>
                    <input type="radio" value="4" name="teenager">
                    <span class="custom-radio">4</span>
                </label>
                <label>
                    <input type="radio" value="5" name="teenager">
                    <span class="custom-radio">5</span>
                </label>
                <label>
                    <input type="radio" value="6" name="teenager">
                    <span class="custom-radio">6</span>
                </label>
                <label>
                    <input type="radio" value="7" name="teenager">
                    <span class="custom-radio">7</span>
                </label>
                <label>
                    <input type="radio" value="8" name="teenager">
                    <span class="custom-radio">8</span>
                </label>
    		</td>
    	</tr>
    	<tr>
    	</tr>
    </table>
    
    <form action="/auth/saveSeats" method="post" onsubmit="submitSeats(event)">
    <input type="hidden" name="title" value="<%= request.getParameter("title") %>">
    <input type="hidden" name="resDate" value="<%= request.getParameter("resDate") %>">
    <input type="hidden" name="theaterName" value="<%= request.getParameter("theaterName") %>">
    <input type="hidden" name="time" value="<%= request.getParameter("time") %>">
    <div>
        
    </div>
    <br>
    <input type="submit" value="좌석 선택">
</form>
    
     <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>
 		// 모든 라디오 버튼 요소를 가져옴
	    const defaultRadios = document.querySelectorAll('input[name="default"]'); // default의 모든 값
	    const teenagerRadios = document.querySelectorAll('input[name="teenager"]'); // teenager의 모든 값
    	
	 	// 좌석 요소를 가져옴
        const seats = document.querySelectorAll('.seat');
	    
	    // 각 라디오 버튼에 클릭 이벤트 리스너 추가
        defaultRadios.forEach(radio => {
            radio.addEventListener('click', checkSum);
        });
        teenagerRadios.forEach(radio => {
            radio.addEventListener('click', checkSum);
        });
    	
        function checkSum() {
            // 선택된 라디오 버튼의 값을 가져옴
            const defaultValue = parseInt(document.querySelector('input[name="default"]:checked').value);
            const teenagerValue = parseInt(document.querySelector('input[name="teenager"]:checked').value);

            // 값의 합이 9 이상인 경우 알림 표시
            if (defaultValue + teenagerValue > 8) {
                alert('최대 8명 선택 가능합니다');
                // 라디오 버튼을 초기 상태로 되돌림
                document.querySelector('input[name="default"][value="0"]').checked = true;
                document.querySelector('input[name="teenager"][value="0"]').checked = true;
            } 
        }
        
        function toggleSeat(seat) {
            
            seat.classList.toggle('selected');
            const checkbox = seat.querySelector('input[type=checkbox]');
            if(checkbox){
	            checkbox.checked = !checkbox.checked;  // 체크박스의 'checked' 속성을 현재 상태와 반대로 설정
				checkbox.disabled = !checkbox.disabled;            	
            }
            
            // 선택 상태가 변경되었을 때 좌석 수 체크
            checkSum();
        }
        
        
	    const title = "<%= title %>";
	    const resDate = "<%= resDate %>";
	    const theaterName = "<%= theaterName %>";
	    const time ="<%= time %>";
    	
	    console.log('seatBooking title: ', title);
	    console.log('seatBooking resDate: ', resDate);
	    console.log('seatBooking theaterName: ', theaterName);
	    console.log('seatBooking time: ', time);
	    
        function toggleSeat(seat) {
            seat.classList.toggle('selected');
            const checkbox = seat.querySelector('input[type=checkbox]');
            checkbox.checked = !checkbox.checked;
        }

        function submitSeats(event) {
            event.preventDefault(); // 폼의 기본 제출 동작을 방지

            // 선택된 좌석 정보를 배열로 저장
            const selectedSeats = Array.from(document.querySelectorAll("input[name='seats']:checked")).map(checkbox => checkbox.value);
            // 배열을 /로 구분된 문자열로 변환
            const seatsString = selectedSeats.join('/') + '/';
            console.log('Seats:', seatsString);
            const data = JSON.stringify({
                title: title,
                res_date: resDate,
                theater_name: theaterName,
                time: time,
                seats: seatsString
            });

            // AJAX 요청
            $.ajax({
                url: "/auth/saveSeats",
                type: "POST",
                contentType: "application/json",
                data: data,
                success: function(response) {
                    // 서버 응답 처리
                    alert(response);
                },
                error: function(xhr, status, error) {
                    console.error("에러 발생:", error);
                }
            });
        }
    </script>
</body>
</html>
