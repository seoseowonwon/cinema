package com.project.cinema.service;

import java.util.List;
import java.util.Map;

import com.project.cinema.entity.Theater;

public interface TheaterService {
	// 버튼 누를 때 마다 db에 제목, 지역, 영화관 이름, 날짜, 시간등 입력
	int addTheater(Theater theater);
	
	// 이미 존재하는 제목인지 체크
	int checkTitle(String title);
	
	
	
	// 버튼 누를때마다 db 정보 초기화
	int deleteTheater();
	
	// 버튼을 누를때 해당 영화의 지역을 가져옴
	List<Map<String, Object>> getRegionInfo(String title);
	
	// 버튼을 누를때 해당 영화의 지역을 가져옴
	List<Map<String, Object>> getTheaterInfo(String title, String region);
	
	// 버튼 누를때 해당 영화의 시간을 가져옴
	List<Map<String, Object>> getTimeInfo(String title, String region, String theaterName);
	
	//예약 날짜를 DB에 저장
	int updateResDate(String res_date, String theaterName, String time);
	
	// seats 정보값 저장
	int updateSeats(String title, String theaterName, String resDate, String time, String seats);
	
	// 첫 화면에서 예약된 자리인지 아닌지 확인 값 불러옴
	Map<String, Object> getSeatInfo(String movieNo);
	
	// 파라미터값에 해당하는 예약하고자 하는 영화의 id를 가져 옴
	String bringMovieNo(String title, String theaterName, String resDate, String time);
	
	// 해당 movie_no의 영화 좌석 테이블이 있는지 체크 
	int checkSeats(String movieNo);
	
	// 테이블에 해당하는 값이 없을 때 INSERT INTO
	int insertSeats(String movieNo);
	
	// 결제 시, 좌석 업데이트
	int updateResvSeats(List<String> selectedSeats, String movieNo);
	
	// 오늘 날짜인지 확인. 오늘 날짜가 아닐 경우 DB를 초기화 하기 위함
	int checkDateResult(String date);
	
	// 로그인
	int checkLogin(String id, String password);
}
