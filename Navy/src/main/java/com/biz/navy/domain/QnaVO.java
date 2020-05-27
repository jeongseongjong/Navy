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
public class QnaVO {

   private long q_id; //  NUMBER PRIMARY KEY,
   private int q_code; // VARCHAR2(6) NOT NULL, --  (p_code ( 상품에 따라서 참조))
   private String q_title; // nVARCHAR2(255),
   private String q_text; // nVARCHAR2(1000),
   private String q_r_text; // nVARCHAR2(1000), -- ( 답변 내용)(관리자)
   private String q_auth; // VARCHAR2(64),
   private String q_date; // VARCHAR2(40)
   private String q_time; // VARCHAR2(40)

}
