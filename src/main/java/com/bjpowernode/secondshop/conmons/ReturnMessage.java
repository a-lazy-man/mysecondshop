package com.bjpowernode.secondshop.conmons;

/**
 * 用于返回前台信息的类
 */
public class ReturnMessage {
    private String message;
    private String code;

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    @Override
    public String toString() {
        return "ReturnMessage{" +
                "message='" + message + '\'' +
                ", code='" + code + '\'' +
                '}';
    }
}
