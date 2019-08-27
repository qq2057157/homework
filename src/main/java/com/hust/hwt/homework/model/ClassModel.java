package com.hust.hwt.homework.model;

import com.alibaba.fastjson.JSONObject;
import lombok.Data;

/** 
 * @Description:ClassModel.java
 * @author  chengshiyang 
 * @date 创建时间：2018年1月12日 上午11:00:46 
 * @version 1.0  
 */
@Data
public class ClassModel {

	/**
	 *
	 */
	private Integer id;
	/**
	 *
	 */
	private String class_name;
	/**
	 *
	 */
	private String class_password;
	/**
	 *
	 */
	private Integer school_id;
	/**
	 *
	 */
	private String school_name;
	/**
	 *
	 */
	private Integer teacher_id;

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

	/**
	 * 状态
	 */
	private Integer status;

	public JSONObject getClassJSONObject() {
		JSONObject classj = new JSONObject();
		classj.put("id", this.id == null ? 0 : this.id);
		classj.put("class_name", this.class_name == null ? 0 : this.class_name);
		classj.put("class_password", this.class_password == null ? "" : this.class_password);
		classj.put("school_id", this.school_id == null ? "" : this.school_id);
		classj.put("school_name", this.school_name == null ? "" : this.school_name);
		classj.put("teacher_id", this.teacher_id == null ? "" : this.teacher_id);
		classj.put("status", this.status == null ? 0 : this.status);
		return classj;

	}
}
