package com.project.cinema.vo;

import lombok.AllArgsConstructor;

import lombok.Builder;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Region {

	public int no;
	public String name;
	public int getNo() {
		return no;
	}
	public void setNo(int no) {
		this.no = no;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		if(name.equals("대전")) {
			this.name = name + "/충청/세종";
		} else if(name.equals("부산")) {
			this.name = name + "/대구/경상";
		} else if(name.equals("광주")) {
			this.name = name + "/전라";
		} else {
			this.name = name;
		}
	}
	@Override
	public String toString() {
		return "Region [no=" + no + ", name=" + name + "]";
	}
	
}
