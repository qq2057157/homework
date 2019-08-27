package com.hust.hwt.homework.model;

import java.util.Date;

import com.alibaba.fastjson.JSONObject;
import lombok.Data;

/**
 * @Description:
 * @author:chengshiyang
 * @date:2018年3月29日
 * @version 1.0  
 */
@Data
public class HomeworkStudentModel {
	
	private Integer id;
	
	private Integer homework_id;
	
	private Integer student_id;
	
	private Integer status;
	
	private Float score;
	
	private Date completedtime;

	public JSONObject toJSONObject(){
		JSONObject obj = new JSONObject();
		obj.put("id", this.id==null?0:this.id);
		obj.put("homework_id", this.homework_id==null?0:this.homework_id);
		obj.put("student_id", this.student_id==null?"":this.student_id);
		obj.put("status", this.status==null?"":this.status);
		obj.put("completedtime", this.completedtime==null?"":this.completedtime);
		obj.put("score", this.score==null?0:this.score);
		return obj;
	}
}

