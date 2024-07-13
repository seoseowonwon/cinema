package com.project.cinema.mapper;

import java.util.List;


import org.apache.ibatis.annotations.Mapper;

import com.project.cinema.dto.MovieRatingDto;

@Mapper
public interface MovieRatingMapper {
	
	public List<MovieRatingDto> getAllList();
	public MovieRatingDto getAllListByMovieNo(int movieNo);
}
