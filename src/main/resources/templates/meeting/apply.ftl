<#import "/spring.ftl" as s>
<!DOCTYPE html>
<html lang="zh_CN">
<head>
    <meta charset="utf-8">
    <title>秦涛会议管理系统</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" type="text/css" href="<@s.url '/css/jquery.pagination.css'/>">
    <link href='<@s.url '/plugins/fullcalender/fullcalendar.min.css'/>' rel='stylesheet' />
    <link href='<@s.url '/plugins/fullcalender/fullcalendar.print.min.css'/>' media='print' />
    <link rel="stylesheet" type="text/css" href="<@s.url '/plugins/bootstrap-timepicker/css/bootstrap-timepicker.css'/>">
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
                    <span class="panel-title"> 会议列表</span>
                </div>
                <div class="panel-body">
                    <div id="calendar"></div>
                    <button id="btn" style="display: none" data-toggle='modal' data-target="#applyModal"></button>
                    <button id="event" style="display: none" data-toggle='modal' data-target="#eventModal"></button>
                </div>
            </div>
        </div>
    </section>

    <!-- 申请会议室 -->
    <div id="applyModal" class="modal fade" tabindex="-1" role="dialog">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                            aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title">申请会议室</h4>
                </div>
                <div class="modal-body">
                    <form class="form-horizontal" role="form">
                        <div class="form-group">
                            <label for="add_modal_name_input" class="control-label col-lg-3">会议主题</label>
                            <div class="bs-component col-lg-8">
                                <input id="add_modal_name_input" class="form-control" v-model="meeting.title">
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="add_modal_mobile_input" class="control-label col-lg-3">开始使用时间</label>
                            <div class="bs-component col-lg-8">
                                <input type="text" class="form-control" id="startTime" :value="meeting.startTime"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="add_modal_mobile_input" class="control-label col-lg-3">结束使用时间</label>
                            <div class="bs-component col-lg-8">
                                <input type="text" class="form-control" id="endTime" :value="meeting.endTime"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="add_modal_mobile_input" class="control-label col-lg-3">会议室名称</label>
                            <div class="bs-component col-lg-8">
                                <select id="add_modal_mobile_input" class="form-control" v-model="meeting.roomId">
                                    <option v-for="room in rooms" :value="room.id">{{room.name}}</option>
                                </select>
                            </div>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                    <button type="button" class="btn btn-primary" v-on:click="apply">确认</button>
                </div>
            </div><!-- /.modal-content -->
        </div><!-- /.modal-dialog -->
    </div><!-- /.modal -->

    <!-- 申请会议室 -->
    <div id="eventModal" class="modal fade" tabindex="-1" role="dialog">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                            aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title">会议详情</h4>
                </div>
                <div class="modal-body">
                    <form class="form-horizontal" role="form">
                        <div class="form-group">
                            <label for="add_modal_name_input" class="control-label col-lg-3">会议主题</label>
                            <div class="bs-component col-lg-8">
                                <input id="add_modal_name_input" class="form-control" v-model="event.title" disabled>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="add_modal_mobile_input" class="control-label col-lg-3">开始使用时间</label>
                            <div class="bs-component col-lg-8">
                                <input type="text" class="form-control" id="startTime" :value="event.start" disabled/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="add_modal_mobile_input" class="control-label col-lg-3">结束使用时间</label>
                            <div class="bs-component col-lg-8">
                                <input type="text" class="form-control" id="endTime" :value="event.end" disabled/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="add_modal_mobile_input" class="control-label col-lg-3">会议室名称</label>
                            <div class="bs-component col-lg-8">
                                <input id="add_modal_mobile_input" class="form-control" v-model="event.roomName" disabled/>
                            </div>
                        </div>
                    </form>
                </div>
            </div><!-- /.modal-content -->
        </div><!-- /.modal-dialog -->
    </div><!-- /.modal -->

</div>
<#include '../include/footer.ftl'/>
<script src="<@s.url '/js/jquery.pagination-1.2.7.js'/>"></script>
<script src='<@s.url '/js/moment.min.js'/>'></script>
<script src='<@s.url '/plugins/fullcalender/fullcalendar.min.js'/>'></script>
<script src='<@s.url '/plugins/fullcalender/locale/zh-cn.js'/>'></script>
<script src="<@s.url '/plugins/bootstrap-timepicker/js/bootstrap-timepicker.min.js'/>"></script>
<script type="text/javascript">
</script>
<script>
    var app = new Vue({
        el: '#main',
        data: {
            now: new Date(),
            meetingEvent: [],
            applyDate: '',
            meeting: {},
            rooms: [],
            meetings: [],
            event: {}
        },
        created: function () {
            this.roomList();
            this.query();
        },
        mounted: function () {
            this.init();
        },
        watch: {

        },
        methods: {
            init: function () {
                var that = this;
                $("#startTime").timepicker({
                    defaultTime: '09:00:00',
                    showMeridian: false,
                    showSeconds: true
                });
                $("#endTime").timepicker({
                    defaultTime: '09:00:00',
                    showMeridian: false,
                    showSeconds: true
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
            query: function () {
                var that = this;
                var url = "/api/meeting/findAll";
                this.$http.post(url).then(function (response) {
                    this.meetings = response.data.data;
                    for(var i = 0; i<this.meetings.length; i++){
                        var info = {
                            id: this.meetings[i].id,
                            title: this.meetings[i].title,
                            start: this.meetings[i].startTime,
                            end: this.meetings[i].endTime,
                            roomName: this.meetings[i].roomName
                        };
                        this.meetingEvent.push(info);
                    }
                    $('#calendar').fullCalendar({
                        defaultDate: this.now,
                        editable: true,
                        eventLimit: true, // allow "more" link when too many events
                        events: this.meetingEvent,
                        dayClick : function( date ) {
                            $("#btn").click();
                            that.applyDate = date.format();
                        },
                        eventClick: function (event, jsEvent, view) {
                            $("#event").click();
                            event.start = event.start.format().toString().substring(0,10) + " " + event.start.format().toString().substring(11,20);
                            event.end = event.end.format().toString().substring(0,10) + " " + event.end.format().toString().substring(11,20);
                            that.event = event;
                        }
                    });
                }, function (error) {
                    swal(error.body.msg);
                });
            },
            apply: function () {
                this.meeting.startTime = $("#startTime").val();
                this.meeting.endTime = $("#endTime").val();
                if (this.meeting.title == null) {
                    sweetAlert("请输入会议主题");
                } else if (this.meeting.startTime == null || this.meeting.startTime == ''){
                    sweetAlert("请输入开始使用时间");
                } else if (this.meeting.endTime == null || this.meeting.endTime == '') {
                    sweetAlert("请输入结束使用时间");
                } else if (this.meeting.roomId == null) {
                    sweetAlert("请选择会议室");
                } else {
                    this.meeting.startTime = this.applyDate + " " + $("#startTime").val();
                    this.meeting.endTime = this.applyDate + " " + $("#endTime").val();
                    var url = "/api/meeting/apply";
                    this.$http.post(url, this.meeting).then(function (response) {
                        $("#applyModal").modal('hide');
                        swal("操作成功！", "", "success");
                        this.query();
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