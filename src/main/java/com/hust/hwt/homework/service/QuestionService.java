package com.hust.hwt.homework.service;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.hust.hwt.homework.mapper.ChoiceQuestionMapper;
import com.hust.hwt.homework.mapper.FillBlanksQuestionMapper;
import com.hust.hwt.homework.mapper.SAQQuestionMapper;
import com.hust.hwt.homework.model.ChoiceQuestionModel;
import com.hust.hwt.homework.model.FillBlanksQuestionModel;
import com.hust.hwt.homework.model.SAQQuestionModel;
import com.hust.hwt.homework.util.CommonCode;
import com.hust.hwt.homework.util.JSONCommon;

/** 
 * @Description:ChoiceQuestionServiceImpl.java
 * @author  huwentao 
 * @date 创建时间：2018年1月18日 下午4:46:41 
 * @version 1.0  
 */
@Service
@Slf4j
public class QuestionService{
	
	/**每页显示条数*/
	private static final Integer PAGE_SIZE = 3;

	/**
	 * 
	 */
	@Autowired
	private ChoiceQuestionMapper choiceQuestionMapper;
	
	@Autowired
	private FillBlanksQuestionMapper fillBlanksQuestionMapper;

	@Autowired
	private SAQQuestionMapper saqQuestionMapper;

	public void addQuestionChoice(HttpServletRequest request,
			HttpServletResponse response,
			ChoiceQuestionModel questionModel) {
		Integer teacherId = (Integer)request.getSession().getAttribute("teacher_id");
		String teacherName = (String)request.getSession().getAttribute("teacher_name");
		questionModel.setTeacher_id(teacherId);
		questionModel.setQuestion_type(1);
		try {
			Integer addResult = choiceQuestionMapper.addQuestionChoice(questionModel);
			if(addResult>0){
				log.info(teacherName+"创建单选题："+questionModel.getQuestion()+"成功");
				JSONCommon.outputResultCodeJson(CommonCode.SUCCESS, response);
			}else{
				log.info(teacherName+"创建单选题："+questionModel.getQuestion()+"失败");
				JSONCommon.outputResultCodeJson(CommonCode.FAIL, response);
			}
		} catch (Exception e) {
			log.info("服务器发生错误，"+teacherName+"创建单选题："+questionModel.getQuestion()+"失败");
			JSONCommon.outputResultCodeJson(CommonCode.SERVER_ERROR, response);
			e.printStackTrace(); 
		}
	}

	public void getChoiceQuestionInfo(HttpServletRequest request,
			HttpServletResponse response,
			ChoiceQuestionModel questionModel) {
		Integer teacherid = (Integer)request.getSession().getAttribute("teacher_id");

		questionModel.setTeacher_id(teacherid);

		if(null==questionModel.getPageSize() || questionModel.getPageSize()==0)
			questionModel.setPageSize(PAGE_SIZE);
		int totalCount = choiceQuestionMapper.totalQuestion(questionModel);
		
		List<ChoiceQuestionModel> choiceQuestionModels = new ArrayList<ChoiceQuestionModel>();
		
		//如果查询到的总数不为空则查询学生信息
		if(totalCount!=0){
			int totalPages = 0;
			
			if (totalCount % PAGE_SIZE == 0) {
				totalPages = totalCount / PAGE_SIZE;
			} else {
				totalPages = totalCount / PAGE_SIZE + 1;
			}
			int currentPage = 0;
			// 若当前页的页号小于等于0.则将其设置为0，否则将获取的页数*每页显示条数作为查询条件
			if(null==questionModel.getCurrentPage() || questionModel.getCurrentPage() <= 0){
				questionModel.setCurrentPage(1);
				currentPage = 1;
			// 如果当前页数大于总页数,将其设置为总页数
			} else if (currentPage >= totalPages){
				currentPage = totalPages;
				questionModel.setCurrentPage(totalPages);
			} else {
				currentPage = questionModel.getCurrentPage();
			}
			questionModel.setStart((currentPage-1)*PAGE_SIZE);
			
			choiceQuestionModels = choiceQuestionMapper.getChoiceQuestionInfo(questionModel);
			
		}
		JSONArray array = new JSONArray();
		if(choiceQuestionModels.size()>0){
			for (ChoiceQuestionModel model: choiceQuestionModels) {
				array.add(model.toJSONObject());
			}
			
		}
		JSONObject jsonObject = new JSONObject();
		jsonObject.put("sumNum", totalCount);
		jsonObject.put("pageSize", questionModel.getPageSize());
		jsonObject.put("currentPage", questionModel.getCurrentPage());
		JSONCommon.outputResultArrayJson(CommonCode.SUCCESS, response, array,jsonObject);
	}

	
	public void addQuestionFillBlanks(HttpServletRequest request,
			HttpServletResponse response,
			FillBlanksQuestionModel questionModel) {
		Integer teacherId = (Integer)request.getSession().getAttribute("teacher_id");
		String teacherName = (String)request.getSession().getAttribute("teacher_name");
		questionModel.setTeacher_id(teacherId);
		try {
			Integer addResult = fillBlanksQuestionMapper.addQuestion(questionModel);
			if(addResult>0){
				log.info(teacherName+"创建填空题："+questionModel.getQuestion()+"成功");
				JSONCommon.outputResultCodeJson(CommonCode.SUCCESS, response);
			}else{
				log.info(teacherName+"创建填空题："+questionModel.getQuestion()+"失败");
				JSONCommon.outputResultCodeJson(CommonCode.FAIL, response);
			}
		} catch (Exception e) {
			log.info("服务器发生错误，"+teacherName+"创建填空题："+questionModel.getQuestion()+"失败");
			JSONCommon.outputResultCodeJson(CommonCode.SERVER_ERROR, response);
			e.printStackTrace();
		}
	}

	
	public void getFillBlanksQuestionInfo(HttpServletRequest request,
			HttpServletResponse response,
			FillBlanksQuestionModel questionModel) {
		Integer teacherid = (Integer)request.getSession().getAttribute("teacher_id");
		questionModel.setTeacher_id(teacherid);

		if(null==questionModel.getPageSize() || questionModel.getPageSize()==0)
			questionModel.setPageSize(PAGE_SIZE);
		int totalCount = fillBlanksQuestionMapper.totalQuestion(questionModel);
		
		List<FillBlanksQuestionModel> questionModels = new ArrayList<FillBlanksQuestionModel>();
		
		//如果查询到的总数不为空则查询学生信息
		if(totalCount!=0){
			int totalPages = 0;
			
			if (totalCount % PAGE_SIZE == 0) {
				totalPages = totalCount / PAGE_SIZE;
			} else {
				totalPages = totalCount / PAGE_SIZE + 1;
			}
			int currentPage = 0;
			// 若当前页的页号小于等于0.则将其设置为0，否则将获取的页数*每页显示条数作为查询条件
			if(null==questionModel.getCurrentPage() || questionModel.getCurrentPage() <= 0){
				questionModel.setCurrentPage(1);
				currentPage = 1;
			// 如果当前页数大于总页数,将其设置为总页数
			} else if (currentPage >= totalPages){
				currentPage = totalPages;
				questionModel.setCurrentPage(totalPages);
			} else {
				currentPage = questionModel.getCurrentPage();
			}
			questionModel.setStart((currentPage-1)*PAGE_SIZE);
			
			questionModels = fillBlanksQuestionMapper.getQuestionInfo(questionModel);
			
		}
		JSONArray array = new JSONArray();
		if(questionModels.size()>0){
			for (FillBlanksQuestionModel model: questionModels) {
				array.add(model.toJSONObject());
			}
			
		}
		JSONObject jsonObject = new JSONObject();
		jsonObject.put("sumNum", totalCount);
		jsonObject.put("pageSize", questionModel.getPageSize());
		jsonObject.put("currentPage", questionModel.getCurrentPage());
		JSONCommon.outputResultArrayJson(CommonCode.SUCCESS, response, array,jsonObject);

	}

	
	public void addQuestionSAQ(HttpServletRequest request,
			HttpServletResponse response, SAQQuestionModel questionModel) {
		Integer teacherId = (Integer)request.getSession().getAttribute("teacher_id");
		String teacherName = (String)request.getSession().getAttribute("teacher_name");
		
		questionModel.setTeacher_id(teacherId);
		//调试语句
		
		try {
			Integer addResult = saqQuestionMapper.addQuestion(questionModel);
			if(addResult>0){
				log.info(teacherName+"创建简答题："+questionModel.getQuestion()+"成功");
				JSONCommon.outputResultCodeJson(CommonCode.SUCCESS, response);
			}else{
				log.info(teacherName+"创建简答题："+questionModel.getQuestion()+"失败");
				JSONCommon.outputResultCodeJson(CommonCode.FAIL, response);
			}
		} catch (Exception e) {
			log.info("服务器发生错误，"+teacherName+"创建简答题："+questionModel.getQuestion()+"失败");
			JSONCommon.outputResultCodeJson(CommonCode.SERVER_ERROR, response);
			e.printStackTrace();
		}
	}

	
	public void getSAQQuestionInfo(HttpServletRequest request,
			HttpServletResponse response, SAQQuestionModel questionModel) {
		Integer teacherid = (Integer)request.getSession().getAttribute("teacher_id");
		questionModel.setTeacher_id(teacherid);
		if(null==questionModel.getPageSize() || questionModel.getPageSize()==0)
			questionModel.setPageSize(PAGE_SIZE);
		int totalCount = saqQuestionMapper.totalQuestion(questionModel);
		
		List<SAQQuestionModel> questionModels = new ArrayList<SAQQuestionModel>();
		
		//如果查询到的总数不为空则查询学生信息
		if(totalCount!=0){
			int totalPages = 0;
			
			if (totalCount % PAGE_SIZE == 0) {
				totalPages = totalCount / PAGE_SIZE;
			} else {
				totalPages = totalCount / PAGE_SIZE + 1;
			}
			int currentPage = 0;
			// 若当前页的页号小于等于0.则将其设置为0，否则将获取的页数*每页显示条数作为查询条件
			if(null==questionModel.getCurrentPage() || questionModel.getCurrentPage() <= 0){
				questionModel.setCurrentPage(1);
				currentPage = 1;
			// 如果当前页数大于总页数,将其设置为总页数
			} else if (currentPage >= totalPages){
				currentPage = totalPages;
				questionModel.setCurrentPage(totalPages);
			} else {
				currentPage = questionModel.getCurrentPage();
			}
			questionModel.setStart((currentPage-1)*PAGE_SIZE);
			
			questionModels = saqQuestionMapper.getQuestionInfo(questionModel);
			
		}
		JSONArray array = new JSONArray();
		if(questionModels.size()>0){
			for (SAQQuestionModel model: questionModels) {
				array.add(model.toJSONObject());
			}
			
		}
		JSONObject jsonObject = new JSONObject();
		jsonObject.put("sumNum", totalCount);
		jsonObject.put("pageSize", questionModel.getPageSize());
		jsonObject.put("currentPage", questionModel.getCurrentPage());
		JSONCommon.outputResultArrayJson(CommonCode.SUCCESS, response, array,jsonObject);

	}

}
