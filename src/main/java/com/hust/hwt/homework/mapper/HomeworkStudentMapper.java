package com.hust.hwt.homework.mapper;

import com.hust.hwt.homework.model.HomeworkStudentModel;

/**
 * @Description:
 * @author:chengshiyang
 * @date:2018年3月26日
 * @version 1.0  
 */
public interface HomeworkStudentMapper {

	public Integer addStudentHomework(HomeworkStudentModel homeworkStudentModel);
	
	public Integer duplicateValidate(HomeworkStudentModel homeworkStudentModel);
	
	public Integer updateStudentHomework(HomeworkStudentModel homeworkStudentModel);
	
}

