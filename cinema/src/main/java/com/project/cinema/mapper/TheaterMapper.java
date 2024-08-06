package com.project.cinema.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.project.cinema.entity.Theater;

@Mapper
public interface TheaterMapper {
	
	int insertTheater(Theater theater);
	
	int deleteTheater();
	
	List<Map<String, Object>> getRegionInfo();
	
	List<Map<String, Object>> getTheaterInfo(String region);
	
	List<Map<String, Object>> getTimeInfo(String theaterName);
	
	int updateResDate(String res_date, String theaterName, String time);
	
	int updateSeats(String seats, String title, String time, String resDate, String theaterName);
	
}
