package com.hust.hwt.homework.interceptor;

import java.util.Collections;
import java.util.Map;
import java.util.Map.Entry;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import lombok.extern.slf4j.Slf4j;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

/** 
 * @Description:UserLoginInterceptor.java
 * @author  huwentao 
 * @date 创建时间：2018年1月11日 上午10:34:01 
 * @version 1.0  
 */
@Component
@Slf4j
public class UserLoginInterceptor implements HandlerInterceptor{

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {

		Map<String,String[]> paramMap = Collections.unmodifiableMap(request.getParameterMap());
		for (Entry<String, String[]> entry : paramMap.entrySet()) {
			if(entry.getValue().length>1) {
				for (int i = 0; i < entry.getValue().length; i++) {
					log.error("数组名:"+entry.getKey()+i+"；第"+(i+1)+"个参数值是："+entry.getValue()[i]);
				}
			}else
			{
				log.error("参数名:"+entry.getKey()+"；参数值："+entry.getValue()[0]);
			}
		}
		String uri = request.getRequestURI();

		if(uri.startsWith("/homework")){
//			request.getSession().setAttribute("id", 1);
//			request.getSession().setAttribute("name", "程诗扬");
//			request.getSession().setAttribute("school_id", 1);
			return true;
		} else if(uri.startsWith("/user")){
			return true;
		} else {
			response.sendRedirect("/login.jsp");
		}
		return false;
	}

	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {

	}

	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) throws Exception {

	}
}
