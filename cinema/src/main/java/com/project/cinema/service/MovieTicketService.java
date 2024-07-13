package com.project.cinema.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.project.cinema.mapper.ShowScheduleScreenMapper;
import com.project.cinema.mapper.TheaterMapper;
import com.project.cinema.vo.Region;






@Service
@Transactional
public class MovieTicketService {

	@Autowired
	private ShowScheduleScreenMapper showDao;
	@Autowired
	private TheaterMapper theaterDao;

	public int countRegionByNo(int regionNo) {
		return showDao.countRegionByNo(regionNo);
	}
	
	public List<Region> listByRegion(){
		return theaterDao.getAllRegion();
	}
	
}

