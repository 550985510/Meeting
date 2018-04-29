package com.qintao.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.qintao.bean.Meeting;
import com.qintao.mapper.MeetingMapper;
import com.qintao.mapper.RoomMapper;
import com.qintao.mapper.UserMapper;
import com.qintao.service.MeetingService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class MeetingServiceImpl implements MeetingService {

    @Resource
    private MeetingMapper meetingMapper;

    @Resource
    private RoomMapper roomMapper;

    @Resource
    private UserMapper userMapper;

    @Override
    public PageInfo<Meeting> findList(Meeting meeting) {
        PageHelper.startPage(meeting.getPage(), meeting.getPageSize());
        List<Meeting> list = meetingMapper.selectList(meeting);
        for (Meeting item : list) {
            item.setRoomName(roomMapper.selectById(item.getRoomId()).getName());
            item.setUserName(userMapper.selectById(item.getUserId()).getName());
        }
        return new PageInfo<>(list);
    }

    @Override
    public List<Meeting> findAll() {
        List<Meeting> list = meetingMapper.selectAll();
        for (Meeting item : list) {
            item.setRoomName(roomMapper.selectById(item.getRoomId()).getName());
            item.setUserName(userMapper.selectById(item.getUserId()).getName());
        }
        return list;
    }

    @Override
    public void insert(Meeting meeting) {
        meetingMapper.insert(meeting);
    }

    @Override
    public void examine(Meeting meeting) {
        meetingMapper.update(meeting);
    }
}
