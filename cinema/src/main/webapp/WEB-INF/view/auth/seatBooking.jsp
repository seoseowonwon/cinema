<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.time.LocalDate, java.time.format.DateTimeFormatter, java.time.DayOfWeek" %>	
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<%
	String userId = (String) session.getAttribute("userId");
%>

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
	<meta charset="utf-8">
    <title>예매 | 깊이 빠져 보다</title>
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
        
        .seat-map {
        display: flex;
        flex-direction: column;
        align-items: center;
        margin: 20px auto;
    }

    .seat-row {
        display: flex;
        justify-content: center;
        margin-bottom: 10px;
    }

    .seat {
        margin: 0 5px;
        padding: 5px;
        text-align: center;
    }

    .seat label {
        display: block;
        cursor: pointer;
    }

    .seat input[type="checkbox"] {
        display: none;
    }

    .seat input[type="checkbox"] + span {
        display: inline-block;
        width: 30px;
        height: 30px;
        line-height: 30px;
        border: 1px solid #ccc;
        border-radius: 3px;
        background-color: #e0e0e0;
        text-align: center;
        color: #333;
    }

    .seat input[type="checkbox"]:checked + span {
        background-color: #4caf50;
        color: #fff;
    }

    .seat.disabled {
        opacity: 0.6;
        cursor: not-allowed;
    }

    .seat.disabled input[type="checkbox"] {
        display: none;
    }

    .seat.disabled input[type="checkbox"] + span {
        background-color: #bdbdbd;
        color: #fff;
    }
    </style>
</head>
<body>
	<div class="container-xxl position-relative bg-white d-flex p-0">
        <!-- Spinner Start -->
        <div id="spinner" class="show bg-white position-fixed translate-middle w-100 vh-100 top-50 start-50 d-flex align-items-center justify-content-center">
            <div class="spinner-border text-primary" style="width: 3rem; height: 3rem;" role="status">
                <span class="sr-only">로딩 중...</span>
            </div>
        </div>
		<!-- Spinner End -->
	
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
        <!-- Back to Top -->
        <a href="#" class="btn btn-lg btn-primary btn-lg-square back-to-top"><i class="bi bi-arrow-up"></i></a>
    
     <!-- Blank Start -->
            <div class="container-fluid pt-4 px-4">
                <div class="row vh-100 bg-light rounded align-items-center justify-content-center mx-0">
                    <div class="col-md-6 text-center">
					    <p><%=title%></p>
					    <p>영화관: <%=theaterName%></p>
					    <p>일시: <%=resDate%>(<%=dayOfWeekInKorean%>) <%=trimmedTime %></p>
					    <h5>인원/좌석</h5>
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
						            <table class="seat-table">
								        <tbody>
								            <% 
								                String[] rows = {"A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K"};
								                int totalSeats = 10;
								
								                for (String row : rows) {
								            %>
								                <tr>
								                    <td><%= row %></td>
								                    <% 
								                        for (int i = 1; i <= totalSeats; i++) {
								                            String seatId = row + i;
								                            Map<String, String> result = (Map<String, String>) request.getAttribute("result");
								                            String xo = result.get(seatId);
								                            boolean isDisabled = "O".equals(xo);
								                    %>
								                        <td class="seat <%= isDisabled ? "disabled" : "" %>">
								                            <label>
								                                <input type="checkbox" value="<%=seatId%>" name="seats" <%= isDisabled ? "disabled" : "" %>>
								                                <span><%=seatId%></span>
								                            </label>
								                        </td>
								                    <% 
								                        } 
								                    %>
								                </tr>
								            <% 
								                }
								            %>
								        </tbody>
								    </table>
						        <div>
						            <button type="submit">좌석 선택</button>
						        </div>
					    </form>
                    </div>
                </div>
            </div>
            
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
            
		</div>
	</div>
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
    
     <!-- JavaScript Libraries -->
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="/lib/chart/chart.min.js"></script>
    <script src="/lib/easing/easing.min.js"></script>
    <script src="/lib/waypoints/waypoints.min.js"></script>
    <script src="/lib/owlcarousel/owl.carousel.min.js"></script>
    <script src="/lib/tempusdominus/js/moment.min.js"></script>
    <script src="/lib/tempusdominus/js/moment-timezone.min.js"></script>
    <script src="/lib/tempusdominus/js/tempusdominus-bootstrap-4.min.js"></script>

    <!-- Template Javascript -->
    <script src="/js/main.js"></script>
</body>
</html>
       
    
    

