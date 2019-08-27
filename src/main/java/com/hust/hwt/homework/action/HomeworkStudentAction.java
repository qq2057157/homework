package com.hust.hwt.homework.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.hust.hwt.homework.service.HomeworkService;
import com.hust.hwt.homework.service.UserLoginService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.hust.hwt.homework.model.AnwserStudentModel;
import com.hust.hwt.homework.model.HomeworkModel;
import org.springframework.web.bind.annotation.RestController;

/** 
 * @Description:HomeworkAction.java
 * @author  huwentao 
 * @date 创建时间：2018年1月15日 上午10:06:10 
 * @version 1.0  
 */
@RestController
@RequestMapping("homework/s")
public class HomeworkStudentAction {

	@Autowired
	private HomeworkService homeworkService;

	@Autowired
	private UserLoginService userLoginService;
	
	@RequestMapping("huwentao")
	public String homeworkMain(HttpServletRequest request,HttpServletResponse response) {
		
		return "WEB-INF/student_huwentao";
	}
	
	@RequestMapping("complete")
	public String classMain(HttpServletRequest request,HttpServletResponse response) {
		
		return "WEB-INF/student_complete";
	}
	
	@RequestMapping("getClassHomework")
	public void getClassHomework(HttpServletRequest request,HttpServletResponse response) {
		
		homeworkService.getHomeworkInfoByClass(request, response);
	}
	
	@RequestMapping("homeworkChoicesList")
	public void getHomeworkChoicesList(HttpServletRequest request,HttpServletResponse response,@RequestParam(value="id")Integer Id){
		Integer studentId = (Integer)request.getSession().getAttribute("student_id");
		homeworkService.getHomeworkChoices(request, response, Id,studentId);
	}
	
	@RequestMapping("homeworkFbList")
	public void getHomeworkFbList(HttpServletRequest request,HttpServletResponse response,@RequestParam(value="id")Integer Id){
		Integer studentId = (Integer)request.getSession().getAttribute("student_id");
		homeworkService.getHomeworkFbs(request, response, Id,studentId);
	}
	
	@RequestMapping("homeworkSAQList")
	public void getHomeworkSAQList(HttpServletRequest request,HttpServletResponse response,@RequestParam(value="id")Integer Id){
		Integer studentId = (Integer)request.getSession().getAttribute("student_id");
		homeworkService.getHomeworkSAQs(request, response, Id,studentId);
	}

	@RequestMapping("homeworkedit")
	public String homeworkEdit(HttpServletRequest request,HttpServletResponse response,HomeworkModel homeworkModel) {
		System.out.println(homeworkModel.getId());
		request.setAttribute("id", homeworkModel.getId());
		request.setAttribute("homework_name", homeworkModel.getHomework_name());
		return "WEB-INF/student_homework_edit";
	}
	
	@RequestMapping("homeworkview")
	public String homeworkView(HttpServletRequest request,HttpServletResponse response,HomeworkModel homeworkModel) {
		System.out.println(homeworkModel.getId());
		Integer studentId = (Integer)request.getSession().getAttribute("student_id");
		AnwserStudentModel anwserStudentModel = new AnwserStudentModel();
		anwserStudentModel.setStudent_id(studentId);
		anwserStudentModel.setHomework_id(homeworkModel.getId());
		Float sumscore = homeworkService.getSumscore(request, response, anwserStudentModel);
		request.setAttribute("id", homeworkModel.getId());
		request.setAttribute("homework_name", homeworkModel.getHomework_name());
		request.setAttribute("sumscore", sumscore==null?0:sumscore);
		return "WEB-INF/student_homework_view";
	}
	@RequestMapping("addStudentAnwser")
	public void addStudentAnwser(HttpServletRequest request,HttpServletResponse response,AnwserStudentModel anwserStudentModel,
			@RequestParam(value="questionIds")Integer[] questionIds,
			@RequestParam(value="answers")String[] answers,
			@RequestParam(value="questionTypes")Integer[] questionTypes) {
		
		homeworkService.addStudentAnwser(request, response, anwserStudentModel,questionIds,answers,questionTypes);
	}
	
	@RequestMapping("getStudentInfo")
	public void getStudentInfo(HttpServletRequest request,HttpServletResponse response) {
		userLoginService.studentInfo(request, response);
	}
}
