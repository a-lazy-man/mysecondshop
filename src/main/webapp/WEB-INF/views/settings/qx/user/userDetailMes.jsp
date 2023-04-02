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
    <title>个人信息</title>
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
        $(function(){
            //给退出按钮绑定一个单击事件
            $("#loginOut").click(function(){
                if(window.confirm("您确定退出登录吗？")){
                    window.location.href = "workbench/loginOut.do";
                }
            })

            $(".collect").click(function(){
                alert("按钮被单击了!!!")
                var goodsId = $(this).attr("goodsId");
                //获取当前用户的id
                var userId = "${sessionScope.sessionUser.id}";
                alert("当前要取消收藏的商品的id" + goodsId + "当前要取消收藏的商品的用户id" + userId);
                $.ajax({
                    url: 'settings/qx/user/CancelCollect',
                    type: 'post',
                    dataType: 'json',
                    data: {
                        goodsId: goodsId,
                        userId: userId
                    },
                    success: function(rm){
                        if(rm.code == 1){
                            alert("取消收藏成功！！！");
                            //需要刷新用户收藏列表
                            window.location.href = "settings/qx/user/toUserDetailMes";
                        }else{
                            alert(rm.message);
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
                        href="workbench/goods/toGoodsPublishPage.do">发布</a></li>


            </ul>

            <ul class="nav navbar-nav navbar-right">
                <li><img
                        src="${sessionScope.sessionUser.userAvatar}"
                        height="50px" width="50px"></li>
                <li><a
                        href="javascript:void(0)">${sessionScope.sessionUser.userName}</a></li>
                <li><a id="loginOut" href="javascript:void(0)">退出</a></li>


            </ul>
        </div>
    </div>
</nav>
<div class="col-md-12" style="height: 70px"></div>

<div class="container"
     style="position: relative; transform: translate(0, 0)">
    <div class="col-md-9" style="float: left">
        <div class="col-md-12 r1"
             style="background-color: #e4e4e4; height: 40px">
            <div class="col-md-6" style="margin-top: 5px">
                <B style="color: #c4c4c4; font-size: 20px">我的信息</B>
            </div>
        </div>

        <div class="col-md-12 r2"
             style="background-color: #f9f9f9; padding-top: 15px; padding-bottom: 15px; margin-bottom: 20px">
            <div class="col-md-2" style="padding-left: 0px; padding-right: 0px;">
                <img src="${sessionScope.sessionUser.userAvatar}"
                     width="128px" height="128px">
            </div>

            <div class="col-md-10">
                <div class="col-md-12" style="height: 60px;">
                    <h3>
                        <B>${sessionScope.sessionUser.userName eq null ? '待完善':sessionScope.sessionUser.userName}</B>
                    </h3>
                </div>

                <div class="col-md-2" style="padding-right: 0px">
                    <p style="color: #666666; height: 20px">
                        <B>昵称：</B>
                    </p>
                    <p style="color: #666666; height: 20px">
                        <B>性别：</B>
                    </p>
                </div>

                <div class="col-md-2" style="padding-left: 0px">
                    <p style="color: #666666; height: 20px">${sessionScope.sessionUser.userName eq null ? '待完善':sessionScope.sessionUser.userName}</p>
                    <p style="color: #666666; height: 20px">${sessionScope.sessionUser.gender eq null ? '待完善':sessionScope.sessionUser.gender }</p>

                </div>

                <div class="col-md-2" style="padding-right: 0px">
                    <p style="color: #666666; height: 20px">
                        <B>手机号：</B>
                    </p>
                    <p style="color: #666666; height: 20px">
                        <B>邮箱：</B>
                    </p>
                </div>

                <div class="col-md-3" style="padding-left: 0px">
                    <p style="color: #666666; height: 20px">${sessionScope.sessionUser.userPhone eq null ? '待完善':sessionScope.sessionUser.userPhone}</p>
                    <p style="color: #666666; height: 20px">${sessionScope.sessionUser.userEmail eq null ? '待完善':sessionScope.sessionUser.userEmail}</p>
                </div>

                <div class="col-md-3">
                    <a
                            href="settings/qx/user/toEditUserMes">修改个人资料</a>
                </div>
            </div>
        </div>

        <div class="col-md-12 r1"
             style="background-color: #e4e4e4; height: 40px">
            <div class="col-md-6" style="margin-top: 5px">
                <B style="color: #c4c4c4; font-size: 20px">我收藏的物品</B>
            </div>
        </div>

        <div class="col-md-12 r2"
             style="background-color: #f9f9f9; padding-top: 15px; padding-bottom: 15px; margin-bottom: 20px;">
            <div class="col-md-12 r" style="background-color: #ffffff;">
                <p></p>
                <p style="color: #c4c4c4; font-size: 20px; margin-bottom: 0px;"
                   align="center">
                    <B>我收藏的物品</B>
                </p>


                <div class="col-md-12 column" style="padding-left: 15px;">
                    <table class="table" style="margin-bottom: 0px">
                        <thead>
                        <tr style="color: #666666">
                            <th style="width: 102px">编号</th>
                            <th style="width: 200px">标题</th>
                            <th style="width: 200px">发布时间</th>
                            <th style="width: 100px">状态</th>
                            <th>操作</th>
                        </tr>
                        </thead>
                    </table>
                </div>

                <div class="col-md-12 column"
                     style="overflow-y: auto; height: 280px;">
                    <table class="table table-hover">
                        <tbody id="collectTable">
                           <c:forEach items="${userCollectGoods}" var="userCollectGood">
                               <tr style="color: #666666">
                                   <td style="width: 102px"><a
                                           href="">${userCollectGood.id}</a></td>
                                   <td style="width: 227px">${userCollectGood.name}</td>
                                   <td style="width: 260px">${userCollectGood.uploadDate}</td>
                                   <td style="width: 102px">${userCollectGood.statusId == 0 ? '已下架':'在售'}</td>
                                   <td>
                                       <button class="collect" goodsId="${userCollectGood.id}" userId="${userCollectGood.userId}">取消收藏</button>
                                   </td>
                               </tr>
                           </c:forEach>
                        </tbody>
                    </table>
                </div>


            </div>
        </div>

        <div class="col-md-12 r1"
             style="background-color: #e4e4e4; height: 40px">
            <div class="col-md-6" style="margin-top: 5px">
                <B style="color: #c4c4c4; font-size: 20px">我的物品</B>
            </div>
        </div>

        <div class="col-md-12 r2"
             style="background-color: #f9f9f9; padding-top: 15px; padding-bottom: 15px; margin-bottom: 20px;">
            <div class="col-md-12 r" style="background-color: #ffffff;">
                <p></p>
                <p style="color: #c4c4c4; font-size: 20px; margin-bottom: 0px;"
                   align="center">
                    <B>我发布的物品</B>
                </p>


                <div class="col-md-12 column" style="padding-left: 15px;">
                    <table class="table" style="margin-bottom: 0px">
                        <thead>
                        <tr style="color: #666666">
                            <th style="width: 102px">编号</th>
                            <th style="width: 227px">标题</th>
                            <th style="width: 260px">发布时间</th>
                            <th>状态</th>
                        </tr>
                        </thead>
                    </table>
                </div>

                <div class="col-md-12 column"
                     style="overflow-y: auto; height: 280px;">
                    <table class="table table-hover">
                        <tbody>
                        <c:forEach items="${publishedGoods}" var="publishedGood">
                            <tr style="color: #666666">
                                <td style="width: 102px"><a
                                        href="">${publishedGood.id}</a></td>
                                <td style="width: 227px">${publishedGood.name}</td>
                                <td style="width: 260px">${publishedGood.uploadDate}</td>
                                <td>${publishedGood.statusId == 0 ? '已下架':'在售'}</td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>


            </div>
        </div>

        <div class="col-md-12 r1"
             style="background-color: #e4e4e4; height: 40px">
            <div class="col-md-6" style="margin-top: 5px">
                <B style="color: #c4c4c4; font-size: 20px">我的订单</B>
            </div>
        </div>

        <div class="col-md-12 r2"
             style="background-color: #f9f9f9; padding-top: 15px; padding-bottom: 15px; margin-bottom: 20px;">
            <div class="col-md-12 r" style="background-color: #ffffff;">
                <p></p>
                <p style="color: #c4c4c4; font-size: 20px; margin-bottom: 0px;"
                   align="center">
                    <B>我所有的订单</B>
                </p>


                <div class="col-md-12 column" style="padding-left: 15px;">
                    <table class="table" style="margin-bottom: 0px">
                        <thead>
                        <tr style="color: #666666">
                            <th style="width: 90px">订单编号</th>
                            <th style="width: 100px">卖家</th>
                            <th style="width: 140px">物品名称</th>
                            <th style="width: 70px">金额</th>
                            <th style="width: 200px">提交时间</th>
                            <th>订单状态</th>
                        </tr>
                        </thead>
                    </table>
                </div>

                <div class="col-md-12 column"
                     style="overflow-y: auto; height: 280px;">
                    <table class="table table-hover">
                        <tbody>
                            <c:forEach items="${goodsOrders}" var="goodsOrder">
                                <tr style="color: #666666">
                                    <td style="width: 90px"><a
                                            href="">${goodsOrder.id}</a></td>
                                    <td style="width: 100px">${goodsOrder.sellerId}</td>
                                    <td style="width: 140px">${goodsOrder.goodName}</td>
                                    <td style="width: 70px">${goodsOrder.money}</td>
                                    <td style="width: 200px">${goodsOrder.submitTime}</td>
                                    <td>${goodsOrder.statusId == 0 ? '交易中':'交易完成'}</td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>


            </div>
        </div>
    </div>

    <div id="re-bar" class="col-md-3"
         style="padding-left: 0px; padding-right: 0px;">
        <div class="col-md-12 r1"
             style="background-color: #e4e4e4; height: 40px; padding-left: 0px; padding-right: 0px;">
            <div id="review-bar" class="col-md-6 rev1-bar" align="center"
                 onclick="reviewButton()">
                <B style="font-size: 16px; color: #c4c4c4">我的成果</B>
            </div>

            <div id="reply-bar" class="col-md-6 rev2-bar" align="center"
                 onclick="replyButton()">
                <B style="font-size: 16px; display: none; color: #c4c4c4">收到的回复</B>
            </div>
        </div>

        <div class="col-md-12 r2"
             style="background-color: #f9f9f9; padding-bottom: 15px">
            <div id="review-body" class="col-md-12 r3"
                 style="display: none; overflow-y: auto; height: 585px; background-color: #ffffff; padding-left: 5px; padding-right: 5px; padding-top: 5px; padding-bottom: 15px;">


            </div>

            <div id="reply-body" class="col-md-12 r3"
                 style="display: none; overflow-y: auto; height: 585px; background-color: #ffffff; padding-left: 5px; padding-right: 5px; padding-top: 5px; padding-bottom: 15px;">


            </div>

            <div id="adv-bar" class="col-md-12"
                 style="margin-top: 5px; padding: 0px;">
                <div class="col-md-12" align="center">
                    <B style="font-size: 16px; color: #c4c4c4">卖出的物品</B>
                </div>

                <div class="col-md-12"
                     style="overflow-y: auto; height: 450px; padding: 5px; background-color: #ffffff;">

                   <c:forEach items="${goods}" var="good">
                       <a
                               href="workbench/goods/toGoodsDetail.do?goodsId=${good.id}"> <!--跳转到商品详情页面-->
                           <div class="col-md-12 b"
                                style="padding-left: 0px; padding-right: 0px">
                               <div class="col-md-6"
                                    style="padding-top: 15px; padding-bottom: 15px">
                                   <img src="${good.photoUrl}" height="100px"
                                        ; width="100px">
                               </div>
                               <div class="col-md-6"
                                    style="padding-top: 15px; padding-bottom: 15px; height: 130px">
                                   <p style="height: 75px">${good.name}</p>
                                   <p align="right" style="color: red">￥${good.prise}</p>
                               </div>
                           </div>
                       </a>
                   </c:forEach>
                </div>
            </div>
        </div>
    </div>
</div>


<script>
    function deleteCollect(collectId) {
        $.get("/secondshop/collect/delete/" + collectId + "&" + 2, function (data) {
            if (data === false) {
                alert("未知原因，删除失败！");
            } else {
                document.getElementById("collectTable").innerHTML = "";
                $.each(data, function (i, type) {
                    var collectId = type.id;
                    var collectGoodId = type.good.id;
                    var collectGoodName = type.good.name;
                    var collectGoodUploadDate = type.good.uploadDate;
                    var collectGoodStatus = type.good.statusId === 0 ? "已下架" : "在售";
                    var collect = "<tr style=\"color: #666666\">" +
                        "<td style=\"width: 102px\"><a target='_blank' href='/secondshop/goods/goodInfo?goodId=" + collectGoodId + "'>" + collectGoodId + "</a></td>" +
                        "<td style=\"width: 200px\">" + collectGoodName + "</td>" +
                        "<td style=\"width: 200px\">" + collectGoodUploadDate + "</td>" +
                        "<td style=\"width: 100px\">" + collectGoodStatus + "</td>" +
                        "<td><a onclick='deleteCollect(" + collectId + ")'>删除</a></td>" +
                        "</tr>";
                    $("#collectTable").append(collect);
                });
                alert("删除成功！");
            }
        })
    }

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

<script>
    var bar_width = document.getElementById("re-bar").scrollWidth;
    $(function () {
        $(window).scroll(function () {
            if ($(document).scrollTop() >= 20) {
                $("#re-bar").css({
                    "position": "fixed",
                    "top": 50 + $(document).scrollTop() + "px",
                    "width": bar_width,
                    "right": 15
                });
            } else {
                $("#re-bar").css({
                    "position": "fixed",
                    "top": 70 + "px",
                    "width": bar_width,
                    "right": 15
                });
            }
        })
    })
</script>
</body>
</html>