package com.bjpowernode.secondshop.conmons.utils;

public class AlipayConfig {

    // 应用ID
    public static String app_id = "2021000122611543";

    // 商户私钥
    public static String merchant_private_key = "MIIEvwIBADANBgkqhkiG9w0BAQEFAASCBKkwggSlAgEAAoIBAQCWc51ImUHZyz/4Kog9jblZ369+c/evHbzloARTG9WOtdc72BLPOz4Xvh4uzwV+jy14VSWmyltJyplBWMH9eVzQwPi+paoRztRpY0BLYcewz1aq0GERRxFb87EdfKi2ywOhEqLzOPs0TKrCVScQR/5NFnPzrr//R5BSKnxfSvekQSmhnP6JTcSEt3wS4FsJKoJxmK4q5HT1Kkjs0oM6j6EoeWLJdZESbvpHz4X39xfHHAOigFAkJsSTwwAyJ+iuOjdLme8xVGJHkmy4VP70JhogoSQeM5gRuPxWsiGJSxc+7R3cswZbtOnAv59Zc/rVDOHI2uiMZN7eytma+SprygT5AgMBAAECggEBAIMF+Kmq3lA/01vaHoAMlqiQRxNHByL4MPOA4YNHMDpyXhj92ZOjsjWXGk4FeHF5W036SSnx/IJM8B6an4aRVKVwCLBvMacEirOk/e8oHnH6fy2O/5m+XH3Jwis9zugx8N0rj8FllE89nVBUPArPx8V2klBblVVKC4OjAGE0tmnSB+kDBCM6xPdxJ8L1jwSNjGsBElkmwaGmoEoOO2Hrtz4R6GQmWVZhbJDP08j7WXXHyo7AikQgqfZCYIhOPbqzbQqQGp1SSjWgnZjHilX3Qr24Z62ryQwlzW7TXbE161iMxbcVXzuvtXT7kZRsZ6DxkLQf1uY5CwTKlNNq3rHr9aECgYEAygSK+l2YPfHZHhqLJ7OM4qX1mk0LMPnS7Xxt3AH8Bt3DEY51gIbe1comkViazDLeIA9XExYXHiQDKIkJ7xNdYBhbgxGjxPV1A+fiFT+TbMUVFNAanUAoPdrga6N/bye4FrMyBafeeM5M8vvap/ouR0Dauhu5eOZKdzcxqOeOFG0CgYEAvqeUe4tQ30/fwtimpYhHwp4fFYHbZ/PyuRB3ScDiEvoj4nxN7v22lAYc+zis8Nop4e5FzlNB/nHrNnYIqQQTe6TmG8HC714/qdirhc8DAakvMAxVwPdWcdWRjIoke6pD3VBem3QD3T+g0Q5nmSToxObbCaQ+MzbwrHY07CGNYz0CgYEAqvMBMDA3fmPD2QeZLfVwiPLrTLFZgQ5HAZRD2uMLBDxwr9Cfei2nL76quGAETjvVX8fbZVlSIr1StuCQOXFnmMPD3Lv2m9siNDXrSRPNi0OTPVOE0gDSjNVFB5EJa2RvETZ+Y+7UAeKBlzSsqWy58K3e6ZJAdyBZb1yTd1zLDFkCgYEAqRGo3coUpIOLdZl0ZpSstkxMWmE2tT+ivjR45EGU+akzC1SaM9ZwA2JMbwe6bTe6Lm2DH827Vy2knT4cve0sbdg0aubvvB+DK1ZF/Lov+1gRzXUS0rVDxlzS3qNeaP/7gJYV35sJFjmnndw9SJRvirUCBtHMitQsp3OHyOKUJC0CgYBfMh2M0N9E2QyxeVdE1cXrH1d5dGEQ4bMdObbRnoIYhkQDq1zopOR/bDcsaIpqD2HJkK96GcTO89EM1udEWqr/0D2QHlfbFr5sPu1+WgZjeQG45DsPY0Drf1X+QZFg0Gykib/7Aun0XPW6FcXWENbNGFrrT8ksF/oE922ULNvoog==";

    // 支付宝公钥
    public static String alipay_public_key = "MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA0FdVRJpKvvi4XPVGi62iMp8aOyCcFobJEDFOLnJ/LNjcaHPA/gHrdhdCUIXrjCDy9ZesY2Fl2G2IOfwjUj9VYQBYGS5fnFURHBgE0HYhgzP63+lbd7DlinOsJKNg+hqHZ5oMuTbuhwulvrguSwck0L+SM3GdULZsP+HeAMe9lxTHmVoniP8fw3qDypkYGfpEQevoEDVg0R+Sceccg/7CEJQRx2EFBgqF9kEbi+W1SX1oSrGnfA7KaGvbb/nsCl0DdGLH7N+41YOQ+ovZsXrQeJMBYzRHn1Nbvo1Ji15nJrB51MtgUToF5JJi4CNgTfPiGqbXD5SLX5KLcqEOaXqb8wIDAQAB";

    // 服务器异步通知页面路径 即支付失败跳转到的页面路径
    public static String notify_url = "";

    // 页面跳转同步通知页面路径 即支付成功跳转的页面路径
    public static String return_url = "";

    // 签名方式
    public static String sign_type = "RSA2";

    // 字符编码格式
    public static String charset = "utf-8";

    // 支付宝网关
    public static String gatewayUrl = "https://openapi.alipaydev.com/gateway.do";

}
