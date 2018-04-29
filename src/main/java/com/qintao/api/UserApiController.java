package com.qintao.api;

import com.qintao.bean.User;
import com.qintao.common.ResponseResult;
import com.qintao.common.RestResultEnum;
import com.qintao.config.AdminSecurityConfig;
import com.qintao.service.UserService;
import com.qintao.util.SecurityPasswordUtils;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

/**
 * @author 木叶丸
 * Created by 木叶丸 on 2018/4/29 12:21
 */
@RestController
@RequestMapping("/api/user")
public class UserApiController {

    private User currentUser = new User();

    @Resource
    private UserService userService;

    /**
     * 登陆判断
     * @param userInfo 用户信息
     * @param session  登陆信息保存
     * @return 登陆操作状态
     */
    @PostMapping("/login")
    public ResponseResult login(@RequestBody User userInfo, HttpSession session) {
        //通过账号拿到混合加密盐值
        User user = userService.findByMobile(userInfo.getMobile());
        if (user == null) {
            return new ResponseResult(RestResultEnum.ERROR_LOGIN);
        }
        String salt = user.getSalt();
        //根据盐值和用户输入密码加密
        String passphrase = SecurityPasswordUtils.getPassphrase(salt, userInfo.getPassword());
        user.setSalt(salt);
        user.setPassword(passphrase);
        //判断登陆
        User info = userService.findForLogin(user);
        if (info != null) {
            session.setAttribute(AdminSecurityConfig.SESSION_KEY,info);
            return new ResponseResult(RestResultEnum.SUCCESS);
        }
        return new ResponseResult(RestResultEnum.ERROR_LOGIN);
    }

    /**
     * 添加用户
     * @param user 用户信息
     * @return 操作状态
     */
    @PostMapping("/add")
    public ResponseResult addUser(@RequestBody User user) {
        userService.add(user);
        return new ResponseResult(RestResultEnum.SUCCESS);
    }
}
