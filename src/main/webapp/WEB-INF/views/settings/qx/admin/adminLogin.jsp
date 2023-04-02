<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
%>
<html>
<head>
    <base href="<%=basePath%>">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>管理员登录界面</title>
    <link rel="stylesheet"
          href="css/bootstrap.min.css" type="text/css">
    <link rel="stylesheet" href="css/style.css" type="text/css">
    <script src="js/jquery-1.12.4.js" type="text/javascript"></script>
    <script src="js/bootstrap.js" type="text/javascript"></script>

    <script type="text/javascript">
        $(function(){
            //给管理员登录按钮绑定单击事件
            $("#adminLogin").click(function(){
                //获取账号
                var userEmail = $("#email").val();
                //获取密码
                var userPwd = $("#password").val();
                //定义标识
                var flag = 1; //表示这是管理员登陆
                //验证数据
                var regExp = /^[A-Z a-z0-9\u4e00-\u9fa5]+@[a-zA-Z0-9_-]+(.[a-zA-Z0-9_-]+)+$/;
                if(!regExp.test(userEmail)){
                    alert("账号格式不正确！！！");
                    return ;
                }
                regExp = /^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{3,8}$/;
                if(!regExp.test(userPwd)){
                    alert("密码格式不正确！！");
                    return ;
                }
                $.ajax({
                    url:'settings/qx/user/login.do',
                    type:'post',
                    dataType: 'json',
                    data:{
                        userEmail:userEmail,
                        userPwd:userPwd,
                        flag:flag
                    },
                    success:function(returnMessage){
                        if(returnMessage.code == 1){
                            alert("登陆成功！！！");
                            //跳转到管理员后台界面
                            window.location.href = "settings/qx/admin/toSecondShopManagePage.do"
                        }
                    }
                })
            })
        })

    </script>
</head>
<body
        style="background-image: url(/secondshop/image/background/background2.jpg); background-size: cover">
<div style="margin: 20px auto">
    <div style="margin: 100px auto; margin-bottom: 40px" align="center">
        <h1 style="font-size: 60px; color: #ffffff">管理员登录</h1>
    </div>
</div>

<div class="container" style="position: relative; margin: 80px auto;">
    <div class="col-md-6 login-back"
         style="position: absolute; left: 50%; transform: translateX(-50%);">
        <form>
            <div class="form-group">
                <label for="email">邮箱</label>
                <input class="form-control" id="email" name="email" type="email"/>
            </div>

            <div class="form-group">
                <label for="password">密码</label>
                <input class="form-control" id="password" name="password" type="password"/>
            </div>

            <div>
                <output style="color: red"></output>
            </div>

            <button id="adminLogin" style="width: 100%" type="button" class="btn btn-primary">登录</button>
        </form>
        <a href="settings/qx/user/toLogin.do">用户登录</a>
    </div>
</div>

</body>
</html>