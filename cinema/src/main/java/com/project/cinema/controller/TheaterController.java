package com.project.cinema.controller;


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
import com.fasterxml.jackson.databind.ObjectMapper;

import lombok.extern.slf4j.Slf4j;


@RestController
@Slf4j
public class TheaterController {

	@Autowired
	private MovieService movieService;
	private final ObjectMapper objectMapper = new ObjectMapper();
	
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
	
	@GetMapping("/api/theater/checkTitle")
	public int checkTitle(String title) {
		return movieService.checkTitle(title);
	}
	
	@GetMapping("/api/theater/getInfo")
    public List<Map<String, Object>> getRegionInfo() {
        return movieService.getRegionInfo();
    }
	
	// 지역명을 전달 받아 해당지역에 상영 중인 극장명을 불러옴
	@GetMapping("/api/theater/getTheaterInfo")
	public List<Map<String, Object>> getTheaterInfo(String region) {
		return movieService.getTheaterInfo(region);
	}
	
	// 극장명을 받아 상영 시간을 받음
	@GetMapping("/api/theater/getTimeInfo")
	public List<Map<String, Object>> getTimeInfo(@RequestParam(name = "theater_name") String theaterName){
		log.debug("theaterName: ",theaterName);
		return movieService.getTimeInfo(theaterName);
	}
	
	// 예약 날짜, 극장, 시간 등을 입력받아 예약 날짜를 수정
	@PostMapping("/api/theater/updateResDate")
	public int updateResDate(@RequestBody Map<String, String> requestData) {
	    String resDate = requestData.get("res_date");
	    String theaterName = requestData.get("theater_name");
	    String time = requestData.get("time");

	    log.debug("res_date: ", resDate);
	    log.debug("theaterName: ", theaterName);
	    log.debug("time: ", time);

	    return movieService.updateResDate(resDate, theaterName, time);
	}
	
	
	// 제목, 극장, 예약 날짜, 예약 시간, 선택된 좌석 값들을 받아 좌석 값을 null -> 'A1'등으로 변경
	@PostMapping("/auth/saveSeats")
	public int updateSeats(@RequestBody Map<String, Object> updateSeatInfo) {
			String title = (String) updateSeatInfo.get("title");
			String theaterName = (String) updateSeatInfo.get("theater_name");
			String resDate = (String) updateSeatInfo.get("res_date");
		    String time = (String) updateSeatInfo.get("time");
		    String seats  =(String) updateSeatInfo.get("seats");
		    
		    log.debug("title: ", title);
			log.debug("theater_name: ", theaterName);
			log.debug("res_date: ", resDate);
			log.debug("time: ", time);
			log.debug("seats: ", seats);
			
		    return movieService.updateSeats(title, theaterName, resDate, time, seats);
	}
	
	@GetMapping("/api/theater/checkDateResultDelete")
	public int checkDateResultDelete(String date) {
		return movieService.checkDateResultDelete(date);
	}
	
	// 파라미터값에 해당되는 예약하고자 하는 영화의 id를 가져 옴
	@GetMapping("/api/theater/bringMovieNo")
	public int bringMovieNo(String title, String theaterName, String resDate, String time){
		return movieService.bringMovieNo(title, theaterName, resDate, time);
	}
	
//	@PostMapping("/auth/seatBooking")
//	public List<Map<String, String>> getSeatInfo(String title, String theaterName, String resDate, String time){
//		return movieService.getSeatInfo(title, theaterName, resDate, time);
//	}
}
