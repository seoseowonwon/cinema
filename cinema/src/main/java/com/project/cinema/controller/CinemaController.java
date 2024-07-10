package com.project.cinema.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import lombok.extern.slf4j.Slf4j;


@Slf4j
@Controller
public class CinemaController {
	@GetMapping("/public/screenList")
	public String screenList() {
		return "/public/screenList";
	}
}
