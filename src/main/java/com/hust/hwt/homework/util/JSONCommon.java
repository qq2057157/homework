package com.hust.hwt.homework.util;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map.Entry;

import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.springframework.util.CollectionUtils;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;

/** 
 * @Description:JSONCommon.java
 * @author  huwentao 
 * @date 创建时间：2018年1月11日 下午2:52:39 
 * @version 1.0  
 */
public class JSONCommon {

	/**
	 * 
	 * @Description:返回请求状态信息和数据
	 * @author  huwentao 
	 * @date 创建时间：2018年1月11日 下午4:00:53
	 * @param
	 * @return
	 */
	public static void outputResultDataJson(String code,HttpServletResponse response,JSONObject JsonData){
		
		JSONObject jsonResult = new JSONObject();
		
		if(!StringUtils.isEmpty(code)){
			jsonResult.put("code", code);
			jsonResult.put("info", CommonCode.getMessage(code));
			jsonResult.put("data", JsonData);
		}
		
		outputJSONResult(jsonResult.toJSONString(), response);
	}
	/**
	 * 
	 * @Description:返回请求状态信息和数组
	 * @author  huwentao 
	 * @date 创建时间：2018年1月11日 下午3:59:29
	 * @param
	 * @return
	 */
	public static void outputResultArrayJson(String code,HttpServletResponse response,JSONArray JsonArray){
		
		JSONObject jsonResult = new JSONObject();
		
		if(!StringUtils.isEmpty(code)){
			jsonResult.put("code", code);
			jsonResult.put("info", CommonCode.getMessage(code));
			jsonResult.put("array", JsonArray);
		}
		
		outputJSONResult(jsonResult.toJSONString(), response);
	}

	/**
	 * 
	 * @Description:TODO
	 * @author  huwentao 
	 * @date 创建时间：2018年1月17日 上午10:49:20
	 * @param
	 * @return
	 */
	public static void outputResultArrayJson(String code,HttpServletResponse response,JSONArray JsonArray,JSONObject jsonObject){
		
		JSONObject jsonResult = new JSONObject();
		
		if(!StringUtils.isEmpty(code)){
			jsonResult.put("code", code);
			jsonResult.put("info", CommonCode.getMessage(code));
			jsonResult.put("array", JsonArray);
			jsonResult.put("pageInfo", jsonObject);
		}
		
		outputJSONResult(jsonResult.toJSONString(), response);
	}
	/**
	 * 
	 * @Description:TODO
	 * @author  huwentao 
	 * @date 创建时间：2018年1月11日 下午3:06:51
	 * @param
	 * @return
	 */
	public static void outputResultCodeJson(String code,HttpServletResponse response){
		
		JSONObject jsonResult = new JSONObject();
		
		if(!StringUtils.isEmpty(code)){
			jsonResult.put("code", code);
			jsonResult.put("info", CommonCode.getMessage(code));
		}
		outputJSONResult(jsonResult.toJSONString(), response);
	}
	/**
	 * 
	 * @Description:异步返回JSON消息方法
	 * @author  huwentao 
	 * @date 创建时间：2018年1月11日 下午3:04:08
	 * @param
	 * @return
	 */
	public static void outputJSONResult(String result,HttpServletResponse response){
		response.setHeader("ContentType", "text/json;charset=UTF-8");
		response.setHeader("Cache-Control", "no-cache");
		response.setCharacterEncoding("utf-8");
		
		try {
			PrintWriter pw = response.getWriter();
			
			if(!StringUtils.isEmpty(result)){
				pw.write(result);
			} else {
				pw.write(returnJSONResult(null));
			}
			pw.flush();
			pw.close();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	/**
	 * 
	 * @Description:根据传递的map集合封装json格式的数据并返回，如果map为空，则返回错误状态码500
	 * 所有的json数据外面包含一层result标签
	 * @author  huwentao 
	 * @date 创建时间：2018年1月11日 下午3:05:28
	 * @param
	 * @return
	 */
	
	public static String returnJSONResult(HashMap<String, String> resultParamMap){
		JSONObject jsonData = new JSONObject();
		if(!CollectionUtils.isEmpty(resultParamMap)){
			for(Entry<String, String> entry : resultParamMap.entrySet()){
				jsonData.put(entry.getKey(), entry.getValue());
			}
		}else{
			jsonData.put("code", CommonCode.SERVER_ERROR);
			jsonData.put("info", CommonCode.SERVER_ERROR_VALUE);
		}
		return jsonData.toJSONString();
	}
}
