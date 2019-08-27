package com.hust.hwt.homework.mapper;

import java.util.List;

import com.hust.hwt.homework.model.SchoolModel;
import org.springframework.stereotype.Component;

/** 
 * @Description:SchoolMapper.java
 * @author  huwentao 
 * @date 创建时间：2018年1月11日 下午2:38:26 
 * @version 1.0  
 */
@Component
public interface SchoolMapper {

	public List<SchoolModel> getSchoolInfo();

}
