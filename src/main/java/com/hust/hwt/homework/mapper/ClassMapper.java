package com.hust.hwt.homework.mapper;

import java.util.List;

import com.hust.hwt.homework.model.ClassModel;
import org.springframework.stereotype.Component;

/** 
 * @Description:ClassMapper.java
 * @author  huwentao 
 * @date 创建时间：2018年1月12日 上午11:00:20 
 * @version 1.0  
 */
@Component
public interface ClassMapper {

	/**
	 * 
	 * @Description:教师新增班级DAO层接口
	 * @author  huwentao 
	 * @date 创建时间：2018年1月12日 上午11:18:16
	 * @param
	 * @return
	 */
	public Integer addClass(ClassModel classModel);
	
	/**
	 * 
	 * @Description:分页取得班级信息接口
	 * @author  huwentao 
	 * @date 创建时间：2018年1月17日 上午10:35:25
	 * @param
	 * @return
	 */
	public List<ClassModel> getClassInfoByPage(ClassModel classModel);
	
	/**
	 * 
	 * @Description:根据学校id或教师id取得班级信息
	 * @author  huwentao 
	 * @date 创建时间：2018年1月18日 下午3:06:55
	 * @param
	 * @return
	 */
	public List<ClassModel> getClassInfo(ClassModel classModel);
	
	/**
	 * 
	 * @Description:验证班级密码是否匹配
	 * @author  huwentao 
	 * @date 创建时间：2018年1月18日 下午3:39:04
	 * @param
	 * @return
	 */
	public Integer verifyPassword(ClassModel classModel);
	
	/**
	 * 
	 * @Description:取得教师所管理班级总数
	 * @author  huwentao 
	 * @date 创建时间：2018年1月17日 上午10:41:31
	 * @param
	 * @return
	 */
	public Integer totalClassInfo(ClassModel classModel);
}
