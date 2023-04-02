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
    <title>修改用户信息</title>
    <link rel="stylesheet"
          href="css/bootstrap.min.css" type="text/css">
    <link rel="stylesheet"
          href="jquery-ui-1.12.1/jquery-ui.css" type="text/css">
    <link rel="stylesheet"
          href="jquery-ui-1.12.1/jquery-ui.theme.css">
    <link rel="stylesheet" href="css/style.css" type="text/css">
    <script src="js/jquery-1.12.4.js" type="text/javascript"></script>
    <script src="js/bootstrap.js" type="text/javascript"></script>
    <script src="jquery-ui-1.12.1/jquery-ui.js" type="text/javascript"></script>
    <script
            src="jquery-ui-1.12.1/datepicker-zh-CN.js" type="text/javascript"></script>
    <script type="text/javascript">
        var userAvatarFileName;
        $(function(){//页面加载完成之后，执行这里面的代码
            //给浏览按钮绑定change事件
            $("#multipartFile").on('change', function(){
                userAvatarFileName = $(this).val();
            })
            //给确定按钮绑定单击事件
            $("#editUserMes").click(function(){
                var multipartFile = null;
                alert("确定按钮被单击了!!!");
                if(userAvatarFileName == undefined){
                    userAvatarFileName = null;
                }else{
                    var suffix = userAvatarFileName.substr(userAvatarFileName.lastIndexOf(".")+1).toLocaleLowerCase();
                    //收集参数并进行表单验证
                    alert("文件的名称"+userAvatarFileName + "文件后缀名" + suffix)
                    if(suffix != 'jpg' && suffix != 'png'){

                        alert("不支持除后缀为.jpg、.png的图片格式！！！");
                        return ;
                    }
                    multipartFile = $("#multipartFile")[0].files[0];
                    console.log("图像文件userAvatarFile=" + multipartFile)
                    //判断文件大小
                    if(multipartFile.size>5*1024*1024){
                        alert("文件大小不得超过5MB！！！");
                        return ;
                    }
                }
                //获取修改之后的姓名
                var userName = $("#name").val();
                if(userName == "待完善"){
                    userName = undefined;
                }
                //获取修改之后的性别
                var gender = $("#gender").find("option:selected").text();
                alert(gender);
                if(gender == "待完善"){
                    gender = undefined;
                }
                //获取修改之后的收集的手机号
                var userPhone = $("#mobile").val();
                if(userPhone == "待完善"){
                    userPhone = undefined;
                }else{
                    var regExp = /^(13[0-9]|14[01456879]|15[0-35-9]|16[2567]|17[0-8]|18[0-9]|19[0-35-9])\d{8}$/
                    if(!regExp.test(userPhone)){
                        alert("请输入合理的手机号码！！！");
                        return ;
                    }
                }
                //获取用户修改之后的邮箱
                var userEmail = $("#email").val()
                if(userEmail == "待完善"){
                    userEmail = undefined;
                }else{
                    regExp = /^[A-Z a-z0-9\u4e00-\u9fa5]+@[a-zA-Z0-9_-]+(.[a-zA-Z0-9_-]+)+$/
                    if(!regExp.test(userEmail)){
                        alert("您输入的邮箱格式不合理!!!");
                    }
                }
                //获取用户id
                var id = "${sessionScope.sessionUser.id}";
                alert("用户的主键id值:" + id)
                //FormData 是ajax提供的接口可以模拟键值对向后台提交参数
                //FormData最大的优势就是不仅能提交字符串数据也能提交二进制数据
                var formData = new FormData();
                if(multipartFile != undefined){
                    formData.append("multipartFile", multipartFile);
                }
                if(userName != undefined){
                    formData.append("userName", userName);
                }
                if(gender != undefined){
                    formData.append("gender", gender);
                }
                if(userPhone != undefined){
                    formData.append("userPhone", userPhone);
                }
                if(userEmail != undefined){
                    formData.append("userEmail", userEmail);
                }
                formData.append("id",id)
                console.log(formData);
                $.ajax({
                    url: "settings/qx/user/EditUserByConditions.do",
                    data:formData,
                    processData: false,//用来设置ajax向后台提交参数之前是否把参数同义转换成字符串；true|false默认情况下,true
                    contentType: false, //设置ajax向后台提交参数之前，是否把所有的参数统一按urlencode编码：true---是 false --否
                    type: "post",
                    success: function(data){
                        if(data.code == "1"){
                            alert("修改信息成功！！!");
                           //跳转到用户详情页面
                            window.location.href = "settings/qx/user/toUserDetailMes";
                        }else{
                            alert(data.message);
                        }
                    }
                })
            })
            //给退出按钮绑定一个单击事件
            $("#loginOut").click(function(){
                window.confirm("您确定退出登录吗？");
                window.location.href = "workbench/loginOut.do";
            })
            //给确认修改按钮绑定一个单击事件
            $("#EditUserPwd").click(function(){
                //收集数据
                var oldPassword = document.getElementById("oldPass").value;
                var userPwd = document.getElementById("newPass1").value;
                var passwordConfirm = document.getElementById("newPass2").value;
                //对数据进行验证
                if($.trim(oldPassword).length == 0){
                    alert("原密码不能为空！！！");
                    return ;
                }else if(oldPassword != '${sessionScope.sessionUser.userPwd}'){
                    //用户输入的原始密码和数据库中的密码不一致时，提示用户密码输错了
                    alert("您输入的原始密码不正确!!!");
                    return ;
                }

                if($.trim(userPwd).length == 0){
                    alert("新密码不能为空！！！");
                    return ;
                }else if(userPwd != passwordConfirm){
                    //前后密码不一致，提示用户
                    alert("前后密码不一致，请重新输入");
                    return ;
                }
                //获取用户id
                var id = "${sessionScope.sessionUser.id}";
                //发送ajax请求到后台
                $.ajax({
                    url: 'settings/qx/user/EditUserByConditions.do',
                    dataType: 'json',
                    data: {
                        id: id,
                        userPwd: userPwd
                    },
                    success: function(data){
                        if(data.code == "1"){
                            alert("修改密码成功！！！");
                            //重定向到
                            window.location.href = "workbench/toGoodsPage.do";
                        }else{//修改失败提示用户
                            alert(data.message);
                        }
                    }
                })
            })

        })
    </script>
</head>
<body>


<nav class="navbar navbar-default navbar-fixed-top" role="navigation">
    <div class="container">
        <div class="navbar-header">
            <a class="navbar-brand" href="#" style="font-size: 25px">校园二手交易平台</a>
        </div>

        <div id="navbar" class="navbar-collapse collapse">
            <ul class="nav navbar-nav">


                <li><a href="/secondshop/">首页</a></li>
                <li><a
                        href="settings/qx/user/toUserDetailMes">我的</a></li>
                <li><a
                        href="/secondshop/goods/publishGood">发布</a></li>



            </ul>

            <ul class="nav navbar-nav navbar-right">


                <li><img
                        src="${user.userAvatar}"
                        height="50px" width="50px"></li>
                <li><a
                        href="javascript:void(0)">${user.userName}</a></li>
                <li><a id="loginOut" href="javascript:void(0)">退出</a></li>



            </ul>
        </div>
    </div>
</nav>
<div class="col-md-12" style="height: 70px"></div>

<div class="container"
     style="position: relative; transform: translate(0, 0)">
    <div class="col-md-9" style="float: left;">
        <div class="col-md-12 r1"
             style="background-color: #e4e4e4; height: 40px">
            <div class="col-md-6" style="margin-top: 5px">
                <B style="color: #c4c4c4; font-size: 20px">修改信息</B>
            </div>
        </div>

        <div class="col-md-12 r2"
             style="background-color: #f9f9f9; padding: 30px; margin-bottom: 15px">
            <form id="register" items="com.secondshop.models.User@1f48dd6" action="/secondshop/user/userEdit?userId=2" method="post" enctype="multipart/form-data">
                <div class="col-md-12"
                     style="padding-left: 0px; padding-bottom: 10px">
                    <div class="col-md-8" style="padding-left: 0px; padding-top: 50px">
                        <label for="multipartFile" cssClass="control-label">头像</label> <input
                            id="multipartFile" style="margin-top: 10px" type="file" name="multipartFile"
                            onchange="change(event)"></input>
                    </div>

                    <div class="col-md-4">
                        <img src="${user.userAvatar eq null ? 'image/photos/default/default.jpg':user.userAvatar}" id="img"
                             height="120px" width="120px">
                    </div>
                </div>


                <div class="form-group">
                    <label for="name" class="control-label">姓名</label>
                    <input id="name" name="name" class="form-control" type="text" value="${user.userName eq null ? '待完善':user.userName}"/>
                </div>



                <div class="form-group">
                    <label for="gender" class="control-label">性别</label>
                    <select id="gender" name="gender" class="form-control">
                        <option value="男" ${user.gender eq '男' ? 'selected':''}>男</option>
                        <option value="女" ${user.gender eq '女' ? 'selected':''}>女</option>
                        <option value="待完善" ${user.gender eq null ? 'selected':''}>待完善</option>
                    </select>
                </div>



                <div class="form-group">
                    <label for="mobile" class="control-label">手机</label>
                    <c:if test="${user.userPhone != null}">
                        <input id="mobile" name="mobile" class="form-control" type="text" value="${user.userPhone}"/>
                    </c:if>
                    <c:if test="${user.userPhone == null}">
                        <input id="mobile" name="mobile" class="form-control" type="text" value="待完善"/>
                    </c:if>
                    <output itemid="status" style="color: red"></output>
                </div>



                <div class="form-group">
                    <label for="email" class="control-label">邮箱</label>
                    <input id="email" name="email" class="form-control" type="text" value="${user.userEmail eq null ? '待完善':user.userEmail}"/>
                    <output itemid="status" style="color: red" value=""></output>
                </div>


                <div class="form-group">
                    <button id="editUserMes" type="button" class="btn btn-primary">确定</button>
                    <a class="btn btn-success pull-right"
                       onClick="javascript :history.back(-1);">返回</a>
                </div>

                <output style="color: red"></output>
            </form>
        </div>

        <div class="col-md-12 r1"
             style="background-color: #e4e4e4; height: 40px">
            <div class="col-md-6" style="margin-top: 5px">
                <B style="color: #c4c4c4; font-size: 20px">修改密码</B>
            </div>
        </div>

        <div class="col-md-12 r2"
             style="background-color: #f9f9f9; padding: 30px; margin-bottom: 15px">
            <div id="sec" class="col-md-12" style="padding: 15px;">
                <div class="form-group">
                    <label for="oldPass">原密码</label> <input id="oldPass"
                                                            class="form-control" type="password">
                </div>

                <div class="form-group">
                    <label for="newPass1">新密码</label> <input id="newPass1"
                                                             class="form-control" type="password">
                </div>

                <div class="form-group">
                    <label for="newPass2">确认密码</label> <input id="newPass2"
                                                              class="form-control" type="password">
                    <output id="passError" style="color: red"></output>
                </div>

                <button id="EditUserPwd" class="btn btn-primary">确认修改</button>
            </div>
        </div>
    </div>
    <div id="re-bar" class="col-md-3"
         style="padding-left: 0px; padding-right: 0px;">
        <div class="col-md-12 r1"
             style="background-color: #e4e4e4; height: 40px; padding-left: 0px; padding-right: 0px;">
            <div id="review-bar" class="col-md-6 rev1-bar" align="center"
                 onclick="reviewButton()">
                <B style="font-size: 16px; color: #c4c4c4">收到的评论</B>
            </div>

            <div id="reply-bar" class="col-md-6 rev2-bar" align="center"
                 onclick="replyButton()">
                <B style="font-size: 16px; color: #c4c4c4">收到的回复</B>
            </div>
        </div>

        <div class="col-md-12 r2"
             style="background-color: #f9f9f9; padding-bottom: 15px">
            <div id="review-body" class="col-md-12 r3"
                 style="display: none; overflow-y: auto; height: 595px; background-color: #ffffff; padding-left: 5px; padding-right: 5px; padding-top: 5px; padding-bottom: 15px;">







            </div>

            <div id="reply-body" class="col-md-12 r3"
                 style="display: none; overflow-y: auto; height: 595px; background-color: #ffffff; padding-left: 5px; padding-right: 5px; padding-top: 5px; padding-bottom: 15px;">







            </div>

            <div id="adv-bar" class="col-md-12"
                 style="margin-top: 5px; padding: 0px;">
                <div class="col-md-12" align="center">
                    <B style="font-size: 20px; color: #c4c4c4">卖出的物品</B>
                </div>
                <div class="col-md-12"
                     style="overflow-y: auto; height: 450px; padding: 5px; background-color: #ffffff;">







                </div>
            </div>
        </div>
    </div>
</div>

<script>
    function submitPass() {
        var oldPassword = document.getElementById("oldPass").value;
        var password = document.getElementById("newPass1").value;
        var passwordConfirm = document.getElementById("newPass2").value;
        var pass = {
            "userId" : "2",
            "oldPassword" : oldPassword,
            "newPassword" : password
        };
        console.log(oldPassword);
        console.log(pass)
        if (password !== passwordConfirm) {
            document.getElementById("passError").innerHTML = "对不起，您2次输入的密码不一致";
        } else if (oldPassword === "" || password === "") {
            document.getElementById("passError").innerHTML = "对不起，不可以为空！";
        } else {
            document.getElementById("passError").innerHTML = "";
            $.ajax({
                type : "POST",
                url : "/secondshop/user/password/edit",
                contentType : "application/json; charset=UTF-8", //必须这样写
                dataType : "json",
                data : JSON.stringify(pass),//要提交是json字符串
                success : function(data) {
                    if (data === true) {
                        alert("密码修改成功！");
                    } else {
                        alert(data);
                    }
                },
                error : function(xhr) {
                    alert(xhr.responseText)
                }
            });
        }
    }
</script>

<script>
    var bar_width = document.getElementById("re-bar").scrollWidth;
    $(function() {
        $(window).scroll(function() {
            if ($(document).scrollTop() >= 20) {
                $("#re-bar").css({
                    "position" : "fixed",
                    "top" : 50 + $(document).scrollTop() + "px",
                    "width" : bar_width,
                    "right" : 15
                });
            } else {
                $("#re-bar").css({
                    "position" : "fixed",
                    "top" : 70 + "px",
                    "width" : bar_width,
                    "right" : 15
                });
            }
        })
    });

    function change(ev) {
        var event = window.event || ev;
        var files = event.target.files[0];
        var myimg = document.getElementById("img");
        myimg.src = URL.createObjectURL(files);
    }
</script>

<script>
    function reviewButton() {
        if (document.getElementById("review-body").style.display === "none") {
            document.getElementById("review-bar").className = "col-md-12 rev-bar";
            $("#reply-bar").slideUp();
            $("#review-body").slideDown();
            $("#adv-bar").slideUp();
        } else {
            document.getElementById("review-bar").className = "col-md-6 rev1-bar";
            $("#reply-bar").slideDown();
            $("#review-body").slideUp();
            $("#adv-bar").slideDown();
        }
    }

    function replyButton() {
        if (document.getElementById("reply-body").style.display === "none") {
            document.getElementById("reply-bar").className = "col-md-12 rev-bar";
            document.getElementById("review-bar").style.display = "none";
            $("#reply-body").slideDown();
            $("#adv-bar").slideUp();
        } else {
            document.getElementById("reply-bar").className = "col-md-6 rev2-bar";
            $("#review-bar").slideDown();
            $("#reply-body").slideUp();
            $("#adv-bar").slideDown();
        }
    }
</script>


</body>
</html>