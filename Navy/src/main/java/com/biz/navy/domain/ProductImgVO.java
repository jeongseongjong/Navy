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
public class ProductImgVO {
	
	   private long p_img_seq;
	   private long p_img_p_code;
	   private String p_img_origin_name;
	   private String p_img_upload_name;

}
