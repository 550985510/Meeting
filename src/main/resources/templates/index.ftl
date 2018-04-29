<#import "/spring.ftl" as s>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>秦涛会议管理系统</title>
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
    <link rel="stylesheet" type="text/css" href="<@s.url '/plugins/sweetAlert/sweetalert.css'/>"
</head>
<body>
<div id="main">
    <!-- 顶部开始 -->
    <div class="container">
        <div class="logo"><a href="/index">秦涛会议管理系统</a></div>
        <ul class="layui-nav right" lay-filter="">
            <li class="layui-nav-item">
                <a href="javascript:;" v-if="role == 1">admin</a>
                <a href="javascript:;" v-if="role == 0">${Session.user.name}</a>
                <dl class="layui-nav-child"> <!-- 二级菜单 -->
                    <dd><a v-on:click="logout">退出</a></dd>
                </dl>
            </li>
            <li class="layui-nav-item to-index"><a href="/">后台首页</a></li>
        </ul>

    </div>
    <!-- 顶部结束 -->
    <!-- 中部开始 -->
    <!-- 左侧菜单开始 -->
    <div class="left-nav">
        <div id="side-nav">
            <ul id="nav">
                <li v-if="role == 1">
                    <a href="javascript:;">
                        <i class="iconfont">&#xe6b8;</i>
                        <cite>用户管理</cite>
                        <i class="iconfont nav_right">&#xe697;</i>
                    </a>
                    <ul class="sub-menu">
                        <li>
                            <a _href="/user/list">
                                <i class="iconfont">&#xe6a7;</i>
                                <cite>用户列表</cite>
                            </a>
                        </li>
                    </ul>
                </li>
                <li>
                    <a href="javascript:;">
                        <i class="iconfont">&#xe723;</i>
                        <cite>会议管理</cite>
                        <i class="iconfont nav_right">&#xe697;</i>
                    </a>
                    <ul class="sub-menu">
                        <li v-if="role == 0">
                            <a _href="/meeting/apply">
                                <i class="iconfont">&#xe6a7;</i>
                                <cite>会议申请</cite>
                            </a>
                        </li>
                        <li v-if="role == 1">
                            <a _href="/meeting/list">
                                <i class="iconfont">&#xe6a7;</i>
                                <cite>会议列表</cite>
                            </a>
                        </li>
                        <li>
                            <a _href="/room/list">
                                <i class="iconfont">&#xe6a7;</i>
                                <cite>会议室列表</cite>
                            </a>
                        </li>
                    </ul>
                </li>
            </ul>
        </div>
    </div>
    <!-- <div class="x-slide_left"></div> -->
    <!-- 左侧菜单结束 -->
    <!-- 右侧主体开始 -->
    <div class="page-content">
        <div class="layui-tab tab" lay-filter="xbs_tab" lay-allowclose="false">
            <ul class="layui-tab-title">
                <li class="home"><i class="layui-icon">&#xe68e;</i>我的桌面</li>
            </ul>
            <div class="layui-tab-content">
                <div class="layui-tab-item layui-show">
                    <iframe src='' frameborder="0" scrolling="yes" class="x-iframe"></iframe>
                </div>
            </div>
        </div>
    </div>
    <div class="page-content-bg"></div>
    <!-- 右侧主体结束 -->
    <!-- 中部结束 -->
    <!-- 底部开始 -->
    <div class="footer">
        <div class="copyright">Copyright ©2017-2018 秦涛会议管理系统</div>
    </div>
</div>
<#include 'include/footer.ftl'/>
<!-- 底部结束 -->
<script>
    var app = new Vue({
        el: '#main',
        data: {
            role: ${Session.user.role}
        },
        created: function () {

        },
        methods: {
            logout: function () {
                var that = this;
                swal({
                    title: "确定退出当前账户吗？",
                    type: "warning",
                    showCancelButton: true,
                    confirmButtonColor: "#DD6B55",
                    confirmButtonText: "确定！",
                    cancelButtonText: "取消！",
                    closeOnConfirm: false,
                    closeOnCancel: false
                }, function (isConfirm) {
                    if (isConfirm) {
                        var url = "/api/user/logout";
                        that.$http.post(url).then(function (response) {
                            swal("操作成功！", "", "success");
                            location.reload();
                        }, function (error) {
                            swal(error.body.msg);
                        });
                    } else {
                        swal("取消！", "", "error");
                    }
                });
            }
        }
    });
</script>
</body>
</html>