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
public class CsCommentVO {

    public long cs_c_id;// NUMBER PRIMARY KEY,
    public long cs_c_b_id;// NUMBER,
    public long cs_c_p_id;// NUMBER,
    public String cs_c_date;// nVARCHAR2(50),
    public String cs_c_time;// nVARCHAR2(50),
    public String cs_c_writer;// VARCHAR2(64),
    public String cs_c_subject;// nVARCHAR2(125)
}
