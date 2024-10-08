package com.project.cinema.service;

import java.util.LinkedHashMap;
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
	public Map<String, Object> getSeatInfo(String movieNo) {
		
		 // MyBatis에서 HashMap으로 결과를 받음
        Map<String, Object> resultMap = theaterMapper.getSeatInfo(movieNo);
        log.debug("MovieService getSeatInfo resultMap --> {}", resultMap);
        // LinkedHashMap으로 변환하여 순서 유지
        Map<String, Object> orderedResult = new LinkedHashMap<>(resultMap);
        log.debug("MovieService getSeatInfo orderedResult --> {}",orderedResult);
        
		return orderedResult;
	}


	// 버튼을 눌렀을 때 이미 DB상에 존재하는 데이터인지 확인
	@Override
	public int checkTitle(String title) {
		return theaterMapper.checkTitle(title);
	}


	// 파라미터값에 해당하는 예약하고자 하는 영화의 id를 가져 옴
	@Override
	public String bringMovieNo(String title, String theaterName, String resDate, String time) {
		return theaterMapper.bringMovieNo(title, theaterName, resDate, time);
	}

	// 해당 movie_no의 영화 좌석 테이블이 있는지 체크
	@Override
	public int checkSeats(String movieNo) {
		return theaterMapper.checkSeats(movieNo);
	}

	// 테이블에 해당하는 값이 없을 때 INSERT INTO
	@Override
	public int insertSeats(String movieNo) {
		return theaterMapper.insertSeats(movieNo);
	}


	@Override
	public int updateResvSeats(List<String> selectedSeats, String movieNo) {
		return theaterMapper.updateResvSeats(selectedSeats, movieNo);
	}

	// 오늘 날짜인지 확인. 오늘 날짜가 아닐 경우 DB를 초기화 하기 위함
	@Override
	public int checkDateResult(String date) {
		return theaterMapper.checkDateResult(date);
	}

	// 로그인 체크
	@Override
	public int checkLogin(String id, String password) {
		return theaterMapper.checkLogin(id, password);
	}
	
	
}
