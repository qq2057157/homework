package com.hust.hwt.homework.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.hust.hwt.homework.model.FillBlanksQuestionModel;
import com.hust.hwt.homework.model.SAQQuestionModel;
import org.springframework.stereotype.Component;

/** 
 * @Description:SAQQuestionMapper.java
 * @author  huwentao 
 * @date 创建时间：2018年1月19日 下午2:33:19 
 * @version 1.0  
 */
@Component
public interface SAQQuestionMapper {

	/**
	 * 
	 * @Description:TODO
	 * @author  huwentao 
	 * @date 创建时间：2018年1月19日 下午2:33:41
	 * @param
	 * @return
	 */
	public Integer addQuestion(SAQQuestionModel questionModel);

	/**
	 * 
	 * @Description:TODO
	 * @author  huwentao 
	 * @date 创建时间：2018年1月19日 下午2:33:49
	 * @param
	 * @return
	 */
	public List<SAQQuestionModel> getQuestionInfo(SAQQuestionModel questionModel);
	
	/**
	 * 
	 * @Description:TODO
	 * @author  huwentao 
	 * @date 创建时间：2018年1月19日 下午2:33:45
	 * @param
	 * @return
	 */
	public Integer totalQuestion(SAQQuestionModel questionModel);
	
	public List<SAQQuestionModel> getSAQByHid(@Param(value = "id") Integer Id);
	
	public List<SAQQuestionModel> getSAQByHidAndSid(@Param(value = "hid") Integer hid, @Param(value = "sid") Integer sid);

	public SAQQuestionModel getSAQById(@Param(value = "id") Integer Id);
}
