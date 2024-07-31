package com.project.cinema.controller;


import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.project.cinema.entity.Theater;
import com.project.cinema.service.MovieService;

import lombok.extern.slf4j.Slf4j;


@RestController
@Slf4j
public class TheaterController {

	@Autowired
	private MovieService movieService;
	
	
	@PostMapping("/api/theater/add")
	public String addTheater(@RequestBody Theater theater) {
		log.debug(theater.getTitle().toString());
		log.debug(theater.getRegion().toString());
		log.debug(theater.getTheater_name().toString());
		log.debug(theater.getDate().toString());
		log.debug(theater.getTime().toString());
		
		int result = movieService.addTheater(theater);
		return result > 0 ? "Success" : "fail";
	} 
	
	@PostMapping("/api/theater/delete")
	public String deleteTheater() {
		
		int result = movieService.deleteTheater();
		return result > 0 ? "Success" : "fail";
	} 
	
	
	@GetMapping("/api/theater/getInfo")
    public List<Map<String, Object>> getRegionInfo() {
        return movieService.getRegionInfo();
    }
	
	@GetMapping("/api/theater/getTheaterInfo")
	public List<Map<String, Object>> getTheaterInfo(String region) {
		return movieService.getTheaterInfo(region);
	}
	
	@GetMapping("/api/theater/getTimeInfo")
	public List<Map<String, Object>> getTimeInfo(@RequestParam(name = "theater_name") String theaterName){
		log.debug("theaterName: ",theaterName);
		return movieService.getTimeInfo(theaterName);
	}
	
	@PostMapping("/api/theater/updateResDate")
	public int updateResDate(@RequestBody Map<String, String> requestData) {
	    String resDate = requestData.get("res_date");
	    String theaterName = requestData.get("theater_name");
	    String time = requestData.get("time");

	    log.debug("res_date: {}", resDate);
	    log.debug("theaterName: {}", theaterName);
	    log.debug("time: {}", time);

	    return movieService.updateResDate(resDate, theaterName, time);
	}

}
