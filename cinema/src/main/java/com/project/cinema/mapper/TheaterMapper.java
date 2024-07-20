package com.project.cinema.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.project.cinema.entity.Theater;

@Mapper
public interface TheaterMapper {
	int insertTheater(Theater theater);
}
