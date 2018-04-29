package com.qintao.service;

import com.github.pagehelper.PageInfo;
import com.qintao.bean.Meeting;

public interface MeetingService {

    PageInfo<Meeting> findList(Meeting meeting);
}
