package com.hust.hwt.homework.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.hust.hwt.homework.service.QuestionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.hust.hwt.homework.model.ChoiceQuestionModel;
import com.hust.hwt.homework.model.FillBlanksQuestionModel;
import com.hust.hwt.homework.model.SAQQuestionModel;
import org.springframework.web.bind.annotation.RestController;

/** 
 * @Description:QuestionChoiceAction.java
 * @author  chengshiyang 
 * @date 创建时间：2018年1月18日 下午5:08:48 
 * @version 1.0  
 */
@RestController
@RequestMapping("homework/t/question")
public class QuestionAction {

	/**
	 * 
	 */
	@Autowired
	private QuestionService choiceQuestionService;
	
	/**
	 * 
	 * @Description:TODO
	 * @author  chengshiyang 
	 * @date 创建时间：2018年1月19日 下午2:42:36
	 * @param
	 * @return
	 */
	@RequestMapping("addchoice")
	public void addChoiceQuestionChoice(HttpServletRequest request,HttpServletResponse response,ChoiceQuestionModel questionModel){
		choiceQuestionService.addQuestionChoice(request, response, questionModel);
	}
	
	/**
	 * 
	 * @Description:TODO
	 * @author  chengshiyang 
	 * @date 创建时间：2018年1月19日 下午2:42:47
	 * @param
	 * @return
	 */
	@RequestMapping("getchoicesinfo")
	public void getChoiceQuestionInfo(HttpServletRequest request,HttpServletResponse response,
			ChoiceQuestionModel questionModel){
		choiceQuestionService.getChoiceQuestionInfo(request, response,questionModel);
	}
	/**
	 * 
	 * @Description:TODO
	 * @author  chengshiyang 
	 * @date 创建时间：2018年1月19日 下午2:42:51
	 * @param
	 * @return
	 */
	@RequestMapping("addfillblanks")
	public void addFillBlanksQuestionChoice(HttpServletRequest request,HttpServletResponse response,FillBlanksQuestionModel questionModel){
		choiceQuestionService.addQuestionFillBlanks(request, response, questionModel);
	}
	
	/**
	 * 
	 * @Description:TODO
	 * @author  chengshiyang 
	 * @date 创建时间：2018年1月19日 下午2:42:56
	 * @param
	 * @return
	 */
	@RequestMapping("getfillblanksinfo")
	public void getFillBlanksQuestionInfo(HttpServletRequest request,HttpServletResponse response,FillBlanksQuestionModel questionModel){
		choiceQuestionService.getFillBlanksQuestionInfo(request, response, questionModel);
	}
	
	/**
	 * 
	 * @Description:TODO
	 * @author  chengshiyang 
	 * @date 创建时间：2018年1月19日 下午2:42:59
	 * @param
	 * @return
	 */
	@RequestMapping("addsaq")
	public void addSAQQuestionChoice(HttpServletRequest request,HttpServletResponse response,SAQQuestionModel questionModel){
		choiceQuestionService.addQuestionSAQ(request, response, questionModel);
	}

	/**
	 * 
	 * @Description:TODO
	 * @author  chengshiyang 
	 * @date 创建时间：2018年1月19日 下午2:43:03
	 * @param
	 * @return
	 */
	@RequestMapping("getsaqinfo")
	public void getSAQQuestionInfo(HttpServletRequest request,HttpServletResponse response,SAQQuestionModel questionModel){
		choiceQuestionService.getSAQQuestionInfo(request, response, questionModel);
	}
}
