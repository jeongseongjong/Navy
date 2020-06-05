package com.biz.navy.domain;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class InventoryVO {
	private long p_code;
	private String p_name;
	private int p_price;
	private long s_code;
	private String s_size;
	private long c_code;
	private String c_color; 
	private int c_qty;
	private int p_qty;
}
