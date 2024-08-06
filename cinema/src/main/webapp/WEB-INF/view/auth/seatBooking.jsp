<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String title = request.getParameter("title");
	String theaterName = request.getParameter("theaterName");
	String resDate = request.getParameter("resDate");
	String time = request.getParameter("time");
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
            margin: 5px;
            background-color: lightgray;
            text-align: center;
            line-height: 30px;
            cursor: pointer;
        }
        .selected {
            background-color: green;
        }
    </style>
   
</head>
<body>
    <h1>좌석 선택</h1>
    <p><%=title%></p>
    <p>영화관 이름: <%=theaterName%></p>
    <p>일시 <%=resDate %> <%=time %></p>

    <h2>좌석을 선택하세요</h2>
    <!-- 폼의 제출을 AJAX로 처리하기 위해 onsubmit 이벤트 리스너 추가 -->
    <form action="/auth/saveSeats" method="post" onsubmit="submitSeats(event)">
        <input type="hidden" name="title" value="<%= request.getParameter("title") %>">
        <input type="hidden" name="resDate" value="<%= request.getParameter("resDate") %>">
        <input type="hidden" name="theaterName" value="<%= request.getParameter("theaterName") %>">
        <input type="hidden" name="time" value="<%= request.getParameter("time") %>">
        <div>
            <%
                String[] rows = {"A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K"};
                for (String row : rows) {
                    for (int i = 1; i <= 10; i++) {
                        String seatId = row + i;
            %>
                        <div class="seat" onclick="toggleSeat(this)" id="<%= seatId %>">
                            <%= seatId %>
                            <input type="checkbox" name="seats" value="<%= seatId %>" style="display:none;">
                        </div>
            <%
                    }
                    out.println("<br>");
                }
            %>
        </div>
        <br>
        <input type="submit" value="예약 확인">
    </form>
    
     <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>
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

            // FormData 객체를 사용하여 폼 데이터와 선택된 좌석 정보 전송
            const formData = new FormData(event.target);
            formData.append("selectedSeats", JSON.stringify(selectedSeats));
			console.log('seatBooking selectSeats: ',selectedSeats);
            // AJAX 요청
            $.ajax({
                url: "/auth/saveSeats",
                type: "POST",
                contentType: "application/json",
                data: JSON.stringify({ // 데이터 객체를 JSON 문자열로 변환
    	        	title: title,
    	        	res_date: resDate,
    	        	theater_name: theaterName,
    	        	time: time,
                	seats: selectedSeats
                }),
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
