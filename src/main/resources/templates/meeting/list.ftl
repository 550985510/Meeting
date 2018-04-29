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

                </div>
            </div>
        </div>
    </section>
</div>
<#include '../include/footer.ftl'/>
<script src="<@s.url '/js/jquery.pagination-1.2.7.js'/>"></script>
<script src='<@s.url '/js/moment.min.js'/>'></script>
<script src='<@s.url '/plugins/fullcalender/fullcalendar.min.js'/>'></script>
<script src='<@s.url '/plugins/fullcalender/locale/zh-cn.js'/>'></script>
<script type="text/javascript">
</script>
<script>
    var app = new Vue({
        el: '#main',
        data: {
            now: new Date(),
            meetingEvent: []
        },
        created: function () {
        },
        mounted: function () {
            this.init();
        },
        watch: {

        },
        methods: {
            init: function () {
                $('#calendar').fullCalendar({
                    defaultDate: this.now,
                    editable: true,
                    eventLimit: true, // allow "more" link when too many events
                    events: this.meetingEvent,
                    dayClick : function( date ) {
                        //do something here...
                        console.log('dayClick触发的时间为：', date.format());
                        // ...
                    }
                });
            }
        }
    });
</script>

</body>
</html>