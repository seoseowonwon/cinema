package com.project.cinema.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.project.cinema.dto.LoginDto;
import com.project.cinema.service.LoginService;
import com.project.cinema.service.MovieService;

import jakarta.servlet.http.HttpSession;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class CinemaController {
	@Autowired
	MovieService movieService;
	@Autowired
	LoginService loginService;

	@GetMapping("/public/screenList")
	public String screenList(Model model, @RequestParam(value = "no", required = false, defaultValue = "0") int no) {
		return "/public/screenList";
	}

	@GetMapping("/public/main")
	public String main() {
		return "/public/main";
	}

	// Test용
	@GetMapping("/public/test")
	public String test() {
		return "/public/test";
	}

	// movie_no의 영화관 좌석 예매 페이지가 있는가? return 값으로 판단하는 메서드
	@GetMapping("/auth/seatBooking")
	public String getSeatInfo(@RequestParam("movieNo") String movieNo, Model model, HttpSession session) {
		
		//로그인 안되어 있을 경우 리다이렉트
		if (session == null || session.getAttribute("userId") == null) {
			return "redirect:/public/login"; // 로그인 페이지로 리다이렉트
		}

		log.debug("getSeatInfo movieNo: {}", movieNo);
		// 해당 movie_no의 영화 좌석 테이블이 있는지 체크
		int check = movieService.checkSeats(movieNo);
		if (check == 0) { // 테이블에 해당하는 값이 없을 때 INSERT INTO
			movieService.insertSeats(movieNo);
		}
		// 좌석 정보를 가져와서 모델에 추가
		Map<String, Object> result = movieService.getSeatInfo(movieNo);
		log.debug("CinemaController result --> " + result.toString());
		model.addAttribute("result", result);
		// seatBooking.jsp로 이동
		return "/auth/seatBooking";
	}

	// 선택한 좌석의 값을 받음
	@PostMapping("/auth/payment")
	public String handleCheckbox(@RequestParam("default") int defaultSelection,
								@RequestParam("teenager") int teenagerSelection, 
								@RequestParam("seats") List<String> selectedSeats,
								Model model, HttpSession session) {
		
		//로그인 안되어 있을 경우 리다이렉트
		if (session == null || session.getAttribute("userId") == null) {
			return "redirect:/public/login"; // 로그인 페이지로 리다이렉트
		}
		
		log.debug("Selected default: {}", defaultSelection);
		log.debug("Selected teenager: {}", teenagerSelection);
		log.debug("Selected seats: {}", selectedSeats);

		// 선택된 좌석 값을 모델에 추가하여 뷰로 전달
		model.addAttribute("selectedSeats", selectedSeats);
		model.addAttribute("defaultSelection", defaultSelection);
		model.addAttribute("teenagerSelection", teenagerSelection);

		return "/auth/payment";
	}

	@PostMapping("/auth/done")
	public String payment(@RequestParam("seats") List<String> seats, 
						  @RequestParam("movieNo") String movieNo,
						  HttpSession session) {
		
		//로그인 안되어 있을 경우 리다이렉트
		if (session == null || session.getAttribute("userId") == null) {
			return "redirect:/public/login"; // 로그인 페이지로 리다이렉트
		}
		movieService.updateResvSeats(seats, movieNo);
		log.debug("Received seats: {}", seats);

		return "/public/main";
	}

}
