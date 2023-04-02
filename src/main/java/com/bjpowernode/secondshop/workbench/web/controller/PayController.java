package com.bjpowernode.secondshop.workbench.web.controller;

import com.bjpowernode.secondshop.conmons.Constants;
import com.bjpowernode.secondshop.conmons.ReturnMessage;
import com.bjpowernode.secondshop.conmons.utils.DateUtils;
import com.bjpowernode.secondshop.settings.domain.User;
import com.bjpowernode.secondshop.workbench.domain.GoodsOrder;
import com.bjpowernode.secondshop.workbench.service.GoodsOrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class PayController {
    @Autowired
    GoodsOrderService goodsOrderService;
    @RequestMapping("/workbench/pay/toOrderDetailPage.do")
    public String toOrderDetailPage(String goodsOrderId, HttpServletRequest request, HttpSession session){
        GoodsOrder goodsOrder = goodsOrderService.queryGoodsOrderById(goodsOrderId);
        User user = (User)session.getAttribute(Constants.SESSION_USER);
        Map<String,Object>map = new HashMap<>();
        map.put("goodsOrderId",goodsOrderId);
        map.put("customerId",user.getId());
        List<GoodsOrder> othersOrder = goodsOrderService.queryOthersGoodsOrder(map);
        request.setAttribute("goodsOrder",goodsOrder);
        if(othersOrder != null){
            request.setAttribute("othersOrder",othersOrder);
        }
        return "workbench/pay/order";
    }
    @RequestMapping("/workbench/pay/transaction.do")
    @ResponseBody
    public Object transaction(String goodsOrderId){
            //封装参数
        Map<String,Object>map = new HashMap<>();
        map.put("goodsOrderId",goodsOrderId);
        map.put("statusId",1);
        map.put("endTime", DateUtils.formatDateTime(new Date()));
        ReturnMessage res = new ReturnMessage();
        try {
            int i = goodsOrderService.modifyGoodsOrder(map);
            if(i == 1){
                res.setCode(Constants.RETURN_OBJECT_CODE_SUCCESS);
            }else{
                res.setCode(Constants.RETURN_OBJECT_CODE_FAIL);
                res.setMessage("系统忙，请稍后....");
            }
        } catch (Exception e) {
            res.setCode(Constants.RETURN_OBJECT_CODE_FAIL);
            res.setMessage("系统忙，请稍后....");
            e.printStackTrace();
        }
        return res;
    }
    @RequestMapping("/workbench/pay/cancelGoodsOrder.do")
    @ResponseBody
    public Object cancelGoodsOrder(String goodsOrderId){
        ReturnMessage res = new ReturnMessage();
        try {
            int i = goodsOrderService.moveGoodsOrderById(goodsOrderId);
            if(i == 1){
                res.setCode(Constants.RETURN_OBJECT_CODE_SUCCESS);
            }else{
                res.setCode(Constants.RETURN_OBJECT_CODE_FAIL);
                res.setMessage("系统忙，请稍后....");
            }
        } catch (Exception e) {
            res.setCode(Constants.RETURN_OBJECT_CODE_FAIL);
            res.setMessage("系统忙，请稍后....");
            e.printStackTrace();
        }
        return res;
    }
}
