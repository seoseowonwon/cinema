package com.project.cinema.service;

import java.util.List;
import java.util.Map;

import com.project.cinema.entity.Theater;

public interface TheaterService {
	// 버튼 누를 때 마다 db에 제목, 지역, 영화관 이름, 날짜, 시간등 입력
	int addTheater(Theater theater);
	
	// 버튼 누를때마다 db 정보 초기화
	int deleteTheater();
	
	// 버튼을 누를때 해당 영화의 지역을 가져옴
	List<Map<String, Object>> getRegionInfo();
	
	// 버튼을 누를때 해당 영화의 지역을 가져옴
	List<Map<String, Object>> getTheaterInfo(String region);
	
	// 버튼 누를때 해당 영화의 시간을 가져옴
	List<Map<String, Object>> getTimeInfo(String theaterName);
	
	//예약 날짜를 DB에 저장
	int insertResDate(String resDate);
	
}
