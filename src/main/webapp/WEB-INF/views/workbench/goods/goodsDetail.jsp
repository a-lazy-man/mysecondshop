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
    <title>${good.name}</title>
    <link rel="stylesheet"
          href="css/bootstrap.min.css" type="text/css">
    <link rel="stylesheet"
          href="jquery-ui-1.12.1/jquery-ui.css" type="text/css">
    <link rel="stylesheet"
          href="jquery-ui-1.12.1/jquery-ui.theme.css">
    <link rel="stylesheet" href="css/style.css" type="text/css">
    <link rel="stylesheet"
          href="css/swiper.min.css">
    <link rmel="stylesheet"
          href="css/simpleAlert.css">
    <script src="js/jquery-1.12.4.js" type="text/javascript"></script>
    <script src="js/simpleAlert.js"></script>
    <script src="js/swiper.min.js"></script>
    <script src="js/bootstrap.js" type="text/javascript"></script>
    <script src="jquery-ui-1.12.1/jquery-ui.js" type="text/javascript"></script>
    <script
            src="jquery-ui-1.12.1/datepicker-zh-CN.js" type="text/javascript"></script>
    <script type="text/javascript">
        $(function () {
            $(".swiper-slide img").mouseover(function () {
                var url = $(this).attr("src");
                $("#img-a").attr("src", url);
            })
            //给退出按钮绑定一个单击事件
            $("#loginOut").click(function () {
                //给退出按钮绑定一个单击事件
                if (window.confirm("您确定退出登录吗？")) {
                    window.location.href = "workbench/loginOut.do";
                }
            })
            //给收藏按钮绑定一个单击事件
            $("#collectGood").click(function () {
                var goodsId = "${good.id}";
                $.ajax({
                    url: 'workbench/goods/CollectedGoods',
                    dataType: 'json',
                    data: {
                        goodsId: goodsId
                    },
                    success: function (data) {
                        if (data.code == "1") {
                            alert("收藏成功！！！");
                            //将"收藏替换为已收藏"
                            $("#alreadyCollect").attr("style", "color: #c4c4c4; font-size: 18px;margin-top: 3px; float: right");
                            $("#collectGood").attr("style", "display: none");
                        } else {
                            alert(data.message);
                        }
                    }
                })
            })
            //给留言发表按钮绑定一个单击事件
            $("#submitMessage").click(function () {
                //获取当前商品的id
                var goodId = $("#goodId").val();
                alert("当前商品的id" + goodId);
                //获取当前留言用户的id
                var fromUserId = $("#fromUserId").val();
                alert("当前发布留言的用户id" + fromUserId);
                //获取当前留言用户的名字
                var fromUserName = $("#fromUserName").val();
                alert("当前发布留言的用户name" + fromUserName);
                //获取留言内容
                var content = $("#content").val();
                alert("当前发布的留言的内容" + content);
                //数据校验
                if ($.trim(content).length == 0) {
                    alert("发表的内容不能为空！！！");
                    return;
                }
                $.ajax({
                    url: 'workbench/goods/publishMessage.do',
                    dataType: 'json',
                    data: {
                        goodId: goodId,
                        fromUserId: fromUserId,
                        fromUserName: fromUserName,
                        content: content
                    },
                    success: function (map) {
                        if (map.returnMessage.code == "1") {
                            var message = map.justMessage;
                            var fromUserName = message.fromUserName;
                            if ("${sessionScope.sessionUser.id}" == message.fromUserId) {
                                fromUserName = "你"
                            }
                            alert("发表成功！！！");
                            //清除掉 "留言版为空的组件"
                            $("#showMessage").remove();
                            //局部刷新页面
                            $("#messageDiv").prepend(" <div class=\"col-md-12 r\"\n" +
                                "                         style=\"background-color: #ffffff; margin-bottom: 15px\">\n" +
                                "                        <p></p>\n" +
                                "                        <P style=\"color: #c4c4c4\">时间：" + message.uploadDate + "</P>\n" +
                                "                        <p messageId=" + message.id + " class=" + message.goodId + ">" +
                                "                            <B style=\"color: #2aabd2\">" + fromUserName + "</B>&nbsp;评论:&nbsp;" + message.content + "\n" +
                                "                        </p>" +
                                "                        <div id=" + message.id + " class=\"col-md-12\"\n" +
                                "                             style=\"margin-bottom: 15px;\">\n" +
                                "                            <form action=\"\" method=\"post\">\n" +
                                "                                <div class=\"col-sm-10\">\n" +
                                "                                    <input id=" + message.id + 'goodId' + " name=\"goodId\" type=\"text\"\n" +
                                "                                           value=" + message.goodId + " style=\"display: none\">" +
                                "                                    <input id=" + message.id + 'fromUserId' + " name=\"fromUserId\" type=\"text\"\n" +
                                "                                        value=" + message.fromUserId + " style=\"display: none\">" +
                                "                                    <input id=" + message.id + 'fromUserName' + " name=\"fromUserName\" type=\"text\"\n" +
                                "                                        value=" + message.fromUserName + " style=\"display: none\">\n" +
                                "                                    <input id=" + message.id + 'remarkUserId' + " name=\"remarkUserId\" type=\"text\"\n" +
                                "                                           value=\"${sessionScope.sessionUser.id}\" style=\"display: none\">\n" +
                                "                                    <input id=" + message.id + 'remarkUserName' + " name=\"remarkUserName\" type=\"text\"\n" +
                                "                                           value=\"${sessionScope.sessionUser.userName}\" style=\"display: none\">" +
                                "                                    <input id=" + message.id + 'remarkContent' + " name=\"remarkContent\" type=\"text\"\n" +
                                "                                        class=\"form-control\" style=\"display: none\" placeholder=\"回复" + message.fromUserName + "\">\n" +
                                "                                </div>\n" +
                                "                                <button id=" + message.id + 'replyBtn' + " type=\"button\" class=\"btn btn-success; col-sm-1\" style=\"display: none\">回复</button>\n" +
                                "                                <p id=" + message.id + 'p' + " messageId=" + message.id + " name=" + message.goodId + 'Name' + " class=\"btn btn-success; col-sm-1\"\n" +
                                "                                   style=\"display: none\">X</p>\n" +
                                "                            </form>\n" +
                                "                        </div> <!--回复功能-->\n" +
                                "                    </div>");
                            //将留言输入框的内容请除掉
                            $("#content").val("");
                        } else {
                            alert(data.message);
                        }
                    }
                })
            })
            //页面加载之后给所有的留言的p标签绑定单击事件
            $("#messageDiv").on("click", ".${good.id}", function () {
                //获取当前 留言的id
                var messageId = $(this).attr("messageId");
                //获取当前留言的发布者的名称
                var fromUserName = $(this).attr("fromUserName");
                //获取被点击的文本框的回复的文本框的jquery对象 messageId+remarkContent
                var selectorName = "#" + messageId + 'remarkContent';
                //让回复框可见
                $(selectorName).attr("style", '');
                $(selectorName).attr("placeholder", "回复" + fromUserName + "");
                //让回复按钮可见
                var repleyName = "#" + messageId + 'replyBtn';
                $(repleyName).attr("style", '')
                //让xxx 按钮可见
                var cancleReplyName = "#" + messageId + 'p';
                $(cancleReplyName).attr("style", '');
            });
            //给所有的xxx标签绑定单击事件
            $("#messageDiv").on("click", 'p[name="${good.id}Name"]', function () {
                var messageId = $(this).attr("messageId");
                var selectorName = "#" + messageId + 'remarkContent';
                var repleyName = "#" + messageId + 'replyBtn';
                var cancleReplyName = "#" + messageId + 'p';
                //让回复框不显示
                $(selectorName).attr("style", "display: none");
                //让回复按钮不显示
                $(repleyName).attr("style", "display: none");
                //让xxx按钮不可见
                $(cancleReplyName).attr("style", "display: none");
            })
            //给所有的回复的文本p绑定单击事件
            $("#messageDiv").on("click", 'p[name="${good.id}remark"]', function () {
                //获取当前回复内容的留言的id
                var messageId = $(this).attr("messageId");
                alert("当前留言的id=" + messageId);
                //获取这个回复内容的发表用户的名字
                var remarkUserName = $(this).attr("toUserName");
                alert("当前回复内容的发表者的名字=" + remarkUserName);
                //获取这个发表这个回复的用户的id
                var remarkUserId = $(this).attr("toUserId");
                alert("当前回复内容的发表者的id=" + remarkUserId);
                var replyName = "#" + messageId + 'replyBtn';
                var selectorName = "#" + messageId + 'remarkContent';
                alert("回复的文本内容框的id选择器=" + selectorName);
                var cancleReplyName = "#" + messageId + 'p';
                //修改回复文本框的内容
                $(selectorName).attr("placeholder", "回复" + remarkUserName + "");
                //给回复文本框的属性设置值
                $(selectorName).attr("toUserName", remarkUserName);
                $(selectorName).attr("toUserId", remarkUserId);
                //让回复按钮可见
                $(replyName).attr("style", "");
                //让回复文本框可见
                $(selectorName).attr("style", "");
                //让取消按钮可见
                $(cancleReplyName).attr("style", "");
                alert("内容被点击之后，回复文本框的toUserId属性=" + $(selectorName).attr("toUserId"));
                alert("内容被点击之后，回复文本框的toUserId属性=" + $(selectorName).attr("toUserName"));
            })
            //给每个留言的回复按钮绑定一个单击事件
            $('button[name="${good.id}Btn"]').click(function () {
                //获取当前留言的id
                var messageId = $(this).attr("messageId");
                alert("当前留言的id=" + messageId);
                var selectorName = "#" + messageId + 'remarkContent';
                alert("当前回复框的选择器名称：" + selectorName);
                var replyName = "#" + messageId + 'replyBtn';
                var cancleReplyName = "#" + messageId + 'p';
                //获取将要被回复的用户的id
                var toUserId = $(selectorName).attr("toUserId");
                alert("被评论的用户的id=" + toUserId);
                //获取将要被回复的用户姓名
                var toUserName = $(selectorName).attr("toUserName");
                alert("被评论的用户的名字=" + toUserName);
                //获取评论者的id
                var remarkUserId = "${sessionScope.sessionUser.id}";
                alert("当前品论的用户的id=" + remarkUserId);
                //获取评论者的name
                var remarkUserName = "${sessionScope.sessionUser.userName}";
                alert("当前品论的用户的名称=" + remarkUserName);
                //获取评论的内容
                var remarkContent = $(selectorName).val();
                alert("品论的内容" + remarkContent);
                //发送ajax异步请求
                $.ajax({
                    url: 'workbench/goods/replyToMessage.do',
                    dataType: 'json',
                    data: {
                        remarkUserId: remarkUserId,
                        remarkUserName: remarkUserName,
                        toUserId: toUserId,
                        toUserName: toUserName,
                        remarkContent: remarkContent,
                        messageId: messageId
                    },
                    success: function (map) {
                        if (map.res.code == 1) {
                            alert("您恢复成功！！！");
                            var remark = map.justRemark;
                            //将这条回复添加在该留言的下边最上面
                            //刷新页面
                            //获取该回复的留言的id
                            var messageId = remark.messageId;
                            var messageDivName = "#" + messageId + "Message";
                            //评论的发布者
                            var remarkUserName = remark.remarkUserName;
                            //被评论者
                            var toUserName = remark.toUserName;
                            if (remark.remarkUserId == "${sessionScope.sessionUser.id}") {
                                remarkUserName = "你";
                            }
                            if (remark.toUserId == "${sessionScope.sessionUser.id}") {
                                toUserName = "你";
                            }
                            $(messageDivName).children().eq(2).after("<div class=\"col-md-10\" style=\"margin-left: 50px\">\n" +
                                "\n" +
                                "                                        <P style=\"color: #c4c4c4\">时间：" + remark.uploadDate + "</P>\n" +
                                "                                        <p messageId=\"" + messageId + "\" toUserId=\"" + remarkUserId + "\" toUserName=\"" + remark.remarkUserName + "\"  remarkId=\"" + remark.id + "\" name=\"${good.id}remark\"><!--onclick=\"replyFun(6,'王二')\"-->\n" +
                                "                                            <B style=\" color: #2aabd2\">" + remarkUserName + "</B>&nbsp;回复&nbsp;<B\n" +
                                "                                                style=\"color: #2aabd2\">" + toUserName + "</B>:&nbsp;" + remark.remarkContent + "\n" +
                                "                                        </p>\n" +
                                "\n" +
                                "                                    </div>")
                            //清除掉回复文本框中的内容 并隐藏掉
                            $(selectorName).val("");
                            $(selectorName).attr("style", "display: none");
                            //让"回复"按钮和xx按钮也隐藏
                            $(replyName).attr("style", "display:none");
                            $(cancleReplyName).attr("style", "display:none");
                        } else {
                            alert(map.res.message);
                        }
                    }
                })
            })
            //给联系卖家按钮绑定一个单击事件
            $("#${good.id}div").click(function () {
                var goodsId = "${good.id}";
                $.ajax({
                    url: 'workbench/goods/querySellerDetailMes.do',
                    dataType: 'json',
                    data: {
                        goodsId: goodsId
                    },
                    success: function (seller) {
                        alert("商家姓名： " + seller.userName + "  商家电话:  " + seller.userPhone);
                    }
                })
            })
            //给购买按钮绑定一个单击事件
           $("#goumai").click(function(){
               alert("按钮被单击了！！！");
               var goodsId = "${good.id}";
               var goodsName = "${good.name}";
               var sellerId = "${good.userId}";
               var money = "${good.prise}";
               if(window.confirm("您确定要购买吗?")){
                   alert("正在创建订单中.........");
                   $.ajax({
                       url: 'workbench/goods/purchase.do',
                       dataType: 'json',
                       type: 'post',
                       data:{
                           goodsId:goodsId,
                           goodsName:goodsName,
                           sellerId:sellerId,
                           money:money
                       },
                       success: function(map){
                           if(map.res.code == 1){
                               alert("订单创建成功！！！");
                               var goodsOrderId = map.goodsOrder.id

                               //跳转到订单详情页面
                               window.location.href="workbench/pay/toOrderDetailPage.do?goodsOrderId="+goodsOrderId;
                           }else{
                               alert(res.message);
                           }
                       }
                   })
               }
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
                        href="settings/qx/user/toUserDetailMes">${sessionScope.sessionUser.userName}</a></li>
                <li><a id="loginOut" href="javascript:void(0)">退出</a></li>


            </ul>
        </div>
    </div>
</nav>
<div class="col-md-12" style="height: 70px"></div>

<div class="container">
    <div class="col-md-9">
        <div class="col-md-12 r1"
             style="background-color: #e4e4e4; height: 40px">
            <div class="col-md-8" style="margin-top: 5px">
                <B style="color: #c4c4c4; font-size: 20px">物品信息</B>
            </div>

            <div class="col-md-4"
                 style="margin-top: 4px; display: ${good.userId == sessionScope.sessionUser.id ? 'none' : ''};">
                <B id="alreadyCollect"
                   style="display: ${isCollect == 1 ? '': 'none'}; color: #c4c4c4; font-size: 18px;margin-top: 3px; float: right">已收藏</B>
                <a id="collectGood" class="btn"
                   style="display:  ${isCollect == 1 ? 'none': ''}; float: right; margin-top: 0px; padding: 2px">
                    <B style="color: #c4c4c4; font-size: 18px;">收藏</B>
                </a>
            </div>
        </div>

        <div class="col-md-12 r2"
             style="background-color: #f9f9f9; padding: 0px; padding-bottom: 15px">
            <div class="col-md-12" style="margin-top: 40px;">
                <div class="col-md-7" align="center;">
                    <div style="width: 100%" align="center">
                        <img src="${good.photoUrl}" width="100%" height="300px"
                             id="img-a">
                    </div>

                    <div class="col-md-12"
                         style="padding-left: 0px; padding-right: 0px; margin-top: 10px">
                        <div class="swiper-container">
                            <div class="swiper-wrapper">
                                <div class="swiper-slide">
                                    <img src="${good.photoUrl}" height="200px"
                                         width="85%">
                                </div>
                                <c:forEach items="${images}" var="image">
                                    <div class="swiper-slide">
                                        <img src="${image.url}" height="200px"
                                             width="85%">
                                    </div>
                                </c:forEach>


                            </div>
                            <div class="swiper-button-next"></div>
                            <div class="swiper-button-prev"></div>
                            <div class="swiper-pagination"></div>
                        </div>
                    </div>
                </div>

                <div class="col-md-5">
                    <h3 style="margin-left: 15px">
                        <B>${good.name}</B>
                    </h3>
                    <div style="height: 50px"></div>
                    <div class="col-md-4" style="padding: 0px">
                        <p style="color: #666666; height: 40px">
                            <B>价格</B>
                        </p>
                        <p style="color: #666666; height: 40px">
                            <B>卖家</B>
                        </p>
                        <p style="color: #666666; height: 40px">
                            <B>物品类型</B>
                        </p>
                        <p style="color: #666666; height: 40px">
                            <B>发布时间</B>
                        </p>
                    </div>

                    <div class="col-md-8" style="padding: 0px">
                        <p style="color: red; height: 40px; font-size: 20px">${good.prise}</p>
                        <p style="color: #808080; height: 40px">${good.userName}</p>
                        <p style="color: #808080; height: 40px">${good.secondTypeName}</p>
                        <p style="color: #808080; height: 40px">${good.uploadDate}</p>
                    </div>

                    <div class="col-md-12" style="padding: 0px">
                        <c:if test="${good.userId != sessionScope.sessionUser.id}">
                            <div id="${good.id}div" class="col-md-5 r-c"
                                 style="">
                                <B style="font-size: 20px; color: #e2e2e2">联系卖家</B>
                            </div>


                            <div id="goumai" class="col-md-5 r-b pull-right"
                                 style="">
                                <B style="font-size: 20px; color: #e2e2e2">购买</B>
                            </div>
                        </c:if>
                        <c:if test="${good.userId == sessionScope.sessionUser.id}">
                            <a

                                    href="workbench/goods/toGoodsEditPage.do?goodsId=${good.id}">
                                <div class="col-md-5 r-b">
                                    <B style="font-size: 20px; color: #e2e2e2">编辑</B>
                                </div>
                            </a>
                        </c:if>


                    </div>

                    <div class="col-md-12" style="margin-top: 50px" align="right">
                        <p>
                            <a
                                    href="settings/qx/user/toSellerDetailMes.do?userId=${good.userId}">查看卖家其他物品</a>
                        </p>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-md-12 r1"
             style="background-color: #e4e4e4; height: 40px; margin-top: 20px;">
            <div class="col-md-6" style="margin-top: 5px">
                <B style="color: #c4c4c4; font-size: 20px">物品描述</B>
            </div>
        </div>

        <div class="col-md-12 r2"
             style="background-color: #f9f9f9; height: 150px">
            <div class="col-md-12" style="margin-top: 20px">
                <p style="color: #b0b0b0;">${good.describe};</p>
            </div>
        </div>

        <div class="col-md-12 r1"
             style="background-color: #e4e4e4; height: 40px; margin-top: 20px;">
            <div class="col-md-6" style="margin-top: 5px">
                <B style="color: #c4c4c4; font-size: 20px">物品留言</B>
            </div>
        </div>

        <div id="messageDiv" class="col-md-12 r2"
             style="padding-top: 15px; background-color: #f9f9f9;">

            <c:if test="${messages == null}"> <!--如果没有留言就显示下面内容-->
                <div id="showMessage" class="col-md-12 r"
                     style="background-color: #ffffff; margin-top: 15px; margin-bottom: 15px">
                    <p></p>
                    <p style="color: #c4c4c4; font-size: 20px" align="center">留言板为空，赶快发表你的留言！</p>
                </div>
            </c:if>

            <c:if test="${messages != null}">
                <c:forEach items="${messages}" var="message">
                    <div id="${message.id}Message" class="col-md-12 r"
                         style="background-color: #ffffff; margin-bottom: 15px">
                        <p></p>
                        <P style="color: #c4c4c4">时间：${message.uploadDate}</P>
                        <p messageId="${message.id}" class="${message.goodId}" fromUserName="${message.fromUserName}">
                            <B style="color: #2aabd2">${message.fromUserName}</B>&nbsp;评论:&nbsp;${message.content}
                        </p>

                        <c:if test="${remarks != null}">
                            <c:forEach items="${remarks}" var="remark">
                                <!--如果当前留言的id 与 remark的messageId一致 说明当前回复是属于该留言的-->
                                <c:if test="${remark.messageId == message.id}">
                                    <div class="col-md-10" style="margin-left: 50px">

                                        <P style="color: #c4c4c4">时间：${remark.uploadDate}</P>
                                        <p messageId="${message.id}" toUserId="${remark.remarkUserId}"
                                           toUserName="${remark.remarkUserName}" remarkId="${remark.id}"
                                           name="${message.goodId}remark"><!--onclick="replyFun(6,'王二')"-->
                                            <B style=" color: #2aabd2">${sessionScope.sessionUser.id==remark.remarkUserId ? '你' : remark.remarkUserName}</B>&nbsp;回复&nbsp;<B
                                                    style="color: #2aabd2">${sessionScope.sessionUser.id==remark.toUserId ? '你' : remark.toUserName}</B>:&nbsp;${remark.remarkContent}
                                        </p>

                                    </div>
                                </c:if>
                            </c:forEach>

                        </c:if>

                        <div id="6" class="col-md-12"
                             style="margin-bottom: 15px;">
                            <form action="/secondshop/goods/goodInfo" method="post">
                                <div class="col-sm-10">
                                    <input id="${message.id}goodId" name="goodId" type="text"
                                           value="${message.goodId}" style="display: none">
                                    <input
                                            id="${message.id}fromUserId" name="fromUserId" type="text"
                                            value="${message.fromUserId}" style="display: none">
                                    <input
                                            id="${message.id}fromUserName" name="fromUserName" type="text"
                                            value="${message.fromUserName}" style="display: none">
                                    <input id="${message.id}remarkUserId" name="remarkUserId" type="text"
                                           value="${sessionScope.sessionUser.id}" style="display: none">
                                    <input id="${message.id}remarkUserName" name="remarkUserName" type="text"
                                           value="${sessionScope.sessionUser.userName}" style="display: none">
                                    <input toUserName="${message.fromUserName}" toUserId="${message.fromUserId}"
                                           id="${message.id}remarkContent" name="remarkContent" style="display: none"
                                           type="text" class="form-control" placeholder="回复${message.fromUserName}">
                                </div>
                                <button messageId="${message.id}" name="${good.id}Btn" id="${message.id}replyBtn"
                                        type="button" class="btn btn-success; col-sm-1" style="display: none">回复
                                </button>
                                <p id="${message.id}p" messageId="${message.id}" name="${good.id}Name"
                                   class="btn btn-success; col-sm-1" style="display: none"
                                >X</p> <!--这是一个xx 用来关闭x回复的文本框-->
                            </form>
                        </div> <!--回复功能-->
                    </div>
                </c:forEach>
            </c:if>


            <form>
                <div class="col-md-12" style="margin-bottom: 15px">
                    <div class="col-sm-11">
                        <input id="goodId" name="goodId" type="text"
                               value="${good.id}" style="display: none"> <input
                            id="fromUserName" name="fromUserName" type="text"
                            value="${sessionScope.sessionUser.userName}" style="display: none">
                        <input id="fromUserId" name="fromUserId" type="text"
                               value="${sessionScope.sessionUser.id}" style="display: none">
                        <input
                                id="content" name="content" type="text"
                                class="form-control" placeholder="留言">
                    </div>


                    <button type="button" id="submitMessage" class="btn btn-success; col-sm-1">发表</button>

                </div>
            </form>


        </div>
    </div>

    <div class="col-md-3 r"
         style="background-color: #f9f9f9; padding-bottom: 15px;">
        <div class="col-md-12 r"
             style="text-align: center; margin-top: 10px; background-color: #e4e4e4; padding: 5px">
            <B style="font-size: 20px; color: #a2a2a2">相关推荐</B>
        </div>

        <div class="col-md-12"
             style="margin-top: 20px; padding-left: 0px; padding-right: 0px">


            <c:forEach items="${relatedGoods}" var="relatedGood">
                <a href="workbench/goods/toGoodsDetail.do?goodsId=${relatedGood.id}">
                    <div class="col-md-12 b"
                         style="padding-left: 0px; padding-right: 0px">
                        <div class="col-md-6"
                             style="padding-top: 15px; padding-bottom: 15px">
                            <img src="${relatedGood.photoUrl}" height="100px"
                                 ; width="100px">
                        </div>

                        <div class="col-md-6"
                             style="padding-top: 15px; padding-bottom: 15px; height: 130px">
                            <p style="height: 75px">${relatedGood.name}</p>
                            <p align="right" style="color: red">￥${relatedGood.prise}</p>
                        </div>
                    </div>
                </a>
            </c:forEach>


            <%--            <a  href="goodInfo?goodId=12">--%>
            <%--                <div class="col-md-12 b"--%>
            <%--                     style="padding-left: 0px; padding-right: 0px">--%>
            <%--                    <div class="col-md-6"--%>
            <%--                         style="padding-top: 15px; padding-bottom: 15px">--%>
            <%--                        <img src="/secondshop/statics/image/good/12fLdnB5THKf.png" height="100px"--%>
            <%--                             ; width="100px">--%>
            <%--                    </div>--%>

            <%--                    <div class="col-md-6"--%>
            <%--                         style="padding-top: 15px; padding-bottom: 15px; height: 130px">--%>
            <%--                        <p style="height: 75px">板鞋</p>--%>
            <%--                        <p align="right" style="color: red">￥310.0</p>--%>
            <%--                    </div>--%>
            <%--                </div>--%>
            <%--            </a>--%>

            <%--            <a  href="goodInfo?goodId=11">--%>
            <%--                <div class="col-md-12 b"--%>
            <%--                     style="padding-left: 0px; padding-right: 0px">--%>
            <%--                    <div class="col-md-6"--%>
            <%--                         style="padding-top: 15px; padding-bottom: 15px">--%>
            <%--                        <img src="/secondshop/statics/image/good/117YEj4a8RtX.png" height="100px"--%>
            <%--                             ; width="100px">--%>
            <%--                    </div>--%>

            <%--                    <div class="col-md-6"--%>
            <%--                         style="padding-top: 15px; padding-bottom: 15px; height: 130px">--%>
            <%--                        <p style="height: 75px">女士鞋</p>--%>
            <%--                        <p align="right" style="color: red">￥200.0</p>--%>
            <%--                    </div>--%>
            <%--                </div>--%>
            <%--            </a>--%>

        </div>
    </div>
</div>


<script>
    var swiper = new Swiper('.swiper-container', {
        slidesPerView: 3,
        spaceBetween: 30,
        slidesPerGroup: 3,
        loop: true,
        loopFillGroupWithBlank: true,
        pagination: {
            el: '.swiper-pagination',
            clickable: true
        },
        navigation: {
            nextEl: '.swiper-button-next',
            prevEl: '.swiper-button-prev'
        }
    });
</script>

<script>
    function collect() {
        var collect = {
            "goodId": "23",
            "goodName": "皮鞋",
            "userId": "2"
        };
        $.ajax({
            type: "POST",
            url: "/secondshop/collect/insert",
            contentType: "application/json", //必须这样写
            dataType: "json",
            data: JSON.stringify(collect),//要提交是json字符串
            success: function (data) {
                if (data === false) {
                    alert("由于未知原因，收藏失败！");
                } else {
                    alert("收藏成功！");
                    $(window).attr('location', '/secondshop/good/goodInfo?goodId=23');
                }
            }
        })
    }

    function replyFun(replyId, replyToUser) {
        if (true) {
            var replyDiv = document.getElementById(replyId);
            var toUser = "回复 " + replyToUser;
            var replyToUserId = "#" + replyId + "replyToUser";
            var replyText = "#" + replyId + "replyText";
            if (replyDiv.style.display === "none") {
                replyDiv.style.display = "";
            }
            $(replyToUserId).attr("value", replyToUser);
            $(replyText).attr("placeholder", toUser);
            console.log("value:" + $(replyToUserId).attr("value"));
            console.log("placeholder:" + $(replyText).attr("placeholder"));
        }
    }

    function closeReplyDiv(replyDiv) {
        document.getElementById(replyDiv).style.display = "none";
    }

    $(function () {
            var message = "";
            if (message !== "" && message !== null) {
                alert(message);
            }
        }
    );

    function connect() {
        alert("卖家联系方式：\n手机号：15545124512\n邮箱：15545124512@qq.com\n请选择自己方便的联系方式与卖家沟通！");
    }
</script>

<script>
    function buyButton() {
        var dblChoseAlert = simpleAlert({
            "content": "您即将购买该物品!",
            "buttons": {
                "确定": function () {
                    dblChoseAlert.close();
                    getBuy();
                },
                "取消": function () {
                    dblChoseAlert.close();
                }
            }
        })
    }

    function getBuy() {
        alert("我们正在为您创建订单！");
        var order = {
            "goodName": "皮鞋",
            "seller": "王二",
            "sellerId": 4,
            "customer": "张三",
            "customerId": "2",
            "goodId": 23,
            "money": 50.0
        };
        console.log(order);
        $.ajax({
            type: "POST",
            url: "/secondshop/user/order/create",
            contentType: "application/json", //必须这样写
            dataType: "json",
            data: JSON.stringify(order),//要提交是json字符串
            success: function (data) {
                if (data === false) {
                    alert("由于未知原因，订单创建失败！");
                } else {
                    alert("订单创建成功，请及时与卖家联系，线下验货交易！");
                    $(window).attr('location', '/secondshop/user/orderInfo?orderId=' + data);
                }
            }
        });
    }
</script>
</body>
</html>