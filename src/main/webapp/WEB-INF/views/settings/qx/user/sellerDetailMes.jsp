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
    <title>${user.userName}发布的商品</title>
    <link rel="stylesheet"
          href="css/bootstrap.min.css" type="text/css">
    <link rel="stylesheet"
          href="jquery-ui-1.12.1/jquery-ui.css" type="text/css">
    <<link rel="stylesheet"
           href="jquery-ui-1.12.1/jquery-ui.theme.css">
    <link rel="stylesheet" href="css/style.css" type="text/css">
    <link rel="stylesheet"
          href="css/swiper.min.css">
    <script src="js/jquery-1.12.4.js" type="text/javascript"></script>
    <script src="js/bootstrap.js" type="text/javascript"></script>
    <script src="jquery-ui-1.12.1/jquery-ui.js" type="text/javascript"></script>
    <script
            src="jquery-ui-1.12.1/datepicker-zh-CN.js" type="text/javascript"></script>
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


            </ul>

            <ul class="nav navbar-nav navbar-right">



                <c:if test="${sessionScope.sessionUser == null}">
                    <li><a href="settings/qx/user/toLogin.do">登录</a></li>
                    <li><a href="settings/qx/user/toRegistPage.do">注册</a></li>
                </c:if>
                <c:if test="${sessionScope.sessionUser != null}">
                    <li><img
                            src="${sessionScope.sessionUser.userAvatar}"
                            height="50px" width="50px"></li>
                    <li><a
                            href="settings/qx/user/toUserDetailMes">${sessionScope.sessionUser.userName}</a></li>
                    <li><a href="javascript:void(0)">退出</a></li>
                </c:if>


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
                <B style="color: #c4c4c4; font-size: 20px">用户信息</B>
            </div>
        </div>

        <div class="col-md-12 r2"
             style="background-color: #f9f9f9; padding-top: 15px; padding-bottom: 15px; margin-bottom: 20px">
            <div class="col-md-2" style="padding-left: 0px; padding-right: 0px;">
                <img src="${user.userAvatar}" width="128px"
                     height="128px">
            </div>

            <div class="col-md-10">
                <div class="col-md-12" style="height: 60px;">
                    <h3>
                        <B>${user.userName}</B>
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
                    <p style="color: #666666; height: 20px">${user.userName}</p>
                    <p style="color: #666666; height: 20px">${user.gender}</p>
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
                    <p style="color: #666666; height: 20px">${user.userPhone}</p>
                    <p style="color: #666666; height: 20px">${user.userEmail}</p>
                </div>
            </div>
        </div>

        <div class="col-md-12 r1"
             style="background-color: #e4e4e4; height: 40px">
            <div class="col-md-6" style="margin-top: 5px">
                <B style="color: #c4c4c4; font-size: 20px">发布的物品</B>
            </div>
        </div>

        <div class="col-md-12 r2" style="background-color: #f9f9f9;">
            <div class="col-md-12"
                 style="margin-top: 15px; margin-bottom: 15px; padding: 15px 15px 15px 5px; background-color: #ffffff">


                <c:forEach items="${goods}" var="good">
                    <a
                            href="workbench/goods/toGoodsDetail.do?goodsId=${good.id}"> <!--用于跳转到该商品的详情页面-->
                        <div class="c col-md-4">
                            <div class="a col-md-12">
                                <img src="${good.photoUrl}" width="100%" height="200px">
                                <p></p>
                                <p style="height: 25px">${good.name}</p>
                                <p style="color: red; text-align: right">
                                    <B>价格：${good.prise}￥</B>
                                </p>
                            </div>
                        </div>
                    </a>
                </c:forEach>

<%--                <a--%>
<%--                        href="/secondshop/goods/goodInfo?goodId=44">--%>
<%--                    <div class="c col-md-4">--%>
<%--                        <div class="a col-md-12">--%>
<%--                            <img src="/secondshop/statics/image/goods/default/nophoto.png" width="100%" height="200px">--%>
<%--                            <p></p>--%>
<%--                            <p style="height: 25px">钱</p>--%>
<%--                            <p style="color: red; text-align: right">--%>
<%--                                <B>价格：0.0￥</B>--%>
<%--                            </p>--%>
<%--                        </div>--%>
<%--                    </div>--%>
<%--                </a>--%>

<%--                <a--%>
<%--                        href="/secondshop/goods/goodInfo?goodId=21">--%>
<%--                    <div class="c col-md-4">--%>
<%--                        <div class="a col-md-12">--%>
<%--                            <img src="/secondshop/statics/image/goods/21hh7EAKXbhG.png" width="100%" height="200px">--%>
<%--                            <p></p>--%>
<%--                            <p style="height: 25px">牛仔裤</p>--%>
<%--                            <p style="color: red; text-align: right">--%>
<%--                                <B>价格：99.0￥</B>--%>
<%--                            </p>--%>
<%--                        </div>--%>
<%--                    </div>--%>
<%--                </a>--%>

<%--                <a--%>
<%--                        href="/secondshop/goods/goodInfo?goodId=20">--%>
<%--                    <div class="c col-md-4">--%>
<%--                        <div class="a col-md-12">--%>
<%--                            <img src="/secondshop/statics/image/goods/20HYtR9EMGq6.png" width="100%" height="200px">--%>
<%--                            <p></p>--%>
<%--                            <p style="height: 25px">牛仔裤</p>--%>
<%--                            <p style="color: red; text-align: right">--%>
<%--                                <B>价格：89.0￥</B>--%>
<%--                            </p>--%>
<%--                        </div>--%>
<%--                    </div>--%>
<%--                </a>--%>

<%--                <a--%>
<%--                        href="/secondshop/goods/goodInfo?goodId=19">--%>
<%--                    <div class="c col-md-4">--%>
<%--                        <div class="a col-md-12">--%>
<%--                            <img src="/secondshop/statics/image/goods/19at1bh3Mizc.png" width="100%" height="200px">--%>
<%--                            <p></p>--%>
<%--                            <p style="height: 25px">休闲裤</p>--%>
<%--                            <p style="color: red; text-align: right">--%>
<%--                                <B>价格：45.0￥</B>--%>
<%--                            </p>--%>
<%--                        </div>--%>
<%--                    </div>--%>
<%--                </a>--%>

<%--                <a--%>
<%--                        href="/secondshop/goods/goodInfo?goodId=18">--%>
<%--                    <div class="c col-md-4">--%>
<%--                        <div class="a col-md-12">--%>
<%--                            <img src="/secondshop/statics/image/goods/18fRDAAt7ihr.png" width="100%" height="200px">--%>
<%--                            <p></p>--%>
<%--                            <p style="height: 25px">毛裤</p>--%>
<%--                            <p style="color: red; text-align: right">--%>
<%--                                <B>价格：68.0￥</B>--%>
<%--                            </p>--%>
<%--                        </div>--%>
<%--                    </div>--%>
<%--                </a>--%>

<%--                <a--%>
<%--                        href="/secondshop/goods/goodInfo?goodId=17">--%>
<%--                    <div class="c col-md-4">--%>
<%--                        <div class="a col-md-12">--%>
<%--                            <img src="/secondshop/statics/image/goods/172suYjx9SMQ.png" width="100%" height="200px">--%>
<%--                            <p></p>--%>
<%--                            <p style="height: 25px">毛衣</p>--%>
<%--                            <p style="color: red; text-align: right">--%>
<%--                                <B>价格：410.0￥</B>--%>
<%--                            </p>--%>
<%--                        </div>--%>
<%--                    </div>--%>
<%--                </a>--%>

<%--                <a--%>
<%--                        href="/secondshop/goods/goodInfo?goodId=16">--%>
<%--                    <div class="c col-md-4">--%>
<%--                        <div class="a col-md-12">--%>
<%--                            <img src="/secondshop/statics/image/goods/16JdQuvqvCMR.png" width="100%" height="200px">--%>
<%--                            <p></p>--%>
<%--                            <p style="height: 25px">秋衣</p>--%>
<%--                            <p style="color: red; text-align: right">--%>
<%--                                <B>价格：201.0￥</B>--%>
<%--                            </p>--%>
<%--                        </div>--%>
<%--                    </div>--%>
<%--                </a>--%>

<%--                <a--%>
<%--                        href="/secondshop/goods/goodInfo?goodId=15">--%>
<%--                    <div class="c col-md-4">--%>
<%--                        <div class="a col-md-12">--%>
<%--                            <img src="/secondshop/statics/image/goods/15aNfKBYpv5j.png" width="100%" height="200px">--%>
<%--                            <p></p>--%>
<%--                            <p style="height: 25px">春天的衣服</p>--%>
<%--                            <p style="color: red; text-align: right">--%>
<%--                                <B>价格：500.0￥</B>--%>
<%--                            </p>--%>
<%--                        </div>--%>
<%--                    </div>--%>
<%--                </a>--%>

<%--                <a--%>
<%--                        href="/secondshop/goods/goodInfo?goodId=14">--%>
<%--                    <div class="c col-md-4">--%>
<%--                        <div class="a col-md-12">--%>
<%--                            <img src="/secondshop/statics/image/goods/14TlVbutO2l4.png" width="100%" height="200px">--%>
<%--                            <p></p>--%>
<%--                            <p style="height: 25px">秋天的衣服</p>--%>
<%--                            <p style="color: red; text-align: right">--%>
<%--                                <B>价格：80.0￥</B>--%>
<%--                            </p>--%>
<%--                        </div>--%>
<%--                    </div>--%>
<%--                </a>--%>

<%--                <a--%>
<%--                        href="/secondshop/goods/goodInfo?goodId=13">--%>
<%--                    <div class="c col-md-4">--%>
<%--                        <div class="a col-md-12">--%>
<%--                            <img src="/secondshop/statics/image/goods/131xUYtIeZuj.png" width="100%" height="200px">--%>
<%--                            <p></p>--%>
<%--                            <p style="height: 25px">夏天的衣服</p>--%>
<%--                            <p style="color: red; text-align: right">--%>
<%--                                <B>价格：100.0￥</B>--%>
<%--                            </p>--%>
<%--                        </div>--%>
<%--                    </div>--%>
<%--                </a>--%>

<%--                <a--%>
<%--                        href="/secondshop/goods/goodInfo?goodId=4">--%>
<%--                    <div class="c col-md-4">--%>
<%--                        <div class="a col-md-12">--%>
<%--                            <img src="/secondshop/statics/image/goods/caidao.png" width="100%" height="200px">--%>
<%--                            <p></p>--%>
<%--                            <p style="height: 25px">菜刀</p>--%>
<%--                            <p style="color: red; text-align: right">--%>
<%--                                <B>价格：5.0￥</B>--%>
<%--                            </p>--%>
<%--                        </div>--%>
<%--                    </div>--%>
<%--                </a>--%>

<%--                <a--%>
<%--                        href="/secondshop/goods/goodInfo?goodId=3">--%>
<%--                    <div class="c col-md-4">--%>
<%--                        <div class="a col-md-12">--%>
<%--                            <img src="/secondshop/statics/image/goods/guochan.png" width="100%" height="200px">--%>
<%--                            <p></p>--%>
<%--                            <p style="height: 25px">锅铲</p>--%>
<%--                            <p style="color: red; text-align: right">--%>
<%--                                <B>价格：10.0￥</B>--%>
<%--                            </p>--%>
<%--                        </div>--%>
<%--                    </div>--%>
<%--                </a>--%>



            </div>
        </div>
    </div>

    <div id="re-bar" class="col-md-3 r"
         style="background-color: #f9f9f9; padding-bottom: 15px;">
        <div class="col-md-12 r"
             style="text-align: center; margin-top: 10px; background-color: #e4e4e4; padding: 5px">
            <B style="font-size: 20px; color: #a2a2a2">最新发布的物品</B>
        </div>

        <div class="col-md-12"
             style="margin-top: 20px; padding-left: 0px; padding-right: 0px">
            <c:forEach items="${latestGoods}" var="latestGood">
                <a
                        href="workbench/goods/toGoodsDetail.do?goodsId=${latestGood.id}">
                    <div class="col-md-12 b"
                         style="padding-left: 0px; padding-right: 0px">
                        <div class="col-md-6"
                             style="padding-top: 15px; padding-bottom: 15px">
                            <img src="${latestGood.photoUrl}" height="100px"
                                 ; width="100px">
                        </div>

                        <div class="col-md-6"
                             style="padding-top: 15px; padding-bottom: 15px; height: 130px">
                            <p style="height: 75px">${latestGood.name}</p>
                            <p align="right" style="color: red">￥${latestGood.prise}</p>
                        </div>
                    </div>
                </a>
            </c:forEach>
<%--            <a--%>
<%--                    href="/secondshop/goods/goodInfo?goodId=44">--%>
<%--                <div class="col-md-12 b"--%>
<%--                     style="padding-left: 0px; padding-right: 0px">--%>
<%--                    <div class="col-md-6"--%>
<%--                         style="padding-top: 15px; padding-bottom: 15px">--%>
<%--                        <img src="/secondshop/statics/image/goods/default/nophoto.png" height="100px"--%>
<%--                             ; width="100px">--%>
<%--                    </div>--%>

<%--                    <div class="col-md-6"--%>
<%--                         style="padding-top: 15px; padding-bottom: 15px; height: 130px">--%>
<%--                        <p style="height: 75px">钱</p>--%>
<%--                        <p align="right" style="color: red">￥0.0</p>--%>
<%--                    </div>--%>
<%--                </div>--%>
<%--            </a>--%>

<%--            <a--%>
<%--                    href="/secondshop/goods/goodInfo?goodId=21">--%>
<%--                <div class="col-md-12 b"--%>
<%--                     style="padding-left: 0px; padding-right: 0px">--%>
<%--                    <div class="col-md-6"--%>
<%--                         style="padding-top: 15px; padding-bottom: 15px">--%>
<%--                        <img src="/secondshop/statics/image/goods/21hh7EAKXbhG.png" height="100px"--%>
<%--                             ; width="100px">--%>
<%--                    </div>--%>

<%--                    <div class="col-md-6"--%>
<%--                         style="padding-top: 15px; padding-bottom: 15px; height: 130px">--%>
<%--                        <p style="height: 75px">牛仔裤</p>--%>
<%--                        <p align="right" style="color: red">￥99.0</p>--%>
<%--                    </div>--%>
<%--                </div>--%>
<%--            </a>--%>

<%--            <a--%>
<%--                    href="/secondshop/goods/goodInfo?goodId=20">--%>
<%--                <div class="col-md-12 b"--%>
<%--                     style="padding-left: 0px; padding-right: 0px">--%>
<%--                    <div class="col-md-6"--%>
<%--                         style="padding-top: 15px; padding-bottom: 15px">--%>
<%--                        <img src="/secondshop/statics/image/goods/20HYtR9EMGq6.png" height="100px"--%>
<%--                             ; width="100px">--%>
<%--                    </div>--%>

<%--                    <div class="col-md-6"--%>
<%--                         style="padding-top: 15px; padding-bottom: 15px; height: 130px">--%>
<%--                        <p style="height: 75px">牛仔裤</p>--%>
<%--                        <p align="right" style="color: red">￥89.0</p>--%>
<%--                    </div>--%>
<%--                </div>--%>
<%--            </a>--%>

<%--            <a--%>
<%--                    href="/secondshop/goods/goodInfo?goodId=19">--%>
<%--                <div class="col-md-12 b"--%>
<%--                     style="padding-left: 0px; padding-right: 0px">--%>
<%--                    <div class="col-md-6"--%>
<%--                         style="padding-top: 15px; padding-bottom: 15px">--%>
<%--                        <img src="/secondshop/statics/image/goods/19at1bh3Mizc.png" height="100px"--%>
<%--                             ; width="100px">--%>
<%--                    </div>--%>

<%--                    <div class="col-md-6"--%>
<%--                         style="padding-top: 15px; padding-bottom: 15px; height: 130px">--%>
<%--                        <p style="height: 75px">休闲裤</p>--%>
<%--                        <p align="right" style="color: red">￥45.0</p>--%>
<%--                    </div>--%>
<%--                </div>--%>
<%--            </a>--%>

        </div>
    </div>
</div>



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
</script>

</body>
</html>