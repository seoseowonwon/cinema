package com.project.cinema.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.project.cinema.dto.MovieRatingDto;
import com.project.cinema.service.MovieRatingService;
import com.project.cinema.service.MovieTicketService;
import com.project.cinema.vo.Region;

import lombok.extern.slf4j.Slf4j;


@Slf4j
@Controller
public class CinemaController {
	@Autowired MovieRatingService movieRatingService;
	@Autowired MovieTicketService movieTicketService;
	
	@GetMapping("/public/screenList")
	public String screenList(Model model,@RequestParam(value = "no", required = false, defaultValue = "0") int no) {
//		List<MovieRatingDto> movies = movieRatingService.getAllList();
//		List<Region> regions = movieTicketService.listByRegion();
//		int number = 0;
//		for(Region rs : regions) {
//			number = rs.no;
//		}
//		int countRegion = movieTicketService.countRegionByNo(number);
//		log.info(movies.toString());
//		model.addAttribute("movies", movies);
//		model.addAttribute("regions", regions);
//		model.addAttribute("countRegion", countRegion);
//		log.info(model.toString());
		return "/public/screenList";
	}
}
