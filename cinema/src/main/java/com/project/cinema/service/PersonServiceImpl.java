package com.project.cinema.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.project.cinema.entity.Person;
import com.project.cinema.mapper.PersonMapper;

import lombok.extern.slf4j.Slf4j;

@Service
@Transactional
@Slf4j
public class PersonServiceImpl implements PersonService{
	@Autowired PersonMapper personMapper;

	@Override
	public int addPerson(Person person) {
        return personMapper.insertPerson(person);
	}
		
}
