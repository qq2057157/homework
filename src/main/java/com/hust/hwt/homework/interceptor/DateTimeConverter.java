package com.hust.hwt.homework.interceptor;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.springframework.core.convert.converter.Converter;

/**
 * @Description:
 * @author:chengshiyang
 * @date:2018年3月13日
 * @version 1.0  
 */
public class DateTimeConverter implements Converter<String, Date> {


	@Override
	public Date convert(String arg0) {
		SimpleDateFormat datetimeFormat = new SimpleDateFormat(
				"yyyy-MM-dd HH:mm:ss");
	 	try {
			Date date= datetimeFormat.parse(arg0);
	          return date;
		} catch (ParseException e) {
			System.out.println("字符串转时间转换失败");
			e.printStackTrace();
		}
		return null;
	}

}

