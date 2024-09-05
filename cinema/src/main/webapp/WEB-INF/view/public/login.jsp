<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>
	window.onload = function() {
	    // ${loginError}는 서버에서 전달된 플래시 속성 값을 포함합니다
	    var loginError = '${loginError}';
	    if (loginError) {
	        alert(loginError);
	    }
	};
</script>
</head>
<body>
	<a href="/public/main">메인 화면</a>
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