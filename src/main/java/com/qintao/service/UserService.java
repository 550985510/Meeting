package com.qintao.service;

import com.qintao.bean.User;

public interface UserService {

    /**
     * 通过手机号查询
     * @param mobile 手机号
     * @return 用户信息
     */
    User findByMobile(String mobile);

    /**
     * 判断登陆
     * @param user 登录信息
     * @return 用户信息
     */
    User findForLogin(User user);

    /**
     * 添加用户
     * @param user 用户信息
     */
    void add(User user);
}
