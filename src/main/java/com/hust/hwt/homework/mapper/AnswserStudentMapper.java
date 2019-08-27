package com.hust.hwt.homework.mapper;

import com.hust.hwt.homework.model.AnwserStudentModel;

/**
 * @Description:
 * @author:chengshiyang
 * @date:2018年3月26日
 * @version 1.0  
 */
public interface AnswserStudentMapper {

	public Integer addStudentAnwser(AnwserStudentModel anwserStudentModel);
	
	public Integer duplicateValidate(AnwserStudentModel anwserStudentModel);
	
	public Integer updateStudentAnwser(AnwserStudentModel anwserStudentModel);

	public Float getSumScore(AnwserStudentModel anwserStudentModel);
	
	
}

