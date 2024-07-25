package com.project.cinema.service;

import java.util.ArrayList;
import java.util.HashMap;

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
	public ArrayList<HashMap<String, Object>> getRegionInfo() {
		return null;
	}
	
	
}
