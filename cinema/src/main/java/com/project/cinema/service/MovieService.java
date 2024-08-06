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

	@Override
	public List<Map<String, Object>> getRegionInfo() {
		return theaterMapper.getRegionInfo();
	}

	@Override
	public List<Map<String, Object>> getTheaterInfo(String region) {
		return theaterMapper.getTheaterInfo(region);
	}

	@Override
	public List<Map<String, Object>> getTimeInfo(String theaterName) {
		return theaterMapper.getTimeInfo(theaterName);
	}

	@Override
	public int updateResDate(String res_date, String theaterName, String time) {
		return theaterMapper.updateResDate(res_date, theaterName, time);
	}

	@Override
	public int updateSeats(String res_date, 
							String title,
							String theaterName, 
							String time,
							String seats) {
		return theaterMapper.updateSeats(title, res_date, theaterName, time, seats);
	}
	
	
}
