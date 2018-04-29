package com.qintao.service;

import com.github.pagehelper.PageInfo;
import com.qintao.bean.Meeting;

import java.util.List;

public interface MeetingService {

    PageInfo<Meeting> findList(Meeting meeting);

    List<Meeting> findAll();

    void insert(Meeting meeting);

    void examine(Meeting meeting);
}
