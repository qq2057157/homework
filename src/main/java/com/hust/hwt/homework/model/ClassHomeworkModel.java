package com.hust.hwt.homework.model;

import java.util.Date;

import com.alibaba.fastjson.JSONObject;
import lombok.Data;

/**
 * @Description:
 * @author:huwentao
 * @date:2018年3月12日
 * @version 1.0  
 */
@Data
public class ClassHomeworkModel {
	private Integer id;
	
	private Integer homework_id;
	
	private Integer class_id;
	
	private String class_name;
	
	private Integer teacher_id;
	
	private Integer status;
	
	private Date deadline;
	
	private Date createtime;
	
	private Integer teacher_correct;

	public JSONObject toJSONObject(){
		JSONObject obj = new JSONObject();
		obj.put("id", this.id==null?0:this.id);
		obj.put("homework_id", this.homework_id==null?0:this.homework_id);
		obj.put("class_id", this.class_id==null?"":this.class_id);
		obj.put("class_name", this.class_name==null?"":this.class_name);
		obj.put("teacher_id", this.teacher_id==null?"":this.teacher_id);
		obj.put("status", this.status==null?"":this.status);
		obj.put("deadline", this.deadline==null?"":this.deadline);
		return obj;
	}
}

