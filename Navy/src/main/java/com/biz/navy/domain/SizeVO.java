package com.biz.navy.domain;

import java.util.List;

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
	
	private long s_code; // number primary key, -- 시퀀스
    private int s_p_code; // number , -- tbl_color의 p_code와 fk될 값
    private String s_size; // VARCHAR(255)
    
    // 상품의 color 정보를 담을 변수
    private List<ColorVO> colorList;

}
