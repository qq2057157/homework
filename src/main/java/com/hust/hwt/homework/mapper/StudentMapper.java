package com.hust.hwt.homework.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.hust.hwt.homework.model.StudentModel;
import org.springframework.stereotype.Component;

/** 
 * @Description:StudentMapper.java
 * @author  chengshiyang 
 * @date 创建时间：2018年1月11日 上午11:03:29 
 * @version 1.0  
 */
@Component
public interface StudentMapper {
	/**
	 * 
	 * @Description:TODO
	 * @author  chengshiyang 
	 * @date 创建时间：2018年1月19日 下午4:37:29
	 * @param
	 * @return
	 */
	public StudentModel studentLogin(StudentModel studentModel);
	/**
	 * 
	 * @Description:TODO
	 * @author  chengshiyang 
	 * @date 创建时间：2018年1月19日 下午4:37:32
	 * @param
	 * @return
	 */
	public Integer studentRegister(StudentModel studentModel);
	/**
	 * 
	 * @Description:TODO
	 * @author  chengshiyang 
	 * @date 创建时间：2018年1月19日 下午4:37:35
	 * @param
	 * @return
	 */
	public List<StudentModel> getStudentsByClass(StudentModel studentModel);

	/**
	 * 
	 * @Description:TODO
	 * @author  chengshiyang 
	 * @date 创建时间：2018年1月19日 下午4:41:00
	 * @param
	 * @return
	 */
	public Integer totalStudentsByClass(StudentModel studentModel);
	/**
	 * 
	 * @Description:TODO
	 * @author  chengshiyang 
	 * @date 创建时间：2018年1月19日 下午4:37:35
	 * @param
	 * @return
	 */
	public StudentModel getStudentInfoById(@Param(value = "id") Integer id);
	
	public List<StudentModel> getStudentsHomeWorkByClass(@Param(value = "class_id") Integer class_id, @Param(value = "homework_id") Integer homework_id);
	
}