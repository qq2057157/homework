package com.hust.hwt.homework.model;

import java.util.Date;
import java.util.List;

import com.alibaba.fastjson.JSONObject;
import lombok.Data;

/**
 * @Description:
 * @author:chengshiyang
 * @date:2018年3月6日
 * @version 1.0  
 */
@Data
public class HomeworkModel {

	private Integer id;
	
	private String homework_name;
	
	private List<ChoiceQuestionModel> choiceQuestion;
	
	private List<FillBlanksQuestionModel> fillBlanksQuestion;
	
	private List<SAQQuestionModel> saqQuestion;
	
	private Integer choice_num;
	
	private Integer fb_num;
	
	private Integer saq_num;

	private Float score;
	
	private Float student_score;
	
	private Integer status;
	
	private Integer teacher_correct;
	
	private Date deadline;
	
	private Date updatetime;
	/**
	 * 
	 */
	private Integer teacher_id;
	
	private String teacher_name;
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
		obj.put("homework_name", this.homework_name==null?0:this.homework_name);
		obj.put("score", this.score==null?"":this.score);
		obj.put("saq_num", this.saq_num==null?"":this.saq_num);
		obj.put("fb_num", this.fb_num==null?"":this.fb_num);
		obj.put("choice_num", this.choice_num==null?"":this.choice_num);
		obj.put("status", this.status==null?0:this.status);
		obj.put("teacher_name", this.teacher_name==null?"":this.teacher_name);
		obj.put("deadline", this.deadline==null?"":this.deadline);
		obj.put("student_score", this.student_score==null?0:this.student_score);
		return obj;
		
	}
}

