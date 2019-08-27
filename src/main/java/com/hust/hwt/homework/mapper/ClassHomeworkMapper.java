package com.hust.hwt.homework.mapper;

import java.util.List;


import com.hust.hwt.homework.model.ClassHomeworkModel;

/**
 * @Description:
 * @author:chengshiyang
 * @date:2018年3月12日
 * @version 1.0  
 */
public interface ClassHomeworkMapper {

	public Integer distributeHomework(ClassHomeworkModel classHomeworkModel);
	
	public Integer duplicateDistributedHomework(ClassHomeworkModel classHomeworkModel);
	
	public List<ClassHomeworkModel> getDistributedClassList(ClassHomeworkModel classHomeworkModel);
	
	
}

