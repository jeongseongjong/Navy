package com.biz.navy.domain;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@ToString
@Builder
public class SizeVO {
	
	   private long c_p_code; 
	   private int c_black_l;
	   private int c_black_m;
	   private int c_black_s;
	   private int c_red_l;
	   private int c_red_m;
	   private int c_red_s;
	   private int c_white_l;
	   private int c_white_m;
	   private int c_white_s;

}
