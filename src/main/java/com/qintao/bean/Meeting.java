package com.qintao.bean;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;

@Data
public class Meeting {

    /**
     * 主键id
     */
    private Integer id;

    /**
     * 申请用户id
     */
    private Integer userId;

    /**
     * 申请人姓名
     */
    private String userName;

    /**
     * 会议主题
     */
    private String title;

    /**
     * 会议室开始使用时间
     */
    private Date startTime;

    /**
     * 会议室结束使用时间
     */
    private Date endTime;

    /**
     * 会议室id
     */
    private Integer roomId;

    /**
     * 会议室名称
     */
    private String roomName;

    /**
     * 申请状态 0:待审批 1:通过 2:未通过
     */
    private Integer status;

    /**
     * 创建时间（会议室申请时间）
     */
    private Date createdTime;

    /**
     * 时间范围
     */
    @JsonFormat(pattern = "yyyy-MM-dd")
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date dateRangeStart;

    @JsonFormat(pattern = "yyyy-MM-dd")
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date dateRangeEnd;

    private Integer page;

    private Integer pageSize;
}
