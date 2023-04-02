package com.bjpowernode.secondshop.settings.web.controller;

import com.bjpowernode.secondshop.conmons.Constants;
import com.bjpowernode.secondshop.conmons.ReturnMessage;
import com.bjpowernode.secondshop.settings.domain.FirstType;
import com.bjpowernode.secondshop.settings.domain.SecondType;
import com.bjpowernode.secondshop.settings.domain.User;
import com.bjpowernode.secondshop.settings.service.FirstTypeService;
import com.bjpowernode.secondshop.settings.service.SecondTypeService;
import com.bjpowernode.secondshop.settings.service.UserService;
import com.bjpowernode.secondshop.workbench.domain.Goods;
import com.bjpowernode.secondshop.workbench.domain.GoodsOrder;
import com.bjpowernode.secondshop.workbench.service.GoodsOrderService;
import com.bjpowernode.secondshop.workbench.service.GoodsService;
import com.sun.deploy.net.HttpResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.annotation.RequestScope;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class AdminController {
    @Autowired
    FirstTypeService firstTypeService;
    @Autowired
    SecondTypeService secondTypeService;
    @Autowired
    GoodsService goodsService;
    @Autowired
    GoodsOrderService goodsOrderService;
    @Autowired
    UserService userService;

    //跳转到管理员登录界面
    @RequestMapping("/settings/qx/admin/toAdminLoginPage.do")
    public String toAdminLoginPage() {
        return "settings/qx/admin/adminLogin";
    }

    //跳转到后台管理管理界面
    @RequestMapping("/settings/qx/admin/toSecondShopManagePage.do")
    public String toSecondShopManagePage(HttpServletRequest request, HttpSession session) {
        User user = (User) session.getAttribute(Constants.SESSION_ADMIN);
        if (user != null) {
            //查询所有的一级类型
            List<FirstType> firstTypes = firstTypeService.queryAllFirstType();
            request.setAttribute("firstTypes", firstTypes);
            //查询所有的商品
            List<Goods> goods = goodsService.queryAllGoodsForAdmin();
            request.setAttribute("goods", goods);
            //查询所有的订单
            List<GoodsOrder> goodsOrders = goodsOrderService.queryAllGoodsOrder();
            request.setAttribute("goodsOrders", goodsOrders);
            //查询所有的用户的信息
            List<User> users = userService.queryAllUserForAdmin();
            request.setAttribute("users", users);
            return "settings/qx/admin/secondManage";
        } else {
            return "settings/qx/admin/adminLogin";
        }
    }

    //删除某个以及类型
    @RequestMapping("/settings/ax/admin/deleteFirstType.do")
    @ResponseBody
    public Object deleteFirstType(Integer firstTypeId, HttpSession session,HttpServletResponse response) {
        response.addHeader("Content-Type", "text/html;charset=utf-8");
        User user = (User) session.getAttribute(Constants.SESSION_ADMIN);
        Object data = "<a href='http://localhost:8080/secondshop/settings/qx/admin/toAdminLoginPage.do'>You haven't logged in yet, click to jump to the login page</a>";
        if (user != null) {
            data = false;
            //先判断这个一级分类是否还有二级分类，如果有就不能删除
            List<SecondType> secondTypes = secondTypeService.querySecondTypeByFirstTypeId(firstTypeId);
            if (secondTypes.size() == 0) {
                try {
                    //删除这个一级分类
                    int result1 = firstTypeService.moveFirstTypeById(firstTypeId);
                    if (result1 != 1) {
                        data = false;
                        throw new RuntimeException("系统忙请稍后!!!");
                    }
                } catch (Exception e) {
                    data = false;
                    throw new RuntimeException("系统忙，请稍后！！！");
                }
                //查询当前所有的一级分类
                List<FirstType> firstTypes = firstTypeService.queryAllFirstType();
                data = firstTypes;
            }
        }
        return data;
    }

    //删除某个二级分类
    @RequestMapping("/settings/ax/admin/deleteSecondType.do")
    @ResponseBody
    public Object deleteSecondType(Integer secondTypeId, HttpSession session,HttpServletResponse response) {
        response.addHeader("Content-Type", "text/html;charset=utf-8");
        User user = (User) session.getAttribute(Constants.SESSION_ADMIN);
        Object data = "<a href='http://localhost:8080/secondshop/settings/qx/admin/toAdminLoginPage.do'>You haven't logged in yet, click to jump to the login page</a>"; 
        if (user != null) {
            //判断该二级分类下是否还有商品，如果还有商品就删除失败
            data = false;
            List<Goods> goods = goodsService.queryGoodsBySecondTypeId(secondTypeId);
            if (goods.size() == 0) {//该类型没有商品可以删除
                int i = 0;
                try {
                    i = secondTypeService.moveSecondTypeById(secondTypeId);
                    if (i == 1) {
                        List<SecondType> secondTypes = secondTypeService.queryAllSecondType();
                        data = secondTypes;
                    } else {
                        data = false;
                        throw new RuntimeException("系统忙，请稍后重试！！！");
                    }
                } catch (Exception e) {
                    data = false;
                    throw new RuntimeException("系统忙，请稍后重试!!!");
                }
            }
        }
        return data;
    }

    //新增一级分类
    @RequestMapping("/settings/ax/admin/addFirstType.do")
    @ResponseBody
    public Object addFirstType(String firstTypeName, HttpSession session,HttpServletResponse response) {
        response.addHeader("Content-Type", "text/html;charset=utf-8");
        User user = (User) session.getAttribute(Constants.SESSION_ADMIN);
        Object data = "<a href='http://localhost:8080/secondshop/settings/qx/admin/toAdminLoginPage.do'>You haven't logged in yet, click to jump to the login page</a>";
        if (user != null) {
            data = false;
            FirstType firstType = new FirstType();
            //设置类型名称
            firstType.setName(firstTypeName);
            try {
                int i = firstTypeService.addFirstType(firstType);
                if (i == 1) {
                    //查询所有的的一级分类类型
                    List<FirstType> firstTypes = firstTypeService.queryAllFirstType();
                    data = firstTypes;
                } else {
                    data = false;
                    throw new RuntimeException("系统忙，请稍后！！！");
                }
            } catch (Exception e) {
                data = false;
                throw new RuntimeException("系统忙，请稍后！！！");
            }
        }
        return data;
    }

    //新增二级分类
    @RequestMapping("/settings/ax/admin/addSecondType.do")
    @ResponseBody
    public Object addSecondType(Integer firstTypeId, String secondTypeName,HttpSession session,HttpServletResponse response) {
        response.addHeader("Content-Type", "text/html;charset=utf-8");
        User user = (User) session.getAttribute(Constants.SESSION_ADMIN);
        Object data = "<a href='http://localhost:8080/secondshop/settings/qx/admin/toAdminLoginPage.do'>You haven't logged in yet, click to jump to the login page</a>";
        if(user != null){
            data = false;
            SecondType secondType = new SecondType();
            secondType.setFirstTypeId(firstTypeId);
            secondType.setName(secondTypeName);
            try {
                int i = secondTypeService.addSecondType(secondType);
                if (i == 1) {
                    //查询当前一级类型对应的所有的二级类型
                    List<SecondType> secondTypes = secondTypeService.querySecondTypeByFirstTypeId(firstTypeId);
                    data = secondTypes;
                } else {
                    data = false;
                    throw new RuntimeException("系统忙，请稍后!!!");
                }
            } catch (Exception e) {
                data = false;
                throw new RuntimeException("系统忙，请稍后!!!");
            }
        }
        return data;
    }

    //下架商品
    @RequestMapping("/settings/ax/admin/undercarriageGoods.do")
    @ResponseBody
    public Object undercarriageGoods(Integer goodsId,HttpSession session,HttpServletResponse response) {
        response.addHeader("Content-Type", "text/html;charset=utf-8");
        User user = (User) session.getAttribute(Constants.SESSION_ADMIN);
        Object data = "<a href='http://localhost:8080/secondshop/settings/qx/admin/toAdminLoginPage.do'>You haven't logged in yet, click to jump to the login page</a>";
        if(user != null){
            data = false;
            try {
                int i = goodsService.modifyGoodsStatus(goodsId);
                if (i == 1) {
                    //查询所有的商品
                    List<Goods> goods = goodsService.queryAllGoodsForAdmin();
                    data = goods;
                } else {
                    data = false;
                    new RuntimeException("系统忙，请稍后！！！");
                }
            } catch (Exception e) {
                data = false;
                new RuntimeException("系统忙，请稍后！！！");
            }
        }
        return data;
    }

    //删除商品
    @RequestMapping("/settings/ax/admin/deleteGoods.do")
    @ResponseBody
    public Object deleteGoods(Integer goodsId,HttpSession session,HttpServletResponse response) {
        response.addHeader("Content-Type", "text/html;charset=utf-8");
        User user = (User) session.getAttribute(Constants.SESSION_ADMIN);
        Object data = "<a href='http://localhost:8080/secondshop/settings/qx/admin/toAdminLoginPage.do'>You haven't logged in yet, click to jump to the login page</a>";
        if(user != null){
            data = false;
            try {
                int i = goodsService.moveGoodsById(goodsId);
                if (i == 1) {
                    //查询所有的商品
                    List<Goods> goods = goodsService.queryAllGoodsForAdmin();
                    data = goods;
                } else {
                    data = false;
                    new RuntimeException("系统忙，请稍后！！！");
                }
            } catch (Exception e) {
                data = false;
                new RuntimeException("系统忙，请稍后！！！");
            }
        }
        return data;
    }

    //删除订单
    @RequestMapping("/settings/ax/admin/deleteGoodsOrder.do")
    @ResponseBody
    public Object deleteGoodsOrder(String goodsOrder,HttpSession session,HttpServletResponse response) {
        response.addHeader("Content-Type", "text/html;charset=utf-8");
        User user = (User) session.getAttribute(Constants.SESSION_ADMIN);
        Object data = "<a href='http://localhost:8080/secondshop/settings/qx/admin/toAdminLoginPage.do'>You haven't logged in yet, click to jump to the login page</a>";
        if(user != null){
            data = false;
            try {
                int i = goodsOrderService.moveGoodsOrderById(goodsOrder);
                if (i == 1) {
                    //查询所有的订单
                    List<GoodsOrder> goodsOrders = goodsOrderService.queryAllGoodsOrder();
                    data = goodsOrders;
                } else {
                    data = false;
                    throw new RuntimeException("系统忙，请稍后!!!");
                }
            } catch (Exception e) {
                data = false;
                throw new RuntimeException("系统忙，请稍后!!!");
            }
        }
        return data;
    }

    //删除用户
    @RequestMapping("/settings/ax/admin/deleteUser.do")
    @ResponseBody
    public Object deleteUser(String userId,HttpSession session,HttpServletResponse response) {
        response.addHeader("Content-Type", "text/html;charset=utf-8");
        User user = (User) session.getAttribute(Constants.SESSION_ADMIN);
        Object data = "<a href='http://localhost:8080/secondshop/settings/qx/admin/toAdminLoginPage.do'>You haven't logged in yet, click to jump to the login page</a>";
        if(user != null){
            data = false;
            try {
                int i = userService.moveUserById(userId);
                if (i == 1) {
                    //查询所有的用户
                    List<User> users = userService.queryAllUserForAdmin();
                    data = users;
                } else {
                    data = false;
                    throw new RuntimeException("系统忙,请稍后!!!");
                }
            } catch (Exception e) {
                data = false;
                throw new RuntimeException("系统忙,请稍后!!!");
            }
        }
        return data;
    }

    //禁用用户
    @RequestMapping("/settings/ax/admin/updateUserState.do")
    @ResponseBody
    public Object updateUserState(String state, String userId,HttpSession session,HttpServletResponse response) {
        response.addHeader("Content-Type", "text/html;charset=utf-8");
        User user = (User) session.getAttribute(Constants.SESSION_ADMIN);
        Object data = "<a href='http://localhost:8080/secondshop/settings/qx/admin/toAdminLoginPage.do'>You haven't logged in yet, click to jump to the login page</a>";
        if(user != null){
            //封装参数
            Map<String, Object> map = new HashMap<>();
            map.put("state", state);
            map.put("userId", userId);
            data = false;
            try {
                int i = userService.modifyUserState(map);
                if (i == 1) {
                    //查询所有的用户
                    List<User> users = userService.queryAllUserForAdmin();
                    data = users;
                } else {
                    data = false;
                    throw new RuntimeException("系统忙,请稍后!!!");
                }
            } catch (Exception e) {
                data = false;
                throw new RuntimeException("系统忙,请稍后!!!");
            }
        }
        return data;
    }
}

