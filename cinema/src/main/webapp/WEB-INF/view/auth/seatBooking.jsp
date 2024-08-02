<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>예매, 깊이 빠져 보다</title>
    <style>
        .seat {
            display: inline-block;
            width: 30px;
            height: 30px;
            margin: 5px;
            background-color: #f0f0f0;
            text-align: center;
            line-height: 30px;
            cursor: pointer;
        }
        .selected {
            background-color: #6c7ae0;
            color: white;
        }
    </style>
</head>
<body>
	
    <h1>영화표 좌석 예매</h1>
    <h3>${title}</h3>
    <h3>일시 ${resDate} ${time}</h3>
    <h3>극장 ${theaterName}</h3>
	
    <button id="reserveSeats">좌석 예약</button>
    
     <div id="seatContainer">
        <c:forEach var="row" begin="A" end="H">
            <div>
                <c:forEach var="col" begin="1" end="10">
                    <div class="seat" data-seat="${row}${col}">${row}${col}</div>
                </c:forEach>
            </div>
        </c:forEach>
    </div>

    <form id="seatForm" action="/auth/reserveSeats" method="post">
        <input type="hidden" name="resDate" value="${resDate}">
        <input type="hidden" name="time" value="${time}">
        <input type="hidden" name="theaterName" value="${theaterName}">
        <input type="hidden" id="selectedSeats" name="selectedSeats" value="">
        <button type="submit">좌석 예약</button>
    </form>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const seats = document.querySelectorAll('.seat');
            const selectedSeatsInput = document.getElementById('selectedSeats');

            seats.forEach(seat => {
                seat.addEventListener('click', function() {
                    seat.classList.toggle('selected');
                    updateSelectedSeats();
                });
            });

            function updateSelectedSeats() {
                const selectedSeats = [];
                seats.forEach(seat => {
                    if (seat.classList.contains('selected')) {
                        selectedSeats.push(seat.dataset.seat);
                    }
                });
                selectedSeatsInput.value = selectedSeats.join(',');
            }
        });
    </script>
</body>
</html>
