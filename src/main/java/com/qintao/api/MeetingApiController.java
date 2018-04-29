package com.qintao.api;

import com.github.pagehelper.PageInfo;
import com.qintao.bean.Meeting;
import com.qintao.common.ResponseResult;
import com.qintao.service.MeetingService;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;
import org.joda.time.LocalDate;

@RestController
@RequestMapping("/api/meeting")
public class MeetingApiController {

    @Resource
    private MeetingService meetingService;

    @PostMapping("/list")
    public ResponseResult<PageInfo<Meeting>> findList(@RequestBody Meeting meeting) {
        if (meeting.getDateRangeStart() == null || meeting.getDateRangeEnd() == null) {
            //获取操作当天开始
            meeting.setDateRangeStart(LocalDate.now().toDate());
            meeting.setDateRangeEnd(LocalDate.now().plusDays(1).toDate());
        }
        PageInfo<Meeting> pageInfo = meetingService.findList(meeting);
        return new ResponseResult<>(pageInfo);
    }
}
