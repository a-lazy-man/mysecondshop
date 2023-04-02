<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
%>
<html>
<head>
    <base href="<%=basePath%>">
    <meta charset="UTF-8">
    <title>测试分页插件</title>
    <!--引入生成二维码的插件qrious-->
    <script type="text/javascript" src="js/qrious.min.js"></script>
</head>
<body>
<img id="qrious">
</body>
</html>

<script type="text/javascript">
    var qr = new QRious({
        element: document.getElementById("qrious"),
        background: 'yellow', //背景色
        foreground: 'red', //前景色
        size: 250,  //二维码的尺寸单位像素
        level: 'H', //二维码的误差矫正级别(L,M,Q,H) 30%
        value: 'http://www.baidu.com' //二维码的信息，后面会换成我们实际微信支付的地址
    })
</script>