package com.bjpowernode.secondshop.conmons.utils;

import java.util.UUID;

public class UUIDUtils {
    /**
     * 获取uuid的方法
     * @return
     */
    public static String generateUUID(){
        return UUID.randomUUID().toString().replaceAll("-", "");
    }
}
