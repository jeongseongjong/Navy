package com.biz.navy.utils;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;

public class DateTime {

	public static String Date() {
		LocalDate localDate = LocalDate.now();
	    String curDate = localDate.toString();
		return curDate;
	}
	
	public static String Time() {
		DateTimeFormatter dt = DateTimeFormatter.ofPattern("HH:mm:ss");
		LocalTime localTime = LocalTime.now();
		String curTime = localTime.format(dt).toString();
		return curTime;
	}
	
}
