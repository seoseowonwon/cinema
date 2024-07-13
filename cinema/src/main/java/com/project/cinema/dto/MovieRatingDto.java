package com.project.cinema.dto;

import java.util.Date;


import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
@ToString
public class MovieRatingDto {

	private int ratingNo;
	private String ratingName;
	private String ratingImageURL;
	private int movieNo;
	private String movieName;
	private long showScheduleNo;
	@JsonFormat(shape= JsonFormat.Shape.STRING, pattern="HH:mm", timezone="Asia/Seoul")
	private Date showScheduleStartTime;
}
