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
    <title>物品发布</title>
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
        $(function () {
            //给一级分类下拉框绑定状态变化事件 一旦一级类型下拉框状态发生变化了，就刷新二级类型下拉框
            $("#firstTypeId").on('change', function () {
                var firstTypeId = this.value;
                alert("当前的一级类型是" + firstTypeId);
                $.ajax({
                    url: 'workbench/goods/showSecondType.do',
                    dataType: 'json',
                    data: {
                        firstTypeId: firstTypeId
                    },
                    success: function (secondTypes) {
                        //先清空原来二级下拉框中的所有数据
                        $("#secondTypeId option").remove();
                        //遍历secondTypes 刷新二级类型表单
                        $.each(secondTypes, function (index, secondType) {
                            $("#secondTypeId").append("<option value='" + secondType.id + "'>" + secondType.name + "</option>")
                        })
                    }
                })
            })
            //给物品标题绑定一个失去焦点事件
            $("#name").focus(function () {
                //清空错误信息
                $("#nameError").val("");
            })
            //给价格绑定一个失去焦点事件
            $("#prise").focus(function () {
                //清空错误信息内容
                $("#priseError").val("");
            })
            //给物品数量绑定一个失去焦点事件
            $("#goodsNum").focus(function () {
                //清空错误信息
                $("#goodsNumError").val("");
            })
            //给获取物品id绑定一个单击事件
            $("#getUserId").click(function () {
                //获取商品名称
                var name = $("#name").val();
                //获取商品的一级分类的类型
                var firstType = $("#firstTypeId option:selected").val();
                //获取商品的二级分类的类型
                var secondType = $("#secondTypeId option:selected").val();
                //获取物品的价格
                var prise = $("#prise").val();
                //获取物品的数量
                var goodsNum = $("#goodsNum").val();
                //获取物品的描述
                var describe = $("#describe").val();
                //做数据校验
                if ($.trim(name).length == 0) {
                    document.getElementById("nameError").innerHTML = "物品标题不能为空！！！";
                    return;
                }
                var reg = /(^[1-9]\d*(\.\d{1,2})?$)|(^0(\.\d{1,2})?$)/;
                if (!reg.test(prise) || prise == 0 || prise == 0.0 || prise == 0.00) {
                    document.getElementById("priseError").innerHTML = "价格只能是数字，并且不能为0！！！";
                    return;
                }
                if (goodsNum < 1) {
                    document.getElementById("goodsNumError").innerHTML = "物品数量不能小于1！！！";
                    return;
                }
                //发送ajax请求到后台
                $.ajax({
                    url: 'workbench/goods/publishGoods.do',
                    dataType: 'json',
                    data: {
                        name: name,
                        firstType: firstType,
                        secondType: secondType,
                        prise: prise,
                        goodsNum: goodsNum,
                        describe: describe
                    },
                    success: function (map) {
                        var rm = map.returnMessage;
                        var goodsId = map.id;
                        alert("商品的主键id是:" + goodsId);
                        if (rm.code == "1") {
                            //将数据保存到 "获取物品的"的value属性中去
                            $("#getUserId").val(goodsId);
                            $("#getUserId").text("已获取物品ID" + goodsId);
                            //并且将物品图片信息显示在发布页面上
                            $("#goodsPhoto").attr("style", "padding: 0px");
                            //删除掉提示信息
                            $("#tishixinxi").remove();
                        } else {
                            alert(rm.message);
                        }
                    }
                })
            })
            //给提交按钮绑定一个单击事件
            $("#submitGoodsPhoto").click(function () {
                //获取当前商品的id
                var id = $("#getUserId").val();
                alert("当前商品的id=" + id);
                //遍历所有的图片，取出有数据的
                var allImages = $(".col-md-4 input");
                //定义存放文件的对象
                var formData = new FormData();
                var countinue = 0;
                $.each(allImages, function (index, image) {
                    var multipartFile = $(image)[0].files[0];
                    var photoname = $(image).val();
                    var suffix = photoname.substr(photoname.lastIndexOf(".") + 1).toLocaleLowerCase();
                    if (!(suffix == "jpg" || multipartFile==null)) {
                        countinue++;
                        alert("您输入的第" + (index + 1) + "个图片的格式不正确！！！");
                        return;
                    }
                    if (multipartFile != null) {
                        alert("当前图片被加载到formData当中了!!!");
                        formData.append("multipartFiles", multipartFile);
                    }
                })
                if (countinue == 0) {//图片格式都是正确的，就把数据传给后台
                    formData.append("id", id);
                    $.ajax({
                        url: 'workbench/goods/toGoodsDetailPage.do',
                        data: formData,
                        processData: false,//用来设置ajax向后台提交参数之前是否把参数同义转换成字符串；true|false默认情况下,true
                        contentType: false, //设置ajax向后台提交参数之前，是否把所有的参数统一按urlencode编码：true---是 false --否
                        type: "post",
                        success: function (data) {
                            if (data.code == 1) {
                                alert("上传图片成功!!!");
                                window.location.href = "workbench/goods/toGoodsDetail.do?goodsId="+id;
                            } else {
                                alert(data.message);
                            }
                        }
                    })
                }
                //获取照片
                // var multipartFile = $("#uploadphoto1")[0].files[0];
                // var formData = new FormData();
                // formData.append("multipartFile", multipartFile);
                // $.ajax({
                //     url: 'workbench/goods/toGoodsDetailPage.do',
                //     data: formData,
                //     processData: false,//用来设置ajax向后台提交参数之前是否把参数同义转换成字符串；true|false默认情况下,true
                //     contentType: false, //设置ajax向后台提交参数之前，是否把所有的参数统一按urlencode编码：true---是 false --否
                //     type: "post",
                //     success: function(data){
                //         if(data.code == 1){
                //             alert("上传图片成功!!!");
                //             window.location.href = "workbench/goods/goodsDetail";
                //         }else{
                //             alert(data.message);
                //         }
                //     }
                // })
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
                        href="javascript:void(0)">发布</a></li>


            </ul>

            <ul class="nav navbar-nav navbar-right">


                <li><img
                        src="${sessionScope.sessionUser.userAvatar}"
                        height="50px" width="50px"></li>
                <li><a
                        href="settings/qx/user/toUserDetailMes">${sessionScope.sessionUser.userName}</a></li>
                <li><a href="workbench/loginOut.do">退出</a></li>


            </ul>
        </div>
    </div>
</nav>
<div class="col-md-12" style="height: 70px"></div>

<div class="container"
     style="position: relative; transform: translate(0, 0)">
    <div class="col-md-9">
        <div class="col-md-12 r1"
             style="background-color: #e4e4e4; height: 40px;">
            <div style="margin-top: 5px">
                <B style="color: #c4c4c4; font-size: 20px;">物品详细信息</B>
            </div>
        </div>

        <div class="col-md-12 r2"
             style="background-color: #f9f9f9; padding-top: 15px; padding-bottom: 15px;">
            <div class="col-md-12">
                <form id="register" items="com.secondshop.models.Good@ffba6f" action="/secondshop/goods/publishGood"
                      method="post">

                    <div class="form-group">
                        <label for="name" class="control-label">物品标题</label>
                        <input id="name" name="name" class="form-control" type="text" value=""/>
                        <output id="nameError" style="color: red"></output>
                    </div>


                    <div class="form-group">
                        <label for="firstTypeId" class="control-label">一级分类</label>
                        <select id="firstTypeId" name="firstTypeId" class="form-control">
                            <c:forEach items="${firstTypes}" var="firstType">
                                <option value="${firstType.id}">${firstType.name}</option>
                            </c:forEach>
                        </select>
                    </div>


                    <div class="form-group">
                        <label for="secondTypeId" class="control-label">二级分类</label>
                        <select id="secondTypeId" name="secondTypeId" class="form-control">
                            <c:forEach items="${secondTypes}" var="secondType">
                                <option value="${secondType.id}">${secondType.name}</option>
                            </c:forEach>
                        </select>
                    </div>


                    <div class="form-group">
                        <label for="prise" class="control-label">物品价格</label>
                        <input id="prise" name="prise" class="form-control" type="text" value="0.0"/>
                        <output id="priseError" style="color: red"></output>
                    </div>

                    <div class="form-group">
                        <label for="goodsNum" class="control-label">物品数量</label>
                        <input id="goodsNum" name="goodsNum" class="form-control" onblur="checkNum(this)" type="text"
                               value="0"/>
                        <output id="goodsNumError" style="color: red"></output>
                    </div>


                    <div class="form-group">
                        <label for="describe" class="control-label">物品描述</label>
                        <textarea id="describe" name="describe" class="form-control" style="height: 160px">
</textarea>
                    </div>


                    <div class="form-group" align="right">


                        <button type="button" class="btn" id="getUserId" value
                                style="background-color: #e5e5e5">获取物品ID
                        </button>


                    </div>
                </form>
            </div>
        </div>

        <div class="col-md-12 r1"
             style="background-color: #e4e4e4; height: 40px; margin-top: 20px;">
            <div style="margin-top: 5px">
                <B style="color: #c4c4c4; font-size: 20px;">物品图片信息</B>
            </div>
        </div>

        <div class="col-md-12 r2"
             style="background-color: #f9f9f9; padding-top: 15px; padding-bottom: 15px;">
            <div class="col-md-12 r"
                 style="margin-top: 15px; background-color: #ffffff; padding: 0px">
                <div class="col-md-12"
                     style="display: ">
                    <div class="col-md-12" align="center"
                         style="height: 100px; padding-top: 20px">
                        <h3 id="tishixinxi" style="color: red">请先填写物品信息，获取物品ID</h3>
                    </div>
                </div>

                <div class="col-md-12" id="goodsPhoto"
                     style="padding: 0px; display: none">
                    <form action="/secondshop/goods/publishGood/uploadImage"
                          method="post" enctype="multipart/form-data">
                        <input name="goodId" value="0" style="display: none">
                        <div class="col-md-12" style="padding: 0px">
                            <div class="col-md-4" style="padding: 15px" align="center">
                                <div style="width: 100%; height: 230px;">
                                    <img src="" id="img1" height="100%" width="100%">
                                </div>
                                <input id="uploadphoto1" style="width: 100%" type="file" name="mainFile"
                                       onchange="change(event)" onclick="changeImgId('img1')">
                            </div>

                            <div class="col-md-4" style="padding: 15px" align="center">
                                <div style="width: 100%; height: 230px;">
                                    <img src="" id="img2" height="100%" width="100%">
                                </div>
                                <input style="width: 100%" type="file" name="file"
                                       onchange="change(event)" onclick="changeImgId('img2')">
                            </div>

                            <div class="col-md-4" style="padding: 15px" align="center">
                                <div style="width: 100%; height: 230px;">
                                    <img src="" id="img3" height="100%" width="100%">
                                </div>
                                <input style="width: 100%" type="file" name="file"
                                       onchange="change(event)" onclick="changeImgId('img3')">
                            </div>
                        </div>

                        <div id="addImg" class="col-md-12"
                             style="padding: 0px; display: none;">
                            <div class="col-md-4" style="padding: 15px" align="center">
                                <div style="width: 100%; height: 230px;">
                                    <img src="" id="img4" height="100%" width="100%">
                                </div>
                                <input style="width: 100%" type="file" name="file"
                                       onchange="change(event)" onclick="changeImgId('img4')">
                            </div>

                            <div class="col-md-4" style="padding: 15px" align="center">
                                <div style="width: 100%; height: 230px;">
                                    <img src="" id="img5" height="100%" width="100%">
                                </div>
                                <input style="width: 100%" type="file" name="file"
                                       onchange="change(event)" onclick="changeImgId('img5')">
                            </div>

                            <div class="col-md-4" style="padding: 15px" align="center">
                                <div style="width: 100%; height: 230px;">
                                    <img src="" id="img6" height="100%" width="100%">
                                </div>
                                <input style="width: 100%" type="file" name="file"
                                       onchange="change(event)" onclick="changeImgId('img6')">
                            </div>
                        </div>

                        <div class="col-md-12" style="padding: 15px">
                            <div class="col-md-6" style="padding: 0px">
                                <p id="addBtn" class="btn" style="background-color: #e5e5e5"
                                   onclick="addImg()">添加图片</p>
                            </div>

                            <div class="col-md-6" align="right" style="padding: 0px">
                                <button type="button" class="btn" id="submitGoodsPhoto"
                                        style="background-color: #e5e5e5">提交
                                </button>
                            </div>
                        </div>
                    </form>
                </div>
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

            <%--            <a--%>
            <%--                    href="/secondshop/goods/goodInfo?goodId=23"><!--跳转到商品详情页面-->--%>
            <%--                <div class="col-md-12 b"--%>
            <%--                     style="padding-left: 0px; padding-right: 0px">--%>
            <%--                    <div class="col-md-6"--%>
            <%--                         style="padding-top: 15px; padding-bottom: 15px">--%>
            <%--                        <img src="image/goods/23uABXbZdY9M.jpg" height="100px"--%>
            <%--                             ; width="100px">--%>
            <%--                    </div>--%>
            <%--                    <div class="col-md-6"--%>
            <%--                         style="padding-top: 15px; padding-bottom: 15px; height: 130px">--%>
            <%--                        <p style="height: 75px">皮鞋</p>--%>
            <%--                        <p align="right" style="color: red">￥50.0</p>--%>
            <%--                    </div>--%>
            <%--                </div>--%>
            <%--            </a>--%>

            <%--            <a--%>
            <%--                    href="/secondshop/goods/goodInfo?goodId=21">--%>
            <%--                <div class="col-md-12 b"--%>
            <%--                     style="padding-left: 0px; padding-right: 0px">--%>
            <%--                    <div class="col-md-6"--%>
            <%--                         style="padding-top: 15px; padding-bottom: 15px">--%>
            <%--                        <img src="image/goods/21hh7EAKXbhG.jpg" height="100px"--%>
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
            <%--                        <img src="image/goods/20HYtR9EMGq6.jpg" height="100px"--%>
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
            <%--                        <img src="image/goods/19at1bh3Mizc.jpg" height="100px"--%>
            <%--                             ; width="100px">--%>
            <%--                    </div>--%>
            <%--                    <div class="col-md-6"--%>
            <%--                         style="padding-top: 15px; padding-bottom: 15px; height: 130px">--%>
            <%--                        <p style="height: 75px">休闲裤</p>--%>
            <%--                        <p align="right" style="color: red">￥45.0</p>--%>
            <%--                    </div>--%>
            <%--                </div>--%>
            <%--            </a>--%>

            <%--            <a--%>
            <%--                    href="/secondshop/goods/goodInfo?goodId=18">--%>
            <%--                <div class="col-md-12 b"--%>
            <%--                     style="padding-left: 0px; padding-right: 0px">--%>
            <%--                    <div class="col-md-6"--%>
            <%--                         style="padding-top: 15px; padding-bottom: 15px">--%>
            <%--                        <img src="image/goods/18fRDAAt7ihr.jpg" height="100px"--%>
            <%--                             ; width="100px">--%>
            <%--                    </div>--%>
            <%--                    <div class="col-md-6"--%>
            <%--                         style="padding-top: 15px; padding-bottom: 15px; height: 130px">--%>
            <%--                        <p style="height: 75px">毛裤</p>--%>
            <%--                        <p align="right" style="color: red">￥68.0</p>--%>
            <%--                    </div>--%>
            <%--                </div>--%>
            <%--            </a>--%>

        </div>
    </div>
</div>


<script>
    $(function () {
        var goodType = $("#goodType option:selected").attr("value");
        $.getJSON("/secondshop/type/secondType/" + goodType, function (
            data) {
            $.each(data, function (i, type) {
                var id = type.id;
                var name = type.name;
                var option = '<option value= \"' + id + '\"> ' + name
                    + '</option>';
                $("#secondType").append(option);
            })
        });
    });

    function selectValue() {
        var goodType = $("#goodType option:selected").attr("value");
        $.getJSON("/secondshop/type/secondType/" + goodType, function (
            data) {
            document.getElementById("secondType").innerHTML = "";
            $.each(data, function (i, type) {
                var id = type.id;
                var name = type.name;
                var option = '<option value= \"' + id + '\"> ' + name
                    + '</option>';
                $("#secondType").append(option);
            })
        });
    }

    function checkNum() {
        var prise = document.getElementById("prise").value;
        var reg = /^[-+]?[0-9]*\.?[0-9]+$/;
        if (!reg.test(prise)) {
            document.getElementById("priseError").innerHTML = "对不起，请输入数字！";
        } else {
            document.getElementById("priseError").innerHTML = "";
        }
    }
</script>

<script>
    var imgId = "img1";

    function changeImgId(img) {
        imgId = img;
    }

    function change(ev) {
        var event = window.event || ev;
        var files = event.target.files[0];
        var myimg = document.getElementById(imgId);
        myimg.src = URL.createObjectURL(files);
    }

    function addImg() {
        if (document.getElementById("addImg").style.display === "none") {
            document.getElementById("addImg").style.display = "";
            document.getElementById("addBtn").innerHTML = "取消添加";
        } else {
            document.getElementById("addImg").style.display = "none";
            document.getElementById("addBtn").innerHTML = "添加图片";
        }
    }
</script>


</body>
</html>
</html>