package com.project.cinema.mapper;

import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface LoginMapper {
	Map<String, Object>selectMember(String id);
}
