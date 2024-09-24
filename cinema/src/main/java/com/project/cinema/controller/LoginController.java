package com.project.cinema.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import com.project.cinema.dto.LoginDto;
import com.project.cinema.service.LoginService;

import jakarta.servlet.http.HttpSession;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class LoginController {
	@Autowired LoginService loginService;
	

	@GetMapping("/public/login") //url 요청
	public String login() {
		return "/public/login"; // 파일 경로
	}
		
	@PostMapping("/public/login")
	public String login(HttpSession session, LoginDto loginDto) {
		int pass = loginService.bringMember(loginDto, session);
		log.debug("pass ---> "+pass);
		if(pass == 1) { // 로그인 됐으면 1 아니면 2로 이동
			session.setAttribute("userId", loginDto.getId());
			session.setAttribute("userPassword", loginDto.getPassword());
			
			log.debug("Cinema controller id --> "+loginDto.getId());
			log.debug("Cinema controller userPassword --> "+loginDto.getPassword());
			return "redirect:/public/main";
			
		} else {
			return "redirect:/public/login";
		}
	}
	
	@GetMapping("/logout")
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:/public/main";
	}
	
	@GetMapping("/auth/on") // redirect:/auth/on 받으면 GetMapping으로 화면 전환.
	public String on() {
		return "/auth/on";
	}
}
