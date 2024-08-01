<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>영화표 좌석 예매</title>
    <style>
        .seat {
            width: 30px;
            height: 30px;
            margin: 5px;
            background-color: #ccc;
            text-align: center;
            line-height: 30px;
            cursor: pointer;
            display: inline-block;
        }
        .selected {
            background-color: #6c6;
        }
        .reserved {
            background-color: #f66;
            cursor: not-allowed;
        }
        .seat-row {
            margin-bottom: 10px;
        }
    </style>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>
        $(document).ready(function() {
            $('.seat').on('click', function() {
                if (!$(this).hasClass('reserved')) {
                    $(this).toggleClass('selected');
                }
            });

            $('#reserveSeats').on('click', function() {
                var selectedSeats = [];
                $('.seat.selected').each(function() {
                    selectedSeats.push($(this).data('seat'));
                });

                if (selectedSeats.length === 0) {
                    alert('좌석을 선택해 주세요.');
                    return;
                }

                // 예약 데이터 전송 (여기서는 콘솔에 출력하지만, 실제로는 서버로 전송해야 함)
                var resDate = '${param.res_date}';
                var theaterName = '${param.theater_name}';
                var time = '${param.time}';

                console.log('예약 날짜:', resDate);
                console.log('극장 이름:', theaterName);
                console.log('상영 시간:', time);
                console.log('선택한 좌석:', selectedSeats);

                // 서버로 예약 정보 전송 (AJAX 예시)
                $.ajax({
                    url: '/api/reserveSeats', // 실제 서버 URL로 변경하세요
                    method: 'POST',
                    contentType: 'application/json',
                    data: JSON.stringify({
                        res_date: resDate,
                        theater_name: theaterName,
                        time: time,
                        seats: selectedSeats
                    }),
                    success: function(response) {
                        alert('좌석 예약이 완료되었습니다.');
                        // 예약 완료 후 페이지 이동 또는 갱신 등의 작업 수행
                    },
                    error: function(xhr, status, error) {
                        alert('좌석 예약에 실패하였습니다. 다시 시도해 주세요.');
                    }
                });
            });
        });
    </script>
</head>
<body>
    <h1>영화표 좌석 예매</h1>
    <h3>날짜: ${param.res_date}</h3>
    <h3>극장: ${param.theater_name}</h3>
    <h3>시간: ${param.time}</h3>

    <div id="seats">
        <c:forEach var="row" begin="0" end="9">
            <div class="seat-row">
                <c:forEach var="col" begin="1" end="10">
                    <c:set var="seatLabel" value="${(char)(65 + row)}${col}" />
                    <div class="seat" data-seat="${seatLabel}">${seatLabel}</div>
                </c:forEach>
            </div>
        </c:forEach>
    </div>

    <button id="reserveSeats">좌석 예약</button>
</body>
</html>
