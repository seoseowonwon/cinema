package com.project.cinema.mapper;

import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.project.cinema.entity.Person;

@Mapper
public interface PersonMapper {
	int insertPerson(Person person);
}
