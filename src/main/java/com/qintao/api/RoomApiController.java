package com.qintao.api;

import com.github.pagehelper.PageInfo;
import com.qintao.bean.Room;
import com.qintao.bean.User;
import com.qintao.common.ResponseResult;
import com.qintao.common.RestResultEnum;
import com.qintao.service.RoomService;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;

@RestController
@RequestMapping("/api/room")
public class RoomApiController {

    @Resource
    private RoomService roomService;

    @PostMapping("/list")
    public ResponseResult<PageInfo<Room>> findList(@RequestBody Room room) {
        PageInfo<Room> pageInfo = roomService.findList(room);
        return new ResponseResult<>(pageInfo);
    }

    /**
     * 添加会议室
     * @param room 会议室信息
     * @return 操作状态
     */
    @PostMapping("/add")
    public ResponseResult addRoom(@RequestBody Room room) {
        roomService.add(room);
        return new ResponseResult(RestResultEnum.SUCCESS);
    }
}
