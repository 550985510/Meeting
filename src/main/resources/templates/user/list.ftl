<#import "/spring.ftl" as s>
<!DOCTYPE html>
<html lang="zh_CN">
<head>
    <meta charset="utf-8">
    <title>秦涛会议管理系统</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" type="text/css" href="<@s.url '/css/jquery.pagination.css'/>">
<#include '../include/baselink.ftl'>
</head>
<body class="dashboard-page">
<div id="main">
    <section id="content" class="table-layout">
        <div class="tray tray-center">
            <div class="panel">
                <div class="panel-heading">
                    <span class="panel-icon">
                        <i class="fa fa-bar-chart-o"></i>
                    </span>
                    <span class="panel-title"> 会员列表</span>
                </div>
                <div class="panel-body">
                    <div class="well">
                        <form class="form-inline">
                            <div class="form-group">
                                <div class="input-group">
                                    <label class="input-group-addon btn-default" for="realName_input">用户姓名</label>
                                    <input id="realName_input" type="text" v-model="searchInfo.name"
                                           class="form-control">
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="input-group">
                                    <label class="input-group-addon btn-default" for="mobile_input">手机号</label>
                                    <input id="mobile_input" type="text" v-model="searchInfo.mobile"
                                           class="form-control">
                                </div>
                            </div>
                            <div class="form-group input-group">
                                <span class="input-group-btn">
                                    <button type="button" class="btn btn-default" v-on:click="search">
                                        <span class="fa fa-search"></span> 查询
                                    </button>
                                </span>
                            </div>
                        </form>
                    </div>
                    <div class="panel-body">
                        <table class="table table-bordered">
                            <thead>
                            <tr>
                                <th>编号</th>
                                <th>姓名</th>
                                <th>手机号</th>
                                <th>权限</th>
                                <th>注册时间</th>
                            </tr>
                            </thead>
                            <tbody>
                            <tr v-for="user in users">
                                <td>{{user.id}}</td>
                                <td>{{user.name}}</td>
                                <td>{{user.mobile}}</td>
                                <td v-if="user.role === 0">普通用户</td>
                                <td v-if="user.role === 1">管理员</td>
                                <td>{{user.createdTime}}</td>
                            </tr>
                            <tr>
                                <td class="text-center" colspan="20" v-if="users.length == 0">没有数据 ！</td>
                            </tr>
                            </tbody>
                            <tfoot>
                            <tr>
                                <td colspan="20">
                                    <div class="table-responsive">
                                        <div id="pageMenu"></div>
                                    </div>
                                </td>
                            </tr>
                            </tfoot>
                        </table>
                    </div>
                </div>
                <div class="panel-footer">
                    <button class="btn btn-success btn-lg" data-toggle='modal' data-target="#addUser">
                        <i class="fa fa-user"></i> 添加用户
                    </button>
                </div>
            </div>
        </div>
    </section>

    <!-- 添加用户 -->
    <div id="addUser" class="modal fade" tabindex="-1" role="dialog">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                            aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title">添加用户</h4>
                </div>
                <div class="modal-body">
                    <form class="form-horizontal" role="form">
                        <div class="form-group">
                            <label for="add_modal_name_input" class="control-label col-lg-3">用户姓名</label>
                            <div class="bs-component col-lg-8">
                                <input id="add_modal_name_input" class="form-control" v-model="user.name">
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="add_modal_mobile_input" class="control-label col-lg-3">手机号码</label>
                            <div class="bs-component col-lg-8">
                                <input id="add_modal_mobile_input" class="form-control" v-model="user.mobile">
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="add_modal_role_select" class="control-label col-lg-3">选择角色</label>
                            <div class="bs-component col-lg-8">
                                <select id="add_modal_role_select" class="form-control" v-model="user.role">
                                    <option value="0">普通用户</option>
                                    <option value="1">管理员</option>
                                </select>
                            </div>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                    <button type="button" class="btn btn-primary" v-on:click="addUser">确认</button>
                </div>
            </div><!-- /.modal-content -->
        </div><!-- /.modal-dialog -->
    </div><!-- /.modal -->

</div>
<#include '../include/footer.ftl'/>
<script src="<@s.url '/js/jquery.pagination-1.2.7.js'/>"></script>
<!-- Charts JS -->
<script>
    var app = new Vue({
        el: '#main',
        data: {
            users: [],
            searchInfo: {
                name: '',
                mobile: '',
                page: 1,
                pageSize: 30
            },
            user: {}
        },
        created: function () {
            this.searchInfo.page = 1;
            $('#pageMenu').page('destroy');
            this.query();
        },
        watch: {
            "searchInfo.page": function () {
                this.query();
            }
        },
        methods: {
            search: function () {
                this.searchInfo.page = 1;
                $('#pageMenu').page('destroy');//销毁分页
                this.query();
            },
            query: function () {
                var url = "/api/user/list";
                this.$http.post(url, this.searchInfo).then(function (response) {
                    this.users = response.data.data.list;
                    var temp = this;
                    $("#pageMenu").page({//加载分页
                        total: response.data.data.total,
                        pageSize: response.data.data.pageSize,
                        firstBtnText: '首页',
                        lastBtnText: '尾页',
                        prevBtnText: '上一页',
                        nextBtnText: '下一页',
                        showInfo: true,
                        showJump: true,
                        jumpBtnText: '跳转',
                        infoFormat: '{start} ~ {end}条，共{total}条'
                    }, response.data.data.page)//传入请求参数
                            .on("pageClicked", function (event, pageIndex) {
                                temp.searchInfo.page = pageIndex + 1;
                            }).on('jumpClicked', function (event, pageIndex) {
                        temp.searchInfo.page = pageIndex + 1;
                    });
                }, function (error) {
                    swal(error.body.msg);
                });
            },
            addUser: function () {
                if (this.user.name == null) {
                    sweetAlert("请输入用户姓名");
                } else if (this.user.mobile == null) {
                    sweetAlert("请输入用户手机号码")
                }  else if (this.user.role == null) {
                    sweetAlert("请选择用户权限")
                } else {
                    var that = this;
                    swal({
                        title: "确定添加用户吗？",
                        type: "warning",
                        showCancelButton: true,
                        confirmButtonColor: "#DD6B55",
                        confirmButtonText: "确定！",
                        cancelButtonText: "取消！",
                        closeOnConfirm: false,
                        closeOnCancel: false
                    }, function (isConfirm) {
                        if (isConfirm) {
                            var url = "/api/user/add";
                            that.$http.post(url, that.user).then(function (response) {
                                $("#addUser").modal('hide');
                                swal("操作成功！", "", "success");
                                that.query();
                            }, function (error) {
                                swal(error.body.msg);
                            });
                        } else {
                            swal("取消！", "", "error");
                        }
                    });
                }
            }
        }
    });
</script>
</body>
</html>
