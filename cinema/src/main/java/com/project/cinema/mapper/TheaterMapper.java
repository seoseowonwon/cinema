package com.project.cinema.mapper;

import java.util.ArrayList;

import java.util.HashMap;

import org.apache.ibatis.annotations.Mapper;

import com.project.cinema.entity.Theater;

@Mapper
public interface TheaterMapper {
	int insertTheater(Theater theater);
	
	int deleteTheater();
	
	ArrayList<HashMap<String, Object>> getRegionInfo();
}
