<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath()+"/";
%>
<html>
<head>
    <base href="<%=basePath%>">
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
    <title>login登录界面</title>
    <link rel="stylesheet" type="text/css" href="css/login.css">
    <!-- Bootstrap -->
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <!--动画CSS插件-->
    <link rel="stylesheet" type="text/css" href="css/animate.min.css">

    <script src="js/jquery-1.12.4.js"></script>
    <script src="js/bootstrap.js"></script>

    <script src="js/wow.min.js"></script>
    <script type="text/javascript">
        $(function(){
            //给登录按钮绑定一个单击事件
            $("#submit_btn").click(function(){
                //收集表单信息
                var userEmail = $("#inputEmail3").val();
                var userPwd = $("#inputPassword3").val();
                var isRemPwd = $("#miandenglu").prop('checked')
                //进行表单验证
                var regExp = /^[A-Z a-z0-9\u4e00-\u9fa5]+@[a-zA-Z0-9_-]+(.[a-zA-Z0-9_-]+)+$/;
                if(!regExp.test(userEmail)){
                    alert("账号格式不正确!!!");
                    return ;
                }
                regExp = /^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{3,8}$/;
                if(!regExp.test(userPwd)){
                    alert("密码格式不正确!!!");
                    return ;
                }
                //向后台发送异步请求
                $.ajax({
                    url: 'settings/qx/user/login.do',
                    type: 'post',
                    dataType: 'json',
                    data: {
                        userEmail: userEmail,
                        userPwd: userPwd,
                        isRemPwd: isRemPwd
                    },
                    success: function(data){
                        if(data.code == "1"){
                            alert("欢迎您登陆校园二手交易系统"); //后续要跳转到系统首页面
                            window.location.href = "workbench/toGoodsPage.do";
                        }else{
                            alert(data.message);
                        }
                    }
                })

            })
        })
    </script>
</head>
<body>
<!-- 登录-->
<div class="container-fluid ">
    <div class="row ">
        <div class="form ">
            <form class="form-horizontal wow slideInDown ">
                <h1 class="col-sm-offset-3">校园二手交易系统</h1>
                <div id="login-form" class="form-group">
                    <label for="inputEmail3" class="col-sm-3 control-label ">用户名：</label>
                    <div class="col-sm-7">

                        <input type="text" class="form-control " id="inputEmail3" placeholder="username" value="${cookie.userEmail.value}">
                    </div>
                </div>
                <div class="form-group">
                    <label for="inputPassword3" class="col-sm-3 control-label">密码:</label>
                    <div class="col-sm-7">

                        <input type="password" class="form-control" id="inputPassword3" placeholder="Password" value="${cookie.userPwd.value}">
                    </div>
                </div>
                <div class="form-group">
                    <div class="col-sm-offset-3 col-sm-8">
                        <div class="checkbox">
                            <label>
                                <input id="miandenglu" type="checkbox">
                                十天免登录功能 </label>
                            <a class="col-sm-offset-7" href="settings/qx/user/toRegistPage.do"><span class="regist">注册</span></a></div>
                    </div>
                </div>
                <div class="form-group">
                    <div class="col-sm-offset-4 col-sm-5">

                        <input class="form-control btn btn-danger" id="submit_btn"
                               value="登&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;陆">
                    </div>
                </div>
        </form>
            <a href="settings/qx/admin/toAdminLoginPage.do">管理员登录</a> <a
                style="float: right" href="/secondshop/">返回首页</a>
        </div>
    </div>
</div>
</body>
</html>