package com.qintao.mapper;

import com.qintao.bean.User;

public interface UserMapper {

    void insert(User user);

    User selectForLogin(User user);

    User selectByMobile(String mobile);
}
