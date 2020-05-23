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
public class ReviewVO {
		
   private long r_id; // number primary key,
   private String r_text; // nvarchar2(1000),
   private int r_start; // int, ?
   private int r_code; // varchar2(6) not null, -- (p_code 참조해서 p_name 가져오기)
   private String r_auth; // varchar2(64),
   private String r_date; // varchar2(40),
   private String r_image; // varchar2(255),
   private int r_like; // number -- 추천

}
