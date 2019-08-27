package com.hust.hwt.homework.service;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.hust.hwt.homework.mapper.AnswserStudentMapper;
import com.hust.hwt.homework.mapper.ChoiceQuestionMapper;
import com.hust.hwt.homework.mapper.ClassHomeworkMapper;
import com.hust.hwt.homework.mapper.FillBlanksQuestionMapper;
import com.hust.hwt.homework.mapper.HomeworkMapper;
import com.hust.hwt.homework.mapper.HomeworkQuestionMapper;
import com.hust.hwt.homework.mapper.HomeworkStudentMapper;
import com.hust.hwt.homework.mapper.SAQQuestionMapper;
import com.hust.hwt.homework.mapper.StudentMapper;
import com.hust.hwt.homework.model.AnwserStudentModel;
import com.hust.hwt.homework.model.ChoiceQuestionModel;
import com.hust.hwt.homework.model.ClassHomeworkModel;
import com.hust.hwt.homework.model.FillBlanksQuestionModel;
import com.hust.hwt.homework.model.HomeworkModel;
import com.hust.hwt.homework.model.HomeworkQuestionModel;
import com.hust.hwt.homework.model.HomeworkStudentModel;
import com.hust.hwt.homework.model.SAQQuestionModel;
import com.hust.hwt.homework.model.StudentModel;
import com.hust.hwt.homework.util.CommonCode;
import com.hust.hwt.homework.util.JSONCommon;
import com.hust.hwt.homework.util.QuestionType;
import com.hust.hwt.homework.util.StudentHomewokStatus;

/**
 * @Description:
 * @author:huwentao
 * @date:2018年3月6日
 * @version 1.0  
 */
@Service
@Slf4j
public class HomeworkService{

	@Autowired
	private HomeworkMapper homeworkMapper;
	
	@Autowired
	private ChoiceQuestionMapper choiceQuestionMapper;
	
	@Autowired
	private FillBlanksQuestionMapper fillBlanksQuestionMapper;
	
	@Autowired
	private SAQQuestionMapper saqQuestionMapper;
	
	@Autowired
	private HomeworkQuestionMapper homeworkQuestionMapper;
	
	@Autowired
	private ClassHomeworkMapper classHomeworkMapper;

	@Autowired
	private AnswserStudentMapper anwserStudentMapper;
	
	@Autowired
	private HomeworkStudentMapper homeworkStudentMapper;
	
	@Autowired
	private StudentMapper studentMapper;
	
	/**每页显示条数*/
	private static final Integer PAGE_SIZE = 3;

	
	public void getHomeworkInfo(HttpServletRequest request, HttpServletResponse response, HomeworkModel homeworkModel) {
		Integer teacherid = (Integer)request.getSession().getAttribute("teacher_id");

		homeworkModel.setTeacher_id(teacherid);

		if(null==homeworkModel.getPageSize() || homeworkModel.getPageSize()==0)
			homeworkModel.setPageSize(PAGE_SIZE);
		int totalCount = homeworkMapper.totalHomework(homeworkModel);
		
		List<HomeworkModel> models = new ArrayList<HomeworkModel>();
		
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
			if(null==homeworkModel.getCurrentPage() || homeworkModel.getCurrentPage() <= 0){
				homeworkModel.setCurrentPage(1);
				currentPage = 1;
			// 如果当前页数大于总页数,将其设置为总页数
			} else if (currentPage >= totalPages){
				currentPage = totalPages;
				homeworkModel.setCurrentPage(totalPages);
			} else {
				currentPage = homeworkModel.getCurrentPage();
			}
			homeworkModel.setStart((currentPage-1)*PAGE_SIZE);
			
			models = homeworkMapper.getHomeworkInfo(homeworkModel);
			
		}
		JSONArray array = new JSONArray();
		if(models.size()>0){
			for (HomeworkModel model: models) {
				if(model.getDeadline()!=null && model.getDeadline().before(new Date()) && model.getStatus()!=StudentHomewokStatus.DONE){
					model.setUpdatetime(new Date());
					if(model.getTeacher_correct()==1 ) {
						model.setStatus(2);
					} else {
						model.setStatus(4);
					}
					float score = model.getScore();
					model.setScore(null);
					homeworkMapper.updateHomeworkInfo(model);
					model.setScore(score);
				}
				array.add(model.toJSONObject());
			}
		}
		JSONObject jsonObject = new JSONObject();
		jsonObject.put("sumNum", totalCount);
		jsonObject.put("pageSize", homeworkModel.getPageSize());
		jsonObject.put("currentPage", homeworkModel.getCurrentPage());
		JSONCommon.outputResultArrayJson(CommonCode.SUCCESS, response, array,jsonObject);

	}

	
	public void getHomeworkChoices(HttpServletRequest request, HttpServletResponse response, Integer Id) {
		try {
			List<ChoiceQuestionModel> models= choiceQuestionMapper.getChoicesByHid(Id);
			
			JSONArray array = new JSONArray();
			if(models.size()>0){
				for (ChoiceQuestionModel model: models) {
					array.add(model.toJSONObject());
				}
				
			}
			JSONCommon.outputResultArrayJson(CommonCode.SUCCESS, response, array);
		} catch (Exception e) {
			e.printStackTrace();
			JSONCommon.outputResultCodeJson(CommonCode.FAIL, response);
		}
	}

	
	public void getHomeworkFbs(HttpServletRequest request, HttpServletResponse response, Integer Id) {
		try {
			List<FillBlanksQuestionModel> models= fillBlanksQuestionMapper.getFillBlanksByHid(Id);
			
			JSONArray array = new JSONArray();
			if(models.size()>0){
				for (FillBlanksQuestionModel model: models) {
					array.add(model.toJSONObject());
				}
				
			}
			JSONCommon.outputResultArrayJson(CommonCode.SUCCESS, response, array);
		} catch (Exception e) {
			e.printStackTrace();
			JSONCommon.outputResultCodeJson(CommonCode.FAIL, response);
		}
	}

	
	public void getHomeworkSAQs(HttpServletRequest request, HttpServletResponse response, Integer Id) {
		try {
			List<SAQQuestionModel> models= saqQuestionMapper.getSAQByHid(Id);
			
			JSONArray array = new JSONArray();
			if(models.size()>0){
				for (SAQQuestionModel model: models) {
					array.add(model.toJSONObject());
				}
				
			}
			JSONCommon.outputResultArrayJson(CommonCode.SUCCESS, response, array);
		} catch (Exception e) {
			e.printStackTrace();
			JSONCommon.outputResultCodeJson(CommonCode.FAIL, response);
		}
	}

	
	public void deleteHomeworkQuestion(HttpServletRequest request, HttpServletResponse response, Integer Id) {
		try {
							
			Integer deleteResult = homeworkQuestionMapper.deleteHomeworkQuestion(Id);
			if(deleteResult>0) {
				JSONCommon.outputResultCodeJson(CommonCode.SUCCESS, response);
			}else {
				JSONCommon.outputResultCodeJson(CommonCode.FAIL, response);
			}
		} catch (Exception e) {
			// TODO: handle exception
			JSONCommon.outputResultCodeJson(CommonCode.SERVER_ERROR, response);
			e.printStackTrace();
		}
	}

	
	@Transactional
	public void addHomeworkChoices(HttpServletRequest request, HttpServletResponse response,
			ChoiceQuestionModel choiceQuestionModel, Integer Id) {
		try {
			if(choiceQuestionModel.getId()==null) {
				Integer teacherId = (Integer)request.getSession().getAttribute("teacher_id");
				choiceQuestionModel.setTeacher_id(teacherId);
				choiceQuestionModel.setQuestion_type(1);
				Integer addResult = choiceQuestionMapper.addQuestionChoice(choiceQuestionModel);
				if(addResult<=0) {
					JSONCommon.outputResultCodeJson(CommonCode.FAIL, response);
					return;
				} 
			} 
			
			HomeworkQuestionModel homeworkQuestionModel = new HomeworkQuestionModel();
			homeworkQuestionModel.setHomework_id(Id);
			homeworkQuestionModel.setCh_id(choiceQuestionModel.getId());
			homeworkQuestionModel.setQuestion_type(QuestionType.CHOICE);				
			Integer addResult = homeworkQuestionMapper.addHomeworkQuestion(homeworkQuestionModel);
			if(addResult>0) {
				HomeworkModel homeworkModel =new HomeworkModel();
				homeworkModel.setId(Id);
				homeworkModel.setScore(choiceQuestionModel.getScore());
				homeworkModel.setUpdatetime(new Date());
				homeworkMapper.updateHomeworkInfo(homeworkModel);
				JSONObject jsonObject = new JSONObject();
				jsonObject.put("id", homeworkQuestionModel.getId());
				JSONCommon.outputResultDataJson(CommonCode.SUCCESS, response, jsonObject);
			}else {
				JSONCommon.outputResultCodeJson(CommonCode.FAIL, response);
			}
		} catch (Exception e) {
			// TODO: handle exception
			JSONCommon.outputResultCodeJson(CommonCode.SERVER_ERROR, response);
			e.printStackTrace();
		}
		
	}

	
	public void addHomeworkFbs(HttpServletRequest request, HttpServletResponse response,
			FillBlanksQuestionModel fillBlanksQuestionModel, Integer Id) {
		
		try {
			Integer teacherId = (Integer)request.getSession().getAttribute("teacher_id");
			if(fillBlanksQuestionModel.getId()==null) {
				fillBlanksQuestionModel.setTeacher_id(teacherId);
				Integer addResult = fillBlanksQuestionMapper.addQuestion(fillBlanksQuestionModel);
				if(addResult<=0) {
					JSONCommon.outputResultCodeJson(CommonCode.FAIL, response);
					return;
				} 
			}
			
			HomeworkQuestionModel homeworkQuestionModel = new HomeworkQuestionModel();
			homeworkQuestionModel.setHomework_id(Id);
			homeworkQuestionModel.setFb_id(fillBlanksQuestionModel.getId());
			homeworkQuestionModel.setQuestion_type(QuestionType.FILLBLANKS);
			Integer addResult = homeworkQuestionMapper.addHomeworkQuestion(homeworkQuestionModel);
			if(addResult>0) {
				HomeworkModel homeworkModel =new HomeworkModel();
				homeworkModel.setId(Id);
				homeworkModel.setScore(fillBlanksQuestionModel.getScore());
				homeworkModel.setUpdatetime(new Date());
				homeworkMapper.updateHomeworkInfo(homeworkModel);
				JSONObject jsonObject = new JSONObject();
				jsonObject.put("id", homeworkQuestionModel.getId());
				JSONCommon.outputResultDataJson(CommonCode.SUCCESS, response, jsonObject);
			}else {
				JSONCommon.outputResultCodeJson(CommonCode.FAIL, response);
			}
		} catch (Exception e) {
			// TODO: handle exception
			JSONCommon.outputResultCodeJson(CommonCode.SERVER_ERROR, response);
			e.printStackTrace();
		}
	}

	
	public void addHomeworkSAQs(HttpServletRequest request, HttpServletResponse response,
			SAQQuestionModel saqQuestionModel, Integer Id) {
		try {
			Integer teacherId = (Integer)request.getSession().getAttribute("teacher_id");
			if(saqQuestionModel.getId()==null) {
				saqQuestionModel.setTeacher_id(teacherId);
				Integer addResult = saqQuestionMapper.addQuestion(saqQuestionModel);
				if(addResult<=0) {
					JSONCommon.outputResultCodeJson(CommonCode.FAIL, response);
					return;
				} 
			}
			HomeworkQuestionModel homeworkQuestionModel = new HomeworkQuestionModel();
			homeworkQuestionModel.setHomework_id(Id);
			homeworkQuestionModel.setSaq_id(saqQuestionModel.getId());
			homeworkQuestionModel.setQuestion_type(QuestionType.SAQ);
			Integer addResult = homeworkQuestionMapper.addHomeworkQuestion(homeworkQuestionModel);
			if(addResult>0) {
				HomeworkModel homeworkModel =new HomeworkModel();
				homeworkModel.setId(Id);
				homeworkModel.setScore(saqQuestionModel.getScore());
				homeworkModel.setUpdatetime(new Date());
				homeworkMapper.updateHomeworkInfo(homeworkModel);
				JSONObject jsonObject = new JSONObject();
				jsonObject.put("id", homeworkQuestionModel.getId());
				JSONCommon.outputResultDataJson(CommonCode.SUCCESS, response, jsonObject);
			}else {
				JSONCommon.outputResultCodeJson(CommonCode.FAIL, response);
			}
		} catch (Exception e) {
			// TODO: handle exception
			JSONCommon.outputResultCodeJson(CommonCode.SERVER_ERROR, response);
			e.printStackTrace();
		}
	}

	
	@Transactional
	public void distributeHomework(HttpServletRequest request, HttpServletResponse response,
			ClassHomeworkModel classHomeworkModel,Integer[] classIds) {
		try {
			Integer teacherId = (Integer)request.getSession().getAttribute("teacher_id");
			for (int i = 0; i < classIds.length; i++) {
				classHomeworkModel.setTeacher_id(teacherId);
				classHomeworkModel.setClass_id(classIds[i]);
				classHomeworkModel.setStatus(1);
				classHomeworkMapper.distributeHomework(classHomeworkModel);
			};
			HomeworkModel homeworkModel = new HomeworkModel();
			homeworkModel.setId(classHomeworkModel.getHomework_id());
			homeworkModel.setDeadline(classHomeworkModel.getDeadline());
			homeworkModel.setStatus(1);
			homeworkModel.setTeacher_correct(classHomeworkModel.getTeacher_correct());
			homeworkModel.setUpdatetime(new Date());
			homeworkMapper.updateHomeworkInfo(homeworkModel);
			JSONCommon.outputResultCodeJson(CommonCode.SUCCESS, response);
			
		} catch (Exception e) {
			// TODO: handle exception
			JSONCommon.outputResultCodeJson(CommonCode.SERVER_ERROR, response);
			e.printStackTrace();
		}
	}

	
	public void getDistributedClassList(HttpServletRequest request, HttpServletResponse response,ClassHomeworkModel classHomeworkModel) {
		try {
			List<ClassHomeworkModel> models= classHomeworkMapper.getDistributedClassList(classHomeworkModel);
			
			JSONArray array = new JSONArray();
			if(models.size()>0){
				for (ClassHomeworkModel model: models) {
					array.add(model.toJSONObject());
				}
			}
			JSONCommon.outputResultArrayJson(CommonCode.SUCCESS, response, array);
		} catch (Exception e) {
			e.printStackTrace();
			JSONCommon.outputResultCodeJson(CommonCode.FAIL, response);
		}
		
	}

	
	public void createHomework(HttpServletRequest request, HttpServletResponse response, HomeworkModel homeworkModel) {
		try {
			Integer teacherId = (Integer)request.getSession().getAttribute("teacher_id");
			homeworkModel.setTeacher_id(teacherId);
			homeworkModel.setStatus(0);
			homeworkModel.setScore(0f);
			if(homeworkMapper.createHomework(homeworkModel)>0) {
				JSONCommon.outputResultCodeJson(CommonCode.SUCCESS, response);
			} else {
				JSONCommon.outputResultCodeJson(CommonCode.FAIL, response);
			}
		} catch (Exception e) {
			// TODO: handle exception
			JSONCommon.outputResultCodeJson(CommonCode.SERVER_ERROR, response);
			e.printStackTrace();
		}
	}

	
	public void getHomeworkInfoByClass(HttpServletRequest request, HttpServletResponse response) {
		try {
			Integer classId = (Integer)request.getSession().getAttribute("class_id");
			Integer studentId = (Integer)request.getSession().getAttribute("student_id");
			List<HomeworkModel> models= homeworkMapper.getHomeworkInfoByClass(classId,studentId);
			
			JSONArray array = new JSONArray();
			if(models.size()>0){
				for (HomeworkModel model: models) {
					//此作业已经过了截止时间
					if(model.getDeadline().before(new Date())) {
						HomeworkStudentModel homeworkStudentModel = new HomeworkStudentModel();

						if(model.getTeacher_correct()==0 || (model.getStatus()!=null&&model.getStatus()==StudentHomewokStatus.DONE)){
							homeworkStudentModel.setStatus(StudentHomewokStatus.DONE);
							model.setStatus(StudentHomewokStatus.DONE);
						} else {
							homeworkStudentModel.setStatus(StudentHomewokStatus.CORRECTIING);
							model.setStatus(StudentHomewokStatus.CORRECTIING);
						}
						//status为null则表示此学生未提交过答案且此作业不需要由教师进行批改
						if(model.getStatus()==null) {
													
							homeworkStudentModel.setStudent_id(studentId);
							homeworkStudentModel.setHomework_id(model.getId());
							homeworkStudentModel.setScore(0f);
							homeworkStudentMapper.addStudentHomework(homeworkStudentModel);
						//status小于2则表示此学生已提交过答案
						} else if(model.getStatus()!=null &&model.getStatus()<=1){
							log.error("作业名称："+model.getHomework_name());
							AnwserStudentModel anwserStudentModel = new AnwserStudentModel();
							anwserStudentModel.setHomework_id(model.getId());
							anwserStudentModel.setStudent_id(studentId);
							Float sumscore=anwserStudentMapper.getSumScore(anwserStudentModel);
							homeworkStudentModel.setScore(sumscore==null?0f:sumscore);
							homeworkStudentModel.setStudent_id(studentId);
							homeworkStudentModel.setHomework_id(model.getId());
							homeworkStudentMapper.updateStudentHomework(homeworkStudentModel);
						}
					}
					array.add(model.toJSONObject());
				}
			}
			JSONCommon.outputResultArrayJson(CommonCode.SUCCESS, response, array);
		} catch (Exception e) {
			e.printStackTrace();
			JSONCommon.outputResultCodeJson(CommonCode.FAIL, response);
		}
	}

	
	@Transactional
	public void addStudentAnwser(HttpServletRequest request, HttpServletResponse response,
			AnwserStudentModel anwserStudentModel,Integer[] questionIds,String[] answers,Integer[] questionTypes) {
		
		try {
			HomeworkModel homeworkModel = homeworkMapper.getHomeworkInfoById(anwserStudentModel.getHomework_id()); 
			//判断此时是否已超过截止时间
			if(homeworkModel.getDeadline().before(new Date())) {
				JSONCommon.outputResultCodeJson(CommonCode.OVERTIME, response);
			} else {
				// 取得学生id
				Integer studentId = (Integer)request.getSession().getAttribute("student_id");
				// 设置答案的学生id、作业id、状态和完成时间
				HomeworkStudentModel homeworkStudentModel = new HomeworkStudentModel();
				homeworkStudentModel.setStudent_id(studentId);
				homeworkStudentModel.setHomework_id(anwserStudentModel.getHomework_id());
				homeworkStudentModel.setStatus(StudentHomewokStatus.SUBMITTED);
				homeworkStudentModel.setCompletedtime(new Date());
				// 根据数据库查重结果决定是新增学生作业或修改学生作业
				// 修改学生作业表的学生作业信息
				if(homeworkStudentMapper.duplicateValidate(homeworkStudentModel)>0) {
					homeworkStudentMapper.updateStudentHomework(homeworkStudentModel);
				}else {
					homeworkStudentMapper.addStudentHomework(homeworkStudentModel);
				}
				
				// 循环保存学生作业的每条答案
				for (int i = 0; i < questionIds.length; i++) {
					// 设置学生每条答案的基本信息
					anwserStudentModel.setStudent_id(studentId);
					anwserStudentModel.setQuestion_id(questionIds[i]);
					anwserStudentModel.setAnswer(answers[i]);
					anwserStudentModel.setId(null);
					anwserStudentModel.setQuestion_type(questionTypes[i]);
					// 当问题类型为1时为选择题
					if(questionTypes[i]==1) {
						// 取得此选择题的详细信息
						ChoiceQuestionModel choiceQuestionModel =choiceQuestionMapper.getChoicesById(anwserStudentModel.getQuestion_id());
						// 根据学生答案和标准答案的比对结果设置学生此条答案的分数
						if(choiceQuestionModel.getAnswer().equals(anwserStudentModel.getAnswer())) {
							anwserStudentModel.setScore(choiceQuestionModel.getScore().floatValue());
						}  else {
							anwserStudentModel.setScore(0f);
						}
					// 当问题类型为1时为填空题
					} else if(questionTypes[i]==2){
						// 取得此填空题的详细信息
						FillBlanksQuestionModel fillBlanksQuestionModel = fillBlanksQuestionMapper.getFillBlanksById(anwserStudentModel.getQuestion_id());
								// 根据学生答案和标准答案的比对结果设置学生此条答案的分数
								if(fillBlanksQuestionModel.getAnswer().equals(anwserStudentModel.getAnswer())) {
									anwserStudentModel.setScore(fillBlanksQuestionModel.getScore().floatValue());
								}  else {
									anwserStudentModel.setScore(0f);
								}
					// 当问题类型为3时为简答题
					}else if(questionTypes[i]==3) {
						// 取得此简答题的详细信息
						SAQQuestionModel saqQuestionModel = saqQuestionMapper.getSAQById(anwserStudentModel.getQuestion_id());
						// 将简答题答案关键词分割为一个String数组
						String[] keyWords = saqQuestionModel.getKey_word().split("，");
						// 设置每个关键词的分数
						float score_key = saqQuestionModel.getScore()/keyWords.length;
						float total = 0;
						// 根据关键词命中个数得到此答案的得分
						for (int j = 0; j < keyWords.length; j++) {
							
							if(anwserStudentModel.getAnswer().contains(keyWords[j])) {
								total += score_key;
							}
						}
						anwserStudentModel.setScore(total);
					}
					// 判断是新增答案还是修改答案
					if(anwserStudentMapper.duplicateValidate(anwserStudentModel)<=0) {
						// 调用dao层接口新增学生答案
						anwserStudentMapper.addStudentAnwser(anwserStudentModel);
					} else {
						// 调用dao层接口修改学生答案
						anwserStudentMapper.updateStudentAnwser(anwserStudentModel);
					}
					
				}
				// 调用共通方法返回成功结果给前端
				JSONCommon.outputResultCodeJson(CommonCode.SUCCESS, response);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			// 调用共通方法返回失败结果给前端
			JSONCommon.outputResultCodeJson(CommonCode.FAIL, response);
		}
	}

	
	public void getHomeworkChoices(HttpServletRequest request, HttpServletResponse response, Integer Id,
			Integer studentId) {
		try {
			List<ChoiceQuestionModel> models= choiceQuestionMapper.getChoicesByHidAndSId(Id, studentId);
			JSONArray array = new JSONArray();
			if(models.size()>0){
				for (ChoiceQuestionModel model: models) {
					array.add(model.toJSONObject());
				}
			}
			JSONCommon.outputResultArrayJson(CommonCode.SUCCESS, response, array);
		} catch (Exception e) {
			e.printStackTrace();
			JSONCommon.outputResultCodeJson(CommonCode.FAIL, response);
		}
	}

	
	public void getHomeworkFbs(HttpServletRequest request, HttpServletResponse response, Integer Id,
			Integer studentId) {
		try {
			List<FillBlanksQuestionModel> models= fillBlanksQuestionMapper.getFillBlanksByHidAndSid(Id,studentId);
			
			JSONArray array = new JSONArray();
			if(models.size()>0){
				for (FillBlanksQuestionModel model: models) {
					array.add(model.toJSONObject());
				}
				
			}
			JSONCommon.outputResultArrayJson(CommonCode.SUCCESS, response, array);
		} catch (Exception e) {
			e.printStackTrace();
			JSONCommon.outputResultCodeJson(CommonCode.FAIL, response);
		}
	}

	
	public void getHomeworkSAQs(HttpServletRequest request, HttpServletResponse response, Integer Id,
			Integer studentId) {
		try {
			List<SAQQuestionModel> models= saqQuestionMapper.getSAQByHidAndSid(Id,studentId);
			
			JSONArray array = new JSONArray();
			if(models.size()>0){
				for (SAQQuestionModel model: models) {
					array.add(model.toJSONObject());
				}
				
			}
			JSONCommon.outputResultArrayJson(CommonCode.SUCCESS, response, array);
		} catch (Exception e) {
			e.printStackTrace();
			JSONCommon.outputResultCodeJson(CommonCode.FAIL, response);
		}
	}

	
	public Float getSumscore(HttpServletRequest request, HttpServletResponse response,
			AnwserStudentModel anwserStudentModel) {
		return anwserStudentMapper.getSumScore(anwserStudentModel);
	}

	
	public void getStudentHomeworkByClass(HttpServletRequest request, HttpServletResponse response,
			Integer class_id,Integer homework_id) {
		
		try {
			List<StudentModel> models= studentMapper.getStudentsHomeWorkByClass(class_id,homework_id);
			
			JSONArray array = new JSONArray();
			if(models.size()>0){
				for (StudentModel model: models) {
					array.add(model.getStudentJSONObject());
					if (model.getHomeworkStudentModel()==null) {
						HomeworkStudentModel homeworkStudentModel = new HomeworkStudentModel();
						homeworkStudentModel.setHomework_id(homework_id);
						homeworkStudentModel.setStatus(StudentHomewokStatus.UNSUBMIT);
						homeworkStudentModel.setScore(0f);
						homeworkStudentModel.setStudent_id(model.getId());
						homeworkStudentMapper.addStudentHomework(homeworkStudentModel);
					}
				}
			}
			JSONCommon.outputResultArrayJson(CommonCode.SUCCESS, response, array);
		} catch (Exception e) {
			e.printStackTrace();
			JSONCommon.outputResultCodeJson(CommonCode.FAIL, response);
		}
	}

	
	public HomeworkModel getHomeworkInfoById(Integer id) {
		
		return homeworkMapper.getHomeworkInfoById(id);
	}

	
	public void correctStudentAnwser(HttpServletRequest request, HttpServletResponse response,
			AnwserStudentModel anwserStudentModel, Integer[] questionIds, Float[] scores) {
		try {
			for (int i = 0; i < questionIds.length; i++) {
				anwserStudentModel.setQuestion_id(questionIds[i]);
				anwserStudentModel.setScore(scores[i]);
				anwserStudentMapper.updateStudentAnwser(anwserStudentModel);
			}
			Float sumscore = anwserStudentMapper.getSumScore(anwserStudentModel);
			HomeworkStudentModel homeworkStudentModel = new HomeworkStudentModel();
			homeworkStudentModel.setScore(sumscore);
			homeworkStudentModel.setStatus(StudentHomewokStatus.DONE);
			homeworkStudentModel.setStudent_id(anwserStudentModel.getStudent_id());
			homeworkStudentModel.setHomework_id(anwserStudentModel.getHomework_id());
			homeworkStudentMapper.updateStudentHomework(homeworkStudentModel);
			JSONCommon.outputResultCodeJson(CommonCode.SUCCESS, response);
		} catch (Exception e) {
			e.printStackTrace();
			JSONCommon.outputResultCodeJson(CommonCode.FAIL, response);
		}
		
	}

	
	public void corrected(HttpServletRequest request, HttpServletResponse response, HomeworkModel homeworkModel) {
	
		try {
			homeworkModel.setStatus(StudentHomewokStatus.DONE);
			homeworkModel.setUpdatetime(new Date());
			homeworkMapper.updateHomeworkInfo(homeworkModel);
			ClassHomeworkModel classHomeworkModel = new ClassHomeworkModel();
			classHomeworkModel.setHomework_id(homeworkModel.getId());
			List<ClassHomeworkModel> classHomeworkModels=classHomeworkMapper.getDistributedClassList(classHomeworkModel);
			
			for (int i = 0; i < classHomeworkModels.size(); i++) {
				ClassHomeworkModel model = classHomeworkModels.get(i);
				List<StudentModel> studentModels = studentMapper.getStudentsHomeWorkByClass(model.getClass_id(), model.getHomework_id());
				for (int j = 0; j < studentModels.size(); j++) {
					StudentModel studentModel = studentModels.get(j);
					HomeworkStudentModel homeworkStudentModel = new HomeworkStudentModel();
					homeworkStudentModel.setHomework_id(model.getHomework_id());
					homeworkStudentModel.setStudent_id(studentModel.getId());
					AnwserStudentModel anwserStudentModel = new AnwserStudentModel();
					anwserStudentModel.setStudent_id(studentModel.getId());
					anwserStudentModel.setHomework_id(model.getHomework_id());
					Float sumscore = anwserStudentMapper.getSumScore(anwserStudentModel);
					if(sumscore!=null) {
						homeworkStudentModel.setScore(sumscore);
					}else {
						homeworkStudentModel.setScore(0f);
					}
					
					homeworkStudentModel.setStatus(StudentHomewokStatus.DONE);
					if(homeworkStudentMapper.duplicateValidate(homeworkStudentModel)>0) {
						
						homeworkStudentMapper.updateStudentHomework(homeworkStudentModel);
					}else {
						homeworkStudentMapper.addStudentHomework(homeworkStudentModel);
					}
				}
			}
			JSONCommon.outputResultCodeJson(CommonCode.SUCCESS, response);
		} catch (Exception e) {
			e.printStackTrace();
			JSONCommon.outputResultCodeJson(CommonCode.FAIL, response);
		}
	}
	
}

