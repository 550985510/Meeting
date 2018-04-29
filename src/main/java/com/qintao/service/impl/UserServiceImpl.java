package com.qintao.service.impl;

import com.qintao.bean.User;
import com.qintao.mapper.UserMapper;
import com.qintao.service.UserService;
import com.qintao.util.SecurityPasswordUtils;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

@Service
public class UserServiceImpl implements UserService {

    @Resource
    private UserMapper userMapper;

    /**
     * 通过手机号查询
     *
     * @param mobile 手机号
     * @return 用户信息
     */
    @Override
    public User findByMobile(String mobile) {
        return userMapper.selectByMobile(mobile);
    }

    /**
     * 判断登陆
     *
     * @param user 登录信息
     * @return 用户信息
     */
    @Override
    public User findForLogin(User user) {
        return userMapper.selectForLogin(user);
    }

    /**
     * 添加用户
     *
     * @param user 用户信息
     */
    @Override
    public void add(User user) {
        //密码随机设置
        String salt = SecurityPasswordUtils.getSalt();
        String password = "admin";
        String passphrase = SecurityPasswordUtils.getPassphrase(salt, password);
        user.setSalt(salt);
        user.setPassword(passphrase);
        userMapper.insert(user);
    }
}
