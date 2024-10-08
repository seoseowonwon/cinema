package com.project.cinema.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.project.cinema.entity.Theater;

@Mapper
public interface TheaterMapper {
	
	int insertTheater(Theater theater);
	
	int checkTitle(String title);
	
	int deleteTheater();
	
	List<Map<String, Object>> getRegionInfo(String title);
	
	List<Map<String, Object>> getTheaterInfo(String title, String region);
	
	List<Map<String, Object>> getTimeInfo(String title, String region, String theaterName);
	
	int updateResDate(String res_date, String theaterName, String time);
	
	int updateSeats(String title, String theaterName, String resDate, String time, String seats);
	
	// 첫 화면에서 예약된 자리인지 확인하는 메서드
	Map<String, Object> getSeatInfo(String movieNo);
	
	// 오늘 날짜인지 확인. 오늘 날짜가 아닐 경우 DB를 초기화 하기 위함
	int checkDateResult(String date);
	
	// 파라미터값에 해당하는 예약하고자 하는 영화의 id를 가져 옴
	String bringMovieNo(String title, String theaterName, String resDate, String time);
	
	// 해당 movie_no의 영화 좌석 테이블이 있는지 체크
	int checkSeats(String movieNo);
	
	// 테이블에 해당하는 값이 없을 때 INSERT INTO
	int insertSeats(String movieNo);
	
	// 결제 시, 좌석 업데이트
	int updateResvSeats(List<String> selectedSeats, String movieNo);
	
	// 로그인 체크
	int checkLogin(String id, String password);
	
}
