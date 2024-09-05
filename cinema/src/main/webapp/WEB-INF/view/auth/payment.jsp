<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    
<%
	int adult = Integer.parseInt(request.getParameter("default"));
	int teenager = Integer.parseInt(request.getParameter("teenager"));
	
	String movieNo = request.getParameter("movieNo");
	//디버깅
	System.out.println(adult);
	System.out.println(teenager);
	
	// 총 결제 금액
	int totalPrice = (adult * 11000) + (teenager * 8000);
	// 디버깅
	System.out.println("payment total price --> "+totalPrice);
	System.out.println("payment movieNo --> "+movieNo);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<!-- 디버깅 -->
	<p>Selected seats: ${selectedSeats}</p>
	<p>Selected default: ${defaultSelection}</p>
	<p>Selected teenager: ${teenagerSelection}</p>
	<p>총 결제 금액: <%=totalPrice%> </p>
	
	<form action="/auth/done" method="post">
		<input type="hidden" value="<%=movieNo%>" name="movieNo">
		<input type="hidden" value="<%=totalPrice%>" name="totalPrice">
		<c:forEach var="seat" items="${selectedSeats}">
        	<input type="text" name="seats" value="${seat}">
   		</c:forEach>
		<a href="/public/main">결제 취소</a>
		<button type="submit">결제 하기</button>
	</form>
	
</body>
</html>