<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>현재 접속자 : ${currentCnt}</h1>
	<h1>로그인 안 했을 때</h1>
	<form method="post" action="${pageContext.request.contextPath}/public/login">
		<div>
			Id: <input type="text" name="id">
		</div>
		
		<div>
			Password: <input type="password" name="password">
		</div>
		<button>로그인</button>
	</form>
</body>
</html>