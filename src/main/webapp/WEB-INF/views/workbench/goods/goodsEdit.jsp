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
    <title>物品编辑</title>
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
            //给一级分类下拉框绑定改变事件
            $("#firstTypeId").on("change",function(){
                var firstTypeId = this.value;
                $.ajax({
                    url:'workbench/goods/showSecondType.do',
                    type:'post',
                    dataType:'json',
                    data:{
                        firstTypeId:firstTypeId
                    },
                    success:function(secondTypes){
                        //局部刷新二级分类表单
                        $("#secondTypeId").html("");
                        $.each(secondTypes,function(index,secondType){
                            $("#secondTypeId").append("<option value="+secondType.id+">"+secondType.name+"</option>")
                        })
                    }
                })
            })
            //给提交信息按钮绑定一个单击事件
            $("#submitEditMes").click(function(){
                //获取该商品的id
                var goodsId = "${goods.id}";
                //获取物品的标题
                var goodsName = $("#name").val();
                //获取一级分类类型
                var firstTypeId = $("#firstTypeId option:selected").val();
                //获取二级分类类型
                var secondTypeId = $("#secondTypeId option:selected").val();
                //获取物品价格
                var prise = $("#prise").val();
                //获取物品描述
                var describe = $("#describe").val();

                $.ajax({
                    url:'workbench/goods/editGoodsMes.do',
                    type:'post',
                    dataType: 'json',
                    data: {
                        goodsId:goodsId,
                        goodsName:goodsName,
                        firstTypeId:firstTypeId,
                        secondTypeId:secondTypeId,
                        prise:prise,
                        describe:describe
                    },
                    success: function(res){
                        if(res.code == 1){
                            alert("商品信息更新成功!!!");
                            //跳转页面
                            window.location.href = "workbench/goods/toGoodsDetail.do?goodsId=${goods.id}"
                        }
                    }
                })
            })
            //给提交图片按钮绑定一个单击事件
            $("#submitPhotoUrl").click(function(){
                //获取当前商品的id
                var id = "${goods.id}";
                alert("当前商品的id=" + id);
                //遍历所有的图片，取出有数据的
                var allImages = $(".col-md-4 input");
                //定义存放文件的对象
                var formData = new FormData();
                var countinue = 0;
                $.each(allImages, function (index, image) {
                    var photoname = $(image).val();
                    var suffix = photoname.substr(photoname.lastIndexOf(".") + 1).toLocaleLowerCase();
                    var multipartFile = $(image)[0].files[0];
                    if (!(suffix == "jpg" || multipartFile == null)) {
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
                        url: 'workbench/goods/editGoodsMesForPhoto.do',
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
                <li><a id="loginOut" href="workbench/loginOut.do">退出</a></li>



            </ul>
        </div>
    </div>
</nav>
<div class="col-md-12" style="height: 70px"></div>

<div class="container">
    <div class="col-md-9">
        <div class="col-md-12 r1"
             style="background-color: #e4e4e4; height: 40px;">
            <div style="margin-top: 5px">
                <B style="color: #c4c4c4; font-size: 20px;">修改物品信息</B>
            </div>
        </div>

        <div class="col-md-12 r2"
             style="background-color: #f9f9f9; padding-top: 15px; padding-bottom: 15px;">
            <div class="col-md-12">
                <form id="register" items="com.secondshop.models.Good@a15b90">
<%--                    <div class="form-group" style="display: none">--%>
<%--                        <input id="id" name="id" class="form-control" type="text" value="16"/>--%>
<%--                    </div>--%>
<%--                    <div class="form-group" style="display: none">--%>
<%--                        <input id="photoUrl" name="photoUrl" class="form-control" type="text" value="/statics/image/goods/16JdQuvqvCMR.png"/>--%>
<%--                    </div>--%>



                    <div class="form-group">
                        <label for="name" class="control-label">物品标题</label>
                        <input id="name" name="goodsName" class="form-control" type="text" value="${goods.name}"/>
                    </div>



                    <div class="form-group">
                        <label for="firstTypeId" class="control-label">一级分类</label>
                        <select id="firstTypeId" name="firstTypeId" class="form-control">
                            <c:forEach items="${firstTypes}" var="firstType">
                                <option ${goods.firstTypeId==firstType.id?'selected="selected"': ''} value="${firstType.id}">${firstType.name}</option>
                            </c:forEach>
                        </select>
                    </div>



                    <div class="form-group">
                        <label for="secondTypeId" class="control-label">二级分类</label>
                        <select id="secondTypeId" name="secondTypeId" class="form-control">
                            <c:forEach items="${secondTypes}" var="secondType">
                                <option ${goods.secondTypeId==secondType.id?'selected="selected"': ''} value="${secondType.id}">${secondType.name}</option>
                            </c:forEach>
                        </select>
                    </div>



                    <div class="form-group">
                        <label for="prise" class="control-label">物品价格</label>
                        <input id="prise" name="prise" class="form-control" onblur="checkNum(this)" type="text" value="${goods.prise}"/>
                        <output id="priseError" style="color: red"></output>
                    </div>



                    <div class="form-group">
                        <label for="describe" class="control-label">物品描述</label>
                        <textarea id="describe" name="describe" class="form-control" style="height: 160px">${goods.describe}
</textarea>
                    </div>


                    <div class="form-group">
                        <a onclick="deleteGood()" class="btn"
                           style="background-color: #e5e5e5">删除物品</a>
                        <button id="submitEditMes" type="button" class="btn pull-right"
                                style="background-color: #e5e5e5">提交信息</button>
                    </div>
                </form>
            </div>
        </div>

        <div class="col-md-12 r1"
             style="background-color: #e4e4e4; height: 40px; margin-top: 20px;">
            <div style="margin-top: 5px">
                <B style="color: #c4c4c4; font-size: 20px;">修改物品图片</B>
            </div>
        </div>

        <div class="col-md-12 r2"
             style="background-color: #f9f9f9; padding-top: 15px; padding-bottom: 15px;">
            <div class="col-md-12 r"
                 style="margin-top: 15px; background-color: #ffffff; padding: 0px">
                <div id="goodImg" class="col-md-12" style="padding: 0px;">
                    <div class="col-md-4" style="padding: 15px" align="center">
                        <div style="width: 100%; height: 230px;">
                            <img src="${goods.photoUrl}" height="100%"
                                 width="100%">
                        </div>
                    </div>


                </div>

                <form enctype="multipart/form-data">
                    <input name="goodId" value="16" style="display: none">
                    <div id="addImg" class="col-md-12"
                         style="padding: 0px; display: none;">
                        <div class="col-md-4" style="padding: 15px" align="center">
                            <div style="width: 100%; height: 230px;">
                                <img src="" id="img1" height="100%" width="100%">
                            </div>
                            <input style="width: 100%" type="file" name="mainFile"
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
                               onclick="addImg()">重新上传图片</p>
                        </div>
                        <div class="col-md-6" align="right" style="padding: 0px">
                            <button id="submitPhotoUrl" type="button" class="btn"
                                    style="background-color: #e5e5e5">提交</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <div class="col-md-3 r"
         style="background-color: #f9f9f9; padding-bottom: 15px;">
        <div class="col-md-12 r"
             style="text-align: center; margin-top: 10px; background-color: #e4e4e4; padding: 5px">
            <B style="font-size: 20px; color: #a2a2a2">最新发布的物品</B>
        </div>

        <div class="col-md-12"
             style="margin-top: 20px; padding-left: 0px; padding-right: 0px">

            <c:forEach items="${latestGoods}" var="latestGood">
                <a  href="workbench/goods/toGoodsDetail.do?goodsId=${latestGood.id}">
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



<%--            <a  href="goodInfo?goodId=16">--%>
<%--                <div class="col-md-12 b"--%>
<%--                     style="padding-left: 0px; padding-right: 0px">--%>
<%--                    <div class="col-md-6"--%>
<%--                         style="padding-top: 15px; padding-bottom: 15px">--%>
<%--                        <img src="/secondshop/statics/image/goods/16JdQuvqvCMR.png" height="100px"--%>
<%--                             ; width="100px">--%>
<%--                    </div>--%>
<%--                    <div class="col-md-6"--%>
<%--                         style="padding-top: 15px; padding-bottom: 15px; height: 130px">--%>
<%--                        <p style="height: 75px">秋衣</p>--%>
<%--                        <p align="right" style="color: red">￥201.0</p>--%>
<%--                    </div>--%>
<%--                </div>--%>
<%--            </a>--%>

<%--            <a  href="goodInfo?goodId=12">--%>
<%--                <div class="col-md-12 b"--%>
<%--                     style="padding-left: 0px; padding-right: 0px">--%>
<%--                    <div class="col-md-6"--%>
<%--                         style="padding-top: 15px; padding-bottom: 15px">--%>
<%--                        <img src="/secondshop/statics/image/goods/12fLdnB5THKf.png" height="100px"--%>
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
<%--                        <img src="/secondshop/statics/image/goods/117YEj4a8RtX.png" height="100px"--%>
<%--                             ; width="100px">--%>
<%--                    </div>--%>
<%--                    <div class="col-md-6"--%>
<%--                         style="padding-top: 15px; padding-bottom: 15px; height: 130px">--%>
<%--                        <p style="height: 75px">女士鞋</p>--%>
<%--                        <p align="right" style="color: red">￥200.0</p>--%>
<%--                    </div>--%>
<%--                </div>--%>
<%--            </a>--%>

<%--            <a  href="goodInfo?goodId=10">--%>
<%--                <div class="col-md-12 b"--%>
<%--                     style="padding-left: 0px; padding-right: 0px">--%>
<%--                    <div class="col-md-6"--%>
<%--                         style="padding-top: 15px; padding-bottom: 15px">--%>
<%--                        <img src="/secondshop/statics/image/goods/10KfmXgKm41b.png" height="100px"--%>
<%--                             ; width="100px">--%>
<%--                    </div>--%>
<%--                    <div class="col-md-6"--%>
<%--                         style="padding-top: 15px; padding-bottom: 15px; height: 130px">--%>
<%--                        <p style="height: 75px">电热水壶</p>--%>
<%--                        <p align="right" style="color: red">￥40.0</p>--%>
<%--                    </div>--%>
<%--                </div>--%>
<%--            </a>--%>

<%--            <a  href="goodInfo?goodId=7">--%>
<%--                <div class="col-md-12 b"--%>
<%--                     style="padding-left: 0px; padding-right: 0px">--%>
<%--                    <div class="col-md-6"--%>
<%--                         style="padding-top: 15px; padding-bottom: 15px">--%>
<%--                        <img src="/secondshop/statics/image/goods/7hcJYNCaPru.png" height="100px"--%>
<%--                             ; width="100px">--%>
<%--                    </div>--%>
<%--                    <div class="col-md-6"--%>
<%--                         style="padding-top: 15px; padding-bottom: 15px; height: 130px">--%>
<%--                        <p style="height: 75px">电风扇</p>--%>
<%--                        <p align="right" style="color: red">￥100.0</p>--%>
<%--                    </div>--%>
<%--                </div>--%>
<%--            </a>--%>

        </div>
    </div>
</div>



<script>
    $(function () {
        var goodType = $("#goodType option:selected").attr("value");
        $.getJSON("/secondshop/type/secondType/" + goodType, function (data) {
            console.log(data);
            $.each(data, function (i, type) {
                var id = type.id;
                var name = type.name;
                console.log(id);
                console.log(name);
                var option = '<option value= \"'+ id +'\"> '+ name +'</option>';
                $("#secondType").append(option);
            })
        });
    });

    function selectValue() {
        var goodType = $("#goodType option:selected").attr("value");
        $.getJSON("/secondshop/type/secondType/" + goodType, function (data) {
            console.log(data);
            document.getElementById("secondType").innerHTML = "";
            $.each(data, function (i, type) {
                var id = type.id;
                var name = type.name;
                console.log(id);
                console.log(name);
                var option = '<option value= \"'+ id +'\"> '+ name +'</option>';
                $("#secondType").append(option);
            })
        });
    }

    function checkNum() {
        var prise = document.getElementById("prise").value;
        var reg = /^[-+]?[0-9]*\.?[0-9]+$/;
        if (! reg.test(prise)){
            document.getElementById("priseError").innerHTML="对不起，请输入数字！";
        }else {
            document.getElementById("priseError").innerHTML="";
        }
    }

    function deleteGood() {
        $.get("/secondshop/goods/userGoodEdit/delete/" + 16, function (data) {
            if (data == true){
                alert("物品删除成功！");
                $(window).attr('location','/secondshop/user/userProfile');
            } else {
                alert("物品删除失败！");
            }
        })
    }
</script>

<script>
    var imgId = "img1";
    function changeImgId(img) {
        imgId = img;
    }

    function change(ev){
        var event = window.event || ev;
        var files = event.target.files[0];
        var myimg = document.getElementById(imgId);
        myimg.src = URL.createObjectURL(files);
    }

    function addImg() {
        if (document.getElementById("addImg").style.display === "none"){
            $("#goodImg").slideUp();
            $("#addImg").slideDown();
            document.getElementById("addBtn").innerHTML = "取消重新上传图片";
        } else {
            $("#goodImg").slideDown();
            $("#addImg").slideUp();
            document.getElementById("addBtn").innerHTML = "重新上传图片";
        }
    }
</script>
</body>
</html>