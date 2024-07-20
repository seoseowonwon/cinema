package com.project.cinema.service;

import com.project.cinema.entity.Theater;

public interface TheaterService {
	// 버튼 누를 때 마다 db에 제목, 지역, 영화관 이름, 날짜, 시간등 입력
	int addTheater(Theater theater);
	
	// 버튼 누를때마다 db 정보 초기화
	int deleteTheater();
}
