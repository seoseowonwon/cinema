<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.time.LocalDate, java.time.format.DateTimeFormatter, java.time.DayOfWeek" %>	
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<%
	String movieNo = request.getParameter("movieNo");
	String title = request.getParameter("title");
	String theaterName = request.getParameter("theaterName");
	String resDate = request.getParameter("resDate");
	String time = request.getParameter("time");
	String trimmedTime = time.substring(0, time.length() - 3);
	DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
	LocalDate date = LocalDate.parse(resDate, formatter);
    DayOfWeek dayOfWeek = date.getDayOfWeek();
    
    //디버깅
    System.out.println("seatBooking movieNo: "+ movieNo);
    System.out.println("seatBooking title: "+ title);
    System.out.println("seatBooking theaterName: "+ theaterName);
    System.out.println("seatBooking resDate: "+ resDate);
    System.out.println("seatBooking time: "+ time);
    
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
    <form action="/auth/payment" method="POST">
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
        <div class="seat-container">
        	<input type="hidden" value="<%=movieNo%>" name="movieNo">
	            <%
	                String[] rows = {"A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K"};
	                int totalSeats = 10;
	
	                for (String row : rows) {
	            %>
                <div class="seat-row">
                    <%
                        for (int i = 1; i <= totalSeats; i++) {
                            String seatId = row + i;
                            Map<String, String> result = (Map<String, String>) request.getAttribute("result");
                            String xo = result.get(seatId);
                            boolean isDisabled = "O".equals(xo);
                    %>
                        <span class="seat <%= isDisabled ? "disabled" : "" %>">
                            <label>
                                <input type="checkbox" value="<%=seatId%>" name="seats" <%= isDisabled ? "disabled" : "" %>>
                                <%=seatId%>
                            </label>
                        </span>
                        
                    <%
                        }
                    %>
                    
                </div>
	            <%
	                }
	            %>
	        	</div>
	        	
	        <div>
	            <button type="submit">좌석 선택</button>
	        </div>
    </form>

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>
 		// 모든 라디오 버튼 요소를 가져옴
	    const defaultRadios = document.querySelectorAll('input[name="default"]'); // default의 모든 값
	    const teenagerRadios = document.querySelectorAll('input[name="teenager"]'); // teenager의 모든 값
    	
	 	
	    const selectedSeats = $('input[name="seats"]:checked')
	    
	    // 각 라디오 버튼에 클릭 이벤트 리스너 추가
        defaultRadios.forEach(radio => {
            radio.addEventListener('click', checkSum);
        });
        teenagerRadios.forEach(radio => {
            radio.addEventListener('click', checkSum);
        });
    	
        // 일반, 청소년 최대 8명까지
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
        
        
        $(document).ready(function() {
            // 선택된 좌석의 값을 가져옴.
            function getSelectedSeats() {
                return $('input[name="seats"]:checked').map(function() {
                    return $(this).val();
                }).get();
            }

            // 좌석 수를 기준으로 체크되지 않은 좌석을 disabled로 변경합니다.
            function updateSeatAvailability() {
                const defaultValue = parseInt($('input[name="default"]:checked').val());
                const teenagerValue = parseInt($('input[name="teenager"]:checked').val());
                const maxSeats = defaultValue + teenagerValue;

                const selectedSeats = getSelectedSeats();
                
                if (selectedSeats.length >= maxSeats) {
                    // 체크된 좌석만 남기고 나머지 좌석을 disabled로 설정합니다.
                    $('input[name="seats"]').each(function() {
                        if ($(this).is(':checked')) {
                            $(this).prop('disabled', false);
                            $(this).closest('.seat').removeClass('disabled');
                        } else {
                            $(this).prop('disabled', true);
                            $(this).closest('.seat').addClass('disabled');
                        }
                    });
                } else {
                    // 초과하지 않는 경우 모든 좌석을 활성화합니다.
                    $('input[name="seats"]').prop('disabled', false);
                    $('.seat').removeClass('disabled');
                }
            }
            
            // 각 라디오 버튼 클릭 시 좌석 조정
            $('input[name="default"], input[name="teenager"]').on('change', function() {
                updateSeatAvailability();
            });

            // 체크박스 클릭 시 좌석 조정
            $('input[name="seats"]').on('change', function() {
                updateSeatAvailability();
            });
        });
    </script>
</body>
</html>
