package com.hust.hwt.homework.mapper;

import java.util.List;


import com.hust.hwt.homework.model.ClassHomeworkModel;
import org.springframework.stereotype.Component;

/**
 * @Description:
 * @author:huwentao
 * @date:2018年3月12日
 * @version 1.0  
 */
@Component
public interface ClassHomeworkMapper {

	public Integer distributeHomework(ClassHomeworkModel classHomeworkModel);
	
	public Integer duplicateDistributedHomework(ClassHomeworkModel classHomeworkModel);
	
	public List<ClassHomeworkModel> getDistributedClassList(ClassHomeworkModel classHomeworkModel);
	
	
}

