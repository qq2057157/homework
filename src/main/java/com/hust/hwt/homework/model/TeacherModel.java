package com.hust.hwt.homework.model;

import lombok.Data;

/**
 * @Description:TeacherModel.java
 * @author  huwentao 
 * @date 创建时间：2018年1月10日 下午5:16:30 
 * @version 1.0  
 */
@Data
public class TeacherModel {
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
	private Integer school_id;

	@Override
	public String toString() {
		return "TeacherModel{" +
				"id=" + id +
				", name='" + name + '\'' +
				", username='" + username + '\'' +
				", password='" + password + '\'' +
				", phone='" + phone + '\'' +
				", email='" + email + '\'' +
				", school_id=" + school_id +
				'}';
	}
}
