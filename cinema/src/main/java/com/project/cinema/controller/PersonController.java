package com.project.cinema.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import com.project.cinema.entity.Person;
import com.project.cinema.service.PersonServiceImpl;

import lombok.extern.slf4j.Slf4j;

@RestController
@Slf4j
public class PersonController {
	@Autowired
	private PersonServiceImpl service;
	
	@PostMapping("/api/person/add")
	public ResponseEntity<String> addPerson(@RequestBody Person person) {
		log.debug("PostMapping");
		int result = service.addPerson(person);
		return result > 0 ? ResponseEntity.ok("Success") : ResponseEntity.ok("fail");
	}
}
