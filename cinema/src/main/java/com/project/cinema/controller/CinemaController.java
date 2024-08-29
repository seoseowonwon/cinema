package com.project.cinema.controller;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.project.cinema.service.MovieService;

import lombok.extern.slf4j.Slf4j;


@Slf4j
@Controller
public class CinemaController {
	@Autowired MovieService movieService;
	
	@GetMapping("/public/screenList")
	public String screenList(Model model,@RequestParam(value = "no", required = false, defaultValue = "0") int no) {
		return "/public/screenList";
	}
	
	@GetMapping("/public/main")
	public String main() {
		return "/public/main";
	}
	
	//Test용
	@GetMapping("/public/test")
	public String test() {
		return "/public/test";
	}
	
	
	// movie_no의 영화관 좌석 예매 페이지가 있는가? return 값으로 판단하는 메서드
	@GetMapping("/auth/seatBooking")
	public String getSeatInfo(@RequestParam("movieNo") String movieNo, Model model){
		log.debug("getSeatInfo movieNo: {}", movieNo);
		// 해당 movie_no의 영화 좌석 테이블이 있는지 체크 
		int check = movieService.checkSeats(movieNo);
		if(check == 0) { // 테이블에 해당하는 값이 없을 때 INSERT INTO
			movieService.insertSeats(movieNo);
		}
		// 좌석 정보를 가져와서 모델에 추가
		Map<String, Object> result = movieService.getSeatInfo(movieNo);
		log.debug("CinemaController result --> " + result.toString());
		model.addAttribute("result", result);
		// seatBooking.jsp로 이동
		return "/auth/seatBooking";
	}

}
