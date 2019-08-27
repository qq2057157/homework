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
import com.hust.hwt.homework.model.ChoiceQuestionModel;
import com.hust.hwt.homework.model.ClassHomeworkModel;
import com.hust.hwt.homework.model.FillBlanksQuestionModel;
import com.hust.hwt.homework.model.HomeworkModel;
import com.hust.hwt.homework.model.SAQQuestionModel;
import com.hust.hwt.homework.model.StudentModel;
import org.springframework.web.bind.annotation.RestController;

/** 
 * @Description:HomeworkAction.java
 * @author  chengshiyang 
 * @date 创建时间：2018年1月15日 上午10:06:10 
 * @version 1.0  
 */
@RestController
@RequestMapping("homework/t")
public class HomeworkTeacherAction {

	@Autowired
	private HomeworkService homeworkService;

	@Autowired
	private UserLoginService userLoginService;
	@RequestMapping("homework")
	public String homeworkMain(HttpServletRequest request,HttpServletResponse response) {
		
		return "WEB-INF/teacher_homework";
	}
	
	@RequestMapping("class")
	public String classMain(HttpServletRequest request,HttpServletResponse response) {
		
		return "WEB-INF/teacher_class";
	}
	
	@RequestMapping("question")
	public String questionMain(HttpServletRequest request,HttpServletResponse response) {
		
		return "WEB-INF/teacher_question";
	}
	@RequestMapping("correct")
	public String correctMain(HttpServletRequest request,HttpServletResponse response,@RequestParam(value="class_id")Integer class_id,@RequestParam(value="homework_id")Integer homework_id) {
		request.setAttribute("class_id", class_id);
		request.setAttribute("homework_id", homework_id);
		return "WEB-INF/teacher_correct";
	}
	
	@RequestMapping("correctStudent")
	public String correctStudentMain(HttpServletRequest request,HttpServletResponse response,@RequestParam(value="student_id")Integer student_id,@RequestParam(value="homework_id")Integer homework_id) {
		request.setAttribute("student_id", student_id);
		request.setAttribute("homework_id", homework_id);
		AnwserStudentModel anwserStudentModel = new AnwserStudentModel();
		anwserStudentModel.setStudent_id(student_id);
		anwserStudentModel.setHomework_id(homework_id);
		Float sumscore = homeworkService.getSumscore(request, response, anwserStudentModel);
		HomeworkModel homeworkModel = homeworkService.getHomeworkInfoById(homework_id);
		StudentModel studentModel = userLoginService.studentInfo(student_id);
		request.setAttribute("sumscore", sumscore);
		request.setAttribute("homework", homeworkModel);
		request.setAttribute("student", studentModel);
		return "WEB-INF/teacher_homework_correct";
	}
	@RequestMapping("homeworkedit")
	public String homeworkEdit(HttpServletRequest request,HttpServletResponse response,HomeworkModel homeworkModel) {
		System.out.println(homeworkModel.getId());
		request.setAttribute("id", homeworkModel.getId());
		request.setAttribute("homework_name", homeworkModel.getHomework_name());
		return "WEB-INF/teacher_homework_edit";
	}
	@RequestMapping("homeworkList")
	public void getHomeworkList(HttpServletRequest request,HttpServletResponse response,HomeworkModel homeworkModel){
		homeworkService.getHomeworkInfo(request, response, homeworkModel);
	}
	
		@RequestMapping("homeworkChoicesList")
		public void getHomeworkChoicesList(HttpServletRequest request,HttpServletResponse response,@RequestParam(value="id")Integer Id){
			homeworkService.getHomeworkChoices(request, response, Id);
		}
		
		@RequestMapping("homeworkFbList")
		public void getHomeworkFbList(HttpServletRequest request,HttpServletResponse response,@RequestParam(value="id")Integer Id){
			homeworkService.getHomeworkFbs(request, response, Id);
		}
		
		@RequestMapping("homeworkSAQList")
		public void getHomeworkSAQList(HttpServletRequest request,HttpServletResponse response,@RequestParam(value="id")Integer Id){
			homeworkService.getHomeworkSAQs(request, response, Id);
		}
	
	@RequestMapping("homeworkAddChoices")
	public void homeworkAddChoices(HttpServletRequest request,HttpServletResponse response,ChoiceQuestionModel choiceQuestionModel,@RequestParam(value="hid")Integer Id){
		homeworkService.addHomeworkChoices(request, response, choiceQuestionModel, Id);
	}
	
	@RequestMapping("homeworkAddFb")
	public void homeworkAddFb(HttpServletRequest request,HttpServletResponse response,FillBlanksQuestionModel fillBlanksQuestionModel,@RequestParam(value="hid")Integer Id){
		homeworkService.addHomeworkFbs(request, response, fillBlanksQuestionModel, Id);
	}
	
	@RequestMapping("homeworkAddSAQ")
	public void homeworkAddSAQ(HttpServletRequest request,HttpServletResponse response,SAQQuestionModel saqQuestionModel,@RequestParam(value="hid")Integer Id){
		homeworkService.addHomeworkSAQs(request, response, saqQuestionModel, Id);
	}
	
	@RequestMapping("deleteHomeworkQuestion")
	public void deleteHomeworkQuestion(HttpServletRequest request,HttpServletResponse response,@RequestParam(value="id")Integer Id){
		homeworkService.deleteHomeworkQuestion(request, response, Id);
	}
	
	@RequestMapping("distributeHomework")
	public void distributeHomework(HttpServletRequest request,HttpServletResponse response,ClassHomeworkModel classHomeworkModel,@RequestParam(value="classIds")Integer[] classIds){
		homeworkService.distributeHomework(request, response, classHomeworkModel,classIds);
	}
	@RequestMapping("getDistributedClassList")
	public void getDistributedHomeworkList(HttpServletRequest request, HttpServletResponse response,ClassHomeworkModel classHomeworkModel) {
		homeworkService.getDistributedClassList(request, response, classHomeworkModel);
	}
	@RequestMapping("createHomework")
	public void createHomework(HttpServletRequest request, HttpServletResponse response, HomeworkModel homeworkModel) {
		homeworkService.createHomework(request, response, homeworkModel);
	}
	@RequestMapping("getStudentHomeworkByClass")
	public void getStudentHomeworkByClass(HttpServletRequest request, HttpServletResponse response,
			@RequestParam(value="class_id")Integer class_id,@RequestParam(value="homework_id")Integer homework_id) {
		homeworkService.getStudentHomeworkByClass(request, response, class_id,homework_id);
	}
	
	@RequestMapping("correctStudentAnwser")
	public void correctStudentAnwser(HttpServletRequest request,HttpServletResponse response,AnwserStudentModel anwserStudentModel,
			@RequestParam(value="questionIds")Integer[] questionIds,
			@RequestParam(value="scores")Float[] scores) {
		
		homeworkService.correctStudentAnwser(request, response,anwserStudentModel, questionIds,scores);
	}
	@RequestMapping("corrected")
	public void corrected(HttpServletRequest request,HttpServletResponse response,HomeworkModel homeworkModel) {
		
		homeworkService.corrected(request, response, homeworkModel);
	}
	
}
