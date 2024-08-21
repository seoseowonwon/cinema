package com.project.cinema.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.project.cinema.entity.Theater;
import com.project.cinema.mapper.TheaterMapper;

import lombok.extern.slf4j.Slf4j;

@Service
@Transactional
@Slf4j
public class MovieService implements TheaterService{
	@Autowired TheaterMapper theaterMapper;
	
	@Override
	public int addTheater(Theater theater) {
		return theaterMapper.insertTheater(theater);
	}
	
	
	@Override
	public int deleteTheater() {
		return theaterMapper.deleteTheater();
	}
	
	// submitBtn을 클릭 시, 해당 지역들이 뜨도록 함
	@Override
	public List<Map<String, Object>> getRegionInfo(String title) {
		return theaterMapper.getRegionInfo(title);
	}

	@Override
	public List<Map<String, Object>> getTheaterInfo(String title, String region) {
		return theaterMapper.getTheaterInfo(title, region);
	}

	@Override
	public List<Map<String, Object>> getTimeInfo(String title, String region, String theaterName) {
		log.debug("theatherName: {}",theaterName);
		return theaterMapper.getTimeInfo(title, region, theaterName);
	}

	@Override
	public int updateResDate(String res_date, String theaterName, String time) {
		return theaterMapper.updateResDate(res_date, theaterName, time);
	}

	
	@Override
	public int updateSeats(String title, String theaterName, String resDate, String time, String seats) {
		return theaterMapper.updateSeats(title, theaterName, resDate, time, seats);
	}

	@Override
	public List<Map<String, String>> getSeatInfo(String title, String theaterName, String resDate, String time) {
		return theaterMapper.getSeatInfo(title, theaterName, resDate, time);
	}


	// 버튼을 눌렀을 때 이미 DB상에 존재하는 데이터인지 확인
	@Override
	public int checkTitle(String title) {
		return theaterMapper.checkTitle(title);
	}

	// 오늘 날짜인지 확인. 오늘 날짜가 아닐 경우 DB를 초기화 하기 위함
	@Override
	public int checkDateResultDelete(String date) {
		return theaterMapper.checkDateResultDelete(date);
	}

	// 파라미터값에 해당하는 예약하고자 하는 영화의 id를 가져 옴
	@Override
	public int bringMovieNo(String title, String theaterName, String resDate, String time) {
		return theaterMapper.bringMovieNo(title, theaterName, resDate, time);
	}
	
	
}
