<#import "/spring.ftl" as s>
<!DOCTYPE html>
<html lang="zh_CN">
<head>
    <meta charset="utf-8">
    <title>秦涛会议管理系统</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" type="text/css" href="<@s.url '/css/jquery.pagination.css'/>">
    <link rel="stylesheet" type="text/css" href="<@s.url '/plugins/daterange/daterangepicker.css'/>">
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
                    <span class="panel-title"> 我的申请记录</span>
                </div>
                <div class="panel-body">
                    <div class="panel-body">
                        <table class="table table-bordered">
                            <thead>
                            <tr>
                                <th>编号</th>
                                <th>申请人姓名</th>
                                <th>会议主题</th>
                                <th>开始使用时间</th>
                                <th>结束使用时间</th>
                                <th>会议室名称</th>
                                <th>会议室申请状态</th>
                                <th>创建时间</th>
                            </tr>
                            </thead>
                            <tbody>
                            <tr v-for="meeting in meetings">
                                <td>{{meeting.id}}</td>
                                <td>{{meeting.userName}}</td>
                                <td>{{meeting.title}}</td>
                                <td>{{meeting.startTime}}</td>
                                <td>{{meeting.endTime}}</td>
                                <td>{{meeting.roomName}}</td>
                                <td>
                                    <label v-if="meeting.status === 0" class="label label-warning">待审批</label>
                                    <label v-if="meeting.status === 1" class="label label-success">通过</label>
                                    <label v-if="meeting.status === 2" class="label label-danger">未通过</label>
                                </td>
                                <td>{{meeting.createdTime}}</td>
                            </tr>
                            <tr>
                                <td class="text-center" colspan="20" v-if="meetings.length == 0">没有数据 ！</td>
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
            </div>
        </div>
    </section>
</div>
<#include '../include/footer.ftl'/>
<script src="<@s.url '/js/jquery.pagination-1.2.7.js'/>"></script>
<script src="<@s.url '/plugins/daterange/moment.js'/>"></script>
<script src="<@s.url '/plugins/daterange/daterangepicker.js'/>"></script>
<!-- Charts JS -->
<script>
    var app = new Vue({
        el: '#main',
        data: {
            meetings: [],
            searchInfo: {
                dateRangeStart:'',
                dateRangeEnd:'',
                userId: ${Session.user.id},
                roomId: '',
                status: '',
                page: 1,
                pageSize: 30
            },
            meeting: {},
            users: [],
            rooms: [],
            examineMeeting: {}
        },
        created: function () {
            this.searchInfo.page = 1;
            $('#pageMenu').page('destroy');
            this.query();
            this.userList();
            this.roomList();
        },
        mounted: function () {

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
                var url = "/api/meeting/list";
                this.$http.post(url, this.searchInfo).then(function (response) {
                    this.meetings = response.data.data.list;
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
            userList: function () {
                var url = "/api/user/findAll";
                this.$http.post(url).then(function (response) {
                    this.users = response.data.data;
                }, function (error) {
                    swal(error.body.msg);
                });
            },
            roomList: function () {
                var url = "/api/room/findAll";
                this.$http.post(url).then(function (response) {
                    this.rooms = response.data.data;
                }, function (error) {
                    swal(error.body.msg);
                });
            },
            examine: function (meeting) {
                this.examineMeeting = meeting;
            },
            passThrough: function () {
                var that = this;
                swal({
                    title: "确定通过审批吗？",
                    type: "warning",
                    showCancelButton: true,
                    confirmButtonColor: "#DD6B55",
                    confirmButtonText: "确定！",
                    cancelButtonText: "取消！",
                    closeOnConfirm: false,
                    closeOnCancel: false
                }, function (isConfirm) {
                    if (isConfirm) {
                        that.examineMeeting.status = 1;
                        var url = "/api/meeting/examine";
                        that.$http.post(url, that.examineMeeting).then(function (response) {
                            $("#examine").modal('hide');
                            swal("操作成功！", "", "success");
                            that.query();
                        }, function (error) {
                            swal(error.body.msg);
                        });
                    } else {
                        swal("取消！", "", "error");
                    }
                });
            },
            noThrough: function () {
                var that = this;
                swal({
                    title: "确定不通过审批吗？",
                    type: "warning",
                    showCancelButton: true,
                    confirmButtonColor: "#DD6B55",
                    confirmButtonText: "确定！",
                    cancelButtonText: "取消！",
                    closeOnConfirm: false,
                    closeOnCancel: false
                }, function (isConfirm) {
                    if (isConfirm) {
                        that.examineMeeting.status = 2;
                        var url = "/api/meeting/examine";
                        that.$http.post(url, that.examineMeeting).then(function (response) {
                            $("#examine").modal('hide');
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
    });
</script>
</body>
</html>
