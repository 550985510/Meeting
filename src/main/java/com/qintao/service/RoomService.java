package com.qintao.service;

import com.github.pagehelper.PageInfo;
import com.qintao.bean.Room;

public interface RoomService {

    PageInfo<Room> findList(Room room);

    void add(Room room);
}
