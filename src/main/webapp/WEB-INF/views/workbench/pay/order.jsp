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
    <title>订单详情页面</title>
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
            $("#loginOut").click(function () {
                //给退出按钮绑定一个单击事件
                if (window.confirm("您确定退出登录吗？")) {
                    window.location.href = "workbench/loginOut.do";
                }
            })
            //给交易完成按钮绑定一个单击事件
            $("#success").click(function(){
                var goodsOrderId = "${goodsOrder.id}";
                $.ajax({
                    url:'workbench/pay/transaction.do',
                    type:'post',
                    data:{
                        goodsOrderId:goodsOrderId
                    },
                    success: function(res){
                        if(res.code == 1){
                            var nowTime = getNewDate();
                            $("#endTime").text(nowTime);
                            $("#statusId").text("交易已完成");
                            $("#success").attr("style","display: none");
                            $("#noSuccess").attr("style","");
                            //将取消订单隐藏
                            $("#delete_order").attr("style","display: none");
                            //跳转到我的详情页面
                            window.location.href = "settings/qx/user/toUserDetailMes";
                        }
                    }
                })
            })
            //给取消订单绑定一个单击事件
            $("#delete_order").click(function(){
                //获取当前订单的id
                var goodsOrderId = "${goodsOrder.id}";
                $.ajax({
                    url: 'workbench/pay/cancelGoodsOrder.do',
                    type: 'post',
                    dataType: 'json',
                    data: {
                        goodsOrderId:goodsOrderId
                    },
                    success:function(res){
                        if(res.code == "1"){
                            alert("您成功取消了订单!!!");
                            //跳转到个人详情页面
                            window.location.href="settings/qx/user/toUserDetailMes";
                        }
                    }
                })

            })
        })

        //获取特定格式的日期时间  "yyyy-MM-dd HH:MMM:SS"
        function getNewDate() {
            var date = new Date();
            console.log(date);
            var transverse = "-";
            var Verticalpoint = ":";
            var month = date.getMonth() + 1;//获取月份
            var strDate = date.getDate();//获取具体的日期
            var strHour = date.getHours();//获取...钟点
            var strMinute = date.getMinutes();//获取分钟数
            var strSeconde = date.getSeconds();//获取秒钟数
            //判断获取月份 、 具体的日期 、...钟点、分钟数、秒钟数 是否在1~9
            //如果是则在前面加“0”
            if (month >= 1 && month <= 9) {
                month = "0" + month;
            }
            console.log(month);
            if (strDate >= 1 && strDate <= 9) {
                strDate = "0" + strDate;
            }
            if (strHour >= 1 && strHour <=9) {
                strHour = "0" + strHour
            }
            console.log(strHour);
            if (strMinute >= 1 && strMinute <= 9) {
                strMinute = "0" + strMinute;
            }

            if (strSeconde >= 1 && strSeconde <= 9) {
                strSeconde = "0" + strSeconde;
            }
            //时间日期字符串拼接
            var NewDate = date.getFullYear() + transverse + month + transverse + strDate + " " +
                strHour + Verticalpoint + strMinute + Verticalpoint + strSeconde;
            //返回拼接字符串
            return NewDate;
        }
    </script>
</head>


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
                        href="settings/qx/user/toUserDetailMes">${sessionScope.sessionUser.userName}</a></li>
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
                <B style="color: #c4c4c4; font-size: 20px">订单</B>
            </div>
        </div>

        <div class="col-md-12 r2"
             style="background-color: #f9f9f9; padding-top: 5px; padding-bottom: 30px; padding-left: 120px; padding-right: 120px; margin-bottom: 20px">
            <div class="col-md-12" align="center" style="margin-bottom: 5px">
                <h3>订单信息明细</h3>
            </div>
            <div class="col-md-12" style="background-color: #ffffff">
                <div class="col-md-12"
                     style="margin-bottom: 10px; margin-top: 20px;">
                    <div class="col-md-12"
                         style="padding: 30px; background-color: #f2f2f2">
                        <div class="col-md-5"
                             style="padding-left: 60px; padding-top: 20px">
                            <p style="color: #666666; height: 30px">
                                <B>订单号</B>
                            </p>
                            <p style="color: #666666; height: 30px">
                                <B>物品名称</B>
                            </p>
                            <p style="color: #666666; height: 30px">
                                <B>卖家</B>
                            </p>
                            <p style="color: #666666; height: 30px">
                                <B>买家</B>
                            </p>
                            <p style="color: #666666; height: 30px">
                                <B>订单状态</B>
                            </p>
                            <p style="color: #666666; height: 30px">
                                <B>交易时间</B>
                            </p>
                            <p style="color: #666666; height: 30px">
                                <B>结束时间</B>
                            </p>
                        </div>

                        <div id="order" class="col-md-7"
                             style="padding-left: 0px; padding-top: 20px">
                            <p style="color: #666666; height: 30px">
                                <B>${goodsOrder.id}</B>
                            </p>
                            <p style="color: #666666; height: 30px">
                                <B>${goodsOrder.goodName}</B>
                            </p>
                            <p style="color: #666666; height: 30px">
                                <B>${goodsOrder.sellerId}</B>
                            </p>
                            <p style="color: #666666; height: 30px">
                                <B>${goodsOrder.customerId}</B>
                            </p>
                            <p style="color: #666666; height: 30px">
                                <B id="statusId">${goodsOrder.statusId == 0 ? '交易中':'交易已完成'}</B>
                            </p>
                            <p style="color: #666666; height: 30px">
                                <B>${goodsOrder.submitTime}</B>
                            </p>
                            <p style="color: #666666; height: 30px">
                                <B id="endTime">${goodsOrder.endTime}</B>
                            </p>
                        </div>
                    </div>

                    <div class="col-md-12" style="margin-top: 20px">
                        <button id="delete_order" style="display: " class="btn btn-success">取消订单</button>
                        <button id="success" class="btn btn-primary pull-right"
                                ${goodsOrder.statusId == 0 ? '':'style="display:none"'}
							 >完成交易</button>
                        <button id="noSuccess" class="btn btn-primary pull-right"
                                style="display:${goodsOrder.statusId == 0? 'none':''}" disabled="true">交易已完成</button>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div id="re-bar" class="col-md-3 r"
         style="background-color: #f9f9f9; padding-bottom: 15px;">
        <div class="col-md-12 r"
             style="text-align: center; margin-top: 10px; background-color: #e4e4e4; padding: 5px">
            <B style="font-size: 20px; color: #a2a2a2">其他订单</B>
        </div>

        <div class="col-md-12 r"
             style="background-color: #ffffff; margin-top: 15px; overflow-y: auto; height: 500px; padding: 5px">


                <c:forEach items="${othersOrder}" var="order">
                    <a href="workbench/pay/toOrderDetailPage.do?goodsOrderId=${order.id}"> <!--跳转到该订单的详细页面-->
                        <div class="col-md-12 rev"
                             style="padding: 10px; margin-bottom: 5px;">
                            <p>${order.submitTime}</p>
                            <p>${order.goodName}</p>
                        </div>
                    </a>
                </c:forEach>


<%--            <a href="/secondshop/user/orderInfo?orderId=16">--%>
<%--                <div class="col-md-12 rev"--%>
<%--                     style="padding: 10px; margin-bottom: 5px;">--%>
<%--                    <p>2023-02-02 14:59:44</p>--%>
<%--                    <p>牛仔裤</p>--%>
<%--                </div>--%>
<%--            </a>--%>

<%--            <a href="/secondshop/user/orderInfo?orderId=15">--%>
<%--                <div class="col-md-12 rev"--%>
<%--                     style="padding: 10px; margin-bottom: 5px;">--%>
<%--                    <p>2023-02-02 14:59:27</p>--%>
<%--                    <p>牛仔裤</p>--%>
<%--                </div>--%>
<%--            </a>--%>

<%--            <a href="/secondshop/user/orderInfo?orderId=14">--%>
<%--                <div class="col-md-12 rev"--%>
<%--                     style="padding: 10px; margin-bottom: 5px;">--%>
<%--                    <p>2023-02-02 14:59:00</p>--%>
<%--                    <p>牛仔裤</p>--%>
<%--                </div>--%>
<%--            </a>--%>

<%--            <a href="/secondshop/user/orderInfo?orderId=13">--%>
<%--                <div class="col-md-12 rev"--%>
<%--                     style="padding: 10px; margin-bottom: 5px;">--%>
<%--                    <p>2023-02-02 14:58:27</p>--%>
<%--                    <p>毛裤</p>--%>
<%--                </div>--%>
<%--            </a>--%>

<%--            <a href="/secondshop/user/orderInfo?orderId=12">--%>
<%--                <div class="col-md-12 rev"--%>
<%--                     style="padding: 10px; margin-bottom: 5px;">--%>
<%--                    <p>2023-02-02 13:46:28</p>--%>
<%--                    <p>毛裤</p>--%>
<%--                </div>--%>
<%--            </a>--%>

<%--            <a href="/secondshop/user/orderInfo?orderId=11">--%>
<%--                <div class="col-md-12 rev"--%>
<%--                     style="padding: 10px; margin-bottom: 5px;">--%>
<%--                    <p>2023-02-02 13:39:29</p>--%>
<%--                    <p>毛裤</p>--%>
<%--                </div>--%>
<%--            </a>--%>

<%--            <a href="/secondshop/user/orderInfo?orderId=10">--%>
<%--                <div class="col-md-12 rev"--%>
<%--                     style="padding: 10px; margin-bottom: 5px;">--%>
<%--                    <p>2023-02-01 09:47:54</p>--%>
<%--                    <p>菜刀</p>--%>
<%--                </div>--%>
<%--            </a>--%>

<%--            <a href="/secondshop/user/orderInfo?orderId=9">--%>
<%--                <div class="col-md-12 rev"--%>
<%--                     style="padding: 10px; margin-bottom: 5px;">--%>
<%--                    <p>2023-02-01 09:47:22</p>--%>
<%--                    <p>菜刀</p>--%>
<%--                </div>--%>
<%--            </a>--%>

<%--            <a href="/secondshop/user/orderInfo?orderId=2">--%>
<%--                <div class="col-md-12 rev"--%>
<%--                     style="padding: 10px; margin-bottom: 5px;">--%>
<%--                    <p>2021-05-27 17:35:25</p>--%>
<%--                    <p>女裙子</p>--%>
<%--                </div>--%>
<%--            </a>--%>



        </div>
    </div>
</div>



<script>
    $(function () {
        $(window).scroll(function () {
            if ($(document).scrollTop() >= 20) {
                $("#re-bar").css({
                    "position": "fixed",
                    "top": 50 + $(document).scrollTop() + "px",
                    "width": 285,
                    "right": 15
                });
            } else {
                $("#re-bar").css({
                    "position": "fixed",
                    "top": 70 + "px",
                    "width": 285,
                    "right": 15
                });
            }
        })
    });

    function deleteOrder() {
        $.getJSON("/secondshop/user/order/delete/" + 17, function (data) {
            if (data == true){
                alert("订单删除成功！");
                $(window).attr('location','/secondshop/user/userProfile');
            } else {
                alert("订单删除失败！");
            }
        })
    }

    function selectValue() {
        $.getJSON("/secondshop/user/order/update/status/" + 17 + "&3", function (data) {
            if (data == false){
                alert("操作失败！");
            } else {
                document.getElementById("success").style.display = "none";
                document.getElementById("noSuccess").style.display = "";
                document.getElementById("order").innerHTML = "<p style=\"color: #666666; height: 30px\"><B>" + data.id + "</B></p>" +
                    "<p style=\"color: #666666; height: 30px\"><B>" + data.goodName + "</B></p>" +
                    "<p style=\"color: #666666; height: 30px\"><B>" + data.seller + "</B></p>" +
                    "<p style=\"color: #666666; height: 30px\"><B>" + data.customer + "</B></p>" +
                    "<p style=\"color: #666666; height: 30px\"><B>交易完成</B></p>" +
                    "<p style=\"color: #666666; height: 30px\"><B>" + data.submitDate + "</B></p>" +
                    "<p style=\"color: #666666; height: 30px\"><B>" + data.endDate + "</B></p>";
            }
        })
    }
</script>
</body>
</html>