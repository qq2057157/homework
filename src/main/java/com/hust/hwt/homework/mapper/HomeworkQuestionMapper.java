package com.hust.hwt.homework.mapper;

import org.apache.ibatis.annotations.Param;

import com.hust.hwt.homework.model.HomeworkQuestionModel;

/**
 * @Description:
 * @author:chengshiyang
 * @date:2018年3月7日
 * @version 1.0  
 */
public interface HomeworkQuestionMapper {

	
	public Integer addHomeworkQuestion(HomeworkQuestionModel homeworkQuestionModel);
	
	public Integer deleteHomeworkQuestion(@Param(value = "id") Integer id);
}

