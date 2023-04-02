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
    <title>后台管理页面</title>
    <link rel="stylesheet"
          href="css/bootstrap.min.css" type="text/css">
    <link rel="stylesheet"
          href="jquery-ui-1.12.1/jquery-ui.css" type="text/css">
    <link rel="stylesheet"
          href="jquery-ui-1.12.1/jquery-ui.theme.css">
    <link rel="stylesheet" href="css/style.css" type="text/css">
    <link rel="stylesheet"
          href="css/simpleAlert.css">
    <script src="js/jquery-1.12.4.js" type="text/javascript"></script>
    <script src="js/simpleAlert.js"></script>
    <script src="js/bootstrap.js" type="text/javascript"></script>
    <script src="jquery-ui-1.12.1/jquery-ui.js" type="text/javascript"></script>
    <script
            src="jquery-ui-1.12.1/datepicker-zh-CN.js" type="text/javascript"></script>
    <style>
        a {
            cursor: pointer
        }
    </style>
    <script type="text/javascript">
        $(function(){
            //给禁用按钮绑定单击事件
            $("#userTable").on("click",".jinyong",function(){
                alert("禁用按钮被单击了！！！");
                var userId = $(this).attr("userId");
                alert("userId="+userId);
                var state = '0';
                disableUser(state,userId);
            })
            $("#userTable").on("click",".jihuo",function(){
                alert("激活按钮被单击了！！！");
                var userId = $(this).attr("userId");
                alert("userId="+userId);
                var state = '1';
                enableUser(state,userId);
            })
            $("#userTable").on("click",".shanchu",function(){
                alert("删除按钮被单击了！！！");
                var userId = $(this).attr("userId");
                alert("userId="+userId);
                deleteUser(userId)
            })
        })
    </script>
</head>
<body>
<nav class="navbar navbar-default navbar-fixed-top" role="navigation"
     style="background-color: #dcdcdc">
    <div class="container">
        <div class="navbar-header">
            <a class="navbar-brand" style="font-size: 25px">校园二手交易平台后台管理</a>
        </div>

        <div id="navbar" class="navbar-collapse collapse">
            <ul class="nav navbar-nav navbar-right">
                <li><a>admin</a></li>
                <li><a
                        href="workbench/loginOut.do">退出</a></li>
            </ul>
        </div>
    </div>
</nav>

<div class="col-md-12" style="height: 50px"></div>
<div class="container" style="width: 100%; padding: 0px">
    <div class="col-md-2"
         style="background-color: #d2d2d2; height: 92%; padding: 0px;">
        <div style="float: right; width: 100%;">
            <div id="menu1" onclick="menuBar('menu1')" class="admenu-b"
                 align="center">
                <p>
                    <B style="font-size: 20px; color: #5c5c5c; cursor: pointer">物品分类管理</B>
                </p>
            </div>

            <div id="menu2" onclick="menuBar('menu2')" class="admenu"
                 align="center">
                <p>
                    <B style="font-size: 20px; color: #5c5c5c; cursor: pointer">物品管理</B>
                </p>
            </div>

            <div id="menu3" onclick="menuBar('menu3')" class="admenu"
                 align="center">
                <p>
                    <B style="font-size: 20px; color: #5c5c5c; cursor: pointer">订单管理</B>
                </p>
            </div>

            <div id="menu4" onclick="menuBar('menu4')" class="admenu"
                 align="center">
                <p>
                    <B style="font-size: 20px; color: #5c5c5c; cursor: pointer">用户管理</B>
                </p>
            </div>
        </div>
    </div>

    <div id="menu-context" class="col-md-10"
         style="background-color: #f3f3f3; height: 92%; padding-left: 0px; padding-right: 30px; float: right;">
        <div id="menu1-context" class="col-md-12">
            <div class="col-md-12" align="center">
                <h3>物品分类管理</h3>
            </div>

            <div class="col-md-12 r"
                 style="background-color: #ffffff; height: 78%; margin: 15px; margin-top: 5px; padding: 15px">
                <div class="col-md-12"
                     style="background-color: #f3f3f3; height: 100%; padding: 15px">
                    <div class="col-md-6" style="height: 100%;">
                        <div class="col-md-12" align="center" style="margin-bottom: 5px">
                            <h4>一级分类</h4>
                        </div>

                        <div class="col-md-12 r"
                             style="background-color: #ffffff; padding: 40px; height: 88%; overflow-y: auto;">
                            <div id="firstType-ba" class="col-md-12" style="padding: 0px">

                                <c:forEach items="${firstTypes}" var="firstType">
                                    <div onclick="firstButton(${firstType.id})"
                                         id="1001" class="col-md-9 adUlLi r">${firstType.name}</div>
                                    <div onclick="deleteFirstButton(${firstType.id})"
                                         class="col-md-1 delType">X</div>
                                </c:forEach>

<%--                                <div onclick="firstButton(1002)"--%>
<%--                                     id="1002" class="col-md-9 adUlLi r">穿着</div>--%>
<%--                                <div onclick="deleteFirstButton(1002)"--%>
<%--                                     class="col-md-1 delType">X</div>--%>

<%--                                <div onclick="firstButton(1003)"--%>
<%--                                     id="1003" class="col-md-9 adUlLi r">日用</div>--%>
<%--                                <div onclick="deleteFirstButton(1003)"--%>
<%--                                     class="col-md-1 delType">X</div>--%>

<%--                                <div onclick="firstButton(1004)"--%>
<%--                                     id="1004" class="col-md-9 adUlLi r">办公</div>--%>
<%--                                <div onclick="deleteFirstButton(1004)"--%>
<%--                                     class="col-md-1 delType">X</div>--%>

<%--                                <div onclick="firstButton(1005)"--%>
<%--                                     id="1005" class="col-md-9 adUlLi r">电子</div>--%>
<%--                                <div onclick="deleteFirstButton(1005)"--%>
<%--                                     class="col-md-1 delType">X</div>--%>

<%--                                <div onclick="firstButton(1006)"--%>
<%--                                     id="1006" class="col-md-9 adUlLi r">测试</div>--%>
<%--                                <div onclick="deleteFirstButton(1006)"--%>
<%--                                     class="col-md-1 delType">X</div>--%>

                            </div>

                            <div id="fir" class="col-md-9 r"
                                 style="display: none; padding: 15px; background-color: #f3f3f3;">
                                <div class="form-group">
                                    <label for="addfirst">一级分类名称</label> <input id="addfirst"
                                                                                class="form-control" type="text">
                                </div>
                                <button onclick="addFirstType()" class="btn btn-success">添加</button>
                                <button onclick="closeAddbar('fir')"
                                        class="btn btn-primary pull-right">取消</button>
                            </div>

                            <div onclick="openAddbar('fir')" class="col-md-9 addFirstType r"
                                 id="addFirstBtn">
                                <B>+</B>
                            </div>
                        </div>
                    </div>

                    <div class="col-md-6" style="height: 100%;">
                        <div class="col-md-12" align="center" style="margin-bottom: 5px">
                            <h4>二级分类</h4>
                        </div>

                        <div class="col-md-12 r"
                             style="background-color: #ffffff; padding: 40px; height: 88%; overflow-y: auto;">
                            <div id="secondType-ba" class="col-md-12" style="padding: 0px">
                                <div class="col-md-12" align="center">
                                    <h3 style="color: #737373">请先选择一级分类</h3>
                                </div>
                            </div>

                            <div id="sec" class="col-md-9 r"
                                 style="display: none; padding: 15px; background-color: #f3f3f3;">
                                <div class="form-group">
                                    <label for="addsecond">二级分类名称</label> <input id="addsecond"
                                                                                 class="form-control" type="text">
                                </div>
                                <button onclick="addSecondType()" class="btn btn-success">添加</button>
                                <button onclick="closeAddbar('sec')"
                                        class="btn btn-primary pull-right">取消</button>
                            </div>

                            <div onclick="openAddbar('sec')" class="col-md-9 addFirstType r"
                                 id="addSecondBtn" style="display: none">
                                <B>+</B>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div id="menu2-context" class="col-md-12" style="display: none">
            <div class="col-md-12" align="center">
                <h3>物品管理</h3>
            </div>

            <div class="col-md-12"
                 style="background-color: #ffffff; height: 78%; margin: 15px; margin-top: 5px; padding: 20px">
                <div class="col-md-12 r" style="height: 100%; padding: 15px;">
                    <div class="col-md-12 column" style="padding-left: 15px;">
                        <table class="table" style="margin-bottom: 0px">
                            <thead>
                            <tr style="color: #666666">
                                <th style="width: 8%">物品Id</th>
                                <th style="width: 14%">标题</th>
                                <th style="width: 10%">类型</th>
                                <th style="width: 15%">发布人</th>
                                <th style="width: 24%">发布时间</th>
                                <th style="width: 14%">状态</th>
                                <th style="width: 15%">操作</th>
                            </tr>
                            </thead>
                        </table>
                    </div>

                    <div class="col-md-12 column"
                         style="overflow-y: auto; height: 92%;">
                        <table class="table table-hover">
                            <tbody id="goodTable">

                            <c:forEach items="${goods}" var="good">
                                <tr id="good44" style="color: #666666">
                                    <td style="width: 8%">${good.id}</td>
                                    <td style="width: 15%">${good.name}</td>
                                    <td style="width: 10%">${good.secondTypeName}</td>
                                    <td style="width: 15%">${good.userName}</td>
                                    <td style="width: 24%">${good.uploadDate}</td>
                                    <td style="width: 13%">${good.statusId == 1?'在售':'已下架'}</td>
                                    <td style="width: 15%">
                                        <c:if test="${good.statusId == 1}">
                                            <a id="${good.id}" onclick="deleteGood(${good.id})">删除</a>&nbsp;&nbsp;
                                            <a onclick="setGoodStatus(${good.id})">下架</a>
                                        </c:if>
                                        <c:if test="${good.statusId == 0}">
                                            <a id="${good.id}" onclick="deleteGood(${good.id})">删除</a>
                                        </c:if>
                                    </td>
                                </tr>
                            </c:forEach>



                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>

        <div id="menu3-context" class="col-md-12" style="display: none">
            <div class="col-md-12" align="center">
                <h3>订单管理</h3>
            </div>
            <div class="col-md-12"
                 style="background-color: #ffffff; height: 78%; margin: 15px; margin-top: 5px; padding: 20px">
                <div class="col-md-12 r" style="height: 100%; padding: 15px;">
                    <div class="col-md-12 column" style="padding-right: 34px;">
                        <table class="table" style="margin-bottom: 0px">
                            <thead>
                            <tr style="color: #666666">
                                <th style="width: 10%">订单编号</th>
                                <th style="width: 15%">卖家</th>
                                <th style="width: 10%">物品ID</th>
                                <th style="width: 20%">物品名称</th>
                                <th style="width: 10%">金额</th>
                                <th style="width: 15%">提交时间</th>
                                <th style="width: 10%">订单状态</th>
                                <th style="width: 10%">操作</th>
                            </tr>
                            </thead>
                        </table>
                    </div>

                    <div class="col-md-12 column"
                         style="overflow-y: auto; height: 92%;">
                        <table class="table table-hover">
                            <tbody id="orderTable">

                            <tr style="color: #666666">
                                <td style="width: 10%">27</td>
                                <td style="width: 15%">张三</td>
                                <td style="width: 10%">13</td>
                                <td style="width: 15%">夏天的衣服</td>
                                <td style="width: 10%">100</td>
                                <td style="width: 20%">2023-02-02 20:50:30</td>
                                <td style="width: 10%">交易中</td>
                                <td style="width: 10%"><a
                                        onclick="deleteOrder(27)">删除</a></td>
                            </tr>

                            <c:forEach items="${goodsOrders}" var="goodsOrder">
                                <tr style="color: #666666">
                                    <td style="width: 10%">${goodsOrder.id}</td>
                                    <td style="width: 15%">${goodsOrder.sellerId}</td>
                                    <td style="width: 10%">${goodsOrder.goodId}</td>
                                    <td style="width: 15%">${goodsOrder.goodName}</td>
                                    <td style="width: 10%">${goodsOrder.money}</td>
                                    <td style="width: 20%">${goodsOrder.submitTime}</td>
                                    <td style="width: 10%">${goodsOrder.statusId == 1? '交易完成':'交易中'}</td>
                                    <td style="width: 10%"><a
                                            onclick="deleteOrder('${goodsOrder.id}')">删除</a></td>
                                </tr>
                            </c:forEach>



                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>

        <div id="menu4-context" class="col-md-12" style="display: none">
            <div class="col-md-12" align="center">
                <h3>用户管理</h3>
            </div>
            <div class="col-md-12"
                 style="background-color: #ffffff; height: 78%; margin: 15px; margin-top: 5px; padding: 20px">
                <div class="col-md-12 r" style="height: 100%; padding: 15px;">
                    <div class="col-md-12 column" style="padding-right: 34px;">
                        <table class="table" style="margin-bottom: 0px">
                            <thead>
                            <tr style="color: #666666">
                                <th style="width: 8%">用户ID</th>
                                <th style="width: 13%">用户昵称</th>
                                <th style="width: 14%">用户手机号</th>
                                <th style="width: 20%">用户邮箱</th>
                                <th style="width: 5%">性别</th>
                                <th style="width: 20%">注册时间</th>
                                <th style="width: 12%">用户状态</th>
                                <th style="width: 8%">操作</th>
                            </tr>
                            </thead>
                        </table>
                    </div>

                    <div class="col-md-12 column"
                         style="overflow-y: auto; height: 92%;">
                        <table class="table table-hover">
                            <tbody id="userTable">

                            <c:forEach items="${users}" var="user">
                                <tr style="color: #666666">
                                    <td style="width: 8%">${user.id}</td>
                                    <td style="width: 13%">${user.userName}</td>
                                    <td style="width: 14%">${user.userPhone}</td>
                                    <td style="width: 20%">${user.userEmail}</td>
                                    <td style="width: 5%">${user.gender}</td>
                                    <td style="width: 20%">${user.createTime}</td>
                                    <td style="width: 10%">${user.state==1?'正常':'失效'}</td>
                                    <td style="width: 10%"><a
                                            onclick="deleteUser('${user.id}')">删除</a>&nbsp;&nbsp;
                                        <c:if test="${user.state == '0'}">
                                            <a onclick="enableUser('1','${user.id}')">激活</a>
                                        </c:if>
                                        <c:if test="${user.state == '1'}">
                                            <a onclick="disableUser('0','${user.id}')">禁用</a>
                                        </c:if>
                                    </td>
                                </tr>
                            </c:forEach>



                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    function menuBar(menuId) {
        var menubar = "#" + menuId + "";
        var menu_context = menubar + "-context";
        $(".admenu-b").removeClass("admenu-b").addClass("admenu");
        $(menubar).removeClass("admenu").addClass("admenu-b");
        $("#menu-context > div").slideUp();
        $(menu_context).slideDown();
    }
</script>

<script>
    // type function
    var first_type_id;

    function deleteFirstButton(first_id) {
        var dblChoseAlert = simpleAlert({
            "content": "确认删除这个分类？",
            "buttons":{
                "确定":function () {
                    dblChoseAlert.close();
                    deleteFirst(first_id);
                },
                "取消":function () {
                    dblChoseAlert.close();
                }
            }
        })
    }

    function deleteSecondButton(second_id) {
        var dblChoseAlert = simpleAlert({
            "content": "确认删除这个分类？",
            "buttons":{
                "确定":function () {
                    dblChoseAlert.close();
                    deleteSecond(second_id);
                },
                "取消":function () {
                    dblChoseAlert.close();
                }
            }
        })
    }

    function closeAddbar(bar_id) {
        var barId = "#" + bar_id;
        $(barId).slideUp();
    }
    function openAddbar(bar_id) {
        var barId = "#" + bar_id;
        $(barId).slideDown();
    }

    function addFirstType() {
        //获取imput框中的一级分类的内容
        var firstTypeName = document.getElementById("addfirst").value;
        $.ajax({
            type:"POST",
            url:"settings/ax/admin/addFirstType.do",
            dataType:"json",
            data:{
                firstTypeName:firstTypeName
            },//要提交是json字符串
            success:function (data) {
                 if (data === false){
                    alert("由于未知原因，一级分类添加失败！");
                } else {
                    document.getElementById("firstType-ba").innerHTML = "";
                    $.each(data, function (i, type) {
                        var firstId = type.id;
                        var firstName = type.name;
                        var firstType = "<div onclick='firstButton("+firstId+")' id='"+firstId+"' class='col-md-9 adUlLi r'>"+firstName+"</div>"+
                            "<div onclick='deleteFirstButton("+firstId+")' class='col-md-1 delType'>X</div>";
                        $("#firstType-ba").append(firstType);
                    });
                    alert("分类添加成功！");
                }
            }

        });
        $("#fir").slideUp();
    }

    function addSecondType() {//添加二级分类
        var secondTypeName = document.getElementById("addsecond").value;
        $.ajax({
            type:"POST",
            url:"settings/ax/admin/addSecondType.do",
            dataType:"json",
            data:{
                firstTypeId:first_type_id,
                secondTypeName:secondTypeName
            },
            success:function (data) {
                 if (data === false){
                    alert("由于未知原因，二级分类添加失败！");
                } else {
                    document.getElementById("secondType-ba").innerHTML = "";
                    $.each(data, function (i, type) {
                        var secondId = type.id;
                        var secondName = type.name;
                        var secondType = "<div class='col-md-9 adUlLi r'>"+secondName+"</div>"+
                            "<div onclick='deleteSecondButton("+secondId+")' class='col-md-1 delType'>X</div>";
                        $("#secondType-ba").append(secondType);
                    });
                    alert("分类添加成功！");
                }
            }

        });
        $("#sec").slideUp();
    }

    function deleteFirst(first_id) {
        $.getJSON("settings/ax/admin/deleteFirstType.do?firstTypeId="+first_id, function (data) {
             if (data === false){
                alert("删除失败，请确认该分类下是否还有二级分类！");
            } else {
                document.getElementById("firstType-ba").innerHTML = "";
                $.each(data, function (i, type) {
                    var firstId = type.id;
                    var firstName = type.name;
                    var firstType = "<div onclick='firstButton("+firstId+")' id='"+firstId+"' class='col-md-9 adUlLi r'>"+firstName+"</div>"+
                        "<div onclick='deleteFirstButton("+firstId+")' class='col-md-1 delType'>X</div>";
                    $("#firstType-ba").append(firstType);
                });
                alert("删除成功！");
            }
        })
    }

    function deleteSecond(second_id) {
        $.getJSON("settings/ax/admin/deleteSecondType.do?secondTypeId="+second_id, function (data) {
             if (data === false){
                alert("删除失败，请确认该分类下是否还有物品！");
            } else if (data === "isNull") {
                document.getElementById("secondType-ba").innerHTML = "";
                alert("该分类下暂无分类！")
            } else {
                document.getElementById("secondType-ba").innerHTML = "";
                $.each(data, function (i, type) {
                    var secondId = type.id;
                    var secondName = type.name;
                    var secondType = "<div class='col-md-9 adUlLi r'>"+secondName+"</div>"+
                        "<div onclick='deleteSecondButton("+secondId+")' class='col-md-1 delType'>X</div>";
                    $("#secondType-ba").append(secondType);
                });
                alert("删除成功！");
            }
        })
    }

    function firstButton(first_id) {
        var firstId = "#" + first_id;
        first_type_id = first_id;
        $(".adUlLi-a").removeClass("adUlLi-a").addClass("adUlLi");
        $(firstId).removeClass("adUlLi").addClass("adUlLi-a");
        document.getElementById("secondType-ba").innerHTML = "";
        document.getElementById("addSecondBtn").style.display = "";
        $.getJSON("workbench/goods/showSecondType.do?firstTypeId="+first_id, function (data) {
            if (data === false){
                alert("好像出了问题，请重试！")
            } else if (data === "isNull") {
                alert("该分类下暂无分类！")
            } else {
                $.each(data, function (i, type) {
                    var secondId = type.id;
                    var secondName = type.name;
                    var secondType = "<div class='col-md-9 adUlLi r'>"+secondName+"</div>"+
                        "<div onclick='deleteSecondButton("+secondId+")' class='col-md-1 delType'>X</div>";
                    $("#secondType-ba").append(secondType);
                });
            }
        })
    }
</script>

<script>
    //user function
    function enableUser(state,userId) {
        alert("state=" + state+"userId="+userId);
        var dblChoseAlert = simpleAlert({
            "content": "确认激活用户？ 用户id:"+userId,
            "buttons":{
                "确定":function () {
                    dblChoseAlert.close();
                    setUserStatus(state,userId);
                },
                "取消":function () {
                    dblChoseAlert.close();
                }
            }
        })
    }

    function disableUser(state,userId) {
        alert("state=" + state+"userId="+userId);
        var dblChoseAlert = simpleAlert({
            "content": "确认禁用用户？ 用户id:"+userId,
            "buttons":{
                "确定":function () {
                    dblChoseAlert.close();
                    setUserStatus(state,userId);
                },
                "取消":function () {
                    dblChoseAlert.close();
                }
            }
        })
    }

    function deleteUser(userId) {
        var dblChoseAlert = simpleAlert({
            "content": "确认禁用用户？ 用户id:"+userId,
            "buttons":{
                "确定":function () {
                    dblChoseAlert.close();
                    delUser(userId);
                },
                "取消":function () {
                    dblChoseAlert.close();
                }
            }
        })
    }

    function setUserStatus(state,userId) {
        $.getJSON("settings/ax/admin/updateUserState.do?state="+state+"&userId="+userId, function (data) {
             if (data === false){
                alert("用户状态修改失败！");
            } else {
                document.getElementById("userTable").innerHTML = "";
                $.each(data, function (i, user) {
                    var userId = user.id;
                    var userName = user.userName;
                    var userMobile = user.userPhone;
                    var userEmail = user.userEmail;
                    var userGender = user.gender;
                    var userRegisterDate = user.createTime;
                    var userStatus = user.state === '1' ? "正常":"失效";
                    var opt="";
                    if(user.state == '1'){
                        opt = "<a userId="+user.id+" class='jinyong'>禁用</a>";
                    }else{
                        opt = "<a userId="+user.id+" class='jihuo'>激活</a>";
                    }
                    var user = "<tr style=\"color: #666666\">"+
                        "<td style=\"width: 8%\">"+userId+"</td>"+
                        "<td style=\"width: 13%\">"+userName+"</td>"+
                        "<td style=\"width: 14%\">"+userMobile+"</td>"+
                        "<td style=\"width: 20%\">"+userEmail+"</td>"+
                        "<td style=\"width: 5%\">"+userGender+"</td>"+
                        "<td style=\"width: 20%\">"+userRegisterDate+"</td>"+
                        "<td style=\"width: 10%\">"+userStatus+"</td>"+
                        "<td style=\"width: 10%\">" +
                        "<a userId="+user.id+" class='shanchu'>删除</a>&nbsp;&nbsp;" +
                        opt+
                        "</td>"+
                        "</tr>";
                    $("#userTable").append(user);
                });
                alert("用户状态修改成功！");
            }
        });
    }

    function delUser(userId) {
        $.getJSON("settings/ax/admin/deleteUser.do?userId="+userId, function (data) {
             if (data === false){
                alert("用户删除失败！");
            } else {
                document.getElementById("userTable").innerHTML = "";
                $.each(data, function (i, user) {
                    var userId = user.id;
                    var userName = user.userName;
                    var userMobile = user.userphone;
                    var userEmail = user.userEmail;
                    var userGender = user.gender;
                    var userRegisterDate = user.createTime;
                    var userStatus = user.state === 1 ? "正常":"失效";
                    var opt = user.state === 1 ? "<a onclick='disableUser("+userId+")'>禁用</a>":"<a onclick='enableUser("+userId+")'>激活</a>";
                    var user = "<tr style=\"color: #666666\">"+
                        "<td style=\"width: 8%\">"+userId+"</td>"+
                        "<td style=\"width: 13%\">"+userName+"</td>"+
                        "<td style=\"width: 14%\">"+userMobile+"</td>"+
                        "<td style=\"width: 20%\">"+userEmail+"</td>"+
                        "<td style=\"width: 5%\">"+userGender+"</td>"+
                        "<td style=\"width: 20%\">"+userRegisterDate+"</td>"+
                        "<td style=\"width: 10%\">"+userStatus+"</td>"+
                        "<td style=\"width: 10%\"><a onclick='deleteUser("+userId+")'>删除</a>&nbsp;&nbsp;"+opt+"</td>"+
                        "</tr>";
                    $("#userTable").append(user);
                });
                alert("用户删除成功！");
            }
        });
    }

</script>

<script>
    // order function
    function deleteOrder(orderId) {
        var dblChoseAlert = simpleAlert({
            "content": "确认删除订单？ 订单id:"+orderId,
            "buttons":{
                "确定":function () {
                    dblChoseAlert.close();
                    delOrder(orderId);
                },
                "取消":function () {
                    dblChoseAlert.close();
                }
            }
        })
    }

    function delOrder(orderId) {
        $.getJSON("settings/ax/admin/deleteGoodsOrder.do?goodsOrder="+orderId, function (data) {
             if (data != false){
                document.getElementById("orderTable").innerHTML = "";
                $.each(data, function (i, goodsOrder) {
                    var orderId = goodsOrder.id;
                    var orderSeller = goodsOrder.sellerId;
                    var orderGoodId = goodsOrder.goodId;
                    var orderGoodName = goodsOrder.goodName;
                    var orderMoney = goodsOrder.money;
                    var orderSubmitDate= goodsOrder.submitTime;
                    var orderStatus = goodsOrder.statusId === 0 ? "交易中":"交易完成";
                    var order = "<tr style=\"color: #666666\">"+
                        "<td style=\"width: 10%\">"+orderId+"</td>" +
                        "<td style=\"width: 15%\">"+orderSeller+"</td>" +
                        "<td style=\"width: 10%\">"+orderGoodId+"</td>" +
                        "<td style=\"width: 15%\">"+orderGoodName+"</td>" +
                        "<td style=\"width: 10%\">"+orderMoney+"</td>" +
                        "<td style=\"width: 20%\">"+orderSubmitDate+"</td>" +
                        "<td style=\"width: 10%\">"+orderStatus+"</td>" +
                        "<td style=\"width: 10%\"><a onclick='deleteOrder("+orderId+")'>删除</a></td>" +
                        "</tr>";
                    $("#orderTable").append(order);
                })
                alert("订单删除成功！");
            } else {
                alert("订单删除失败！");
            }
        });
    }
</script>

<script>
    // good function
    function deleteGood(goodId) {
        var dblChoseAlert = simpleAlert({
            "content": "确认删除物品？ 物品id:"+goodId,
            "buttons":{
                "确定":function () {
                    dblChoseAlert.close();
                    delGood(goodId);
                },
                "取消":function () {
                    dblChoseAlert.close();
                }
            }
        })
    }

    function setGoodStatus(goodId) {
        var dblChoseAlert = simpleAlert({
            "content": "确认下架物品？ 物品id:"+goodId,
            "buttons":{
                "确定":function () {
                    dblChoseAlert.close();
                    setStatus(goodId);//下架该商品
                },
                "取消":function () {
                    dblChoseAlert.close();
                }
            }
        })
    }

    function delGood(goodId) {
        $.getJSON("settings/ax/admin/deleteGoods.do?goodsId="+goodId, function (data) {
             if (data != false){
                document.getElementById("goodTable").innerHTML = "";
                $.each(data, function (i, good) {
                    var goodId = good.id;
                    var goodName = good.name;
                    var goodType = good.secondTypeName;
                    var goodUserName = good.userName;
                    var goodUploadeDate = good.uploadDate;
                    var goodStatus = good.statusId === 0 ? '已下架':'在售';
                    var opt = good.statusId === 1 ? "<a onclick='setGoodStatus("+goodId+")'>下架</a>":"";
                    var good = "<tr style=\"color: #666666\">" +
                        "<td style=\"width: 8%\">"+goodId+"</td>" +
                        "<td style=\"width: 15%\">"+goodName+"</td>" +
                        "<td style=\"width: 10%\">"+goodType+"</td>" +
                        "<td style=\"width: 15%\">"+goodUserName+"</td>" +
                        "<td style=\"width: 24%\">"+goodUploadeDate+"</td>" +
                        "<td style=\"width: 13%\">"+goodStatus+"</td>" +
                        "<td style=\"width: 15%\"><a onclick='deleteGood("+goodId+")'>删除</a>&nbsp;&nbsp;"+opt+"</td>" +
                        "</tr>";
                    $("#goodTable").append(good);
                })
                alert("物品删除成功！");
            } else {
                alert("物品删除失败！");
            }
        });
    }

    function setStatus(goodId) {
        $.getJSON("settings/ax/admin/undercarriageGoods.do?goodsId="+goodId, function (data) {
             if (data != false){
                document.getElementById("goodTable").innerHTML = "";
                $.each(data, function (i, good) {
                    var goodId = good.id;
                    var goodName = good.name;
                    var goodType = good.secondTypeName;
                    var goodUserName = good.userName;
                    var goodUploadeDate = good.uploadDate;
                    var goodStatus = good.statusId === 0 ? '已下架':'在售';
                    var opt = good.statusId === 1 ? "<a onclick='setGoodStatus("+goodId+")'>下架</a>":"";
                    var good = "<tr style=\"color: #666666\">" +
                        "<td style=\"width: 8%\">"+goodId+"</td>" +
                        "<td style=\"width: 15%\">"+goodName+"</td>" +
                        "<td style=\"width: 10%\">"+goodType+"</td>" +
                        "<td style=\"width: 15%\">"+goodUserName+"</td>" +
                        "<td style=\"width: 25%\">"+goodUploadeDate+"</td>" +
                        "<td style=\"width: 13%\">"+goodStatus+"</td>" +
                        "<td style=\"width: 15%\"><a onclick='deleteGood("+goodId+")'>删除</a>&nbsp;&nbsp;"+opt+"</td>" +
                        "</tr>";
                    $("#goodTable").append(good);
                })
                alert("物品下架成功！");
            } else {
                alert("物品下架失败！");
            }
        });
    }
</script>
</body>
</html>