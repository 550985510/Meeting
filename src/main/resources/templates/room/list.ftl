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
                    <span class="panel-title"> 会议室列表</span>
                </div>
                <div class="panel-body">
                    <div class="well">
                        <form class="form-inline">
                            <div class="form-group">
                                <div class="input-group">
                                    <label class="input-group-addon btn-default" for="realName_input">会议室名称</label>
                                    <input id="realName_input" type="text" v-model="searchInfo.name"
                                           class="form-control">
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="input-group">
                                    <label class="input-group-addon btn-default" for="mobile_input">会议室使用状态</label>
                                    <select id="mobile_input" type="text" v-model="searchInfo.status"
                                           class="form-control">
                                        <option value="">全部</option>
                                        <option value="0">空闲</option>
                                        <option value="1">已预约</option>
                                    </select>
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
                                <th>会议室名称</th>
                                <th>会议室地点</th>
                                <th>会议室容纳人数</th>
                                <th>使用状态</th>
                                <th>创建时间</th>
                            </tr>
                            </thead>
                            <tbody>
                            <tr v-for="room in rooms">
                                <td>{{room.id}}</td>
                                <td>{{room.name}}</td>
                                <td>{{room.location}}</td>
                                <td>{{room.number}}</td>
                                <td v-if="room.status === 0">空闲</td>
                                <td v-if="room.status === 1">已预约</td>
                                <td>{{room.createdTime}}</td>
                            </tr>
                            <tr>
                                <td class="text-center" colspan="20" v-if="rooms.length == 0">没有数据 ！</td>
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
                <div class="panel-footer" v-if="role == 1">
                    <button class="btn btn-success btn-lg" data-toggle='modal' data-target="#addRoom">
                        <i class="fa fa-room"></i> 添加会议室
                    </button>
                </div>
            </div>
        </div>
    </section>

    <!-- 添加用户 -->
    <div id="addRoom" class="modal fade" tabindex="-1" role="dialog">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                            aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title">添加会议室</h4>
                </div>
                <div class="modal-body">
                    <form class="form-horizontal" role="form">
                        <div class="form-group">
                            <label for="add_modal_name_input" class="control-label col-lg-3">会议室名称</label>
                            <div class="bs-component col-lg-8">
                                <input id="add_modal_name_input" class="form-control" v-model="room.name">
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="add_modal_mobile_input" class="control-label col-lg-3">会议室地点</label>
                            <div class="bs-component col-lg-8">
                                <input id="add_modal_mobile_input" class="form-control" v-model="room.location">
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="add_modal_mobile_input" class="control-label col-lg-3">会议室容纳人数</label>
                            <div class="bs-component col-lg-8">
                                <input id="add_modal_mobile_input" class="form-control" v-model="room.number">
                            </div>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                    <button type="button" class="btn btn-primary" v-on:click="addRoom">确认</button>
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
            rooms: [],
            searchInfo: {
                name: '',
                status: '',
                page: 1,
                pageSize: 30
            },
            room: {},
            role: ${Session.user.role}
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
                var url = "/api/room/list";
                this.$http.post(url, this.searchInfo).then(function (response) {
                    this.rooms = response.data.data.list;
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
            addRoom: function () {
                if (this.room.name == null) {
                    sweetAlert("请输入会议室名称");
                } else if (this.room.location == null) {
                    sweetAlert("请输入会议室地点")
                }  else if (this.room.number == null) {
                    sweetAlert("请输入会议室容纳人数")
                } else {
                    var that = this;
                    swal({
                        title: "确定添加会议室吗？",
                        type: "warning",
                        showCancelButton: true,
                        confirmButtonColor: "#DD6B55",
                        confirmButtonText: "确定！",
                        cancelButtonText: "取消！",
                        closeOnConfirm: false,
                        closeOnCancel: false
                    }, function (isConfirm) {
                        if (isConfirm) {
                            var url = "/api/room/add";
                            that.$http.post(url, that.room).then(function (response) {
                                $("#addRoom").modal('hide');
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
