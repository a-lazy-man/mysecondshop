import com.bjpowernode.secondshop.conmons.utils.DateUtils;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

public class DateTest {

    public static void main(String[] args) throws ParseException {
        String str = "5508f752880046e5a958a0d111ad786e,795f534c20c14174bd9ed4af4265bbc2,aabd0dbecfad449ca22157143e70ee4d,d8c624688e0045f48e451c316ae7e101,ec3dcdcf878549b29ca915c9ff715fbb";
        String[] strs = str.split(",");
        for (int i = 0; i < strs.length; i++) {
            System.out.println(strs[i]);
        }
    }
}
