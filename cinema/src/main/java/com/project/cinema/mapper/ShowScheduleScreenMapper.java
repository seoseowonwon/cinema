package com.project.cinema.mapper;

import java.util.List;


import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;


@Mapper
public interface ShowScheduleScreenMapper {
	public int countRegionByNo(int regionNo);
}
