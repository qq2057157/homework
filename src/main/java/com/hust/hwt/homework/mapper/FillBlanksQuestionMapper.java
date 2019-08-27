package com.hust.hwt.homework.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.hust.hwt.homework.model.FillBlanksQuestionModel;
import org.springframework.stereotype.Component;

/** 
 * @Description:FillBlanksQuestionMapper.java
 * @author  huwentao 
 * @date 创建时间：2018年1月19日 上午10:20:02 
 * @version 1.0  
 */
@Component
public interface FillBlanksQuestionMapper {

	/**
	 * 
	 * @Description:TODO
	 * @author  huwentao 
	 * @date 创建时间：2018年1月19日 上午10:20:30
	 * @param
	 * @return
	 */
	public Integer addQuestion(FillBlanksQuestionModel questionModel);

	/**
	 * 
	 * @Description:TODO
	 * @author  huwentao 
	 * @date 创建时间：2018年1月19日 上午10:20:33
	 * @param
	 * @return
	 */
	public List<FillBlanksQuestionModel> getQuestionInfo(FillBlanksQuestionModel questionModel);
	
	/**
	 * 
	 * @Description:TODO
	 * @author  huwentao 
	 * @date 创建时间：2018年1月19日 上午10:20:38
	 * @param
	 * @return
	 */
	public Integer totalQuestion(FillBlanksQuestionModel questionModel);
	
	/**
	 * 
	 * @Description:TODO
	 * @author: huwentao    
	 * @date:   2018年3月7日 下午3:45:32   
	 * @version V1.0
	 */
	public List<FillBlanksQuestionModel> getFillBlanksByHid(@Param(value = "id") Integer Id);
	
	public List<FillBlanksQuestionModel> getFillBlanksByHidAndSid(@Param(value = "hid") Integer hid, @Param(value = "sid") Integer sid);
	
	public FillBlanksQuestionModel getFillBlanksById(@Param(value = "id") Integer Id);
}
