package com.hust.hwt.homework.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.hust.hwt.homework.model.HomeworkModel;
import org.springframework.stereotype.Component;

/**
 * @Description:
 * @author:huwentao
 * @date:2018年3月6日
 * @version 1.0  
 */
@Component
public interface HomeworkMapper {

	public List<HomeworkModel> getHomeworkInfo(HomeworkModel homeworkModel);
	
	public Integer totalHomework(HomeworkModel homeworkModel);
	
	public Integer updateHomeworkInfo(HomeworkModel homeworkModel);
	
	public Integer createHomework(HomeworkModel homeworkModel);
	
	public HomeworkModel getHomeworkInfoById(@Param(value = "id") Integer id);
	
	
	public List<HomeworkModel> getHomeworkInfoByClass(@Param(value = "class_id") Integer class_id, @Param(value = "student_id") Integer student_id);
	
	
}

