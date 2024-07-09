package com.project.cinema.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.project.cinema.dto.LoginDto;
import com.project.cinema.mapper.LoginMapper;

import lombok.extern.slf4j.Slf4j;

@Transactional
@Service
@Slf4j
public class LoginService {
	@Autowired LoginMapper loginMapper;
	
	public int bringMember(LoginDto loginDto){ // 아이디 비밀번호 비교 후 로그인 결정
		log.debug("memberMapper Data --> "+loginMapper.selectMember(loginDto.getId()));
		Map<String, Object> userInfo = loginMapper.selectMember(loginDto.getId());
		//디버깅
		log.debug("userInfo -->"+userInfo.toString());
		log.debug("user password -->"+userInfo.get("password"));
		log.debug("member.getPassword -->"+loginDto.getPassword());
		
		//입력한 ID, PW와 DB의 ID, PW값이 일치할 때,
		if(loginDto.getId().equals(userInfo.get("id")) 
				&& loginDto.getPassword().equals(userInfo.get("password"))){
			return 1; // 일치하면 1을 반환
		} else {
			return 0; // 불일치시 0을 반환
		}
	}
	
}
