package com.hust.hwt.homework.service;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.stereotype.Service;

import com.hust.hwt.homework.mapper.ClassMapper;
import com.hust.hwt.homework.mapper.StudentMapper;
import com.hust.hwt.homework.mapper.TeacherMapper;
import com.hust.hwt.homework.model.ClassModel;
import com.hust.hwt.homework.model.StudentModel;
import com.hust.hwt.homework.model.TeacherModel;
import com.hust.hwt.homework.util.CommonCode;
import com.hust.hwt.homework.util.JSONCommon;
import com.hust.hwt.homework.util.MD5;

/** 
 * @Description:UserLoginServiceImpl.java
 * @author  chengshiyang 
 * @date 创建时间：2018年1月11日 上午10:57:41 
 * @version 1.0  
 */
@Service
@Slf4j
public class UserLoginService{

	/**
	 * 
	 */
	@Autowired
	private TeacherMapper teacherMapper;
	/**
	 * 
	 */
	@Autowired
	private StudentMapper studentMapper;
	
	@Autowired
	private ClassMapper classMapper;

	@Autowired
	private RedisTemplate redisTemplate;

	@Autowired
	private StringRedisTemplate stringRedisTemplate;
	
	public void studentRegister(HttpServletRequest request,
			HttpServletResponse response, StudentModel studentModel,ClassModel classModel) {
		try {
			studentModel.setPassword(MD5.GetMD5Code(studentModel.getPassword()));
			classModel.setId(studentModel.getClass_id());
			Integer queryResult = classMapper.verifyPassword(classModel);
			if(queryResult!=null && queryResult>0){
				Integer insertResult = studentMapper.studentRegister(studentModel);
				if (insertResult!=null && insertResult>0) {
					log.info("学生用户:"+studentModel.getName()+"注册成功，注册时间:"+new Date());
					JSONCommon.outputResultCodeJson(CommonCode.SUCCESS, response);
				} else {
					log.info("学生用户:"+studentModel.getUsername()+"注册失败，注册时间:"+new Date());
					JSONCommon.outputResultCodeJson(CommonCode.FAIL, response);
				}
			} else {
				log.info("班级密码错误，学生用户:"+studentModel.getUsername()+"注册失败，注册时间:"+new Date());
				JSONCommon.outputResultCodeJson(CommonCode.CLASS_PWD_ERROR, response);
			}
			
		} catch (Exception e) {
			log.info("服务器发生故障，学生用户:"+studentModel.getUsername()+"注册失败，注册时间:"+new Date());
			JSONCommon.outputResultCodeJson(CommonCode.SERVER_ERROR, response);
			e.printStackTrace();
		}
	}

	public void teacherRegister(HttpServletRequest request,
			HttpServletResponse response, TeacherModel teacherModel) {
		try {
			teacherModel.setPassword(MD5.GetMD5Code(teacherModel.getPassword()));
			
			Integer insertResult = teacherMapper.teacherRegister(teacherModel);
			if (insertResult!=null && insertResult>0) {
				log.info("教师用户:"+teacherModel.getName()+"注册成功，注册时间:"+new Date());
				JSONCommon.outputResultCodeJson(CommonCode.SUCCESS, response);
			} else {
				log.info("教师用户:"+teacherModel.getUsername()+"注册失败，注册时间:"+new Date());
				JSONCommon.outputResultCodeJson(CommonCode.FAIL, response);
			}
		} catch (Exception e) {
			log.info("服务器发生故障，教师用户:"+teacherModel.getUsername()+"注册失败，注册时间:"+new Date());
			JSONCommon.outputResultCodeJson(CommonCode.SERVER_ERROR, response);
			e.printStackTrace();
		}
	}

	
	public void teacherLogin(HttpServletRequest request,
			HttpServletResponse response, TeacherModel teacherModel) {
		TeacherModel loginResult;
		try {
			teacherModel.setPassword(MD5.GetMD5Code(teacherModel.getPassword()));
			loginResult = teacherMapper.teacherLogin(teacherModel);
			if (loginResult!=null) {
				request.getSession().setAttribute("teacher_id", loginResult.getId());
				request.getSession().setAttribute("teacher_name", loginResult.getName());
				request.getSession().setAttribute("school_id", loginResult.getSchool_id());

				log.info("教师用户:"+loginResult.toString()+"登录成功，本次登录时间:"+LocalDateTime.now()+"上次登录时间是："+redisTemplate.opsForValue().get(loginResult.getUsername()+"_login_time"));
				redisTemplate.opsForValue().set(loginResult.getUsername()+"_login_time", LocalDateTime.now().format(DateTimeFormatter.ISO_DATE_TIME));
				JSONCommon.outputResultCodeJson(CommonCode.SUCCESS, response);
			} else {
				log.info("教师用户:"+loginResult.getUsername()+"登录失败，登录时间:"+new Date());
				JSONCommon.outputResultCodeJson(CommonCode.FAIL, response);
			}
		} catch (Exception e) {
			log.info("服务器发生故障，教师用户:"+teacherModel.getUsername()+"登录失败，登录时间:"+new Date());
			JSONCommon.outputResultCodeJson(CommonCode.SERVER_ERROR, response);
			e.printStackTrace();
		}
	}

	
	public void studentLogin(HttpServletRequest request,
			HttpServletResponse response, StudentModel studentModel) {
		try {
			studentModel.setPassword(MD5.GetMD5Code(studentModel.getPassword()));
			StudentModel loginResult = studentMapper.studentLogin(studentModel);
			if (loginResult!=null) {
				request.getSession().setAttribute("student_id", loginResult.getId());
				request.getSession().setAttribute("student_name", loginResult.getName());
				request.getSession().setAttribute("school_id", loginResult.getSchool_id());
				request.getSession().setAttribute("class_id", loginResult.getClass_id());
				log.info("学生用户:"+loginResult.getName()+"登录成功，登录时间:"+new Date());
				JSONCommon.outputResultCodeJson(CommonCode.SUCCESS, response);
			} else {
				log.info("学生用户:"+studentModel.getUsername()+"登录失败，登录时间:"+new Date());
				JSONCommon.outputResultCodeJson(CommonCode.FAIL, response);
			}
		} catch (Exception e) {
			log.info("服务器发生故障，学生用户:"+studentModel.getUsername()+"登录失败，登录时间:"+new Date());
			JSONCommon.outputResultCodeJson(CommonCode.SERVER_ERROR, response);
			e.printStackTrace();
		}
	}

	
	public void studentInfo(HttpServletRequest request, HttpServletResponse response) {
		try {
			Integer studentId = (Integer)request.getSession().getAttribute("student_id");
			
			StudentModel model = studentMapper.getStudentInfoById(studentId);
			
			JSONCommon.outputResultDataJson(CommonCode.SUCCESS, response, model.getStudentJSONObject());
			
		} catch (Exception e) {
			JSONCommon.outputResultCodeJson(CommonCode.SERVER_ERROR, response);
			e.printStackTrace();
		}
	
	}

	
	public StudentModel studentInfo(Integer id) {
		
		return studentMapper.getStudentInfoById(id);
	}
}
