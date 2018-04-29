package com.qintao.bean;

import lombok.Data;

import java.util.Date;

@Data
public class Room {

    /**
     * 主键id
     */
    private Integer id;

    /**
     * 会议室名称
     */
    private String name;

    /**
     * 会议室地点
     */
    private String location;

    /**
     * 会议室容纳人数
     */
    private Integer number;

    /**
     * 创建时间
     */
    private Date createdTime;

    /**
     * 当前页
     */
    private Integer page;

    /**
     * 每页数量
     */
    private Integer pageSize;
}
