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
public class InventoryChangeVO {
    private long ch_id;// NUMBER PRIMARY KEY,
    private long ch_p_code;// VARCHAR(6),
    private String ch_p_name;// nVARCHAR2(255),
    private String ch_date;// nVARCHAR2(50),
    private String ch_time;// nVARCHAR2(50),
    private long ch_inout;// INT,
    private long ch_qty;// NUMBER,
    private long ch_price;// NUMBER
}
