package com.hust.hwt.homework.util;

import lombok.Data;

public enum ResultCode {

    SUCCESS(200, "请求成功"),
    FAIL(999, "请求失败"),
    SERVER_ERROR(500, "服务器发生错误"),
    ;

    private int code;
    private String info;

    ResultCode(int code, String info) {
        this.code = code;
        this.info = info;
    }

    public int getCode() {
        return code;
    }

    public String getInfo() {
        return info;
    }

}