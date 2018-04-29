package com.qintao.bean;

import lombok.Data;

import java.util.Date;

@Data
public class User {

    /**
     * 用户id
     */
    private Integer id;


    /**
     * 密码
     */
    private String password;

    /**
     * 混合加密盐值
     */
    private String salt;

    /**
     * 真实姓名
     */
    private String name;


    /**
     * 手机号(账号)
     */
    private String mobile;

    /**
     * 用户权限 0:普通用户 1:管理员
     */
    private Integer role;

    /**
     * 创建时间
     */
    private Date createdTime;

    /**
     * 最后修改时间
     */
    private Date modifiedTime;


    /**
     * 当前页
     */
    private Integer page;

    /**
     * 每页数量
     */
    private Integer pageSize;
}
