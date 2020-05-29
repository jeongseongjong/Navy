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
public class CsVO {
    private long cs_id;// NUMBER PRIMARY KEY,
    private String cs_username;// VARCHAR2(64),
    private String cs_title;// nVARCHAR2(255),
    private String cs_text;// nVARCHAR2(1000),
    private String cs_date;// nVARCHAR2(50),
    private String cs_time;// nVARCHAR2(50),
    private String cs_file;// nVARCHAR2(255)
    private int cs_count;
}
