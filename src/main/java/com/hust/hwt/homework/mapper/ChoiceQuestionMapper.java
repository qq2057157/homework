package com.hust.hwt.homework.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.hust.hwt.homework.model.ChoiceQuestionModel;
import com.hust.hwt.homework.model.ClassModel;
import org.springframework.stereotype.Component;

/** 
 * @Description:ChoiceQuestionMapper.java
 * @author  huwentao 
 * @date 创建时间：2018年1月18日 下午4:26:07 
 * @version 1.0  
 */
@Component
public interface ChoiceQuestionMapper {
	
	/**
	 * 
	 * @Description:添加单选题
	 * @author  huwentao 
	 * @date 创建时间：2018年1月18日 下午4:43:21
	 * @param
	 * @return
	 */
	public Integer addQuestionChoice(ChoiceQuestionModel choiceQuestionModel);
	
	/**
	 * 
	 * @Description:分页取得单选题
	 * @author  huwentao 
	 * @date 创建时间：2018年1月18日 下午4:43:28
	 * @param
	 * @return
	 */
	public List<ChoiceQuestionModel> getChoiceQuestionInfo(ChoiceQuestionModel choiceQuestionModel);
	
	/**
	 * 
	 * @Description:取得单选题总数
	 * @author  huwentao 
	 * @date 创建时间：2018年1月18日 下午4:43:31
	 * @param
	 * @return
	 */
	public Integer totalQuestion(ChoiceQuestionModel choiceQuestionModel);
	
	/**
	 * 
	 * @Description:根据作业id取得与作业关联的单选题信息
	 * @author: huwentao    
	 * @date:   2018年3月7日 下午2:42:07   
	 * @version V1.0
	 */
	public List<ChoiceQuestionModel> getChoicesByHid(@Param(value = "id") Integer Id);
	
	public List<ChoiceQuestionModel> getChoicesByHidAndSId(@Param(value = "hid") Integer hid, @Param(value = "sid") Integer sid);
	
	public ChoiceQuestionModel getChoicesById(@Param(value = "id") Integer Id);
}
