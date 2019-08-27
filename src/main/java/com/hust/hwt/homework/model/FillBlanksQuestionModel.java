package com.hust.hwt.homework.model;

import java.sql.Timestamp;

import com.alibaba.fastjson.JSONObject;
import lombok.Data;

/** 
 * FillBlanksQuestionModel.java
 * @author  chengshiyang 
 * @date 创建时间：2018年1月19日 上午10:15:43 
 * @version 1.0  
 */
@Data
public class FillBlanksQuestionModel {

	/**
	 * 
	 */
	private Integer id;
	
	/**
	 * 
	 */
	private Integer teacher_id;

	/**
	 * 
	 */
	private String question;

	/**
	 * 
	 */
	private String answer;
	
	/**
	 * 
	 */
	private Float score;
	
	/**
	 * 
	 */
	private String student_answer;

	/**
	 * 
	 */
	private Float student_score;

	/**
	 * 
	 */
	private Timestamp createtime;

	/**总条数*/
	private Integer sumNum;
	
	/**显示条数*/
	private Integer pageSize;
	
	/**当前页*/
	private Integer currentPage;
	
	/**起始条数*/
	private Integer start;


	public JSONObject toJSONObject(){
		JSONObject obj = new JSONObject();
		obj.put("id", this.id==null?0:this.id);
		obj.put("question", this.question==null?0:this.question);
		obj.put("answer", this.answer==null?"":this.answer);
		obj.put("score", this.score==null?"":this.score);
		obj.put("answer", this.answer==null?"":this.answer);
		obj.put("student_answer", this.student_answer==null?"":this.student_answer);
		obj.put("student_score", this.student_score==null?0:this.student_score);
		return obj;
		
	}

}
