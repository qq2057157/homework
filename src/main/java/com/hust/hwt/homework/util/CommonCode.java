package com.hust.hwt.homework.util;

import java.util.HashMap;
import java.util.Map;

/** 
 * @Description:CommonCode.java
 * @author  chengshiyang 
 * @date 创建时间：2018年1月11日 下午3:01:07 
 * @version 1.0  
 */
public class CommonCode {
	/** 200 OK K*/
	public static String SUCCESS = "99999";
	/** 200 OK V*/
	public static String SUCCESS_VALUE = "success";
	
	/** 00000 ERROR K*/
	public static String FAIL = "00000";
	
	/** 00000 ERROR V*/
	public static String FAIL_VALUE = "操作失败";
	
	/** 10001 班级密码错误 K*/
	public static String CLASS_PWD_ERROR = "10001";
	
	/** 00000 ERROR V*/
	public static String CLASS_PWD_ERROR_VALUE = "班级密码错误";
	
	/** 88888 重复的记录 K*/
	public static String DUPLICATE = "88888";
	
	/** 88888 ERROR V*/
	public static String DUPLICATE_VALUE = "数据库记录已存在";
	
	/** 66666 重复的记录 K*/
	public static String OVERTIME = "66666";
	
	/** 66666 ERROR V*/
	public static String OVERTIME_VALUE = "超过截止时间！";

	/** 500 EXCPTION K*/
	public static String SERVER_ERROR = "500";
	
	/** 500 EXCPTION V*/
	public static String SERVER_ERROR_VALUE = "服务器异常";
	
	/** 状态码存储列表 */
	public static Map<String, String> allCodeMap = new HashMap<String, String>();
	
	static{

		allCodeMap.put(SERVER_ERROR, SERVER_ERROR_VALUE);
		allCodeMap.put(FAIL, FAIL_VALUE);
		allCodeMap.put(SUCCESS, SUCCESS_VALUE);
		allCodeMap.put(CLASS_PWD_ERROR, CLASS_PWD_ERROR_VALUE);
		allCodeMap.put(DUPLICATE, DUPLICATE_VALUE);
		allCodeMap.put(OVERTIME, OVERTIME_VALUE);
	}
	
	/**
	 * 获取状态码对应的消息
	 * @param code 状态码
	 * @return
	 */
	public static String getMessage(String code) {
		return allCodeMap.get(code);
	}
}
