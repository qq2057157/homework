package com.hust.hwt.homework.util;

import com.alibaba.fastjson.JSON;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class ResultCommon {

    private ResultCommon(){
    }
    public static Map<String,String> success(){
        Map<String,String> result = getCodeMap(ResultCode.SUCCESS);
        return result;
    }

    public static Map<String,String> success(Map<String, List<?>> resultMap){
        Map<String,String> result = getCodeMap(ResultCode.SUCCESS);
        result.put("data", JSON.toJSONString(resultMap));
        return result;
    }

    public static Map<String,String> fail(){
        Map<String,String> result = getCodeMap(ResultCode.FAIL);
        return result;
    }

    public static Map<String,String> error(){
        Map<String,String> result = getCodeMap(ResultCode.SERVER_ERROR);
        return result;
    }
    public static Map<String,String> getCodeMap(ResultCode resultCode){
        Map<String,String> result = new HashMap<>();
        result.put("code",String.valueOf(resultCode.getCode()));
        result.put("info",resultCode.getInfo());
        return result;
    }
}
