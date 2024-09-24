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
	String userId = (String) session.getAttribute("userId");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<meta content="width=device-width, initial-scale=1.0" name="viewport">
    <meta content="" name="keywords">
    <meta content="" name="description">

    <!-- Favicon -->
    <link href="img/favicon.ico" rel="icon">

    <!-- Google Web Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Heebo:wght@400;500;600;700&display=swap" rel="stylesheet">
    
    <!-- Icon Font Stylesheet -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">

    <!-- Libraries Stylesheet -->
    <link href="/lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">
    <link href="/lib/tempusdominus/css/tempusdominus-bootstrap-4.min.css" rel="stylesheet" />

    <!-- Customized Bootstrap Stylesheet -->
    <link href="/css/bootstrap.min.css" rel="stylesheet">

    <!-- Template Stylesheet -->
    <link href="/css/style.css" rel="stylesheet">
</head>
<body>
	<div class="container-xxl position-relative bg-white d-flex p-0">
		
		
        
        <!-- Sidebar Start -->
		<div class="sidebar pe-4 pb-3">
            <nav class="navbar bg-light navbar-light">
                <a href="index.html" class="navbar-brand mx-4 mb-3">
                    <h3 class="text-primary"><i class="fa fa-hashtag me-2"></i>CINEMA</h3>
                </a>
                <div class="d-flex align-items-center ms-4 mb-4">
                    <%
					if (userId != null) {
				%>
                    	<div class="position-relative">
	                        <img class="rounded-circle" src="/img/user.png" alt="" style="width: 40px; height: 40px;">
	                        <div class="bg-success rounded-circle border border-2 border-white position-absolute end-0 bottom-0 p-1"></div>
	                    </div>
	                    <div class="ms-3">
	                        <h6 class="mb-0"><%=userId%></h6>
	                        <span>회원</span>
	                    </div>
	            <%
					} else {
				%>        
						<div class="position-relative">
							<div class="ms-3">
		                        <h6 class="mb-0">비회원</h6>
		                    </div>
	                    </div>
				<%
					}
				%>
                </div>
                <div class="navbar-nav w-100">
                    <a href="index.html" class="nav-item nav-link active"><i class="fa fa-laptop me-2"></i>영화 예매</a>
                    <div class="nav-item dropdown">
                        <a href="#" class="nav-link dropdown-toggle" data-bs-toggle="dropdown"><i class="far fa-file-alt me-2"></i>계정</a>
                        <div class="dropdown-menu bg-transparent border-0">
                            <a href="signin.html" class="dropdown-item">로그인</a>
                            <a href="signup.html" class="dropdown-item">회원가입</a>
                        </div>
                    </div>
                </div>
            </nav>
        </div>
        <!-- Sidebar End -->
        
        <!-- Content Start -->
        <div class="content">
        	<!-- Navbar Start -->
            <nav class="navbar navbar-expand bg-light navbar-light sticky-top px-4 py-0">
                <a href="index.html" class="navbar-brand d-flex d-lg-none me-4">
                    <h2 class="text-primary mb-0"><i class="fa fa-hashtag"></i></h2>
                </a>
                <a href="#" class="sidebar-toggler flex-shrink-0">
                    <i class="fa fa-bars"></i>
                </a>
                
                <div class="navbar-nav align-items-center ms-auto">
                    <div class="nav-item dropdown">
                       <%
                  			if (userId != null) {
                       %>  
                       	<a href="#" class="nav-link dropdown-toggle" data-bs-toggle="dropdown">  
                            <img class="rounded-circle me-lg-2" src="/img/user.png"
                             style="width: 40px; height: 40px;">
                   			<span class="d-none d-lg-inline-flex">
                              		<%=userId %>
                            </span>
                           </a>
                       <%
                           } else {
                       %>
                       		<a href="/public/login"><span class="d-none d-lg-inline-flex">로그인</span></a>
                   		<%
                           }
                  		%>
                        <div class="dropdown-menu dropdown-menu-end bg-light border-0 rounded-0 rounded-bottom m-0">
                            <a href="#" class="dropdown-item">예약 정보</a>
                            <a href="/logout" class="dropdown-item">로그아웃</a>
                        </div>
                    </div>
                </div>
            </nav>
            <!-- Navbar End -->
            
             <!-- Table Start -->
            <div class="container-fluid pt-4 px-4">
            	<div class="col-12">
	                <div class="bg-light rounded h-100 p-4">
	                    <h6 class="mb-4">테스트</h6>
	                    <div class="table-responsive">
	                        <!-- 디버깅 -->
							<p>선택 좌석: ${selectedSeats}</p>
							<p>성인: ${defaultSelection}명</p>
							<p>청소년: ${teenagerSelection}명</p>
							<p>총 결제 금액: <%=totalPrice%> </p>
							
							<form action="/auth/done" method="post">
								<input type="hidden" value="<%=movieNo%>" name="movieNo">
								<input type="hidden" value="<%=totalPrice%>" name="totalPrice">
								<c:forEach var="seat" items="${selectedSeats}">
						        	<input type="hidden" name="seats" value="${seat}">
						   		</c:forEach>
								<a href="/public/main">결제 취소</a>
								<button type="submit">결제 하기</button>
							</form>
	                    </div>
	                </div>
                </div>
            </div>
            <!-- Table End -->
            
            <!-- Footer Start -->
            <div class="container-fluid pt-4 px-4">
                <div class="bg-light rounded-top p-4">
                    <div class="row">
                        <div class="col-12 col-sm-6 text-center text-sm-start">
                            &copy; <a href="#">Cinema</a>, 깊이 빠져 보다. 
                        </div>
                    </div>
                </div>
            </div>
            <!-- Footer End -->
            
        </div>
        <!-- Content End -->
	</div>
</body>
</html>