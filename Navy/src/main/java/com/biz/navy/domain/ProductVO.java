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
public class ProductVO {
      
	private long p_code;// number primary key, -- 시퀀스 사용
    private String p_name;// nVARCHAR2(255) Not null, -- ( = review 상품 이름),
    private int p_price;// number,
    private String p_desc;// nVARCHAR2(1000),
    private String p_image;// nVARCHAR2(255)
    private String p_size;
    private String p_color;
    private int p_qty;
    
    private List<String> m_size_list;
    private List<String> m_color_list;
    
    private List<SizeVO> p_size_list;
    private List<String> p_color_list;
    
    
    // 상품의 각 Size, Color 정보를 담을 변수
    // private List<SizeVO> sizeList;
    // private List<ColorVO> colorList;
    
    // 상품의 디테일이미지 정보를 담을 변수
    private List<ProductImgVO> proDImgList;
    
    // 상품의 회원리뷰 정보를 담을 변수
    private List<ReviewVO> reviewList;
    
    // 상품의 회원Qna 정보를 담을 변수
    private List<QnaVO> qnaList;
      
}