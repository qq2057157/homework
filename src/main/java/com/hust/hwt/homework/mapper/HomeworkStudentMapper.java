package com.hust.hwt.homework.mapper;

import com.hust.hwt.homework.model.HomeworkStudentModel;
import org.springframework.stereotype.Component;

/**
 * @Description:
 * @author:huwentao
 * @date:2018年3月26日
 * @version 1.0  
 */
@Component
public interface HomeworkStudentMapper {

	public Integer addStudentHomework(HomeworkStudentModel homeworkStudentModel);
	
	public Integer duplicateValidate(HomeworkStudentModel homeworkStudentModel);
	
	public Integer updateStudentHomework(HomeworkStudentModel homeworkStudentModel);
	
}

