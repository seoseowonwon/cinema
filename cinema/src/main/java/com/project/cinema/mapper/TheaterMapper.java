package com.project.cinema.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.project.cinema.vo.Region;





@Mapper
public interface TheaterMapper {
	List<Region> getAllRegion();
}
