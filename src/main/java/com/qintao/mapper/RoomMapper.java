package com.qintao.mapper;

import com.qintao.bean.Room;

import java.util.List;

public interface RoomMapper {

    void insert(Room room);

    List<Room> selectList(Room room);

    List<Room> selectAll();

    Room selectById(Integer roomId);
}
