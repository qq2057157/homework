package com.hust.hwt.homework.mapper;

import com.hust.hwt.homework.model.TeacherModel;
import org.springframework.stereotype.Component;

/** 
 * @Description:TeacherMapper.java
 * @author  huwentao 
 * @date 创建时间：2018年1月10日 下午5:17:46 
 * @version 1.0  
 */
@Component
public interface TeacherMapper {
	public TeacherModel teacherLogin(TeacherModel teacherModel);
	public Integer teacherRegister(TeacherModel teacherModel);
}
