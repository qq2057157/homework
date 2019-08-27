package com.hust.hwt.homework.model;

import com.alibaba.fastjson.JSONObject;
import lombok.Data;

/** 
 * @Description:StudentModel.java
 * @author  chengshiyang 
 * @date 创建时间：2018年1月11日 上午11:00:15 
 * @version 1.0  
 */
@Data
public class StudentModel {
	/**
	 * 
	 */
	private Integer id;
	/**
	 * 
	 */
	private String name;
	/**
	 * 
	 */
	private String username;
	/**
	 * 
	 */
	private String password;
	/**
	 * 
	 */
	private String phone;
	/**
	 * 
	 */
	private String email;
	/**
	 * 
	 */
	private Integer class_id;
	/**
	 * 
	 */
	private Integer school_id;
	/**
	 * 
	 */
	private String class_name;
	
	/**
	 * 
	 */
	private String school_name;
	
	/**
	 * 
	 */
	private HomeworkStudentModel homeworkStudentModel;
	
	/**总条数*/
	private Integer sumNum;
	
	/**显示条数*/
	private Integer pageSize;

	/**当前页*/
	private Integer currentPage;
	
	/**起始条数*/
	private Integer start;

	public JSONObject getStudentJSONObject(){
		JSONObject obj = new JSONObject();
		obj.put("id", this.id==null?0:this.id);
		obj.put("name", this.name==null?0:this.name);
		obj.put("username", this.username==null?"":this.username);
		obj.put("phone", this.phone==null?"":this.phone);
		obj.put("email", this.email==null?"":this.email);
		obj.put("class_name", this.class_name==null?"":this.class_name);
		obj.put("school_name", this.school_name==null?"":this.school_name);
		obj.put("homework", this.homeworkStudentModel==null?"":this.homeworkStudentModel.toJSONObject());
		return obj;
		
	}
}
