package com.qintao.service;

import com.github.pagehelper.PageInfo;
import com.qintao.bean.Room;

import java.util.List;

public interface RoomService {

    PageInfo<Room> findList(Room room);

    void add(Room room);

    List<Room> findAll();
}
