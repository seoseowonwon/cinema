package com.project.cinema.vo;

import lombok.AllArgsConstructor;

import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;


@Setter
@Getter
@ToString
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class Theater {

	private int no;
	private String name;
	private String streetAddress;
	private double longitude;
	private double latitude;
	private int regionNo;
	
}
