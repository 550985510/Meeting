package com.qintao.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.qintao.bean.Room;
import com.qintao.mapper.RoomMapper;
import com.qintao.service.RoomService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class RoomServiceImpl implements RoomService {

    @Resource
    private RoomMapper roomMapper;

    @Override
    public PageInfo<Room> findList(Room room) {
        PageHelper.startPage(room.getPage(), room.getPageSize());
        List<Room> list = roomMapper.selectList(room);
        return new PageInfo<>(list);
    }

    @Override
    public void add(Room room) {
        roomMapper.insert(room);
    }

    @Override
    public List<Room> findAll() {
        return roomMapper.selectAll();
    }
}
