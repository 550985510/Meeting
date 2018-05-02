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
                    <span class="panel-title"> 会议室列表</span>
                </div>
                <div class="panel-body">
                    <div class="well">
                        <form class="form-inline">
                            <div class="form-group">
                                <div class="input-group">
                                    <label class="input-group-addon btn-default" for="realName_input">申请人姓名</label>
                                    <select id="realName_input" type="text" v-model="searchInfo.userId"
                                           class="form-control">
                                        <option value="">全部</option>
                                        <option v-for="user in users" :value="user.id">{{user.name}}</option>
                                    </select>
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="input-group">
                                    <label class="input-group-addon btn-default" for="realName_input">会议室名称</label>
                                    <select id="realName_input" type="text" v-model="searchInfo.roomId"
                                            class="form-control">
                                        <option value="">全部</option>
                                        <option v-for="room in rooms" :value="room.id">{{room.name}}</option>
                                    </select>
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="input-group">
                                    <label class="input-group-addon btn-default" for="mobile_input">会议室申请状态</label>
                                    <select id="mobile_input" type="text" v-model="searchInfo.status"
                                            class="form-control">
                                        <option value="">全部</option>
                                        <option value="0">待审批</option>
                                        <option value="1">通过</option>
                                        <option value="2">未通过</option>
                                    </select>
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="input-group">
                                    <div class="input-group-addon btn btn-default">开始使用时间</div>
                                    <input type="text" class="form-control" id="dateTimeRange">
                                    <div class="input-group-addon btn btn-default">
                                        <i class="glyphicon glyphicon-calendar fa fa-calendar"></i>
                                    </div>
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
                                <th>申请人姓名</th>
                                <th>会议主题</th>
                                <th>开始使用时间</th>
                                <th>结束使用时间</th>
                                <th>会议室名称</th>
                                <th>会议室申请状态</th>
                                <th>创建时间</th>
                                <th>操作</th>
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
                                <td>
                                    <button class="btn btn-info" v-if="meeting.status === 0" data-toggle='modal'
                                            data-target="#examine" v-on:click="examine(meeting)">审批</button>
                                    <label v-if="meeting.status === 1" class="label label-success">通过</label>
                                    <label v-if="meeting.status === 2" class="label label-danger">未通过</label>
                                </td>
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

    <!-- 会议申请审批 -->
    <div id="examine" class="modal fade bs-example-modal-sm" tabindex="-1" role="dialog">
        <div class="modal-dialog modal-sm" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                            aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title">会议申请审批</h4>
                </div>
                <div class="modal-body text-center">
                    <button type="button" class="btn btn-danger btn-lg" v-on:click="noThrough">
                        <i class="fa fa-times"></i> 审批不通过
                    </button>
                    <button type="button" class="btn btn-success btn-lg" v-on:click="passThrough">
                        <i class="fa fa-check"></i> 审批通过
                    </button>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                </div>
            </div><!-- /.modal-content -->
        </div><!-- /.modal-dialog -->
    </div><!-- /.modal -->
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
                userId: '',
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
            this.init();
        },
        watch: {
            "searchInfo.page": function () {
                this.query();
            }
        },
        methods: {
            init: function () {
                var start = moment().date(20).subtract(1, "months").add(1, 'days');
                var end = moment().date(20);
                if (moment().format("D") > 20) {
                    start = moment().date(21);
                    end = moment().date(20).add(1, "months");
                }
                $("#dateTimeRange").daterangepicker({
                    applyClass: 'btn-sm btn-success',
                    cancelClass: 'btn-sm btn-default',
                    opens: 'right',
                    separator: ' - ',
                    showWeekNumbers: true,
                    startDate: start,
                    endDate: end,
                    ranges: {
                        '标准': [start, end],
                        '今日': [moment().startOf('day'), moment().add( 'days',1)],
                        '昨日': [moment().subtract(1, 'days').startOf('day'), moment()],
                        '最近7日': [moment().subtract(6, 'days'), moment()],
                        '最近30日': [moment().subtract(29, 'days'), moment()],
                        '本月': [moment().startOf("month"), moment().endOf("month")],
                        '上个月': [moment().subtract(1, "month").startOf("month"), moment().subtract(1, "month").endOf("month")]
                    },
                    locale: {
                        format: 'YYYY-MM-DD',
                        applyLabel: '确认',
                        cancelLabel: '取消',
                        fromLabel: '起始时间',
                        toLabel: '结束时间',
                        customRangeLabel: '自定义',
                        daysOfWeek: "日,一,二,三,四,五,六".split(","),
                        monthNames: "一月,二月,三月,四月,五月,六月,七月,八月,九月,十月,十一,十二月".split(","),
                        firstDay: 1
                    }
                }, function (start, end, label) {
                    app.searchInfo.dateRangeStart = start.format('YYYY-MM-DD');
                    app.searchInfo.dateRangeEnd = end.format('YYYY-MM-DD');
                });
            },
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
