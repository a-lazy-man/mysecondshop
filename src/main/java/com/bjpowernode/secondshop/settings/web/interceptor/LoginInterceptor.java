package com.bjpowernode.secondshop.settings.web.interceptor;

import com.bjpowernode.secondshop.conmons.Constants;
import com.bjpowernode.secondshop.settings.domain.User;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class LoginInterceptor implements HandlerInterceptor {
    @Override
    //这个方法是在处理目标资源之前执行的，所以我们登陆验证的代码就写在该方法内，表示登陆之前就进行登陆验证
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object o) throws Exception {
        //true表示放行，false表示拦截
        //判断用户是否登陆成功,如果没有登陆成功就跳转到登陆页面。登陆成功就放行请求

        User user = (User) request.getSession().getAttribute(Constants.SESSION_USER);
        if(user == null){
            //自己写的重定向必须要添加项目的名称 request.getContextPath
            response.sendRedirect(request.getContextPath()+"/settings/qx/user/toLogin.do");
            return false;
        }
        return true;//放行
    }

    @Override
    public void postHandle(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o, ModelAndView modelAndView) throws Exception {

    }

    @Override
    public void afterCompletion(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o, Exception e) throws Exception {

    }
}
