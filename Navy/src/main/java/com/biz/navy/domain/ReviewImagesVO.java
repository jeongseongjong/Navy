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
public class ReviewImagesVO {

	private long r_img_seq;			// NUMBER PRIMARY KEY,
	private long r_img_p_code; 		// number, -- ( 갤러리 테이블 IMG_SEQ 참조)
	private String r_img_origin_name; 	// nVARCHAR2(255),
	private String r_img_upload_name; 	// nVARCHAR2(255)
}
