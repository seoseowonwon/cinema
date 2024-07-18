package com.project.cinema.controller;

import org.springframework.beans.factory.annotation.Autowired;


import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.project.cinema.service.MovieRatingService;

import lombok.extern.slf4j.Slf4j;


@Slf4j
@Controller
public class CinemaController {
	@Autowired MovieRatingService movieRatingService;
	
	@GetMapping("/public/screenList")
	public String screenList(Model model,@RequestParam(value = "no", required = false, defaultValue = "0") int no) {
		
		return "/public/screenList";
	}
	
	
	@GetMapping("/public/main")
	public String main() {
		
		return "/public/main";
	}
}
