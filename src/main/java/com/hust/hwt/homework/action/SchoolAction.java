package com.hust.hwt.homework.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.hust.hwt.homework.service.SchoolService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.hust.hwt.homework.model.ClassModel;
import com.hust.hwt.homework.model.StudentModel;
import org.springframework.web.bind.annotation.RestController;

/** 
 * @Description:LoginAction.java
 * @author  chengshiyang 
 * @date 创建时间：2018年1月10日 下午5:07:20 
 * @version 1.0  
 */
@RestController
@RequestMapping("homework/t/school")
public class SchoolAction {
	
	@Autowired
	private SchoolService schoolService;
	
	@RequestMapping("getinfo")
	public void getSchoolInfo(HttpServletRequest request,HttpServletResponse response){
		schoolService.getSchoolInfo(request, response);
	}

	@RequestMapping("addclass")
	public void addClass(HttpServletRequest request,HttpServletResponse response,ClassModel classModel){
		schoolService.addClass(request, response,classModel);
	}
	
	/**
	 * 
	 * @Description:分页取得班级信息
	 * @author  chengshiyang 
	 * @date 创建时间：2018年1月19日 下午5:20:15
	 * @param
	 * @return
	 */
	@RequestMapping("getclassinfobypage")
	public void getClass(HttpServletRequest request,HttpServletResponse response,ClassModel classModel){
		schoolService.getClassInfoByPage(request, response, classModel);
	}
	/**
	 * 
	 * @Description:根据学校id或者学校id取得班级信息
	 * @author  chengshiyang 
	 * @date 创建时间：2018年1月19日 下午5:20:30
	 * @param
	 * @return
	 */
	@RequestMapping("getclassinfo")
	public void getClassInfo(HttpServletRequest request,HttpServletResponse response,ClassModel classModel){
		schoolService.getClassInfo(request, response, classModel);
	}
	/**
	 * 
	 * @Description:根据班级id取得学生信息
	 * @author  chengshiyang 
	 * @date 创建时间：2018年1月19日 下午5:20:57
	 * @param
	 * @return
	 */
	@RequestMapping("getstudentsbyclass")
	public void getStudentsByClass(HttpServletRequest request,HttpServletResponse response,StudentModel studentModel){
		schoolService.getStudentsByClass(request, response, studentModel);
	}

}
