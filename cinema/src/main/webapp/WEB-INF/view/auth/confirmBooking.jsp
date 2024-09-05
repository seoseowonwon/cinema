<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>예약 확인</title>
</head>
<body>
    <h1>예약 확인</h1>
    <p>영화 제목: <%= request.getParameter("title") %></p>
    <p>예약 날짜: <%= request.getParameter("resDate") %></p>
    <p>영화관 이름: <%= request.getParameter("theaterName") %></p>
    <p>시간: <%= request.getParameter("time") %></p>

    <h2>선택된 좌석</h2>
    <ul>
        <%
            String[] seats = request.getParameterValues("seats");
            if (seats != null) {
                for (String seat : seats) {
                    out.println("<li>" + seat + "</li>");
                }
            } else {
                out.println("<li>선택된 좌석이 없습니다.</li>");
            }
        %>
    </ul>
</body>
</html>
