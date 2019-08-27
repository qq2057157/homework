package com.hust.hwt.homework.model;

import lombok.Data;

import java.util.Date;

/**
 * @Description:
 * @author:chengshiyang
 * @date:2018年3月26日
 * @version 1.0  
 */
@Data
public class AnwserStudentModel {
	
	private Integer id;
	
	private Integer homework_id;
	
	private Integer student_id;
	
	private Integer question_id;
	
	private Integer question_type;
	
	private String answer;
	
	private Float score;
	
	private Date createtime;
}

