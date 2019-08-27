package com.hust.hwt.homework.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.hust.hwt.homework.service.UserLoginService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.hust.hwt.homework.model.ClassModel;
import com.hust.hwt.homework.model.StudentModel;
import com.hust.hwt.homework.model.TeacherModel;
import org.springframework.web.bind.annotation.RestController;

/** 
 * @Description:LoginAction.java
 * @author  huwentao 
 * @date 创建时间：2018年1月10日 下午5:07:20 
 * @version 1.0  
 */
@RestController
@RequestMapping("user")
public class LoginAction {
	/**
	 * 
	 */
	@Autowired
	private UserLoginService loginService;
	
	/**
	 * 
	 * @Description:教师登录
	 * @author  huwentao 
	 * @date 创建时间：2018年1月12日 上午10:28:54
	 * @param
	 * @return
	 */
	@RequestMapping("login/teacher")
	public void teacherLogin(HttpServletRequest request,HttpServletResponse response,TeacherModel teacherModel){
		loginService.teacherLogin(request, response, teacherModel);
	}
	
	/**
	 * 
	 * @Description:学生登录
	 * @author  huwentao 
	 * @date 创建时间：2018年1月12日 上午10:28:58
	 * @param
	 * @return
	 */
	@RequestMapping("login/student")
	public void studentLogin(HttpServletRequest request,HttpServletResponse response,StudentModel studentModel){
		loginService.studentLogin(request, response, studentModel);
	}

	@RequestMapping("regist/student")
	public void studentRegist(HttpServletRequest request,HttpServletResponse response,StudentModel studentModel,ClassModel classModel){
		loginService.studentRegister(request, response, studentModel,classModel);
	}

	@RequestMapping("regist/teacher")
	public void teacherRegist(HttpServletRequest request,HttpServletResponse response,TeacherModel teacherModel){
		loginService.teacherRegister(request, response, teacherModel);
	}
}
