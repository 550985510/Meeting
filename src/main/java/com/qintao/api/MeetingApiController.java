package com.qintao.api;

import com.github.pagehelper.PageInfo;
import com.qintao.bean.Meeting;
import com.qintao.bean.User;
import com.qintao.common.ResponseResult;
import com.qintao.common.RestResultEnum;
import com.qintao.config.AdminSecurityConfig;
import com.qintao.service.MeetingService;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import java.util.List;

@RestController
@RequestMapping("/api/meeting")
public class MeetingApiController {

    @Resource
    private MeetingService meetingService;

    @PostMapping("/list")
    public ResponseResult<PageInfo<Meeting>> findList(@RequestBody Meeting meeting) {
        PageInfo<Meeting> pageInfo = meetingService.findList(meeting);
        return new ResponseResult<>(pageInfo);
    }

    @PostMapping("findAll")
    public ResponseResult<List<Meeting>> findAll() {
        List<Meeting> list = meetingService.findAll();
        return new ResponseResult<>(list);
    }

    @PostMapping("apply")
    public ResponseResult apply(@RequestBody Meeting meeting, HttpSession session) {
        User user = (User)session.getAttribute(AdminSecurityConfig.SESSION_KEY);
        meeting.setUserId(user.getId());
        meetingService.insert(meeting);
        return new ResponseResult(RestResultEnum.SUCCESS);
    }

    /**
     * 会议室申请状态
     * @param meeting 申请状态
     * @return 操作状态
     */
    @PostMapping("/examine")
    public ResponseResult examine(@RequestBody Meeting meeting) {
        meetingService.examine(meeting);
        return new ResponseResult(RestResultEnum.SUCCESS);
    }
}
