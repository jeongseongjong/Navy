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
	
	private long c_id ;// number PRIMARY KEY,
	private String c_p_code; // VARCHAR(6) ,
	private String c_size; // VARCHAR(255),
	private long c_qty; // number

}
