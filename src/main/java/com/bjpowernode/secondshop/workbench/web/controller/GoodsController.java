package com.bjpowernode.secondshop.workbench.web.controller;

import com.bjpowernode.secondshop.conmons.Constants;
import com.bjpowernode.secondshop.conmons.ReturnMessage;
import com.bjpowernode.secondshop.conmons.utils.DateUtils;
import com.bjpowernode.secondshop.conmons.utils.UUIDUtils;
import com.bjpowernode.secondshop.settings.domain.FirstType;
import com.bjpowernode.secondshop.settings.domain.SecondType;
import com.bjpowernode.secondshop.settings.domain.User;
import com.bjpowernode.secondshop.settings.service.FirstTypeService;
import com.bjpowernode.secondshop.settings.service.SecondTypeService;
import com.bjpowernode.secondshop.settings.service.UserService;
import com.bjpowernode.secondshop.workbench.domain.*;
import com.bjpowernode.secondshop.workbench.service.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.lang.String;
import java.util.*;
@Controller
public class GoodsController {
    private SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    //注入service
    @Autowired
    private GoodsService goodsService;
    @Autowired
    private SecondTypeService secondTypeService;
    //注入UserService
    @Autowired
    private UserService userService;
    //注入ImageService
    @Autowired
    private ImageService imageService;
    //注入CollectService
    @Autowired
    private CollectService collectService;
    @Autowired
    private MessageService messageService;
    @Autowired
    private RemarkService remarkService;
    @Autowired
    private FirstTypeService firstTypeService;
    @Autowired
    private GoodsOrderService goodsOrderService;
    @RequestMapping("/workbench/toGoodsPage.do")
    public String toGoodsPage(Integer secondTypeId,HttpServletRequest request, HttpSession session) {
//        Map<String,Object>map = new HashMap<>();
//        map.put("startIndex", 0);
//        map.put("pageSize", 6);
//        List<Goods> goods = goodsService.pageQueryByConditions(map);
//        request.setAttribute("goods",goods);
        //查询出所有的一级的商品类型
        List<FirstType> firstTypes = firstTypeService.queryAllFirstType();
        request.setAttribute("firstTypes",firstTypes);
        //查询出所有的二级的商品的类型
        List<SecondType> secondTypes = secondTypeService.queryAllSecondType();
        request.setAttribute("secondTypes",secondTypes);
        //请求转发跳转到系统首页面
        return "workbench/index";
    }

    @RequestMapping("/workbench/goods/showSecondType.do")
    @ResponseBody
    public Object showSecondType(Integer firstTypeId)   {
        List<SecondType> secondTypes = secondTypeService.querySecondTypeByFirstTypeId(firstTypeId);
        return secondTypes;
    }

    @RequestMapping("/workbench/goods/publishGoods.do")
    @ResponseBody
    public Object publishGoods(HttpSession session,
                               String name,
                               int firstType,
                               int secondType,
                               float prise,
                               String describe,
                               int goodsNum) throws ParseException {
        Map<String, Object> map = new HashMap<>();
        User u = (User) session.getAttribute(Constants.SESSION_USER);
        //封装参数
        Goods goods = new Goods();
        goods.setName(name);
        goods.setFirstTypeId(firstType);
        goods.setSecondTypeId(secondType);
        goods.setPrise(prise);
        goods.setDescribe(describe);
        goods.setGoodsNum(goodsNum);
        int i = goodsService.queryGoodsNum();
        //给goods生成主键  即调用goodsService 查询goods表中有多少条记录
        goods.setId(i + 1);
        //给goods生成商品上传时间
        String uploadDate = DateUtils.formatDateTime(new Date());
        goods.setUploadDate(uploadDate);
        //给goods设置默认的图片
        goods.setPhotoUrl("image/goods/default/nophoto.jpg");
        //给goods设置状态值
        goods.setStatusId(1);
        //给goods设置userId
        goods.setUserId(u.getId());
        ReturnMessage returnMessage = new ReturnMessage();
        try {
            int success = goodsService.publishGoods(goods);
            if (success == 1) {
                returnMessage.setCode(Constants.RETURN_OBJECT_CODE_SUCCESS);
            } else {
                returnMessage.setCode(Constants.RETURN_OBJECT_CODE_FAIL);
                returnMessage.setMessage("系统忙，请稍后！！！");
            }
        } catch (Exception e) {
            returnMessage.setCode(Constants.RETURN_OBJECT_CODE_FAIL);
            returnMessage.setMessage("系统忙，请稍后！！！");
            e.printStackTrace();
        }
        map.put("returnMessage", returnMessage);
        map.put("id", goods.getId());
        return map;
    }

    @RequestMapping("/workbench/goods/toGoodsDetailPage.do")
    @ResponseBody
    public Object toGoodsDetailPage(@RequestParam("multipartFiles") MultipartFile[] multipartFiles,
                                    int id) {
        ReturnMessage returnMessage = new ReturnMessage();
        Map<String, Object> map = new HashMap<>();
        map.put("id", id);
        //遍历mutipartFile数组
        for (int i = 0; i < multipartFiles.length; i++) {
            //定义上传文件的存放位置
            String filePath = "D:\\bishe-useravatar\\";
            String virtualPath = "bishe-useravatar/";
            String fileName = multipartFiles[i].getOriginalFilename();
            String newFilePath = filePath + fileName; //新文件的路径
            try {
                multipartFiles[i].transferTo(new File(newFilePath));  //将传来的文件写入新建的文件
            } catch (IllegalStateException | IOException e) {
                e.printStackTrace();
            }
            if (i == 0) {
                map.put("photoUrl", virtualPath + fileName);
                //修改goods表中的图片路径
                int count1 = goodsService.modifyPhotoUrlByGoodsId(map);
                if (count1 != 1) {
                    throw new RuntimeException("系统忙，请稍后！！！");
                }
            } else {
                //其它记录全部插入到image表中
                Image image = new Image();   //id, good_id,  name, url
                //给image实体类设置主键
                image.setId(UUIDUtils.generateUUID());
                //给image实体类设置goodsId
                image.setGoodId(id);
                //给image实体类设置name
                image.setName(fileName);
                //给image实体类设置url
                image.setUrl(virtualPath + fileName);
                int count2 = imageService.addImage(image);
                if (count2 != 1) {
                    throw new RuntimeException("系统忙，请稍后！！！");
                }
            }

        }
        returnMessage.setCode(Constants.RETURN_OBJECT_CODE_SUCCESS);
        return returnMessage;
    }

    @RequestMapping("/workbench/goods/toGoodsDetail.do")
    public String toGoodsDetail(Integer goodsId, HttpServletRequest request, HttpSession session) {
        Goods good = goodsService.queryGoodsByGoodsId(goodsId);
        request.setAttribute("good", good);
        //查看当前商品是否是当前用户的收藏商品
        Collect collect = collectService.queryCollectByGoodsId(goodsId);
        User user = (User) session.getAttribute(Constants.SESSION_USER);
        if (collect != null && collect.getUserId().equals(user.getId())) {
            request.setAttribute("isCollect", Constants.RETURN_OBJECT_CODE_SUCCESS);
        } else {//当前商品没有被当前用户收藏过
            request.setAttribute("isCollect", Constants.RETURN_OBJECT_CODE_FAIL);
        }
        //查出与该商品的一级类型相关的商品
        Integer secondTypeId = good.getSecondTypeId();
        List<Goods> relatedGoods = goodsService.queryRelatedGoodsBySecondTypeId(secondTypeId);
        //将数据存储到request域中
        request.setAttribute("relatedGoods", relatedGoods);
        //查询该商品的除主图片的之外的所有的图片
        List<Image> images = imageService.queryImagesByGoodsId(goodsId);
        request.setAttribute("images", images);
        //查询该商品的所有的留言
        List<Message> messages = messageService.queryMessagesByGoodId(goodsId);
        request.setAttribute("messages", messages);
        StringBuffer messageIdsStr = new StringBuffer();
        for(Message message : messages){
            messageIdsStr.append(message.getId()+",");
        }
        String[] messageIds = messageIdsStr.toString().split(",");
        List<Remark> remarks = remarkService.queryRemarksByMessageId(messageIds);
        request.setAttribute("remarks", remarks);
        return "workbench/goods/goodsDetail";
    }

    @RequestMapping("/settings/qx/user/toSellerDetailMes.do")
    public String toSellerDetailMes(String userId, HttpServletRequest request) {
        //根据userId查询该卖家的详细信息
        User user = userService.queryUserByUserId(userId);
        //根据userId在goods表中查询所有该卖家的商品
        List<Goods> goods = goodsService.queryGoodsByUserId(userId);
        //查出最新发布的物品
        List<Goods> latestGoods = goodsService.queryGoodsByUploadTimeForFive();
        request.setAttribute("user", user);
        request.setAttribute("goods", goods);
        request.setAttribute("latestGoods", latestGoods);
        return "settings/qx/user/sellerDetailMes";
    }

    @RequestMapping("/workbench/goods/CollectedGoods")
    @ResponseBody
    public Object CollectedGoods(int goodsId, HttpSession session) {
        //id good_id good_name user_id
        Collect collect = new Collect();
        //设置主键id
        collect.setId(UUIDUtils.generateUUID());
        //设置商品id
        collect.setGoodId(goodsId);
        //设置商品的名称
        Goods goods = goodsService.queryGoodsByGoodsId(goodsId);
        collect.setGoodName(goods.getName());
        //设置userId
        User user = (User) session.getAttribute(Constants.SESSION_USER);
        collect.setUserId(user.getId());
        ReturnMessage returnMessage = new ReturnMessage();
        try {
            int i = collectService.addCollectedGoods(collect);
            if (i == 1) {
                returnMessage.setCode(Constants.RETURN_OBJECT_CODE_SUCCESS);
            } else {
                returnMessage.setCode(Constants.RETURN_OBJECT_CODE_FAIL);
                returnMessage.setMessage("系统忙，请稍后!!!");
            }
        } catch (Exception e) {
            returnMessage.setCode(Constants.RETURN_OBJECT_CODE_FAIL);
            returnMessage.setMessage("系统忙，请稍后!!!");
            e.printStackTrace();
        }
        return returnMessage;
    }
    @RequestMapping("/workbench/goods/publishMessage.do")
    @ResponseBody
    public Object publishMessage(
            Integer goodId,
            String fromUserId,
            String fromUserName,
            String content) {
        //封装参数
        Message message = new Message();
        //设置主键id
        message.setId(UUIDUtils.generateUUID());
        //设置该留言的商品的id
        message.setGoodId(goodId);
        //设置发布留言的用户的id
        message.setFromUserId(fromUserId);
        //设置发布留言的姓名
        message.setFromUserName(fromUserName);
        //设置留言的内容
        message.setContent(content);
        //设置留言的发布的时间
        message.setUploadDate(DateUtils.formatDateTime(new Date()));
        //设置留言的状态
        message.setStatus(0);
        ReturnMessage returnMessage = new ReturnMessage();
        try {
            int i = messageService.addMessage(message);
            if (i == 1) {
                returnMessage.setCode(Constants.RETURN_OBJECT_CODE_SUCCESS);
            } else {
                returnMessage.setCode(Constants.RETURN_OBJECT_CODE_FAIL);
                returnMessage.setMessage("系统忙，请稍后！！！");
            }
        } catch (Exception e) {
            returnMessage.setCode(Constants.RETURN_OBJECT_CODE_FAIL);
            returnMessage.setMessage("系统忙，请稍后！！！");
            e.printStackTrace();
        }
        Map<String, Object> map = new HashMap<>();
        map.put("justMessage", message);
        map.put("returnMessage", returnMessage);
        return map;
    }
    @RequestMapping("/workbench/goods/replyToMessage.do")
    @ResponseBody
    public Object replyToMessage(String remarkUserId,
                                 String remarkUserName,
                                 String toUserId,
                                 String toUserName,
                                 String remarkContent,
                                 String messageId){
        //封装参数
        Remark remark = new Remark();
        remark.setId(UUIDUtils.generateUUID());
        remark.setRemarkUserId(remarkUserId);
        remark.setRemarkUserName(remarkUserName);
        remark.setToUserId(toUserId);
        remark.setToUserName(toUserName);
        remark.setRemarkContent(remarkContent);
        remark.setMessageId(messageId);
        //设置评论的主键
        remark.setId(UUIDUtils.generateUUID());
        //设置时间
        remark.setUploadDate(DateUtils.formatDateTime(new Date()));
        //设置状态
        remark.setStatusId(0);
        Map<String,Object>map = new HashMap<>();
        ReturnMessage res = new ReturnMessage();
        try {
            int i = remarkService.addRemark(remark);
            if(i == 1){
                res.setCode(Constants.RETURN_OBJECT_CODE_SUCCESS);
            }else{
                res.setCode(Constants.RETURN_OBJECT_CODE_FAIL);
                res.setMessage("系统忙，请稍后!!!");
            }
        } catch (Exception e) {
            res.setCode(Constants.RETURN_OBJECT_CODE_FAIL);
            res.setMessage("系统忙，请稍后!!!");
            e.printStackTrace();
        }
        map.put("justRemark", remark);
        map.put("res",res);
        return map;
    }
    @RequestMapping("/workbench/pageQueryByConditions.do")
    @ResponseBody
    public Object pageQueryByConditions(Integer secondTypeId,
                                        String goodsName,
                                        Integer pageNum,
                                        Integer pageSize){
        //封装参数
        Map<String,Object>map = new HashMap<>();
        if(secondTypeId != null){
            //设置二级商品类型id
            map.put("secondTypeId",secondTypeId);
        }
        if(goodsName != null){
            //设置商品的名称
            map.put("goodsName",goodsName);
        }
        //设置startIndex
        int startIndex = (pageNum-1)*pageSize;
        map.put("startIndex", startIndex);
        //设置每页显示记录条数
        map.put("pageSize", pageSize);
        //查询满足条件的商品
        List<Goods> goods = goodsService.pageQueryByConditions(map);
        //查询满足条件的总记录条数
        int totalRows = goodsService.pageQueryCountsByConditions(map);
        Map<String,Object>hashMap = new HashMap<>();
        hashMap.put("pageSelectGoods", goods);
        hashMap.put("totalRows",totalRows);
        return hashMap;
    }
    @RequestMapping("/workbench/goods/querySellerDetailMes.do")
    @ResponseBody
    public Object querySellerDetailMes(int goodsId){
        //根据商品i查询到该商品的卖家的id
        String userId = goodsService.queryUserIdByGoodsId(goodsId);
        User seller = userService.queryUserByUserId(userId);
        return seller;
    }
    @RequestMapping("/workbench/goods/purchase.do")
    @ResponseBody
    public Object purchase(HttpSession session,int goodsId,String goodsName,String sellerId,Double money){
        User customer = (User)session.getAttribute(Constants.SESSION_USER);
        GoodsOrder order = new GoodsOrder();
        //封装参数
        order.setGoodId(goodsId);
        order.setGoodName(goodsName);
        order.setSellerId(sellerId);
        order.setMoney(money);
        //生成订单编号
        order.setId(UUIDUtils.generateUUID());
        //生成买家
        order.setCustomerId(customer.getId());
        //生成订单创建时间
        order.setSubmitTime(DateUtils.formatDateTime(new Date()));
        //生成订单状态
        order.setStatusId(0); //表示该订单交易正在进行中
        ReturnMessage res = new ReturnMessage();
        try {
            int i = goodsOrderService.addGoodsOrder(order);
            if(i == 1){
                res.setCode(Constants.RETURN_OBJECT_CODE_SUCCESS);
            }else{
                res.setCode(Constants.RETURN_OBJECT_CODE_FAIL);
                res.setMessage("订单创建失败，请联系管理员");
            }
        } catch (Exception e) {
            res.setCode(Constants.RETURN_OBJECT_CODE_FAIL);
            res.setMessage("订单创建失败，请联系管理员");
            e.printStackTrace();
        }
        Map<String,Object>map = new HashMap<>();
        map.put("res",res);
        map.put("goodsOrder", order);
        return map;
    }
    //完成取消收藏
    @RequestMapping("/settings/qx/user/CancelCollect")
    @ResponseBody
    public Object CancelCollect(Integer goodsId, String userId){
        ReturnMessage rm = new ReturnMessage();
        Map<String,Object>map = new HashMap<>();
        map.put("goodsId",goodsId);
        map.put("userId",userId);
        try {
            int i = collectService.moveCollectByGoodsIdAndUserId(map);
            if(i == 1){
                rm.setCode(Constants.RETURN_OBJECT_CODE_SUCCESS);
            }else{
                rm.setCode(Constants.RETURN_OBJECT_CODE_FAIL);
                rm.setMessage("系统忙，请稍后重试！！！");
            }
        } catch (Exception e) {
            rm.setCode(Constants.RETURN_OBJECT_CODE_FAIL);
            rm.setMessage("系统忙，请稍后重试！！！");
            e.printStackTrace();
        }
        return rm;
    }
}
