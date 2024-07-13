package com.project.cinema.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.project.cinema.dto.MovieRatingDto;
import com.project.cinema.mapper.MovieRatingMapper;

@Service
@Transactional
public class MovieRatingService {

	@Autowired
	private MovieRatingMapper movieRatingDto;

	public List<MovieRatingDto> getAllList(){
		return movieRatingDto.getAllList();
	}
	
}
