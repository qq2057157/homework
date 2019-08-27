package com.hust.hwt.homework.model;

import com.alibaba.fastjson.JSONObject;
import lombok.Data;

/** 
 * @Description:SchoolModel.java
 * @author  chengshiyang 
 * @date 创建时间：2018年1月11日 下午2:35:05 
 * @version 1.0  
 */
@Data
public class SchoolModel {

	/**
	 * 
	 */
	private Integer id;
	/**
	 * 
	 */
	private String schoolname;
	/**
	 * 
	 */
	private String address;
	/**
	 * 
	 */
	private String schooltype;

	public JSONObject getSchoolJSONObject(){
		JSONObject school = new JSONObject();
		school.put("id", this.id==null?0:this.id);
		school.put("schoolname", this.schoolname==null?0:this.schoolname);
		school.put("address", this.address==null?"":this.address);
		school.put("schooltype", this.schooltype==null?"":this.schooltype);
		return school;
		
	}

	@Override
	public String toString() {
		return "SchoolModel{" +
				"id=" + id +
				", schoolname='" + schoolname + '\'' +
				", address='" + address + '\'' +
				", schooltype='" + schooltype + '\'' +
				'}';
	}
}
