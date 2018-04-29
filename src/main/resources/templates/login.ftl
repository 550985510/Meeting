<#import "spring.ftl" as s>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>后台登录</title>
    <meta name="renderer" content="webkit|ie-comp|ie-stand">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport"
          content="width=device-width,user-scalable=yes, minimum-scale=0.4, initial-scale=0.8,target-densitydpi=low-dpi"/>
    <meta http-equiv="Cache-Control" content="no-siteapp"/>

    <script type="text/javascript" src="js/jquery.min.js"></script>
    <link rel="stylesheet" href="/css/font.css">
    <link rel="stylesheet" href="/css/xadmin.css">
    <script src="/js/layui.js" charset="utf-8"></script>
    <script type="text/javascript" src="/js/xadmin.js"></script>
    <link rel="stylesheet" type="text/css" href="plugins/sweetAlert/sweetalert.css"/>

</head>
<body class="login-bg">
<div id="app">
    <div class="login" v-if="flag">
        <div class="message">后台登录</div>
        <div id="darkbannerwrap"></div>
        <input name="mobile" placeholder="用户名" type="text" class="layui-input" v-model="user.mobile">
        <hr class="hr15">
        <input name="password" placeholder="密码" type="password" class="layui-input" v-model="user.password">
        <hr class="hr15">
        <input value="登录" lay-submit lay-filter="login" style="width:100%;" type="submit" v-on:click="login">
        <input value="注册" lay-submit lay-filter="login" style="width:100%; margin-top: 10px" type="submit" v-on:click="registerBtn">
        <hr class="hr20">
    </div>

    <div class="login" v-else="">
        <div class="message">用户注册</div>
        <div id="darkbannerwrap"></div>
        <input name="mobile" placeholder="手机号" type="text" class="layui-input" v-model="registerUser.mobile">
        <hr class="hr15">
        <input name="name" placeholder="用户姓名" type="text" class="layui-input" v-model="registerUser.name">
        <hr class="hr15">
        <input name="password" placeholder="密码" type="password" class="layui-input" v-model="registerUser.password">
        <hr class="hr15">
        <input name="password2" placeholder="确认密码" type="password" class="layui-input" v-model="registerUser.password2">
        <hr class="hr15">
        <input value="注册" lay-submit lay-filter="login" style="width:100%;" type="button" v-on:click="register">
        <hr class="hr20">
    </div>
</div>
<#include 'include/footer.ftl'/>
<script>
    var app = new Vue({
        el: '#app',
        data: {
            user: {},
            flag: true,
            registerUser: {}
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
            },
            registerBtn: function () {
                this.flag = false;
            },
            register: function () {
                if (this.registerUser.mobile == null) {
                    sweetAlert("请输入手机号");
                } else if (this.registerUser.name == null){
                    sweetAlert("请输入用户姓名");
                } else if (this.registerUser.password == null) {
                    sweetAlert("请输入密码");
                } else if (this.registerUser.password != this.registerUser.password2) {
                    sweetAlert("请保持两次密码输入一致");
                } else {
                    var url = "/api/user/register";
                    this.$http.post(url, this.registerUser).then(function (response) {
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
        }
    });
</script>
</body>
</html>