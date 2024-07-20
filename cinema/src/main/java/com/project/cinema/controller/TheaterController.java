package com.project.cinema.controller;

import org.springframework.beans.factory.annotation.Autowired;	
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import com.project.cinema.entity.Theater;
import com.project.cinema.service.TheaterServiceImpl;

import lombok.extern.slf4j.Slf4j;


@RestController
@Slf4j
public class TheaterController {
	@Autowired
	private TheaterServiceImpl service;
	
	@PostMapping("/api/theater/add")
	public String addTheater(@RequestBody Theater theater) {
		log.debug(theater.getTitle().toString());
		log.debug(theater.getRegion().toString());
		log.debug(theater.getTheater_name().toString());
		log.debug(theater.getDate().toString());
		log.debug(theater.getTime().toString());
		
		int result = service.addTheater(theater);
		return result > 0 ? "Success" : "fail";
	} 
}
