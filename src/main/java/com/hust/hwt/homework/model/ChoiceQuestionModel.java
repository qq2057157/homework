package com.hust.hwt.homework.model;

import java.sql.Timestamp;

import com.alibaba.fastjson.JSONObject;
import lombok.Data;

/** 
 * @Description:ChoiceModel.java
 * @author  chengshiyang 
 * @date 创建时间：2018年1月18日 下午4:15:43 
 * @version 1.0  
 */
@Data
public class ChoiceQuestionModel {

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
	private Integer question_type;

	/**
	 *
	 */
	private String choice_a;

	/**
	 *
	 */
	private String choice_b;

	/**
	 *
	 */
	private String choice_c;

	/**
	 *
	 */
	private String choice_d;

	/**
	 *
	 */
	private String answer;

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
	private Float score;

	/**
	 *
	 */
	private Timestamp createtime;

	/**
	 * 总条数
	 */
	private Integer sumNum;

	/**
	 * 显示条数
	 */
	private Integer pageSize;

	/**
	 * 当前页
	 */
	private Integer currentPage;

	/**
	 * 起始条数
	 */
	private Integer start;

	public JSONObject toJSONObject() {
		JSONObject obj = new JSONObject();
		obj.put("id", this.id == null ? 0 : this.id);
		obj.put("question", this.question == null ? 0 : this.question);
		obj.put("choice_a", this.choice_a == null ? "" : this.choice_a);
		obj.put("choice_b", this.choice_b == null ? "" : this.choice_b);
		obj.put("choice_c", this.choice_c == null ? "" : this.choice_c);
		obj.put("choice_d", this.choice_d == null ? "" : this.choice_d);
		obj.put("answer", this.answer == null ? "" : this.answer);
		obj.put("student_answer", this.student_answer == null ? "" : this.student_answer);
		obj.put("score", this.score == null ? "" : this.score);
		obj.put("student_score", this.student_score == null ? 0 : this.student_score);
		return obj;

	}
}
