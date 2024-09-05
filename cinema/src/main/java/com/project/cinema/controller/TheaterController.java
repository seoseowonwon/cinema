package com.project.cinema.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

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

	@GetMapping("/api/theater/checkDateResult")
	public int checkDateResult(String date) {
		return movieService.checkDateResult(date);
	}
	
	
	@GetMapping("/api/theater/checkTitle")
	public int checkTitle(String title) {
		log.debug("checkTitle title: {}", title);
		return movieService.checkTitle(title);
	}

	@GetMapping("/api/theater/getInfo")
	public List<Map<String, Object>> getRegionInfo(String title) {
		log.debug("getRegionInfo title: {}", title);
		return movieService.getRegionInfo(title);
	}

	// 지역명을 전달 받아 해당지역에 상영 중인 극장명을 불러옴
	@GetMapping("/api/theater/getTheaterInfo")
	public List<Map<String, Object>> getTheaterInfo(String title, String region) {
		log.debug("getTheaterInfo title: {}", title);
		log.debug("getTheaterInfo region: {}", region);
		return movieService.getTheaterInfo(title, region);
	}

	// 극장명을 받아 상영 시간을 받음
	@PostMapping("/api/theater/getTimeInfo")
	public List<Map<String, Object>> getTimeInfo(@RequestBody Map<String, String> requestData) {
		String title = requestData.get("title");
		String region = requestData.get("region");
		String theaterName = requestData.get("theater_name");

		log.debug("getTimeInfo title: {}", title);
		log.debug("getTimeInfo region: {}", region);
		log.debug("getTimeInfo theaterName: {}", theaterName);
		return movieService.getTimeInfo(title, region, theaterName);
	}

	// 예약 날짜, 극장, 시간 등을 입력받아 예약 날짜를 수정
	@PostMapping("/api/theater/updateResDate")
	public int updateResDate(@RequestBody Map<String, String> requestData) {
		String resDate = requestData.get("res_date");
		String theaterName = requestData.get("theater_name");
		String time = requestData.get("time");

		log.debug("updateResDate res_date: {}", resDate);
		log.debug("updateResDate theaterName: {}", theaterName);
		log.debug("updateResDate time: {}", time);

		return movieService.updateResDate(resDate, theaterName, time);
	}

	// 파라미터값에 해당되는 예약하고자 하는 영화의 id를 가져 옴
	@PostMapping("/api/theater/bringMovieNo")
	public String bringMovieNo(@RequestBody Map<String, Object> getMovieNoInfo) {
		String title = (String) getMovieNoInfo.get("title");
		String theaterName = (String) getMovieNoInfo.get("theater_name");
		String resDate = (String) getMovieNoInfo.get("res_date");
		String time = (String) getMovieNoInfo.get("time");
		String result = movieService.bringMovieNo(title, theaterName, resDate, time);
		
		log.debug("bringMovieNo title: {}", title);
		log.debug("bringMovieNo theater_name: {}", theaterName);
		log.debug("bringMovieNo res_date: {}", resDate);
		log.debug("bringMovieNo time: {}", time);
		log.debug("bringMovieNo result --> {}", result);
		return result;
	}
	
}
