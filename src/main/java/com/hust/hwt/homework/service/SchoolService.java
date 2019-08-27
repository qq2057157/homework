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
import com.hust.hwt.homework.mapper.ClassMapper;
import com.hust.hwt.homework.mapper.SchoolMapper;
import com.hust.hwt.homework.mapper.StudentMapper;
import com.hust.hwt.homework.model.ClassModel;
import com.hust.hwt.homework.model.SchoolModel;
import com.hust.hwt.homework.model.StudentModel;
import com.hust.hwt.homework.util.CommonCode;
import com.hust.hwt.homework.util.JSONCommon;

/** 
 * @Description:SchoolServiceImpl.java
 * @author  huwentao 
 * @date 创建时间：2018年1月11日 下午2:49:17 
 * @version 1.0  
 */
@Service
@Slf4j
public class SchoolService{

	/**每页显示条数*/
	private static final Integer PAGE_SIZE = 3;

	/**
	 * 
	 */
	@Autowired
	private SchoolMapper schoolMapper;
	/**
	 * 
	 */
	@Autowired
	private ClassMapper classMapper;
	/**
	 * 
	 */
	@Autowired
	private StudentMapper studentMapper;
	
	public void getSchoolInfo(HttpServletRequest request,
			HttpServletResponse response) {
		try {
			List<SchoolModel> schoolModels = schoolMapper.getSchoolInfo();
			if(schoolModels.size()>0){
				JSONArray schoolArray = new JSONArray();
				for (SchoolModel schoolModel : schoolModels) {
					schoolArray.add(schoolModel.getSchoolJSONObject());
				}
				log.info("获取学校信息成功学校信息是:{}",schoolArray.toString());
				JSONCommon.outputResultArrayJson(CommonCode.SUCCESS, response, schoolArray);
			}else{
				log.info("获取学校信息失败");
				JSONCommon.outputResultCodeJson(CommonCode.FAIL, response);
			}
		} catch (Exception e) {
			log.info("获取学校信息时"+"服务器发生错误");
			JSONCommon.outputResultCodeJson(CommonCode.SERVER_ERROR, response);
			e.printStackTrace();
		}
	}

	
	public void addClass(HttpServletRequest request,
			HttpServletResponse response, ClassModel classModel) {
		
		try {
			
			String teacherName = (String)request.getSession().getAttribute("teacher_name");
			Integer teacherId = (Integer)request.getSession().getAttribute("teacher_id");
			Integer schoolId = (Integer)request.getSession().getAttribute("school_id");

			//未登录时接口调试使用
			classModel.setTeacher_id(teacherId);   
				
			classModel.setSchool_id(schoolId);

			Integer addResult = classMapper.addClass(classModel);
			if(addResult>0){
				log.info(teacherName+"创建班级："+classModel.getClass_name()+"成功");
				JSONCommon.outputResultCodeJson(CommonCode.SUCCESS, response);
			}else{
				log.info(teacherName+"创建班级："+classModel.getClass_name()+"失败");
				JSONCommon.outputResultCodeJson(CommonCode.FAIL, response);
			}
		} catch (Exception e) {
			log.info("服务器发生错误，新增班级"+classModel.getClass_name()+"失败");
			JSONCommon.outputResultCodeJson(CommonCode.SERVER_ERROR, response);
			e.printStackTrace();
		}
	}

	
	public void getClassInfoByPage(HttpServletRequest request,
			HttpServletResponse response, ClassModel classModel) {
		Integer teacherid = (Integer)request.getSession().getAttribute("teacher_id");

		classModel.setTeacher_id(teacherid);
	
		if(null==classModel.getPageSize() || classModel.getPageSize()==0)
			classModel.setPageSize(PAGE_SIZE);
		int totalCount = classMapper.totalClassInfo(classModel);
		
		List<ClassModel> classModels = new ArrayList<ClassModel>();
		
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
			if(null==classModel.getCurrentPage() || classModel.getCurrentPage() <= 0){
				classModel.setCurrentPage(1);
				currentPage = 1;
			// 如果当前页数大于总页数,将其设置为总页数
			} else if (currentPage >= totalPages){
				currentPage = totalPages;
				classModel.setCurrentPage(totalPages);
			} else {
				currentPage = classModel.getCurrentPage();
			}
			classModel.setStart((currentPage-1)*PAGE_SIZE);
			
			classModels = classMapper.getClassInfoByPage(classModel);
			
		}
		JSONArray array = new JSONArray();
		if(classModels.size()>0){
			for (ClassModel model: classModels) {
				array.add(model.getClassJSONObject());
			}
			
		}
		JSONObject jsonObject = new JSONObject();
		jsonObject.put("sumNum", totalCount);
		jsonObject.put("pageSize", classModel.getPageSize());
		jsonObject.put("currentPage", classModel.getCurrentPage());
		JSONCommon.outputResultArrayJson(CommonCode.SUCCESS, response, array,jsonObject);
	}

	
	public void getClassInfo(HttpServletRequest request,
			HttpServletResponse response, ClassModel classModel) {
		if(null==classModel.getSchool_id()||0==classModel.getSchool_id()){
			Integer school_id= (Integer)request.getSession().getAttribute("school_id");
			classModel.setSchool_id(school_id);
		}
		try {
			List<ClassModel> classModels = classMapper.getClassInfo(classModel);
			if(classModels.size()>0){
				JSONArray array = new JSONArray();
				for (ClassModel model: classModels) {
					array.add(model.getClassJSONObject());
				}
				log.info("取得班级信息成功");
				JSONCommon.outputResultArrayJson(CommonCode.SUCCESS, response, array);
				
			}else{
				log.info("取得班级信息失败");
				JSONCommon.outputResultCodeJson(CommonCode.FAIL, response);
			}
		} catch (Exception e) {
			log.info("服务器发生错误，取得班级信息失败");
			JSONCommon.outputResultCodeJson(CommonCode.SERVER_ERROR, response);
			e.printStackTrace();
		}
	}

	
	public void getStudentsByClass(HttpServletRequest request,
			HttpServletResponse response, StudentModel studentModel) {

		if(null==studentModel.getPageSize() || studentModel.getPageSize()==0)
			studentModel.setPageSize(PAGE_SIZE);
		int totalCount = studentMapper.totalStudentsByClass(studentModel);
		
		List<StudentModel> studentModels = new ArrayList<StudentModel>();
		
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
			if(null==studentModel.getCurrentPage() || studentModel.getCurrentPage() <= 0){
				studentModel.setCurrentPage(1);
				currentPage = 1;
			// 如果当前页数大于总页数,将其设置为总页数
			} else if (currentPage >= totalPages){
				currentPage = totalPages;
				studentModel.setCurrentPage(totalPages);
			} else {
				currentPage = studentModel.getCurrentPage();
			}
			studentModel.setStart((currentPage-1)*PAGE_SIZE);
			
			studentModels = studentMapper.getStudentsByClass(studentModel);
		}
		JSONArray array = new JSONArray();
		if(studentModels.size()>0){
			for (StudentModel model: studentModels) {
				array.add(model.getStudentJSONObject());
			}
			
		}
		JSONObject jsonObject = new JSONObject();
		jsonObject.put("sumNum", totalCount);
		jsonObject.put("pageSize", studentModel.getPageSize());
		jsonObject.put("currentPage", studentModel.getCurrentPage());
		JSONCommon.outputResultArrayJson(CommonCode.SUCCESS, response, array,jsonObject);

	}
}
