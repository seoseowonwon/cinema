package com.project.cinema.controller;

import org.springframework.beans.factory.annotation.Autowired;


import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
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
	
	@GetMapping("/public/test")
	public String test() {
		return "/public/test";
	}
	
	@PostMapping("/auth/seatBooking")
    public String handleSeatBooking(@RequestParam String resDate,
    								@RequestParam String title,
                                     @RequestParam String theaterName,
                                     @RequestParam String time, Model model){
		// view단으로 전달
		model.addAttribute("title", title);
		model.addAttribute("resDate", resDate);
        model.addAttribute("theaterName", theaterName);
        model.addAttribute("time", time);
        System.out.println("Received title: " + title);
        System.out.println("Received resDate: " + resDate);
        System.out.println("Received theaterName: " + theaterName);
        System.out.println("Received time: " + time);
        
        return "/auth/seatBooking";
    }
	
	@PostMapping("/auth/confirmBooking")
	public String confirmBooking(@RequestParam String resDate,
								 @RequestParam String title,
					             @RequestParam String theaterName,
					             @RequestParam String time, 
					             @RequestParam String seats, Model model) {
		model.addAttribute("title", title);
		model.addAttribute("resDate", resDate);
        model.addAttribute("theaterName", theaterName);
        model.addAttribute("time", time);
        model.addAttribute("seats", seats);
        System.out.println("Received title: " + title);
        System.out.println("Received resDate: " + resDate);
        System.out.println("Received theaterName: " + theaterName);
        System.out.println("Received time: " + time);
		
		
		return "/auth/confirmBooking";
	}
}
