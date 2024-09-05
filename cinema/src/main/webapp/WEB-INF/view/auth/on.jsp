<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>로그인했을 때</h1>
	${userId}님 반갑습니다
	<a href="${pageContext.request.contextPath}/logout">로그아웃</a>
</body>
</html>