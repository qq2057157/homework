package com.hust.hwt.homework.model;


import lombok.Data;

/**
 * @Description:
 * @author:chengshiyang
 * @date:2018年3月6日
 * @version 1.0  
 */
@Data
public class HomeworkQuestionModel {

	private Integer id;
	
	private Integer homework_id;
	
	private Integer ch_id;
	
	private Integer saq_id;
	
	private Integer fb_id;
	
	private Integer question_type;
}

