<#import "spring.ftl" as s>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>后台登录</title>
    <meta name="renderer" content="webkit|ie-comp|ie-stand">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width,user-scalable=yes, minimum-scale=0.4, initial-scale=0.8,target-densitydpi=low-dpi" />
    <meta http-equiv="Cache-Control" content="no-siteapp" />

    <script type="text/javascript" src="js/jquery.min.js"></script>
    <link rel="stylesheet" href="/css/font.css">
    <link rel="stylesheet" href="/css/xadmin.css">
    <script src="/js/layui.js" charset="utf-8"></script>
    <script type="text/javascript" src="/js/xadmin.js"></script>
    <link rel="stylesheet" type="text/css" href="plugins/sweetAlert/sweetalert.css"/>

</head>
<body class="login-bg">

<div class="login" id="app">
    <div class="message">后台登录</div>
    <div id="darkbannerwrap"></div>

        <input name="mobile" placeholder="用户名"  type="text" class="layui-input" v-model="user.mobile">
        <hr class="hr15">
        <input name="password" placeholder="密码"  type="password" class="layui-input" v-model="user.password">
        <hr class="hr15">
        <input value="登录" lay-submit lay-filter="login" style="width:100%;" type="submit" v-on:click="login">
        <hr class="hr20">

</div>
<#include 'include/footer.ftl'/>
<script>
    var app = new Vue({
        el: '#app',
        data: {
            user: {}
        },
        created: function () {

        },
        methods: {
            login: function () {
                var url = "/api/user/login";
                this.$http.post(url, this.user).then(function (response) {
                    console.log(response.data);
                    if (response.data.retcode == 2000000) {
                        window.location.href = "/";
                    } else {
                        swal("", response.data.msg, "error");
                    }
                }, function (error) {
                    swal(error.body.msg);
                });
            }
        }
    });
</script>
</body>
</html>