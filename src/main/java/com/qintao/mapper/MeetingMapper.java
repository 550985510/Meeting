package com.qintao.mapper;

import com.qintao.bean.Meeting;

import java.util.List;

public interface MeetingMapper {

    void insert(Meeting meeting);

    List<Meeting> selectList(Meeting meeting);
}
