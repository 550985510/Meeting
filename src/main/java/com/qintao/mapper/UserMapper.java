package com.qintao.mapper;

import com.qintao.bean.User;

import java.util.List;

public interface UserMapper {

    void insert(User user);

    User selectForLogin(User user);

    User selectByMobile(String mobile);

    List<User> selectList(User user);

    List<User> selectAll();

    User selectById(Integer userId);
}
