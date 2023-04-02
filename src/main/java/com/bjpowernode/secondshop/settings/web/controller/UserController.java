package com.bjpowernode.secondshop.settings.web.controller;

import com.bjpowernode.secondshop.conmons.Constants;
import com.bjpowernode.secondshop.conmons.ReturnMessage;
import com.bjpowernode.secondshop.conmons.utils.DateUtils;
import com.bjpowernode.secondshop.conmons.utils.UUIDUtils;
import com.bjpowernode.secondshop.settings.domain.FirstType;
import com.bjpowernode.secondshop.settings.domain.SecondType;
import com.bjpowernode.secondshop.settings.domain.User;
import com.bjpowernode.secondshop.settings.mapper.FirstTypeMapper;
import com.bjpowernode.secondshop.settings.mapper.SecondTypeMapper;
import com.bjpowernode.secondshop.settings.service.FirstTypeService;
import com.bjpowernode.secondshop.settings.service.SecondTypeService;
import com.bjpowernode.secondshop.settings.service.UserService;
import com.bjpowernode.secondshop.workbench.domain.Goods;
import com.bjpowernode.secondshop.workbench.domain.GoodsOrder;
import com.bjpowernode.secondshop.workbench.mapper.GoodsMapper;
import com.bjpowernode.secondshop.workbench.service.CollectService;
import com.bjpowernode.secondshop.workbench.service.GoodsOrderService;
import com.bjpowernode.secondshop.workbench.service.GoodsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.*;
import java.io.File;
import java.io.IOException;
import java.util.*;

@Controller
public class UserController {
    @Autowired
    private UserService userService;
    @Autowired
    private FirstTypeService firstTypeService;
    @Autowired
    private SecondTypeService secondTypeService;
    @Autowired
    private GoodsService goodsService;
    @Autowired
    private CollectService collectService;
    @Autowired
    private GoodsOrderService goodsOrderService;
    @RequestMapping("/settings/qx/user/toLogin.do")
    public String toLogin() {
        return "settings/qx/user/login";
    }

    @RequestMapping("/settings/qx/user/login.do")
    @ResponseBody
    public Object login(String userEmail,
                        String userPwd,
                        Boolean isRemPwd,
                        Integer flag,
                        HttpServletResponse response,
                        HttpSession session) {
        User user = new User();
        user.setUserEmail(userEmail);
        user.setUserPwd(userPwd);
        User u = userService.queryUserByUserEmailAndUserPwd(user);
        ReturnMessage returnMessage = new ReturnMessage();
        if (u != null) {//登陆成功
            returnMessage.setCode(Constants.RETURN_OBJECT_CODE_SUCCESS);
            if(flag == null ||flag != 1){//用户登录
                if("1".equals(u.getState())){//账号可用
                    //将用户信息存储到会话域中
                    session.setAttribute(Constants.SESSION_USER, u);
                    if (isRemPwd != null && isRemPwd) {
                        //实现十天内记住密码
                        Cookie cookie1 = new Cookie("userEmail", userEmail);
                        cookie1.setMaxAge(10 * 24 * 60 * 60);
                        cookie1.setPath("/secondshop");
                        response.addCookie(cookie1);
                        Cookie cookie2 = new Cookie("userPwd", userPwd);
                        cookie2.setMaxAge(10 * 24 * 60 * 60);
                        cookie2.setPath("/secondshop");
                        response.addCookie(cookie2);
                    } else {//清除掉cookie
                        Cookie cookie1 = new Cookie("userEmail", "1");
                        cookie1.setMaxAge(0);
                        cookie1.setPath("/secondshop");
                        response.addCookie(cookie1);
                        Cookie cookie2 = new Cookie("userPwd", "1");
                        cookie2.setMaxAge(0);
                        cookie2.setPath("/secondshop");
                        response.addCookie(cookie2);
                    };
                    returnMessage.setCode(Constants.RETURN_OBJECT_CODE_SUCCESS);
                }else{
                    //账户不可用
                    returnMessage.setCode(Constants.RETURN_OBJECT_CODE_FAIL);
                    returnMessage.setMessage("您账号被禁用了！！！");
                }

            }else{//管理员登录
                if("1".equals(u.getState())){
                    session.setAttribute(Constants.SESSION_ADMIN,u);
                    returnMessage.setCode(Constants.RETURN_OBJECT_CODE_SUCCESS);
                }else{//账号不可用
                    returnMessage.setCode(Constants.RETURN_OBJECT_CODE_FAIL);
                    returnMessage.setMessage("该管理员账号被禁用了！！！");
                }
            }
        } else {//登录失败
            returnMessage.setCode(Constants.RETURN_OBJECT_CODE_FAIL);
            returnMessage.setMessage("用户名或者密码错误，请重新登录!!");
        }
        return returnMessage;
    }

    @RequestMapping("/settings/qx/user/toRegistPage.do")
    public String toRegistPage() {
        return "settings/qx/user/regist";
    }

    @RequestMapping("/settings/qx/user/userRegist.do")
    @ResponseBody
    public Object userRegist(String userAct, String userPwd, String userEmail) {
        //封装参数
        User user = new User();
        user.setUserAct(userAct);
        user.setUserPwd(userPwd);
        user.setUserEmail(userEmail);
        //设置主键id 采用UUID
        user.setId(UUIDUtils.generateUUID());
        //设置创建时间
        user.setCreateTime(DateUtils.formatDateTime(new Date()));
        //设置账号的state值
        user.setState(Constants.RETURN_OBJECT_CODE_SUCCESS); //1表示该账号处于可用状态
        //设置该账号的角色
        user.setRoleId(Constants.ROLE_USER);
        ReturnMessage returnMessage = new ReturnMessage();
        try {
            int i = userService.addToUser(user);
            if (i == 1) {
                returnMessage.setCode(Constants.RETURN_OBJECT_CODE_SUCCESS);
            } else {
                returnMessage.setCode(Constants.RETURN_OBJECT_CODE_FAIL);
                returnMessage.setMessage("系统忙，请稍后！！！");
            }
        } catch (Exception e) {
            returnMessage.setCode(Constants.RETURN_OBJECT_CODE_FAIL);
            returnMessage.setMessage("系统忙，请稍后！！！");
        }
        return returnMessage;
    }

    @RequestMapping("/workbench/toWorkbenchIndex.do")
    public String toWorkbenchIndex() {
        return "workbench/index";
    }

    //跳转到用户详细信息页面
    @RequestMapping("/settings/qx/user/toUserDetailMes")
    public String toUserDetailMes(HttpServletRequest request, HttpSession session) {
        //将包含用户信息的实体类存放到request域中
        User u = (User) session.getAttribute(Constants.SESSION_USER);
        User user = userService.queryUserByUserId(u.getId());
        //查询该卖家发布的所有的商品
        List<Goods> publishedGoods = goodsService.queryGoodsByUserId(user.getId());
        //查询该用户收藏的所有的商品的商品的id
        Integer[] goodsIds = collectService.queryGoodsIdsByUserId(u.getId());
        if(goodsIds.length != 0){//说明该用户有收藏的商品
            List<Goods> userCollectGoods = goodsService.queryCollectGoodsByGoodsIds(goodsIds);
            request.setAttribute("userCollectGoods", userCollectGoods);
        }
        request.setAttribute("user", user);
        request.setAttribute("publishedGoods", publishedGoods);
        //查询该用户的所有的订单
        List<GoodsOrder> goodsOrders = goodsOrderService.queryAllGoodsOrderByCustomerId(u.getId());
        request.setAttribute("goodsOrders", goodsOrders);
        //查看当前用户卖出哪些物品
        Map<String,Object>map = new HashMap<>();
        map.put("sellerId",user.getId());
        map.put("statusId",1);
        Integer[] ids = goodsOrderService.queryGoodsId(map); //这个是卖家
        if(ids.length != 0 ){
            List<Goods> goods = goodsService.queryCollectGoodsByGoodsIds(ids);
            request.setAttribute("goods",goods);
        }

        //请求转发跳转到页面
        return "settings/qx/user/userDetailMes";
    }

    //跳转到用户信息编辑页面
    @RequestMapping("/settings/qx/user/toEditUserMes")
    public String toEditUserMes(HttpSession session, HttpServletRequest request) {
        User u = (User) session.getAttribute(Constants.SESSION_USER);
        User user = userService.queryUserByUserId(u.getId());
        request.setAttribute("user", user);
        //请求转发到用户信息编辑页面
        return "settings/qx/user/EditUserMes";
    }

    //处理用户上传图片的
    @RequestMapping("/settings/qx/user/EditUserByConditions.do")
    @ResponseBody
    public Object EditUserByConditions(
                                       HttpSession session,
                                       MultipartFile multipartFile,
                                       String userName,
                                       String gender,
                                       String userPhone,
                                       String userEmail,
                                       String userPwd,
                                       String id) {
        User user = new User();
        if(multipartFile != null){
            //定义上传文件的存放位置
            String filePath = "D:\\bishe-useravatar\\";
            String virtualPath = "bishe-useravatar/";
            //获取上传的图片的名称
            String fileName = multipartFile.getOriginalFilename();
            String newFilePath = filePath + fileName; //新文件的路径
            try {
                multipartFile.transferTo(new File(newFilePath));  //将传来的文件写入新建的文件
            } catch (IllegalStateException | IOException e) {
                e.printStackTrace();
            }
            user.setUserAvatar(virtualPath+fileName);
        }
        user.setUserName(userName);
        user.setGender(gender);
        user.setUserPhone(userPhone);
        user.setUserEmail(userEmail);
        user.setUserPwd(userPwd);
        user.setId(id);
        ReturnMessage returnMessage = new ReturnMessage();
        try {
            int i = userService.editUserByConditions(user);
            if(i == 1){
                returnMessage.setCode(Constants.RETURN_OBJECT_CODE_SUCCESS);
            }else{
                returnMessage.setCode(Constants.RETURN_OBJECT_CODE_FAIL);
                returnMessage.setMessage("系统忙，请稍后！！！");
            }
        } catch (Exception e) {
            returnMessage.setCode(Constants.RETURN_OBJECT_CODE_FAIL);
            returnMessage.setMessage("系统忙，请稍后！！！");
            e.printStackTrace();
        }
        //重新查询用户信息
        User u = (User)session.getAttribute(Constants.SESSION_USER);
        User editedUser = userService.queryUserByUserId(u.getId());
        session.setAttribute(Constants.SESSION_USER, editedUser);
        return returnMessage;
    }
    @RequestMapping("/workbench/loginOut.do")
    public String loginOut(HttpSession session,HttpServletResponse response){
        //清除掉cookie中的数据
        Cookie cookie1 = new Cookie("userEmail", "1");
        cookie1.setMaxAge(0);
        cookie1.setPath("/secondshop");
        response.addCookie(cookie1);
        Cookie cookie2 = new Cookie("userPwd", "1");
        cookie2.setMaxAge(0);
        cookie2.setPath("/secondshop");
        response.addCookie(cookie2);
        //清除掉session中的数据
        session.invalidate();
        //重定向到用户首页
        return "redirect:/workbench/toGoodsPage.do";
    }
    //跳转到商品发布页面
    @RequestMapping("/workbench/goods/toGoodsPublishPage.do")
    public String toGoodsPublishPage(HttpServletRequest request){
        //查询出所有的以及类型的类型
        List<FirstType> firstTypes = firstTypeService.queryAllFirstType();
        //查询出一级类型对应的所有的二级类型的类型
        Integer firstTypeId = firstTypes.get(0).getId();
        List<SecondType> secondTypes = secondTypeService.querySecondTypeByFirstTypeId(firstTypeId);
        //查询出 最新发布的5件商品
        List<Goods> goods = goodsService.queryGoodsByUploadTimeForFive();
        //将这些数据全部存储到request域中
        request.setAttribute("firstTypes", firstTypes);
        request.setAttribute("secondTypes", secondTypes);
        request.setAttribute("goods", goods);
        //请求转发，跳转到商品发布页面
        return "workbench/goods/goodsPublish";
    }
}
