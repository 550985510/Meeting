package com.qintao.Service;

import com.qintao.bean.User;
import com.qintao.service.UserService;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import javax.annotation.Resource;

@SpringBootTest
@RunWith(SpringJUnit4ClassRunner.class)
public class UserServiceTest {

    private final Logger logger = LoggerFactory.getLogger(getClass());

    @Resource
    private UserService userService;

    @Test
    public void insert() {
        User user = new User();
        user.setRole(1);
        user.setMobile("17611206883");
        user.setName("管理员");
        userService.add(user);
    }
}
