package com.bjpowernode.secondshop.conmons.utils;

import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * 专门对日期类型的数据格式化的工具类
 */
public class DateUtils {
    /**
     * 对指定时间对象格式化成字 yyyy-MM-dd HH:mm:ss
     * @param date
     * @return String
     */
    public static String formatDateTime(Date date){
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

        return sdf.format(date);
    }
}
