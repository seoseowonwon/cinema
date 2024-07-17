package com.project.cinema.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.project.cinema.entity.Person;
import com.project.cinema.service.MovieRatingService;
import com.project.cinema.service.MovieTicketService;
import com.project.cinema.service.PersonServiceImpl;

import lombok.extern.slf4j.Slf4j;


@Slf4j
@Controller
public class CinemaController {
	@Autowired MovieRatingService movieRatingService;
	@Autowired MovieTicketService movieTicketService;
	
	@GetMapping("/public/screenList")
	public String screenList(Model model,@RequestParam(value = "no", required = false, defaultValue = "0") int no) {
		// Model을 통해 controller에서 view로 데이터 전달
		// required = false: no가 필수가 아님을 표시
		// defaultValue : no가 없을 경우 "0"으로 표시
		
//		List<MovieRatingDto> movies = movieRatingService.getAllList(); // rating_no, rating_name, ratingImageURL, movieNo, movieName 값 
//		List<Region> regions = movieTicketService.listByRegion(); // region_no, region_name 값
//		int number = 0;
//		for(Region rs : regions) {
//			number = rs.no;
//		}
//		int countRegion = movieTicketService.countRegionByNo(number); // 상영 지역과 극장이 일치하는 전체 수
//		log.info(movies.toString());
//		model.addAttribute("movies", movies);
//		model.addAttribute("regions", regions);
//		model.addAttribute("countRegion", countRegion);
//		log.info(model.toString());
		return "/public/screenList";
	}
	
	
	@GetMapping("/public/main")
	public String main() {
		
		return "/public/main";
	}
}
