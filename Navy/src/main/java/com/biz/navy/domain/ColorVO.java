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
public class ColorVO {

	 private long c_code; // number primary key,
	 private String c_color; // nvarchar2(255),
	 private int c_s_code; // number, -- s_code 랑 fk될 값
	 private int c_qty; // number
	 
}
