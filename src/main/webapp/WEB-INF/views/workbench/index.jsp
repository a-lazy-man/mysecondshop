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
    <title>首页</title>
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
    <link rel="stylesheet" type="text/css" href="css/jquery.bs_pagination.min.css">
    <script type="text/javascript" src="js/jquery.bs_pagination.min.js"></script>
    <script type="text/javascript" src="js/en.js"></script>

    <script type="text/javascript">
        var a = 6; //表示当前每页显示记录条数 pageSize
        var b = 1; //表示当前的页号pageNum
        $(function(){
            var width = $("#type-bar").width();
            $(window).scroll(function () {
                if ($(document).scrollTop() >= $("#search-bar").height()) {
                    $("#type-bar").css({
                        "position": "fixed",
                        "top": 150 - $("#search-bar").height() + "px",
                        "width": width
                    });
                } else {
                    $("#type-bar").css({
                        "position": "fixed",
                        "top": 150 - $(document).scrollTop() + "px",
                        "width": width
                    });
                }
            })
            //给退出按钮绑定一个单击事件
            $("#loginOut").click(function () {
                if(window.confirm("您确定退出登录吗？")){
                    window.location.href = "workbench/loginOut.do";
                }
            })
            //页面加载完成之后，调用分页查询函数
            pageQuery(undefined,undefined,1,6);
            //给所有的二级类型的a标签绑定单击事件
            $(".r-type").click(function(){
                //获取当前商品类型的二级类型
                var secondTypeId = $(this).attr("secondTypeId");
                pageQuery(secondTypeId,undefined,b,a);
            })
            //给搜索按钮绑定单击事件
            $("#sosuo").click(function(){
                //获取当前搜索栏中商品的名称
                var goodsName = $("#searchText").val();
                if($.trim(goodsName).length == 0){
                    alert("搜索内容不能为空！！！");
                    return ;
                }
                pageQuery(undefined,goodsName,b,a);
                //清除掉搜索栏中的检索信息
                $("#searchText").val("");
            })

        })
        function pageQuery(secondTypeId,goodsName,pageNum,pageSize){
            $.ajax({
                url: 'workbench/pageQueryByConditions.do',
                type: 'post',
                dataType: 'json',
                data: {
                    secondTypeId: secondTypeId,
                    pageNum:pageNum,
                    pageSize:pageSize,
                    goodsName:goodsName
                },
                success: function(hashMap){//从后台查询到的商品
                    var goods = hashMap.pageSelectGoods;
                    var totalRows = hashMap.totalRows;
                    //刷新页面
                    //清空之前goodsList中的内容
                    $("#goodsList").html("");
                    console.log(goods);
                    if(goods.length == 0){
                        $("#goodsList").append("<img src=\"image/goods/default/zanwu.png\" height=\"80%\" width=\"80%\">")
                    }else{
                        $.each(goods,function(index,good){
                            $("#goodsList").append("<a href=\"workbench/goods/toGoodsDetail.do?goodsId="+good.id+"\">\n" +
                                "                    <div class=\"c col-md-3\">\n" +
                                "                        <div class=\"a col-md-12\">\n" +
                                "                            <img src=\""+good.photoUrl+"\" width=\"100%\" height=\"200px\">\n" +
                                "                            <p style=\"height: 25px; margin-top: 20px\">"+good.name+"</p>\n" +
                                "                            <p style=\"color: red; text-align: right\">\n" +
                                "                                <B>价格："+good.prise+"￥</B>\n" +
                                "                            </p>\n" +
                                "                        </div>\n" +
                                "                    </div>\n" +
                                "                </a>\n" +
                                "\n")
                        })
                    }
                    //计算总页数
                    var totalPages;
                    if(totalRows % pageSize == 0){
                        totalPages = totalRows / pageSize
                    }else{
                        totalPages = parseInt(totalRows/pageSize)+1;
                    }
                    $("#demo_pag1").bs_pagination({
                        currentPage: pageNum, //参数值默认是1，表示当前页面 pageNo

                        rowsPerPage: pageSize, //每页显示条数 pageSize
                        totalRows:  totalRows, //总记录条数
                        totalPages: totalPages, //必填参数，我们根据总的条数和每页显示条数算好传给框架

                        visiblePageLinks: 4,//最多可以显示的卡片数量

                        showGoToPage: true,//是否显示"跳转到"部分。默认是true--显示
                        showRowsPerPage: true,//是否显示"每页显示条数部分。默认是true---显示"
                        showRowsInfo: true,//是否显示记录的信息，默认是true----显示

                        onChangePage: function(event,pageObj){//当用户每次切换页号时，都会执行该方法
                            //每次返回切换页号之后的pageNo,pageSize 手动刷新活动列表
                            a = pageObj.rowsPerPage;//表示当前每页显示的条数
                            b = pageObj.currentPage;//表示当前的页号
                            pageQuery(secondTypeId,goodsName,pageObj.currentPage,pageObj.rowsPerPage);
                        }
                    });
                }
            });
        }
    </script>
</head>
<body>
<div>


    <nav class="navbar navbar-default navbar-fixed-top" role="navigation">
        <div class="container">
            <div class="navbar-header">
                <a class="navbar-brand" href="#" style="font-size: 25px">校园二手交易平台</a>
            </div>

            <div id="navbar" class="navbar-collapse collapse">
                <ul class="nav navbar-nav">


                    <li><a href="/secondshop/">首页</a></li>
                    <c:if test="${sessionScope.sessionUser != null}">
                        <li><a
                                href="settings/qx/user/toUserDetailMes">我的</a></li>
                        <li><a
                                href="workbench/goods/toGoodsPublishPage.do">发布</a></li>
                    </c:if>

                </ul>

                <ul class="nav navbar-nav navbar-right">
                    <%--                    <li><img--%>
                    <%--                            src="image/photos/zs.jpg"--%>
                    <%--                            height="50px" width="50px"></li>--%>
                    <%--                    <li><a--%>
                    <%--                            href="/secondshop/user/userProfile">张三</a></li>--%>
                    <%--                    <li><a href="/secondshop/logout?logout=true">退出</a></li>--%>

                    <c:if test="${sessionScope.sessionUser != null}">
                        <li><img
                                src="${sessionScope.sessionUser.userAvatar}"
                                height="50px" width="50px"></li>
                        <li><a
                                href="settings/qx/user/toUserDetailMes">${sessionScope.sessionUser.userName}</a></li>
                        <li><a id="loginOut" href="javascript:void(0)">退出</a></li>
                    </c:if>
                    <c:if test="${sessionScope.sessionUser == null}">
                        <li><img
                                src="image/photos/default/default.jpg"
                                height="50px" width="50px"></li>
                        <li><a
                                href="settings/qx/user/toLogin.do">登录</a></li>
                        <li><a href="settings/qx/user/toRegistPage.do">注册</a></li>
                    </c:if>


                </ul>
            </div>
        </div>
    </nav>
    <div class="col-md-12" style="height: 70px"></div>
</div>

<div class="col-md-12" style="height: 80px;" id="search-bar">
    <div class="col-md-3"></div>
    <div class="col-md-6" style="padding-top: 10px">
        <form class="form-horizontal" action="/secondshop/" method="get">
            <div class="form-group col-md-12">
                <div class="col-md-10">
                    <input secondTypeId="默认值" id="searchText" name="searchText" type="text"
                           class="form-control" value=""
                           placeholder="这里可以搜索哦~~">
                </div>

                <button type="button" id="sosuo" class="btn btn-success; col-md-2">搜索</button>

                <div class="col-md-12">

                </div>
            </div>
        </form>
    </div>
    <div class="col-md-3"></div>
</div>

<div class="container">
    <div class="main-content">
        <div class="col-md-2" style="padding-left: 0px; padding-right: 0px;"
             id="type-bar">
            <div class="col-md-12" align="center"
                 style="padding-left: 0px; padding-right: 0px;" id="type-button">

                <c:if test="${firstTypes != null}">
                    <c:forEach items="${firstTypes}" var="firstType">
                        <div
                                style="height: 50px; width: 100%; background-color: #eaeaea; margin-top: 15px;"
                                class="btn-type" align="center;" id="type${firstType.id}"
                                onclick="typeButton('${firstType.id}')">
                            <p>
                            <h4>${firstType.name}</h4>
                            </p>
                        </div>
                        <div class="col-md-12 r" id="${firstType.id}"
                             style="display: none; background-color: #f5f5f5; padding-left: 0px; padding-right: 0px;"
                             align="center">
                            <c:forEach items="${secondTypes}" var="secondType">
                                <c:if test="${secondType.firstTypeId == firstType.id}">
                                        <a secondTypeId="${secondType.id}" firstTypeId="${firstType.id}" class="col-md-12 r-type"
                                       href="javascript:void(0)">
                                        <p></p>
                                        <p>${secondType.name}</p>
                                    </a>
                                </c:if>
                            </c:forEach>
                        </div>
                    </c:forEach>
                </c:if>

                <%--                <div--%>
                <%--                        style="height: 50px; width: 100%; background-color: #eaeaea; margin-top: 15px;"--%>
                <%--                        class="btn-type" align="center;" id="type1002"--%>
                <%--                        onclick="typeButton(1002)">--%>
                <%--                    <p>--%>
                <%--                    <h4>穿着</h4>--%>
                <%--                    </p>--%>
                <%--                </div>--%>

                <%--                <div class="col-md-12 r" id="1002"--%>
                <%--                     style="display: none; background-color: #f5f5f5; padding-left: 0px; padding-right: 0px;"--%>
                <%--                     align="center">--%>

                <%--                    <a class="col-md-12 r-type"--%>
                <%--                       href="javascript:void(0)">--%>
                <%--                        <p></p>--%>
                <%--                        <p>上衣</p>--%>
                <%--                    </a>--%>

                <%--                    <a class="col-md-12 r-type"--%>
                <%--                       href="javascript:void(0)">--%>
                <%--                        <p></p>--%>
                <%--                        <p>裙子</p>--%>
                <%--                    </a>--%>

                <%--                    <a class="col-md-12 r-type"--%>
                <%--                       href="javascript:void(0)">--%>
                <%--                        <p></p>--%>
                <%--                        <p>裤子</p>--%>
                <%--                    </a>--%>

                <%--                    <a class="col-md-12 r-type"--%>
                <%--                       href="javascript:void(0)">--%>
                <%--                        <p></p>--%>
                <%--                        <p>鞋</p>--%>
                <%--                    </a>--%>

                <%--                </div>--%>

                <%--                <div--%>
                <%--                        style="height: 50px; width: 100%; background-color: #eaeaea; margin-top: 15px;"--%>
                <%--                        class="btn-type" align="center;" id="type1003"--%>
                <%--                        onclick="typeButton(1003)">--%>
                <%--                    <p>--%>
                <%--                    <h4>日用</h4>--%>
                <%--                    </p>--%>
                <%--                </div>--%>

                <%--                <div class="col-md-12 r" id="1003"--%>
                <%--                     style="display: none; background-color: #f5f5f5; padding-left: 0px; padding-right: 0px;"--%>
                <%--                     align="center">--%>

                <%--                    <a class="col-md-12 r-type"--%>
                <%--                       href="javascript:void(0)">--%>
                <%--                        <p></p>--%>
                <%--                        <p>纸巾</p>--%>
                <%--                    </a>--%>

                <%--                    <a class="col-md-12 r-type"--%>
                <%--                       href="javascript:void(0)">--%>
                <%--                        <p></p>--%>
                <%--                        <p>牙膏</p>--%>
                <%--                    </a>--%>

                <%--                    <a class="col-md-12 r-type"--%>
                <%--                       href="javascript:void(0)">--%>
                <%--                        <p></p>--%>
                <%--                        <p>毛巾</p>--%>
                <%--                    </a>--%>

                <%--                </div>--%>

                <%--                <div--%>
                <%--                        style="height: 50px; width: 100%; background-color: #eaeaea; margin-top: 15px;"--%>
                <%--                        class="btn-type" align="center;" id="type1004"--%>
                <%--                        onclick="typeButton(1004)">--%>
                <%--                    <p>--%>
                <%--                    <h4>办公</h4>--%>
                <%--                    </p>--%>
                <%--                </div>--%>

                <%--                <div class="col-md-12 r" id="1004"--%>
                <%--                     style="display: none; background-color: #f5f5f5; padding-left: 0px; padding-right: 0px;"--%>
                <%--                     align="center">--%>

                <%--                    <a class="col-md-12 r-type"--%>
                <%--                       href="javascript:void(0)">--%>
                <%--                        <p></p>--%>
                <%--                        <p>笔</p>--%>
                <%--                    </a>--%>

                <%--                    <a class="col-md-12 r-type"--%>
                <%--                       href="javascript:void(0)">--%>
                <%--                        <p></p>--%>
                <%--                        <p>书籍</p>--%>
                <%--                    </a>--%>

                <%--                    <a class="col-md-12 r-type"--%>
                <%--                       href="javascript:void(0)">--%>
                <%--                        <p></p>--%>
                <%--                        <p>电脑</p>--%>
                <%--                    </a>--%>

                <%--                </div>--%>

                <%--                <div--%>
                <%--                        style="height: 50px; width: 100%; background-color: #eaeaea; margin-top: 15px;"--%>
                <%--                        class="btn-type" align="center;" id="type1005"--%>
                <%--                        onclick="typeButton(1005)">--%>
                <%--                    <p>--%>
                <%--                    <h4>电子</h4>--%>
                <%--                    </p>--%>
                <%--                </div>--%>

                <%--                <div class="col-md-12 r" id="1005"--%>
                <%--                     style="display: none; background-color: #f5f5f5; padding-left: 0px; padding-right: 0px;"--%>
                <%--                     align="center">--%>

                <%--                    <a class="col-md-12 r-type"--%>
                <%--                       href="javascript:void(0)">--%>
                <%--                        <p></p>--%>
                <%--                        <p>手机</p>--%>
                <%--                    </a>--%>

                <%--                    <a class="col-md-12 r-type"--%>
                <%--                       href="javascript:void(0)">--%>
                <%--                        <p></p>--%>
                <%--                        <p>电脑</p>--%>
                <%--                    </a>--%>

                <%--                    <a class="col-md-12 r-type"--%>
                <%--                       href="javascript:void(0)">--%>
                <%--                        <p></p>--%>
                <%--                        <p>平板</p>--%>
                <%--                    </a>--%>

                <%--                    <a class="col-md-12 r-type"--%>
                <%--                       href="javascript:void(0)">--%>
                <%--                        <p></p>--%>
                <%--                        <p>手环</p>--%>
                <%--                    </a>--%>

                <%--                </div>--%>

                <%--                <div--%>
                <%--                        style="height: 50px; width: 100%; background-color: #eaeaea; margin-top: 15px;"--%>
                <%--                        class="btn-type" align="center;" id="type1006"--%>
                <%--                        onclick="typeButton(1006)">--%>
                <%--                    <p>--%>
                <%--                    <h4>测试</h4>--%>
                <%--                    </p>--%>
                <%--                </div>--%>

                <%--                <div class="col-md-12 r" id="1006"--%>
                <%--                     style="display: none; background-color: #f5f5f5; padding-left: 0px; padding-right: 0px;"--%>
                <%--                     align="center">--%>

                <%--                    <a class="col-md-12 r-type"--%>
                <%--                       href="javascript:void(0)">--%>
                <%--                        <p></p>--%>
                <%--                        <p>测试1</p>--%>
                <%--                    </a>--%>

                <%--                </div>--%>

            </div>
        </div>

        <div id="goodsList" class="col-md-10" style="margin-top: 10px; float: right;">
            <c:forEach items="${goods}" var="good">
                <a href="workbench/goods/toGoodsDetail.do?goodsId=${good.id}">
                    <div class="c col-md-3">
                        <div class="a col-md-12">
                            <img src="${good.photoUrl}" width="100%" height="200px">
                            <p style="height: 25px; margin-top: 20px">${good.name}</p>
                            <p style="color: red; text-align: right">
                                <B>价格：${good.prise}￥</B>
                            </p>
                        </div>
                    </div>
                </a>
            </c:forEach>


            <%--            <a  href="goods/goodInfo?goodId=23">--%>
            <%--                <div class="c col-md-3">--%>
            <%--                    <div class="a col-md-12">--%>
            <%--                        <img src="image/goods/23uABXbZdY9M.jpg" width="100%" height="200px">--%>
            <%--                        <p style="height: 25px; margin-top: 20px">皮鞋</p>--%>
            <%--                        <p style="color: red; text-align: right">--%>
            <%--                            <B>价格：50.0￥</B>--%>
            <%--                        </p>--%>
            <%--                    </div>--%>
            <%--                </div>--%>
            <%--            </a>--%>

            <%--            <a  href="goods/goodInfo?goodId=21">--%>
            <%--                <div class="c col-md-3">--%>
            <%--                    <div class="a col-md-12">--%>
            <%--                        <img src="image/goods/21hh7EAKXbhG.jpg" width="100%" height="200px">--%>
            <%--                        <p style="height: 25px; margin-top: 20px">牛仔裤</p>--%>
            <%--                        <p style="color: red; text-align: right">--%>
            <%--                            <B>价格：99.0￥</B>--%>
            <%--                        </p>--%>
            <%--                    </div>--%>
            <%--                </div>--%>
            <%--            </a>--%>

            <%--            <a  href="goods/goodInfo?goodId=20">--%>
            <%--                <div class="c col-md-3">--%>
            <%--                    <div class="a col-md-12">--%>
            <%--                        <img src="image/goods/20HYtR9EMGq6.jpg" width="100%" height="200px">--%>
            <%--                        <p style="height: 25px; margin-top: 20px">牛仔裤</p>--%>
            <%--                        <p style="color: red; text-align: right">--%>
            <%--                            <B>价格：89.0￥</B>--%>
            <%--                        </p>--%>
            <%--                    </div>--%>
            <%--                </div>--%>
            <%--            </a>--%>

            <%--            <a  href="goods/goodInfo?goodId=19">--%>
            <%--                <div class="c col-md-3">--%>
            <%--                    <div class="a col-md-12">--%>
            <%--                        <img src="image/goods/19at1bh3Mizc.jpg" width="100%" height="200px">--%>
            <%--                        <p style="height: 25px; margin-top: 20px">休闲裤</p>--%>
            <%--                        <p style="color: red; text-align: right">--%>
            <%--                            <B>价格：45.0￥</B>--%>
            <%--                        </p>--%>
            <%--                    </div>--%>
            <%--                </div>--%>
            <%--            </a>--%>

            <%--            <a  href="goods/goodInfo?goodId=18">--%>
            <%--                <div class="c col-md-3">--%>
            <%--                    <div class="a col-md-12">--%>
            <%--                        <img src="image/goods/18fRDAAt7ihr.jpg" width="100%" height="200px">--%>
            <%--                        <p style="height: 25px; margin-top: 20px">毛裤</p>--%>
            <%--                        <p style="color: red; text-align: right">--%>
            <%--                            <B>价格：68.0￥</B>--%>
            <%--                        </p>--%>
            <%--                    </div>--%>
            <%--                </div>--%>
            <%--            </a>--%>

            <%--            <a  href="goods/goodInfo?goodId=17">--%>
            <%--                <div class="c col-md-3">--%>
            <%--                    <div class="a col-md-12">--%>
            <%--                        <img src="image/goods/172suYjx9SMQ.jpg" width="100%" height="200px">--%>
            <%--                        <p style="height: 25px; margin-top: 20px">毛衣</p>--%>
            <%--                        <p style="color: red; text-align: right">--%>
            <%--                            <B>价格：410.0￥</B>--%>
            <%--                        </p>--%>
            <%--                    </div>--%>
            <%--                </div>--%>
            <%--            </a>--%>

            <%--            <a  href="goods/goodInfo?goodId=16">--%>
            <%--                <div class="c col-md-3">--%>
            <%--                    <div class="a col-md-12">--%>
            <%--                        <img src="image/goods/16JdQuvqvCMR.jpg" width="100%" height="200px">--%>
            <%--                        <p style="height: 25px; margin-top: 20px">秋衣</p>--%>
            <%--                        <p style="color: red; text-align: right">--%>
            <%--                            <B>价格：201.0￥</B>--%>
            <%--                        </p>--%>
            <%--                    </div>--%>
            <%--                </div>--%>
            <%--            </a>--%>

            <%--            <a  href="goods/goodInfo?goodId=15">--%>
            <%--                <div class="c col-md-3">--%>
            <%--                    <div class="a col-md-12">--%>
            <%--                        <img src="image/goods/15aNfKBYpv5j.jpg" width="100%" height="200px">--%>
            <%--                        <p style="height: 25px; margin-top: 20px">春天的衣服</p>--%>
            <%--                        <p style="color: red; text-align: right">--%>
            <%--                            <B>价格：500.0￥</B>--%>
            <%--                        </p>--%>
            <%--                    </div>--%>
            <%--                </div>--%>
            <%--            </a>--%>

            <%--            <a  href="goods/goodInfo?goodId=14">--%>
            <%--                <div class="c col-md-3">--%>
            <%--                    <div class="a col-md-12">--%>
            <%--                        <img src="image/goods/14TlVbutO2l4.jpg" width="100%" height="200px">--%>
            <%--                        <p style="height: 25px; margin-top: 20px">秋天的衣服</p>--%>
            <%--                        <p style="color: red; text-align: right">--%>
            <%--                            <B>价格：80.0￥</B>--%>
            <%--                        </p>--%>
            <%--                    </div>--%>
            <%--                </div>--%>
            <%--            </a>--%>

            <%--            <a  href="goods/goodInfo?goodId=13">--%>
            <%--                <div class="c col-md-3">--%>
            <%--                    <div class="a col-md-12">--%>
            <%--                        <img src="image/goods/131xUYtIeZuj.jpg" width="100%" height="200px">--%>
            <%--                        <p style="height: 25px; margin-top: 20px">夏天的衣服</p>--%>
            <%--                        <p style="color: red; text-align: right">--%>
            <%--                            <B>价格：100.0￥</B>--%>
            <%--                        </p>--%>
            <%--                    </div>--%>
            <%--                </div>--%>
            <%--            </a>--%>

            <%--            <a  href="goods/goodInfo?goodId=12">--%>
            <%--                <div class="c col-md-3">--%>
            <%--                    <div class="a col-md-12">--%>
            <%--                        <img src="image/goods/12fLdnB5THKf.jpg" width="100%" height="200px">--%>
            <%--                        <p style="height: 25px; margin-top: 20px">板鞋</p>--%>
            <%--                        <p style="color: red; text-align: right">--%>
            <%--                            <B>价格：310.0￥</B>--%>
            <%--                        </p>--%>
            <%--                    </div>--%>
            <%--                </div>--%>
            <%--            </a>--%>

            <%--            <a  href="goods/goodInfo?goodId=11">--%>
            <%--                <div class="c col-md-3">--%>
            <%--                    <div class="a col-md-12">--%>
            <%--                        <img src="image/goods/117YEj4a8RtX.jpg" width="100%" height="200px">--%>
            <%--                        <p style="height: 25px; margin-top: 20px">女士鞋</p>--%>
            <%--                        <p style="color: red; text-align: right">--%>
            <%--                            <B>价格：200.0￥</B>--%>
            <%--                        </p>--%>
            <%--                    </div>--%>
            <%--                </div>--%>
            <%--            </a>--%>

            <%--            <a  href="goods/goodInfo?goodId=10">--%>
            <%--                <div class="c col-md-3">--%>
            <%--                    <div class="a col-md-12">--%>
            <%--                        <img src="image/goods/10KfmXgKm41b.jpg" width="100%" height="200px">--%>
            <%--                        <p style="height: 25px; margin-top: 20px">电热水壶</p>--%>
            <%--                        <p style="color: red; text-align: right">--%>
            <%--                            <B>价格：40.0￥</B>--%>
            <%--                        </p>--%>
            <%--                    </div>--%>
            <%--                </div>--%>
            <%--            </a>--%>

            <%--            <a  href="goods/goodInfo?goodId=7">--%>
            <%--                <div class="c col-md-3">--%>
            <%--                    <div class="a col-md-12">--%>
            <%--                        <img src="image/goods/7hcJYNCaPru.jpg" width="100%" height="200px">--%>
            <%--                        <p style="height: 25px; margin-top: 20px">电风扇</p>--%>
            <%--                        <p style="color: red; text-align: right">--%>
            <%--                            <B>价格：100.0￥</B>--%>
            <%--                        </p>--%>
            <%--                    </div>--%>
            <%--                </div>--%>
            <%--            </a>--%>

            <%--            <a  href="goods/goodInfo?goodId=4">--%>
            <%--                <div class="c col-md-3">--%>
            <%--                    <div class="a col-md-12">--%>
            <%--                        <img src="image/goods/caidao.jpg" width="100%" height="200px">--%>
            <%--                        <p style="height: 25px; margin-top: 20px">菜刀</p>--%>
            <%--                        <p style="color: red; text-align: right">--%>
            <%--                            <B>价格：5.0￥</B>--%>
            <%--                        </p>--%>
            <%--                    </div>--%>
            <%--                </div>--%>
            <%--            </a>--%>

            <%--            <a  href="goods/goodInfo?goodId=3">--%>
            <%--                <div class="c col-md-3">--%>
            <%--                    <div class="a col-md-12">--%>
            <%--                        <img src="image/goods/guochan.jpg" width="100%" height="200px">--%>
            <%--                        <p style="height: 25px; margin-top: 20px">锅铲</p>--%>
            <%--                        <p style="color: red; text-align: right">--%>
            <%--                            <B>价格：10.0￥</B>--%>
            <%--                        </p>--%>
            <%--                    </div>--%>
            <%--                </div>--%>
            <%--            </a>--%>

            <%--            <a  href="goods/goodInfo?goodId=1">--%>
            <%--                <div class="c col-md-3">--%>
            <%--                    <div class="a col-md-12">--%>
            <%--                        <img src="image/goods/1u11JdttpRc.jpg" width="100%" height="200px">--%>
            <%--                        <p style="height: 25px; margin-top: 20px">电磁炉</p>--%>
            <%--                        <p style="color: red; text-align: right">--%>
            <%--                            <B>价格：50.0￥</B>--%>
            <%--                        </p>--%>
            <%--                    </div>--%>
            <%--                </div>--%>
            <%--            </a>--%>
        </div>
        <!--创建容器-->
        <div id="demo_pag1"  style="width: 100%;height: 10px"></div>
    </div>

</div>


<script>
    function typeButton(firstTypeId) {
        var firstType = "#" + firstTypeId;
        var firstType1 = "#type" + firstTypeId;
        if (document.getElementById(firstTypeId).style.display === "none") {
            $(".btn-type").slideUp();
            $(firstType1).slideDown();
            $(firstType).slideDown();
        } else {
            $(".btn-type").slideDown();
            $(firstType).slideUp();
        }
    }
</script>
</body>
</html>