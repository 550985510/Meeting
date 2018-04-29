package com.qintao.config;

import com.qintao.bean.User;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurerAdapter;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@Configuration
public class AdminSecurityConfig extends WebMvcConfigurerAdapter {

    /**
     * 登录session key
     */
    public final static String SESSION_KEY = "user";

    @Bean
    public SecurityInterceptor getSecurityInterceptor() {
        return new SecurityInterceptor();
    }

    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        InterceptorRegistration addInterceptor = registry.addInterceptor(getSecurityInterceptor());

        // 排除配置
        addInterceptor.excludePathPatterns("/error_403");
        addInterceptor.excludePathPatterns("/error_404");
        addInterceptor.excludePathPatterns("/error_500");
        addInterceptor.excludePathPatterns("/api/user/login");
        addInterceptor.excludePathPatterns("/login");

        // 拦截配置
        addInterceptor.addPathPatterns("/**");
    }

    private class SecurityInterceptor extends HandlerInterceptorAdapter {

        @Override
        public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
                throws Exception {
            HttpSession session = request.getSession();
            User user = (User) session.getAttribute(SESSION_KEY);
            if (user != null) {
                Integer role = user.getRole();
                String requestUri = request.getRequestURI();
                String contextPath = request.getContextPath();
                String url = requestUri.substring(contextPath.length());
                //logger.info("url:"+url);
                if (role != 1 && ("/staff/user".equals(url) || "/staff/dept".equals(url) || "/staff/role".equals(url))) {
                    response.sendRedirect("/error_403");
                    return false;
                } else if(role == 3 && ("/module/list".equals(url) || "/user/list".equals(url) || "/article/list".equals(url) || "/article/banner/list".equals(url))) {
                    response.sendRedirect("/error_403");
                    return false;
                } else {
                    return true;
                }
            }

            // 跳转登录
            response.sendRedirect("/login");
            return false;
        }
    }
}
